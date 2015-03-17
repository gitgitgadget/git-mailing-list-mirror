From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/14] diff_opt_parse(): use convert_i() when handling --abbrev=<num>
Date: Tue, 17 Mar 2015 17:00:16 +0100
Message-ID: <1426608016-2978-15-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvU-0001I3-DP
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbbCQQAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50538 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753562AbbCQQAq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:46 -0400
X-AuditID: 12074411-f79fa6d000006b8a-c1-55084fa625d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 04.23.27530.6AF48055; Tue, 17 Mar 2015 12:00:38 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSp023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:37 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvMnyPU4MJ3VYuuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZ7zpmMha0
	s1fMbTrF3sD4gLWLkZNDQsBE4uCM/SwQtpjEhXvr2boYuTiEBC4zShw6NA/KOckk8XbRfbAO
	NgFdiUU9zUwgtoiAmsTEtkNg3cwCKRKdf+6wg9jCAqES8zq6wGpYBFQlXnV9ZgaxeQVcJJ7s
	P8oOsU1O4vzxn2BxTqD4iz+vGUFsIQFnibXTJrNNYORdwMiwilEuMac0Vzc3MTOnODVZtzg5
	MS8vtUjXVC83s0QvNaV0EyMkfAR3MM44KXeIUYCDUYmHtyGPPVSINbGsuDL3EKMkB5OSKG+e
	B0eoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeO+5AOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0
	xJLU7NTUgtQimKwMB4eSBK+OH1CjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCg2
	4ouB0QGS4gHaawPSzltckJgLFIVoPcWoy3Fnyv9FTEIsefl5qVLivEEgRQIgRRmleXArYMni
	FaM40MfCvHNAqniAiQZu0iugJUxAS1ra2UCWlCQipKQaGJ0uhYnm3WRPtGaN/nQx/MrKAH5F
	hWviyxPKK6oEqldbdUbPjs5nfrBPnF1UIWNL9KTlpjaC+esYUjWezmfUXvq14qai0onoa1zX
	Dt1XL2vi9i/d9OcHX2yTgvB6gSnvj4ZdXDbT6v2t1rdye65f8lLeePSTdc38eB3n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265642>

die() with an error message if the argument is not a non-negative
integer. This change tightens up parsing: '+' and '-', leading
whitespace, and trailing junk are all disallowed now.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index be389ae..1cc5428 100644
--- a/diff.c
+++ b/diff.c
@@ -3830,7 +3830,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (skip_prefix(arg, "--abbrev=", &arg)) {
-		options->abbrev = strtoul(arg, NULL, 10);
+		if (convert_i(arg, 10, &options->abbrev))
+			die("--abbrev requires an integer argument");
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev = MINIMUM_ABBREV;
 		else if (40 < options->abbrev)
-- 
2.1.4
