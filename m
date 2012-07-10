From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git commit --amend --only --" nevertheless commits staged
 changes
Date: Tue, 10 Jul 2012 13:14:32 -0700
Message-ID: <7vwr2bgyqf.fsf@alter.siamese.dyndns.org>
References: <4FFC06C9.5050405@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:14:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SogpV-0006au-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab2GJUOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:14:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab2GJUOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:14:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E55490C2;
	Tue, 10 Jul 2012 16:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RN3tHbcDHx1moGror4Bj95CM+O4=; b=s6gy/t
	MnkJ31t4OPTp42PTCWdV6J9FfNFVuDw0fpluf34MWSCPX+QHnBwX22wKnwGlStjb
	1ayP9kcYYi8tCn+H5X71JBI5qic/nR3t941kX7xLhaGDZOcCYw9IKHpYRFbTH8Od
	fFIXkJvE5UrqKjE+OS9cArsRwwX52slTQ3MLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p2U0HnVABM5IY6q4oWVXgu59TBpUiJXJ
	e5IIQU42Mu9uF1RpSeKROVkXcCMhUU2jHSzLh7ORSEVXX45mqHe28fu3/yMLbEmW
	N8rp4D/M6AeZEqGjmqSkD731VK4Z4nVZyYsASXH2iDUAAIw9DGJIf0fIA8T0cOSG
	MRaQyDL7rIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55AF790C1;
	Tue, 10 Jul 2012 16:14:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D13DF90BF; Tue, 10 Jul 2012
 16:14:33 -0400 (EDT)
In-Reply-To: <4FFC06C9.5050405@syntevo.com> (Marc Strapetz's message of "Tue,
 10 Jul 2012 12:41:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD5A3596-CACB-11E1-9BCA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201275>

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> When using "git commit --amend --only --message <message> --", I'd
> expect to have just the commit message of my last commit changed,
> according to the man page:
>
> "--only Make a commit only from the paths specified on the command line,
> disregarding any contents that have been staged so far. [...] If this
> option is specified together with --amend, then no paths need to be
> specified, which can be used to amend the last commit without committing
> changes that have already been staged."
>
> However, all staged changes are committed as well. So looks like either
> the man page or Git is wrong here!?

I do not think the combination with --amend, --only and no paths
ever worked.  We rejected such a combination before 6a74642c5, which
merely made us to accept the combination but I do not think the
commit did anything to re-read the tree from the HEAD being amended
to the index.

Something like this, but I haven't thought about what other things
it may break.

 builtin/commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f43eaaf..59ef5e1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -184,6 +184,9 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	int i;
 	char *m;
 
+	if (!pattern)
+		return 0;
+
 	for (i = 0; pattern[i]; i++)
 		;
 	m = xcalloc(1, i);
@@ -345,7 +348,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!pathspec || !*pathspec) {
+	if (!(only && amend) && (!pathspec || !*pathspec)) {
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
