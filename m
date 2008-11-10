From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] 3-way merge with file move fails when diff.renames =
 copies
Date: Mon, 10 Nov 2008 15:49:03 -0800
Message-ID: <7v63mv3zww.fsf@gitster.siamese.dyndns.org>
References: <1226355970-2542-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgWm-0001ok-RN
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYKJXtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYKJXtZ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:49:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYKJXtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:49:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 252797B0BB;
	Mon, 10 Nov 2008 18:49:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5BD9A7B0B9; Mon,
 10 Nov 2008 18:49:10 -0500 (EST)
In-Reply-To: <1226355970-2542-1-git-send-email-ddkilzer@kilzer.net> (David D.
 Kilzer's message of "Mon, 10 Nov 2008 14:26:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 333F0586-AF82-11DD-98EE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100595>

"David D. Kilzer" <ddkilzer@kilzer.net> writes:

> With diff.renames = copies, a 3-way merge (e.g. "git rebase") would
> fail with the following error:
>
>     fatal: mode change for <file>, which is not in current HEAD
>     Repository lacks necessary blobs to fall back on 3-way merge.
>     Cannot fall back to three-way merge.
>     Patch failed at 0001.
>
> The bug is a logic error added in ece7b749, which attempts to find
> an sha1 for a patch with no index line in build_fake_ancestor().
> Instead of failing unless an sha1 is found for both the old file and
> the new file, a failure should only be reported if neither the old
> file nor the new file is found.
>
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
> ---
>  builtin-apply.c   |    2 +-
>  t/t3400-rebase.sh |   17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 4c4d1e1..cfeb6cc 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2573,7 +2573,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
>  		else if (get_sha1(patch->old_sha1_prefix, sha1))
>  			/* git diff has no index line for mode/type changes */
>  			if (!patch->lines_added && !patch->lines_deleted) {
> -				if (get_current_sha1(patch->new_name, sha1) ||
> +				if (get_current_sha1(patch->new_name, sha1) &&
>  				    get_current_sha1(patch->old_name, sha1))
>  					die("mode change for %s, which is not "
>  						"in current HEAD", name);

Hmm.

The logic introduced by the blamed commit makes the --index-info
unreliable (I'd rather see it fail reliably if it does not have enough
information rather than pretending everything is Ok), and I think the
patch makes it slightly more so.

If new_name that is not related at all to old_name happens to exist in the
current tree you are applying the patch to, you can grab the contents of
the unrelated file as the preimage and try to merge the changes in.

When running --index-info for the purpose of "am -3" (hence rebase), the
expectation is that the tree you are applying the changes to is _similar_
to the preimage of the change, i.e. old_name.  Shouldn't missing old_name
be treated as a fatal condition?  new_name does not have to even exist
because otherwise you cannot accept a patch that creates the path.

Wouldn't this be a better patch, I wonder...

 builtin-apply.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git i/builtin-apply.c w/builtin-apply.c
index 4c4d1e1..7de70e9 100644
--- i/builtin-apply.c
+++ w/builtin-apply.c
@@ -2573,8 +2573,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
 			/* git diff has no index line for mode/type changes */
 			if (!patch->lines_added && !patch->lines_deleted) {
-				if (get_current_sha1(patch->new_name, sha1) ||
-				    get_current_sha1(patch->old_name, sha1))
+				if (get_current_sha1(patch->old_name, sha1))
 					die("mode change for %s, which is not "
 						"in current HEAD", name);
 				sha1_ptr = sha1;
