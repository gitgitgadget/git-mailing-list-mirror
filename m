From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Mon, 19 Mar 2007 22:49:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192245490.6730@woody.linux-foundation.org>
References: <1174361424.3143.42.camel@dv> <7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTXEa-0000DY-0L
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbXCTFuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXCTFuH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:50:07 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47955 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbXCTFuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:50:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K5nscD024433
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 22:49:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K5nrCr027002;
	Mon, 19 Mar 2007 21:49:54 -0800
In-Reply-To: <7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.475 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42716>



On Mon, 19 Mar 2007, Junio C Hamano wrote:
> 
> If the error message above is linewrapped by e-mail, I think it
> is coming from here:

I think I found it.

The thing is, if the output buffer is empty, we should *still* actually 
use the zlib routines to *unpack* that empty output buffer.

But we had a test that said "only unpack if we still expect more output".

So we wouldn't use up all the zlib stream, because we felt that we didn't 
need it, because we already had all the bytes we wanted. And it was 
"true": we did have all the output data. We just needed to also eat all 
the input data!

We've had this bug before - thinking that we don't need to inflate() 
anything because we already had it all..

		Linus

---
 sha1_file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b0b2177..c0efed3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1030,7 +1030,7 @@ static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size
 		n = size;
 	memcpy(buf, (char *) buffer + bytes, n);
 	bytes = n;
-	if (bytes < size) {
+	if (bytes <= size) {
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
 		while (status == Z_OK)
