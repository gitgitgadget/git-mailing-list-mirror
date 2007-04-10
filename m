From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 13:11:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
 <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
 <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
 <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
 <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
 <7v6484vxd5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 06:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMhE-0007aI-0i
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXDJUME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbXDJUME
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:12:04 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43484 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030501AbXDJUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:12:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AKBvVZ009817
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 13:11:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AKBt2e016221;
	Tue, 10 Apr 2007 13:11:56 -0700
In-Reply-To: <7v6484vxd5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44180>



On Tue, 10 Apr 2007, Junio C Hamano wrote:
> 
> Well, I was planning to apply this directly on 'master' after
> giving them another pass.

Goodie. I gave them another pass myself, and noticed a small leak and a 
stupid copy-paste problem, fixed thus..

		Linus

---
diff --git a/read-cache.c b/read-cache.c
index 8fe94cd..f458f50 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -279,7 +279,7 @@ int base_name_compare(const char *name1, int len1, int mode1,
 	c2 = name2[len];
 	if (!c1 && (S_ISDIR(mode1) || S_ISDIRLNK(mode1)))
 		c1 = '/';
-	if (!c2 && (S_ISDIR(mode2) || S_ISDIRLNK(mode1)))
+	if (!c2 && (S_ISDIR(mode2) || S_ISDIRLNK(mode2)))
 		c2 = '/';
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
diff --git a/refs.c b/refs.c
index 229da74..11a67a8 100644
--- a/refs.c
+++ b/refs.c
@@ -229,6 +229,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 	if (!f)
 		return -1;
 	read_packed_refs(f, &refs);
+	fclose(f);
 	ref = refs.packed;
 	retval = -1;
 	while (ref) {
