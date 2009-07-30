From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Thu, 30 Jul 2009 00:03:28 -0700
Message-ID: <7vtz0uk5z3.fsf@alter.siamese.dyndns.org>
References: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
 <C695A6A4.61CD9%jbenjore@whitepages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Josh ben Jore <jbenjore@whitepages.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 09:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWPg4-0003N8-Eo
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 09:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZG3HDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 03:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbZG3HDh
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 03:03:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbZG3HDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 03:03:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBA44162AC;
	Thu, 30 Jul 2009 03:03:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36C49162AB; Thu, 30 Jul 2009
 03:03:29 -0400 (EDT)
In-Reply-To: <C695A6A4.61CD9%jbenjore@whitepages.com> (Josh ben Jore's
 message of "Wed\, 29 Jul 2009 07\:11\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1991F954-7CD7-11DE-806B-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124445>

Josh ben Jore <jbenjore@whitepages.com> writes:

> I know more now. 

Thanks.  The log was a bit hard to read with linewrapping; here is what I
could glean out of it anyway.

You have something like this in the output

    CONFLICT (rename/add):

    Rename config/conf/target/dev-ubuntu/wpn_rails/appserver.yml
    ->
    config/conf/target/dev/wpn_rails/appserver.yml
    in
    Temporary merge branch 1.
    config/conf/target/dev/wpn_rails/appse2

    Adding as
    config/conf/target/dev/wpn_rails/appserver.yml~Temporary merge branch 2
    instead

which almost matches this part from merge_recursive.c

	} else if (!sha_eq(dst_other.sha1, null_sha1)) {
		const char *new_path;
		clean_merge = 0;
		try_merge = 1;
		output(o, 1, "CONFLICT (rename/add): Rename %s->%s in %s. "
		       "%s added in %s",
		       ren1_src, ren1_dst, branch1,
		       ren1_dst, branch2);
		new_path = unique_path(o, ren1_dst, branch2);
		output(o, 1, "Adding as %s instead", new_path);
		update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);

although I do not see "%s added in %s" part, which means we cannot see what
ren1_dst nor branch2 were.

And the crucial bit is:

>       There are unmerged index entries:
>       2 config/conf/target/dev/wpn_rails/appserver.yml
>       3 config/conf/target/dev/wpn_rails/appserver.yml

So the code did not want to add config/conf/target/dev/wpn_rails/appse2???
and instead tried to add it with suffix.  That is what the "update_file()"
does for a recursive "virtual base" merge --- it is supposed to resolve
everything down to stage#0.

But it forgets to resolve the original path (in dev/ not in dev-ubuntu/
and without the "~Temporary" suffix).

Since I do not have an access to exact details, nor reproducible history,
this is shot in the dark, but I think this may fix it.

The codepath saw that one branch renamed dev-ubuntu/ stuff to dev/ at that
"unmerged" path, while the other branch added something else to the same
path, and decided to add that at an alternative path, and the intent of
that is so that it can safely resolve the "renamed" side to its final
destination.  The added update_file() call is about finishing that
conflict resolution the code forgets to do.

 merge-recursive.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d415c41..868b383 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -955,6 +955,7 @@ static int process_renames(struct merge_options *o,
 				new_path = unique_path(o, ren1_dst, branch2);
 				output(o, 1, "Adding as %s instead", new_path);
 				update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+				update_file(o, 0, src_other.sha1, src_other.mode, ren1_dst);
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
