From: Jeff King <peff@peff.net>
Subject: [PATCH 2alt/2] work around unreliable gmtime errors on AIX
Date: Tue, 1 Apr 2014 03:45:59 -0400
Message-ID: <20140401074559.GA22591@sigill.intra.peff.net>
References: <20140326212227.GC6991@hashpling.org>
 <20140326215741.GA17716@sigill.intra.peff.net>
 <20140326224616.GA9454@hashpling.org>
 <20140327224837.GB32434@sigill.intra.peff.net>
 <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
 <20140328184710.GA29987@sigill.intra.peff.net>
 <xmqqppl69meh.fsf@gitster.dls.corp.google.com>
 <20140328190548.GB30739@sigill.intra.peff.net>
 <xmqq8uru9l51.fsf@gitster.dls.corp.google.com>
 <20140401073848.GA22023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 09:46:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUtOZ-0005oJ-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 09:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbaDAHqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 03:46:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:51553 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751199AbaDAHqB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 03:46:01 -0400
Received: (qmail 11397 invoked by uid 102); 1 Apr 2014 07:46:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 02:46:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 03:45:59 -0400
Content-Disposition: inline
In-Reply-To: <20140401073848.GA22023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245575>

AIX's gmtime will happily overflow the tm_year field. Let's
catch this error before handing the value to gmtime.

Signed-off-by: Jeff King <peff@peff.net>
---
This is an alternative to loosening the test in t4212.

It's really not _that_ ugly.  The "LL" here may not be portable, though.
32-bit systems can't represent this timestamp at all (so they're safe),
but I don't know what would be the best way to conditionally compile
here.

 compat/gmtime.c  | 10 ++++++++++
 config.mak.uname |  1 +
 2 files changed, 11 insertions(+)

diff --git a/compat/gmtime.c b/compat/gmtime.c
index 75a5835..f95ba50 100644
--- a/compat/gmtime.c
+++ b/compat/gmtime.c
@@ -12,6 +12,16 @@ struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
 {
 	struct tm *ret;
 
+	/*
+	 * Some systems, like AIX, will happily overflow the tm_year field.
+	 * So let's recognize obviously out-of-bound data before it hits gmtime
+	 * and just mark it as an error. This date is ~316 million years in the
+	 * future, which is far enough that nobody should care, but close
+	 * enough for the year to fit into a 32-bit tm_year.
+	 */
+	if (*timep > 9999999999999999LL)
+		return NULL;
+
 	ret = gmtime_r(timep, result);
 
 	/*
diff --git a/config.mak.uname b/config.mak.uname
index 0e22ac0..c1110ad 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -236,6 +236,7 @@ ifeq ($(uname_S),AIX)
 		INLINE = ''
 	endif
 	GIT_TEST_CMP = cmp
+	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
-- 
1.9.1.656.ge8a0637
