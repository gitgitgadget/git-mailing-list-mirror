From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow testing of _relative family of time formatting and
	parsing functions
Date: Fri, 28 Aug 2009 22:52:32 +0200
Message-ID: <20090828205232.GD9233@blimp.localdomain>
References: <4A97193A.8090502@facebook.com> <20090828060538.GA22416@coredump.intra.peff.net> <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com> <20090828150212.GA6013@coredump.intra.peff.net> <alpine.LFD.2.00.0908281307510.6044@xanadu.home> <20090828190319.GA9233@blimp.localdomain> <20090828191521.GA12292@coredump.intra.peff.net> <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com> <20090828193302.GB9233@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 22:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh8RL-0006F3-2T
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 22:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZH1Uwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZH1Uwo
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 16:52:44 -0400
Received: from mout3.freenet.de ([195.4.92.93]:44538 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbZH1Uwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 16:52:44 -0400
Received: from [195.4.92.21] (helo=11.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1Mh8R2-00084c-Ka; Fri, 28 Aug 2009 22:52:36 +0200
Received: from x54ff.x.pppool.de ([89.59.84.255]:37812 helo=tigra.home)
	by 11.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1Mh8R2-0006A9-Dp; Fri, 28 Aug 2009 22:52:36 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 3CE5E277D8;
	Fri, 28 Aug 2009 22:52:33 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id DEF0836D28; Fri, 28 Aug 2009 22:52:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090828193302.GB9233@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127349>

To complement the testability of approxidate.
---
Alex Riesen, Fri, Aug 28, 2009 21:33:02 +0200:
> 
> It should allow safe testing of this part of the code.

And this should really allow testing of it:

    $ ./test-date '10.days.ago'
    10.days.ago -> bad -> Thu Jan  1 01:00:00 1970
    10.days.ago -> Tue Aug 18 22:50:20 2009

    relative: 10.days.ago -> Fri Dec 22 12:00:00 1989

    relative: 10 days ago, out of Fri Dec 22 12:00:00 1989

    $

According to Wikipedia, absolutely nothing of note happened
at the day 10 January, 1990.

 test-date.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/test-date.c b/test-date.c
index 62e8f23..dcc7973 100644
--- a/test-date.c
+++ b/test-date.c
@@ -4,6 +4,17 @@ int main(int argc, char **argv)
 {
 	int i;
 
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
@@ -15,6 +26,12 @@ int main(int argc, char **argv)
 
 		t = approxidate(argv[i]);
 		printf("%s -> %s\n", argv[i], ctime(&t));
+
+		t = approxidate_relative(argv[i], &when);
+		printf("relative: %s -> %s\n", argv[i], ctime(&t));
+
+		printf("relative: %s, out of %s\n",
+		       show_date_relative(t, 0, &when), ctime(&t));
 	}
 	return 0;
 }
-- 
1.6.4.1.263.g468a
