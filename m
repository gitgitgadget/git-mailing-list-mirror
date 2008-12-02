From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/5] avoid parse_sha1_header() accessing memory out of
	bound
Date: Tue, 2 Dec 2008 07:42:57 -0800
Message-ID: <20081202154257.GK23984@spearce.org>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <4934949B.70307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:45:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XR7-0000db-Eb
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbYLBPnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbYLBPm7
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:42:59 -0500
Received: from george.spearce.org ([209.20.77.23]:33419 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbYLBPm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:42:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B71B938200; Tue,  2 Dec 2008 15:42:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4934949B.70307@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102148>

Liu Yubao <yubao.liu@gmail.com> wrote:
> diff --git a/sha1_file.c b/sha1_file.c
> index 6c0e251..efe6967 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1254,10 +1255,10 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
>  	/*
>  	 * The type can be at most ten bytes (including the
>  	 * terminating '\0' that we add), and is followed by
> -	 * a space.
> +	 * a space, at least one byte for size, and a '\0'.
>  	 */
>  	i = 0;
> -	for (;;) {
> +	while (hdr < hdr_end - 2) {
>  		char c = *hdr++;
>  		if (c == ' ')
>  			break;
> @@ -1265,6 +1266,8 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
>  		if (i >= sizeof(type))
>  			return -1;

That first hunk I am citing is unnecessary, because of the lines
right above.  All of the callers of this function pass in a buffer
that is at least 32 bytes in size; this loop aborts if it does not
find a ' ' within the first 10 bytes of the buffer.  We'll never
access memory outside of the buffer during this loop.

So IMHO your first three hunks here aren't necessary.

> @@ -1275,7 +1278,7 @@ static int parse_sha1_header(const char *hdr, unsigned long *sizep)
>  	if (size > 9)
>  		return -1;
>  	if (size) {
> -		for (;;) {
> +		while (hdr < hdr_end - 1) {
>  			unsigned long c = *hdr - '0';
>  			if (c > 9)
>  				break;

OK, there's no promise here that we don't roll off the buffer.

This can be fixed in the caller, ensuring we always have the '\0'
at some point in the initial header buffer we were asked to parse:

diff --git a/sha1_file.c b/sha1_file.c
index 6c0e251..26c6ffb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1162,9 +1162,10 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	stream->next_in = map;
 	stream->avail_in = mapsize;
 	stream->next_out = buffer;
-	stream->avail_out = bufsiz;
 
 	if (legacy_loose_object(map)) {
+		stream->avail_out = bufsiz - 1;
+		buffer[bufsiz - 1] = '\0';
 		inflateInit(stream);
 		return inflate(stream, 0);
 	}
@@ -1186,6 +1187,7 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 	/* Set up the stream for the rest.. */
 	stream->next_in = map;
 	stream->avail_in = mapsize;
+	stream->avail_out = bufsiz;
 	inflateInit(stream);
 
 	/* And generate the fake traditional header */

-- 
Shawn.
