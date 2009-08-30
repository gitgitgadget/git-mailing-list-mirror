From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Allow testing of _relative family of time formatting
	and parsing functions
Date: Sun, 30 Aug 2009 11:15:41 +0200
Message-ID: <20090830091541.GB14928@blimp.localdomain>
References: <20090828150212.GA6013@coredump.intra.peff.net> <alpine.LFD.2.00.0908281307510.6044@xanadu.home> <20090828190319.GA9233@blimp.localdomain> <20090828191521.GA12292@coredump.intra.peff.net> <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com> <20090828193302.GB9233@blimp.localdomain> <20090828205232.GD9233@blimp.localdomain> <7vk50mz41e.fsf@alter.siamese.dyndns.org> <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com> <20090830091346.GA14928@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 11:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhgWD-0007LC-NG
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 11:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbZH3JP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 05:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZH3JP5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 05:15:57 -0400
Received: from mout0.freenet.de ([195.4.92.90]:48862 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbZH3JP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 05:15:57 -0400
Received: from [195.4.92.27] (helo=17.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MhgVm-0008Cl-S3; Sun, 30 Aug 2009 11:15:46 +0200
Received: from x5b2e.x.pppool.de ([89.59.91.46]:59299 helo=tigra.home)
	by 17.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1MhgVm-0003Tl-GQ; Sun, 30 Aug 2009 11:15:46 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 4F916277D8;
	Sun, 30 Aug 2009 11:15:42 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 131E236D28; Sun, 30 Aug 2009 11:15:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090830091346.GA14928@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127401>

To complement the testability of approxidate.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Sun, Aug 30, 2009 11:13:46 +0200:
> test-date.c is updated and shall follow in a moment.

here it goes.

 test-date.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/test-date.c b/test-date.c
index 62e8f23..4cb146d 100644
--- a/test-date.c
+++ b/test-date.c
@@ -4,6 +4,19 @@ int main(int argc, char **argv)
 {
 	int i;
 
+	/* see date.c, function show_date_relative */
+	char timebuf[(sizeof(long) * 5 / 2 + sizeof(" minutes ago,")) * 2];
+	struct tm tm;
+	struct timeval when = {0, 0};
+	tm.tm_sec  = 0;
+	tm.tm_min  = 0;
+	tm.tm_hour = 12;
+	tm.tm_mday = 1;
+	tm.tm_mon  = 0  /* January */;
+	tm.tm_year = 90 /* 1990 */ ;
+	tm.tm_isdst = -1;
+	when.tv_sec = mktime(&tm);
+
 	for (i = 1; i < argc; i++) {
 		char result[100];
 		time_t t;
@@ -15,6 +28,13 @@ int main(int argc, char **argv)
 
 		t = approxidate(argv[i]);
 		printf("%s -> %s\n", argv[i], ctime(&t));
+
+		t = approxidate_relative(argv[i], &when);
+		printf("relative: %s -> %s", argv[i], ctime(&t));
+
+		printf("relative: %s, out of %s",
+		       show_date_relative(t, 0, &when, timebuf,sizeof(timebuf)),
+		       ctime(&t));
 	}
 	return 0;
 }
-- 
1.6.4.1.294.g16262
