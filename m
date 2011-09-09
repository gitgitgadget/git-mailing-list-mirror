From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Disable useless check_for_new_submodule_commits() by default
Date: Thu, 08 Sep 2011 18:56:56 -0700
Message-ID: <7vy5xyv5p3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 03:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1qL6-0003ad-IB
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 03:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab1IIB5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 21:57:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932468Ab1IIB5B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 21:57:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B9D14802;
	Thu,  8 Sep 2011 21:56:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	/T2YARosS7JoEn3ZH2xU3KMvGE=; b=AA+CIgyyzNISCxTqbnnxo+2PyXQLR4Bv9
	glGv9aqm1V1e8s09i6wu/Mm/bs2OINERg8sRu89pv58rKVD7ATM8ptpQDp3QywdS
	JYvuh59IgtyL1T9G/StpgoUxNGxub03kIyNOEalxegOC3ZiuR/wpyWfHIMaRwsiv
	B9sLcdStfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=sv4AGKe+mqpkskpudOSl7Y3vvZ42l8lxJ0kUaCdXhcmWO7B1GRyy4rrO
	Df1tBIGOxtHkObMZ2e3W63po5TdVgygOwh7i6xhwWsr6uUlL9W9AK1sZHxs9mGlS
	fkKhULaT6I+YCdFoDQGFvRXoO5VTvk0MS/9/Aio6mMs+tfrQzkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2328E4800;
	Thu,  8 Sep 2011 21:56:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6240147FD; Thu,  8 Sep 2011
 21:56:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 007460C8-DA87-11E0-AD53-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181019>

Imagine a project with 20k paths with a history 250k commits deep, without
any submodule.

Imagine another project with the same depth of history but with 1k paths,
among which there are 200 submodules.

Further, imagine fetching from one of the above repositories into a
repository that is very behind, and updating many remote tracking
branches.  Now, think about what check_for_new_submodule_commits() in
submodule.c that is called from update_local_ref() in builtin/fetch.c
would do.

For each updated remote tracking branch (or anything that is not a tag),
the problem function will run the equivalent of:

	git log --raw $new --not --all

which would mean 250k rounds of diff-tree to enumerate the submodules that
may have been updated, and it does it for each and every refs outside the
refs/tags hierarchy.

Presumably, this is so that it only has to actually fetch in the submodule
"on demand", but even if in a project _with_ submodules (i.e. the latter
example above), this is simply not acceptable. You could just enumerate
those 200 submodules at the tip that _might_ matter and that would be
million times cheaper. To add insult to injury, this "on demand" behaviour
is on by default, which hurts projects without any submodules (i.e. the
former example above) a lot.

In short, if "on demand" check is million times more expensive than
actually doing it, the check does not have any value.

In the longer term, people who want to have the on-demand behaviour need
to come up with a cheaper way to determine if it is necessary to recurse
into submodules by fixing check_for_new_submodule_commits(), but until
that happens, we should disable submodule recursion by default unless the
user explicitly asks for it from the command line or from the configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is meant for 1.7.6.X maintenance track to fix the huge regression
   caused by 88a2197 (fetch/pull: recurse into submodules when necessary,
   2011-03-06).  I would very much appreciate a simpler and trivially
   correct patch as a counter-proposal that makes sure that the expensive
   check_for_new_submodule_commits() and fetch_populated_submodules()
   functions are never called when the user does not have any command line
   option or configuration variable to tell otherwise. I suspect that this
   patch may be disabling more things than absolutely necessary.

   I also suspect that it might be just a matter of finding any and all
   comparison of the form:

	if (recurse != ON && recurse != OFF)

   that was present before the on-demand stuff and replace that with
        
	if (recurse == ON_DEMAND)

   but I didn't look very closely. At least this patch is much less error
   prone for the purpose of not triggering the expensive and pointless
   check ;-)

 builtin/fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 93c9938..71232c1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,7 +29,7 @@ enum {
 };
 
 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
-static int progress, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int progress, recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
