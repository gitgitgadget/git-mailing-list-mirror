From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix git-fast-export for zero-sized blobs
Date: Tue, 11 Dec 2007 23:01:28 +0100
Message-ID: <20071211220128.GA19857@steel.home>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2DAn-0004IY-P1
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 23:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbXLKWBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbXLKWBc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 17:01:32 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:27213 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbXLKWBc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 17:01:32 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a7Bs=
Received: from tigra.home (Fc89d.f.strato-dslnet.de [195.4.200.157])
	by post.webmailer.de (mrclete mo60) (RZmta 14.6)
	with ESMTP id x06a74jBBLsjUr ; Tue, 11 Dec 2007 23:01:29 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 23FE0277AE;
	Tue, 11 Dec 2007 23:01:29 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A830456D22; Tue, 11 Dec 2007 23:01:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67955>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-fast-export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Nicolas Pitre, Tue, Dec 11, 2007 21:27:33 +0100:
> Simply doing something like:
> 
> $ git fast-export --all > /dev/null
> 
> results in:
> 
> fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 

I get this for my git repo:

	$ git fast-export --all >/dev/null
	fatal: Could not write blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
	$ git cat-file blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 |wc -c
	0

Writing a zero-size blob will surely returns 0.

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 2136aad..ef27eee 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -103,7 +103,7 @@ static void handle_object(const unsigned char *sha1)
 	mark_object(object);
 
 	printf("blob\nmark :%d\ndata %lu\n", last_idnum, size);
-	if (fwrite(buf, size, 1, stdout) != 1)
+	if (size && fwrite(buf, size, 1, stdout) != 1)
 		die ("Could not write blob %s", sha1_to_hex(sha1));
 	printf("\n");
 
-- 
1.5.3.7.1177.gb22b
