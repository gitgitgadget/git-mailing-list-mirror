From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix buffer overflow in ce_flush().
Date: Sun, 11 Sep 2005 10:54:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111050040.3242@g5.osdl.org>
References: <20050911132747.GA26401@mayhq.zapto.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 19:55:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEW2d-0007vM-94
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVIKRyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVIKRyz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:54:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964994AbVIKRyy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 13:54:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BHskBo014398
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 10:54:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BHsj3O014534;
	Sun, 11 Sep 2005 10:54:45 -0700
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <20050911132747.GA26401@mayhq.zapto.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8307>



On Sun, 11 Sep 2005, Qingning Huo wrote:
>
> Fix buffer overflow in ce_flush().

Thanks, good find. However, I'd almost prefer the simpler patch below..

		Linus

---
Fix buffer overflow in ce_flush()

Qingning Huo <qhuo@mayhq.co.uk> noticed that we migth overflow the write 
buffer when writing the final SHA1 of the index file. Make sure we have 
enough extra room at the end that we can always add the final checksum to 
the end of the buffer.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -428,7 +428,7 @@ unmap:
 }
 
 #define WRITE_BUFFER_SIZE 8192
-static unsigned char write_buffer[WRITE_BUFFER_SIZE];
+static unsigned char write_buffer[WRITE_BUFFER_SIZE+20];
 static unsigned long write_buffer_len;
 
 static int ce_write(SHA_CTX *context, int fd, void *data, unsigned int len)
