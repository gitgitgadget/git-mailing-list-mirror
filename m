From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/18] is_refname_available(): convert local variable "dirname" to strbuf
Date: Mon, 11 May 2015 17:25:06 +0200
Message-ID: <1431357920-25090-5-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:25:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrpaU-0002S7-FH
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbbEKPZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61958 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638AbbEKPZg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:36 -0400
X-AuditID: 1207440e-f79bc6d000000c43-6c-5550c9ef9ac8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.55.03139.FE9C0555; Mon, 11 May 2015 11:25:35 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnG002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:33 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqPv+ZECowa0/6hZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7ox5BxcyFfzjqFgw/x57A2M/excjJ4eEgIlE//bXLBC2mMSFe+vZuhi5
	OIQELjNKXDjykhEkISRwnEliyoECEJtNQFdiUU8zE4gtIqAmMbHtEAtIA7PALkaJe0ungk0S
	FoiR+LzgI9gGFgFViUft98DivAIuEnMuX4DaLCdx/vhPZhCbU8BVYunVyywQy1wkmh7fY5nA
	yLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkiQ8e1gbF8vc4hRgINR
	iYfX4IJ/qBBrYllxZe4hRkkOJiVR3l97A0KF+JLyUyozEosz4otKc1KLDzFKcDArifAqrwHK
	8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeBtPADUKFqWmp1akZeaU
	IKSZODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC9X0HaeYsLEnOBohCtpxgVpcR5ZYHR
	LyQAksgozYMbC0sdrxjFgb4U5l0P0s4DTDtw3a+ABjMBDXaMAxtckoiQkmpg3OJ1a7ZqzUa7
	/uW5q4OS+9j+mMz9dSLwx7m/Qpzv131azVZ31bz9sJlfU/ABxlOvk05PaJp4TeLrnt3XRV+n
	7Le9us0tp3rKp846FXY+TRbVNX6KSQ9ld/DcUDI60fpmXVGb7zQvjrBEwW9Zux0v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268781>

This change wouldn't be worth it by itself, but in a moment we will
use the strbuf for more string juggling.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 9d87e84..faabd68 100644
--- a/refs.c
+++ b/refs.c
@@ -887,9 +887,8 @@ static int is_refname_available(const char *refname,
 				struct ref_dir *dir)
 {
 	const char *slash;
-	size_t len;
 	int pos;
-	char *dirname;
+	struct strbuf dirname = STRBUF_INIT;
 
 	/*
 	 * For the sake of comments in this function, suppose that
@@ -955,11 +954,10 @@ static int is_refname_available(const char *refname,
 	 * names are in the "refs/foo/bar/" namespace, because they
 	 * *do* conflict.
 	 */
-	len = strlen(refname);
-	dirname = xmallocz(len + 1);
-	sprintf(dirname, "%s/", refname);
-	pos = search_ref_dir(dir, dirname, len + 1);
-	free(dirname);
+	strbuf_addstr(&dirname, refname);
+	strbuf_addch(&dirname, '/');
+	pos = search_ref_dir(dir, dirname.buf, dirname.len);
+	strbuf_release(&dirname);
 
 	if (pos >= 0) {
 		/*
-- 
2.1.4
