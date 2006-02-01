From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 18:09:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311807470.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
 <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 03:11:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F47TI-00057X-Tu
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 03:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWBACLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 21:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWBACLq
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 21:11:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964876AbWBACLp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 21:11:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1129XDZ021429
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 18:09:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1129Wb4013621;
	Tue, 31 Jan 2006 18:09:32 -0800
To: Ray Lehtiniemi <rayl@mail.com>
In-Reply-To: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15376>



On Tue, 31 Jan 2006, Linus Torvalds wrote:
> 
> We still have one unused bit in the cache-entry "ce_flags", so we wouldn't 
> even need to break any existing index files with it.

In case it wasn't clear, the _core_ of this optimization would be as 
simple as something like the appended.

The real meat is just making sure that CE_VALID gets set/cleared properly.

(That's also the most complex part, of course, but this trivial patch 
might help show the basic idea)

		Linus

---
diff --git a/cache.h b/cache.h
index bdbe2d6..7adc2e6 100644
--- a/cache.h
+++ b/cache.h
@@ -91,6 +91,7 @@ struct cache_entry {
 #define CE_NAMEMASK  (0x0fff)
 #define CE_STAGEMASK (0x3000)
 #define CE_UPDATE    (0x4000)
+#define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
 #define create_ce_flags(len, stage) htons((len) | ((stage) << CE_STAGESHIFT))
diff --git a/read-cache.c b/read-cache.c
index c5474d4..738fe78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -148,7 +148,16 @@ static int ce_match_stat_basic(struct ca
 
 int ce_match_stat(struct cache_entry *ce, struct stat *st)
 {
-	unsigned int changed = ce_match_stat_basic(ce, st);
+	unsigned int changed;
+
+	/*
+	 * If it's marked as always valid in the index, it's 
+	 * valid whatever the checked-out copy says
+	 */
+	if (ce->ce_flags & htons(CE_VALID))
+		return 0;
+
+	changed = ce_match_stat_basic(ce, st);
 
 	/*
 	 * Within 1 second of this sequence:
