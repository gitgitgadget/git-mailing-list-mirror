From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 10:01:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
 <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
 <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwhqu-0008QA-F8
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 19:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967465AbXFHRCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 13:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966018AbXFHRCT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 13:02:19 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51600 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756362AbXFHRCS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 13:02:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l58H1l9Q030153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2007 10:01:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l58H1fA1005525;
	Fri, 8 Jun 2007 10:01:42 -0700
In-Reply-To: <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
Received-SPF: neutral (207.189.120.55 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-2.783 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49486>



On Fri, 8 Jun 2007, Thomas Glanzmann wrote:
> 
> yes, it is reproducable. Again I am off the net for an hour.

Could you compile your own git? If so, please try this patch on top of 
current git, to make the error message a bit more informative.

It does sound like a corrupt stream, but maybe debian has some strange 
zlib version that git doesn't like.

		Linus
---
 index-pack.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 82c8da3..542687b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -277,9 +277,13 @@ static void *get_data_from_pack(struct object_entry *obj)
 	stream.avail_in = len;
 	inflateInit(&stream);
 	while ((st = inflate(&stream, Z_FINISH)) == Z_OK);
+	if (st != Z_STREAM_END)
+		die("serious inflate inconsistency: %d (%s)",
+			st, stream.msg ? stream.msg : "no message");
+	if (stream.total_out != obj->size)
+		die("serious inflate inconsistency: got %lu bytes, expected %lu",
+			stream.total_out, obj->size);
 	inflateEnd(&stream);
-	if (st != Z_STREAM_END || stream.total_out != obj->size)
-		die("serious inflate inconsistency");
 	free(src);
 	return data;
 }
