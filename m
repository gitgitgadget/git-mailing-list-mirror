From: Andreas Gal <gal@uci.edu>
Subject: [PATH] fix segfault in fsck-cache
Date: Sat, 23 Apr 2005 22:05:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232202380.7195@sam.ics.uci.edu>
References: <1114280570.5068.5.camel@mulgrave>  <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
  <1114292680.4799.4.camel@mulgrave>  <20050423230238.GD13222@pasky.ji.cz> 
 <1114298490.5264.10.camel@mulgrave>  <Pine.LNX.4.58.0504231759010.2344@ppc970.osdl.org>
 <1114317771.4980.7.camel@mulgrave> <Pine.LNX.4.58.0504232153500.15879@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 07:01:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZEz-0007zx-UU
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVDXFFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVDXFFy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:05:54 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:26519 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262259AbVDXFFt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:05:49 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3O55iqd007260;
	Sat, 23 Apr 2005 22:05:44 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3O55inP007256;
	Sat, 23 Apr 2005 22:05:44 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504232153500.15879@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I somehow got some corrupted object files in my repository that zlib 
refuses to decompress. This patch makes sure we abort early before the 
memcpy a few lines downtream segfaults (due to total_out == 0).

Andreas

Signed-off-by: Andreas Gal <gal@uci.edu>

--- 66308ede85c2dad6b184fb74a7215b06a173d8f7/sha1_file.c
+++ sha1_file.c
@@ -155,6 +155,8 @@
 
 	inflateInit(&stream);
 	ret = inflate(&stream, 0);
+	if (ret != Z_OK)
+		return NULL;
 	if (sscanf(buffer, "%10s %lu", type, size) != 2)
 		return NULL;
 

