From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by
 using string_list
Date: Wed, 3 Jul 2013 02:23:32 -0400
Message-ID: <20130703062332.GA16090@sigill.intra.peff.net>
References: <1372809228-2963-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mfick@codeaurora.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 08:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuGTb-0006TY-M5
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 08:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab3GCGXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 02:23:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:35761 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab3GCGXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 02:23:35 -0400
Received: (qmail 26428 invoked by uid 102); 3 Jul 2013 06:24:45 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 01:24:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 02:23:32 -0400
Content-Disposition: inline
In-Reply-To: <1372809228-2963-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229453>

On Tue, Jul 02, 2013 at 04:53:48PM -0700, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> When pushing, each ref in the local repository must be paired with a
> ref advertised by the remote server.  Currently, this is performed by
> first applying the refspec to the local ref to transform the local ref
> into the name of the remote ref, and then performing a linear search
> through the list of remote refs to see if the remote ref was advertised
> by the remote system.
> 
> This has O(n) complexity and makes match_push_refs() be an O(n^2)
> operation.

Just to be sure I understand correctly, is this actually O(m*n) where
"m" is the number of local refs and "n" is the number of remote refs?

For a repository that repeatedly pushes everything it has to the remote,
we end up with m=n, but it would not necessarily be the case if you are
pushing a subset of your refs. But even pushing a small number of refs
into a repository with a very large number of refs would be
unnecessarily slow, as we would do several O(n) lookups which could be
O(log n). So it may speed things up even in the case of a normal-sized
repo pushing to a large one.

> Dry-run push of a repository with 121913 refs:
> 
>         before     after
> real    1m40.582s  0m0.804s
> user    1m39.914s  0m0.515s
> sys     0m0.125s   0m0.106s

Very nice. :)

> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  remote.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Patch itself looks good to me, although...

> @@ -1362,6 +1378,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  		free(dst_name);
>  	}
>  
> +	string_list_clear(&ref_list, 0);
> +
>  	if (flags & MATCH_REFS_FOLLOW_TAGS)
>  		add_missing_tags(src, dst, &dst_tail);
>  
> @@ -1376,11 +1394,15 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  
>  			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
>  			if (src_name) {
> -				if (!find_ref_by_name(src, src_name))
> +				if (!ref_list.nr)
> +					prepare_searchable_ref_list(src,
> +						&ref_list);
> +				if (!string_list_has_string(&ref_list, src_name))

This hunk threw me for a bit, as it looked like we were lazily
initializing ref_list in case we had not done so earlier. But we would
have cleared it mid-way through the function (in the hunk above), and it
is only that we are reusing the same ref_list for two different
purposes.

I do not feel strongly about it, but it might be a little more obvious
to just declare a new variable in the block, like:

diff --git a/remote.c b/remote.c
index 75255af..53bef82 100644
--- a/remote.c
+++ b/remote.c
@@ -1399,6 +1399,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		add_missing_tags(src, dst, &dst_tail);
 
 	if (send_prune) {
+		struct string_list src_ref_index = STRING_LIST_INIT_NODUP;
 		/* check for missing refs on the remote */
 		for (ref = *dst; ref; ref = ref->next) {
 			char *src_name;
@@ -1409,15 +1410,15 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
-				if (!ref_list.nr)
+				if (!src_ref_index.nr)
 					prepare_searchable_ref_list(src,
-						&ref_list);
-				if (!string_list_has_string(&ref_list, src_name))
+						&src_ref_index);
+				if (!string_list_has_string(&src_ref_index, src_name))
 					ref->peer_ref = alloc_delete_ref();
 				free(src_name);
 			}
 		}
-		string_list_clear(&ref_list, 0);
+		string_list_clear(&src_ref_index, 0);
 	}
 	if (errs)
 		return -1;

And similarly maybe call the outer ref_list dst_ref_index or something.
I also note that we don't do the lazy-prepare for the other loop. I
guess that is because we assume that "src" is always non-NULL?

-Peff
