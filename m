From: Linus Torvalds <torvalds@osdl.org>
Subject: Improve config file escape sanity checking
Date: Tue, 11 Oct 2005 12:13:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510111211080.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 11 21:17:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPPa9-0005vU-Md
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 21:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJKTOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 15:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVJKTOM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 15:14:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932314AbVJKTOL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 15:14:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BJE04s029264
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 12:14:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BJDxrV022353;
	Tue, 11 Oct 2005 12:14:00 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9979>


I had meant to disallow unknown escape characters in the config file 
parser, but instead an unknown escaped character would silently pass 
through as itself. That's correct for some cases (notably '\' itself), but 
wasn't correct in general.

This fixes it, and makes the parser write a nice error message if the 
config file contains bogus escaped characters.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/config.c b/config.c
index f3c4fa4..510456c 100644
--- a/config.c
+++ b/config.c
@@ -64,7 +64,12 @@ static char *parse_value(void)
 			case 'n':
 				c = '\n';
 				break;
-			return NULL;
+			/* Some characters escape as themselves */
+			case '\\': case '"':
+				break;
+			/* Reject unknown escape sequences */
+			default:
+				return NULL;
 			}
 			value[len++] = c;
 			continue;
