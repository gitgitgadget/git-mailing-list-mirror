From: Junio C Hamano <gitster@pobox.com>
Subject: "Detailed diagnosis" perhaps broken
Date: Thu, 14 Jun 2012 21:03:45 -0700
Message-ID: <7vpq91cjby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 15 06:03:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfNlK-0001tC-OT
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 06:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765Ab2FOEDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 00:03:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab2FOEDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 00:03:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DDEC86FC;
	Fri, 15 Jun 2012 00:03:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	x7RBAZILzvZumSuqoOVsCqUvnw=; b=tTu7vHZXWkODPAxQSlWp6R/l2ga+r5QLa
	JiisEQugXmR6zg2RS3HfHnkm+P+IVNgMvyoRMsz8UAhGaY6LMf4vo20CJZOca1i0
	onMaOH57syqG7Ws/sEHZqjBF3o4yK7zmF6lZpiN6Y+IEApQMJ87AeUg0Ws+XnnZ4
	dwprYEMzq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Fd1ehQSpyspycEL85KgXDzef6dcavnHGTpAZWOCqfOEK18F+p7zGImrS
	wl+cwXkU0T7ROhaC5WlAF4jC+ev068rrWOd+kTPz5ALP7sN+CvxbkO9CFRoro3pb
	sAfaEYtf6RwkD3jjS12xk6qfrBL0bJeWvYFEQRY62zths06sjZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7451786FB;
	Fri, 15 Jun 2012 00:03:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4D5A86F7; Fri, 15 Jun 2012
 00:03:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B1DEBCA-B69F-11E1-9EDC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200038>

009fee4 (Detailed diagnosis when parsing an object name fails., 2009-12-07)
added a logic to try to see what kind of breakage the object name
user gave in the $treeish:$path or /:$search syntax.

This logic however triggers in a funny way, leading to an idiotic
error message.  You can try this in the git repository:

	$ git log COPYING HEAD^:COPYING
	fatal: Path 'COPYING' exists on disk, but not in 'HEAD^'.

When setup_revisions() tries to parse the command line arguments, it
notices that there is no "--", and it makes sure that earlier
arguments are all revs that cannot possibly refer to working tree
files, and later arguments all refer to working tree files and
cannot possibly refer to objects.

It first looks at "COPYING", notices that it is _not_ a rev.  Which
means that anything that follows must _not_ be an object name.  It
calls verify_filename() on "COPYING", which is a happy filename, and
then calls verify_filename() on "HEAD^:COPYING", and then calls
die_verify_filename() on it, assuming that it is being fed a badly
formed rev.

Obviously, this assumption is *WRONG*.

Then get_sha1_with_mode_1() is called with "gently" set to 0 (in
later code, we have a fix to flip the value of this flag and renamed
it to "only-to-die"---we are calling this function only to let it die
with diagnostics).  It tries to interpret HEAD^:COPYING as a rev,
and even though get_tree_entry() call for "COPYING" inside "HEAD^"
tree-ish succeeds, it ignores the fact that it successfully names an
object, and calls diagnose_invalid_sha1_path() to die.

	Side note.  The original motivation of the "detailed diag"
	patch was to catch something like

	$ git rev-parse HEAD^:COPYIGN

	and the codepath is called when the caller _knows_
	HEAD^:COPYIGN must resolve to an object name, and made sure
	that it does not, so in that case, it results in expected
	behaviour.  But for this "earlier must be all revs, later
	must be all paths" caller, it was a wrong conversion.

That causes "Path exists on disk, but not in 'HEAD^'", which is only
half correct (because the caller just checked and it knows the path
exists in 'HEAD^', but it ignored the result of the check), and more
importantly, completely misses the point.

At least, the following patch seems to work around _this_ particular
codepath, but I suspect that we need to check other places that can
reach diagnose_invalid_foo() functions your commit introduced for
similar breakages.

Ideas for better fix?

 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index c633113..574c68a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1127,7 +1127,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			if (new_filename)
 				filename = new_filename;
 			ret = get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
-			if (only_to_die) {
+			if (only_to_die && ret) {
 				diagnose_invalid_sha1_path(prefix, filename,
 							   tree_sha1, object_name);
 				free(object_name);
