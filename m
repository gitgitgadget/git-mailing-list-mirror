From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] parse_date: fix signedness in timezone calculation
Date: Sun, 4 Jul 2010 07:00:17 -0400
Message-ID: <20100704110017.GA23121@sigill.intra.peff.net>
References: <20100704104834.GA23070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 13:01:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVMxM-0000Ub-1v
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 13:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab0GDLAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 07:00:21 -0400
Received: from peff.net ([208.65.91.99]:33951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757172Ab0GDLAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 07:00:20 -0400
Received: (qmail 29597 invoked by uid 107); 4 Jul 2010 11:01:15 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 04 Jul 2010 07:01:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jul 2010 07:00:17 -0400
Content-Disposition: inline
In-Reply-To: <20100704104834.GA23070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150222>

When no timezone is specified, we deduce the offset by
subtracting the result of mktime from our calculated
timestamp.

However, our timestamp is stored as an unsigned integer,
meaning we perform the subtraction as unsigned. For a
negative offset, this means we wrap to a very high number,
and our numeric timezone is in the millions of hours. You
can see this bug by doing:

   $ TZ=EST \
     GIT_AUTHOR_DATE='2010-06-01 10:00' \
     git commit -a -m foo
   $ git cat-file -p HEAD | grep author
   author Jeff King <peff@peff.net> 1275404416 +119304128

Instead, we should perform this subtraction as a time_t, the
same type that mktime returns.

Signed-off-by: Jeff King <peff@peff.net>
---
Are there any platforms with an unsigned time_t? In that case, we would
need to use a regular "long" to get signedness. Presumably on such
platforms "long" will grow with time_t to 64-bits so we don't create a
Y2038 problem (though most of the rest of the code uses "unsigned long"
interchangeably with time_t, so we have a Y2106 problem in that case
anyway).

 date.c          |    2 +-
 t/t0006-date.sh |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 68cdcaa..3c981f7 100644
--- a/date.c
+++ b/date.c
@@ -635,7 +635,7 @@ int parse_date_toffset(const char *date, unsigned long *timestamp, int *offset)
 	/* mktime uses local timezone */
 	*timestamp = tm_to_time_t(&tm);
 	if (*offset == -1)
-		*offset = (*timestamp - mktime(&tm)) / 60;
+		*offset = ((time_t)*timestamp - mktime(&tm)) / 60;
 
 	if (*timestamp == -1)
 		return -1;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 3ea4f9e..b2df4fe 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -39,6 +39,7 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST
 
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
-- 
1.7.2.rc1.209.g2a36c
