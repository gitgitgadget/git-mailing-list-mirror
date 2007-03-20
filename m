From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 23:00:53 -0700
Message-ID: <7v648wbgiy.fsf@assigned-by-dhcp.cox.net>
References: <1174361424.3143.42.camel@dv>
	<7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703192245490.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 07:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTXP1-00063S-I5
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 07:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbXCTGA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 02:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbXCTGAz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 02:00:55 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58892 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbXCTGAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 02:00:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320060053.TUZN1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 02:00:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cu0t1W00c1kojtg0000000; Tue, 20 Mar 2007 02:00:54 -0400
In-Reply-To: <Pine.LNX.4.64.0703192245490.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 19 Mar 2007 22:49:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42719>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We've had this bug before - thinking that we don't need to inflate() 
> anything because we already had it all..
>
> 		Linus

Thanks.  I think we _do_ need a big fat warning near the code to
avoid the same mistake in the future.  Something like this?


diff --git a/sha1_file.c b/sha1_file.c
index 9fe2bd6..d273aff 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1030,7 +1030,17 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 		n = size;
 	memcpy(buf, (char *) buffer + bytes, n);
 	bytes = n;
-	if (bytes < size) {
+	if (bytes <= size) {
+		/*
+		 * The above condition must be (bytes <= size), not
+		 * (bytes < size).  In other words, even if we expect
+		 * no more output, the input zlib stream may have bytes
+		 * that express "this concludes the stream", and we do
+		 * want to eat that input.  Otherwise we would not be
+		 * able to test that we consumed all the input to reach
+		 * the expected size *and* zlib gave status == Z_STREAM_END
+		 * to signal all went well.
+		 */
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
 		while (status == Z_OK)
