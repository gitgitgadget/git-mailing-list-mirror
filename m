From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/14] diff_opt_parse(): use convert_i() when handling "-l<num>"
Date: Tue, 17 Mar 2015 17:00:15 +0100
Message-ID: <1426608016-2978-14-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvT-0001I3-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbbCQQAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:48 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44999 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932517AbbCQQAi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:38 -0400
X-AuditID: 12074413-f79f26d0000030e7-e5-55084fa593b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 65.3C.12519.5AF48055; Tue, 17 Mar 2015 12:00:37 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSo023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:36 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvUnyPUYF+/rEXXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6Mo5svsRf8
	ZKvY07uEtYHxMmsXIyeHhICJxOKr/SwQtpjEhXvr2boYuTiEBC4zSrz5MY8JwjnJJHHw4yWw
	KjYBXYlFPc1MILaIgJrExLZDYHFmgRSJzj932EFsYYEAifsbvjKD2CwCqhJbZq9gBLF5BVwk
	dn1azgaxTU7i/PGfYDWcQPEXf16D1QgJOEusnTaZbQIj7wJGhlWMcok5pbm6uYmZOcWpybrF
	yYl5ealFuuZ6uZkleqkppZsYIeEjvINx10m5Q4wCHIxKPLwNeeyhQqyJZcWVuYcYJTmYlER5
	8zw4QoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8N5xB8rxpiRWVqUW5cOkpDlYlMR51Zao+wkJ
	pCeWpGanphakFsFkZTg4lCR4dfyAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB
	sRFfDIwOkBQP0N4KkHbe4oLEXKAoROspRl2OO1P+L2ISYsnLz0uVEucNAikSACnKKM2DWwFL
	Fq8YxYE+FuZVBqniASYauEmvgJYwAS1paWcDWVKSiJCSamAMXyR5bH3mc0fBv62tQqmrzSJa
	zHnenv+x/4jOle7IR0ePaplkf0hz75wTLq0buOke95fnOgU/8zgZN6zlLZ+Ut+Kl1vyAAIdi
	w54y5dVK84I1GFYudmh9JCdozqlyUcDMOKCLSbumx2TuFdZnFU/UFhj+z9z276e+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265640>

die() with an error message if the argument is not a non-negative
integer. This change tightens up parsing: '+' and '-', leading
whitespace, and trailing junk are all disallowed now.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index bc1e3c3..be389ae 100644
--- a/diff.c
+++ b/diff.c
@@ -3799,7 +3799,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if ((argcount = short_opt('l', av, &optarg))) {
-		options->rename_limit = strtoul(optarg, NULL, 10);
+		if (convert_i(optarg, 10, &options->rename_limit))
+			die("-l requires a non-negative integer argument");
 		return argcount;
 	}
 	else if ((argcount = short_opt('S', av, &optarg))) {
-- 
2.1.4
