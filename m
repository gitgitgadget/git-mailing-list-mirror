From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cat-file: fix output when format string contains no
 variables
Date: Wed, 6 Nov 2013 10:31:21 -0800
Message-ID: <20131106183121.GA2566@sigill.intra.peff.net>
References: <1748846.6BAMC5enOx@localhost.localdomain>
 <xmqqsiv98l5y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sven Brauch <svenbrauch@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 19:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve7t3-0004PU-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 19:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab3KFSbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 13:31:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:34429 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871Ab3KFSbY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 13:31:24 -0500
Received: (qmail 32180 invoked by uid 102); 6 Nov 2013 18:31:23 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Nov 2013 12:31:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Nov 2013 10:31:21 -0800
Content-Disposition: inline
In-Reply-To: <xmqqsiv98l5y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237361>

On Wed, Nov 06, 2013 at 10:00:57AM -0800, Junio C Hamano wrote:

> I think the real problem is that sha1_loose_object_info() is called
> by sha1_object_info_extended(), when it does not find a cached or a
> packed object, and the callee assumes that it is asked to fill in
> only the requested pieces of information while the caller does not
> even bother to check if such an object actually exists.

Yes, exactly. This is over-optimization on the part of my 052fe5ea. The
caller asked for "nothing", so we happily optimize the request to do
nothing. But I forgot there is always an implicit "does it even exist"
query in the call. I do not see any point in adding an "exists" query
field to "struct object_info". :)

> -- >8 --
> Subject: sha1_loose_object_info(): do not return success on missing object
> 
> Since 052fe5ea (sha1_loose_object_info: make type lookup optional,
> 2013-07-12), sha1_loose_object_info() returns happily without
> checking if the object in question exists, which is not what the the
> caller sha1_object_info_extended() expects; the caller does not even
> bother checking the existence of the object itself.
> 
> Noticed-by: Sven Brauch <svenbrauch@googlemail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This is definitely the right fix. Commit message and patch look good to
me. A few extra bits are in the patch below.

>   Oh, by the way, there is this one iffy bit in batch_one_object():
> 
>           if (get_sha1(obj_name, data->sha1)) {
>                   printf("%s missing\n", obj_name);
>                   fflush(stdout);
>                   return 0;
>           }
> 
>   At this point, the object _may_ be missing, but the obj_name may be
>   malformed, so saying "missing" is not strictly correct.  If, for
>   example, you misspelled the name of the master branch, you would get
>   this:
> 
>           $ echo mastre | git cat-file --batch-check=foo
>           mastre missing
> 
>   I however doubt that it is a good idea to reword this message by
>   adding a logic to tell misspelled object name and missing object
>   name apart.  The users of "cat-file --batch-check" are not
>   expecting to be able to distinguish these two classes of errors
>   anyway.

Yes, I noticed that while doing the original series, but left it intact
for the exact reason you mention. Note that it is going to stdout and is
part of the actual data stream (so there is a good chance scripts are
parsing it).

> diff --git a/sha1_file.c b/sha1_file.c
> index 7dadd04..00220a4 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2486,12 +2486,11 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	 * need to look inside the object at all.
>  	 */
>  	if (!oi->typep && !oi->sizep) {
> -		if (oi->disk_sizep) {
> -			struct stat st;
> -			if (stat_sha1_file(sha1, &st) < 0)
> -				return -1;
> +		struct stat st;
> +		if (stat_sha1_file(sha1, &st) < 0)
> +			return -1;
> +		if (oi->disk_sizep)
>  			*oi->disk_sizep = st.st_size;
> -		}
>  		return 0;

Here's a squashable patch which expands the comment above the code
you're tweaking, and adds a test to t1006.

I notice that t1006 could use some modernization, whitespace-fixing, and
typo-fixing, but I left that out of the patch for clarity.

Thanks both of you for working on this.

-Peff

---
diff --git a/sha1_file.c b/sha1_file.c
index 3474dca..10676ba 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2489,7 +2489,11 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 
 	/*
 	 * If we don't care about type or size, then we don't
-	 * need to look inside the object at all.
+	 * need to look inside the object at all. Note that we
+	 * do not optimize out the stat call, even if the
+	 * caller doesn't care about the disk-size, since our
+	 * return value implicitly indicates whether the
+	 * object even exists.
 	 */
 	if (!oi->typep && !oi->sizep) {
 		struct stat st;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index a420742..8a1bc5c 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -194,6 +194,12 @@ test_expect_success "--batch-check for an emtpy line" '
     test " missing" = "$(echo | git cat-file --batch-check)"
 '
 
+test_expect_success 'empty --batch-check notices missing object' '
+	echo "$_z40 missing" >expect &&
+	echo "$_z40" | git cat-file --batch-check="" >actual &&
+	test_cmp expect actual
+'
+
 batch_input="$hello_sha1
 $commit_sha1
 $tag_sha1
