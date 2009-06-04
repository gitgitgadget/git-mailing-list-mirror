From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] diesys calls die and also reports strerror(errno)
Date: Thu,  4 Jun 2009 06:05:05 +0400
Message-ID: <1244081105-7149-1-git-send-email-aspotashev@gmail.com>
References: <20090603015503.GA14166@coredump.intra.peff.net>
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 04:04:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC2Jq-0005py-DD
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 04:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbZFDCE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 22:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbZFDCEZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 22:04:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12422 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZFDCEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 22:04:25 -0400
Received: by fg-out-1718.google.com with SMTP id 16so148644fgg.17
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QClMxxeEyndgznQ+SPv7ByMPiIkL0VmnCjkumM9YMks=;
        b=JUAynvdAwuqg+XdP63+6wN2vdoBhLDz7/kMyw6IJlkfNB/cXvps80GMAMY/owEfsAg
         b9RMDHPvPEMrAeM+9/Sk+tv53/D72iVdCcUBXap62FXLRwPGJx+FWggjykTN0kYoEBd1
         B9MEq4aBpF0osw0+PZZnot/jxmFzM3iAaEmWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V3AYME8PONiZwFXS9h6T8lebKllH+5Zu72/Y7/mqe5LmFGFi19NwEcxd2mtCnzoqQi
         llP0KwYbdJCr1t4AyeKA3T1I4g+WT5FVpQrSyKoBW0R2voGCyUfpAWzuEB20xnUZaZpY
         d/j7HfuVtFNZDbUsuWpg+rnhSNCIENTUW46hk=
Received: by 10.86.96.12 with SMTP id t12mr1901037fgb.77.1244081066015;
        Wed, 03 Jun 2009 19:04:26 -0700 (PDT)
Received: from localhost.localdomain (ppp91-77-15-110.pppoe.mtu-net.ru [91.77.15.110])
        by mx.google.com with ESMTPS id d6sm595264fga.22.2009.06.03.19.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 19:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <20090603015503.GA14166@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120672>

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
Firstly I was going to write a 'adapt_to_fmt' function which would
double all inclusions of '%', and then use it for strerror(err) and
make printf-like functions happy (actually 'die_routine').

BUT, Have you ever seen an error description containing '%'? I haven't.
So, handling the case of '%'s is not worth injecting several dump lines
into the sources of the Beatiful Content Tracker.



 git-compat-util.h |    1 +
 usage.c           |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f25f7f1..cbfee60 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,6 +162,7 @@ extern char *gitbasename(char *);
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
+extern void diesys(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
diff --git a/usage.c b/usage.c
index 820d09f..e20f696 100644
--- a/usage.c
+++ b/usage.c
@@ -60,6 +60,24 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
+void diesys(const char *err, ...)
+{
+	va_list params;
+	char *fullfmt;
+	const char *strerr;
+
+	va_start(params, err);
+
+	strerr = strerror(errno);
+	if (strchr(strerr, '%'))
+		strerr = "<error description contains '%%'>";
+	fullfmt = xmalloc(strlen(err) + strlen(strerr) + 3);
+	sprintf(fullfmt, "%s: %s", err, strerr);
+	die_routine(fullfmt, params);
+
+	va_end(params);
+}
+
 int error(const char *err, ...)
 {
 	va_list params;
-- 
1.6.2.3
