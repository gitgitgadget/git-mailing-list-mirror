From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 23:05:56 -0700
Message-ID: <7v1wjkbgaj.fsf@assigned-by-dhcp.cox.net>
References: <1174361424.3143.42.camel@dv>
	<7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703192245490.6730@woody.linux-foundation.org>
	<7v648wbgiy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 07:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTXU1-0008Tj-2y
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 07:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbXCTGF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 02:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbXCTGF6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 02:05:58 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50280 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbXCTGF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 02:05:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320060557.IRGY2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 02:05:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cu5w1W00n1kojtg0000000; Tue, 20 Mar 2007 02:05:57 -0400
In-Reply-To: <7v648wbgiy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Mar 2007 23:00:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42720>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> We've had this bug before - thinking that we don't need to inflate() 
>> anything because we already had it all..
>>
>> 		Linus
>
> Thanks.  I think we _do_ need a big fat warning near the code to
> avoid the same mistake in the future...

By the way, I think the test that comes after the part you fixed
is wrong (I know it is my bad without running git-blame).  Since
we are making sure that we eat everything, we should expect
Z_STREAM_END and no avail_in.

diff --git a/sha1_file.c b/sha1_file.c
index d7dc80d..7dc16ea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1037,7 +1037,7 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 			status = inflate(stream, Z_FINISH);
 	}
 	buf[size] = 0;
-	if ((status == Z_OK || status == Z_STREAM_END) && !stream->avail_in) {
+	if (status == Z_STREAM_END && !stream->avail_in) {
 		inflateEnd(stream);
 		return buf;
 	}
