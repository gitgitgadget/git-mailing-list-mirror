From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 04/11] remote: use the new functions for handling --prune options
Date: Wed,  4 Dec 2013 06:44:43 +0100
Message-ID: <1386135890-13954-5-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5OT-00088n-C1
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab3LDFw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:52:59 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53414 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306Ab3LDFw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:58 -0500
X-AuditID: 12074412-b7fc96d0000023d5-3e-529ec177f8a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BA.80.09173.771CE925; Wed,  4 Dec 2013 00:45:27 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCA9016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:26 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqFt+cF6QwcJVmhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ1xY5JZwTXOiu2Ln7A0MP5j
	72Lk5JAQMJE4u+44G4QtJnHh3nogm4tDSOAyo8Tcz0eYQBJCAueZJD63SYPYbAK6Eot6msHi
	IgLiEm+PzwQaxMHBLBAhcehtCUhYWMBf4nvrK7ASFgFViekvL4HZvAIuEss7ZrFA7FKQ6Fzz
	nxHE5hRwlejoXcIMMkYIqObeWacJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVm
	luilppRuYoQEidAOxvUn5Q4xCnAwKvHwJnDOCxJiTSwrrsw9xCjJwaQkylu/HSjEl5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhNemDCjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgm
	K8PBoSTBa3UAqFGwKDU9tSItM6cEIc3EwQkiuEA28ABtMAUp5C0uSMwtzkyHKDrFqCglzhsG
	khAASWSU5sENgMXzK0ZxoH+EeT1BqniAqQCu+xXQYCagweavZoEMLklESEk1MG4JujvNymxX
	QmVrcl1G0L9NIqffXwpMjinb7LC7ZJqbhfYr+9YnMW0n3YP530+9YyM66Ual1EteWav+l372
	+yfucvKdIr/x/r5LnZ4TEqQWFtkvfH1Mr7JYR35ORZdQxbuk11qGWS4spyz6Lfum7eCbGS7O
	Hvt8deHt9kNSv5g/hX69/iLCVYmlOCPRUIu5qDgRAAlG2arCAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238761>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c08dfa8..09b965a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1372,10 +1372,12 @@ static int get_remote_default(const char *key, const char *value, void *priv)
 
 static int update(int argc, const char **argv)
 {
-	int i, prune = -1;
+	int i;
+	struct prune_option prune_option = PRUNE_OPTION_INIT;
 	struct option options[] = {
-		OPT_BOOL('p', "prune", &prune,
-			 N_("prune remotes after fetching")),
+		{ OPTION_CALLBACK, 'p', "prune", &prune_option, N_("pattern"),
+			N_("prune remotes after fetching"),
+			PARSE_OPT_NOARG, prune_option_parse },
 		OPT_END()
 	};
 	struct argv_array fetch_argv = ARGV_ARRAY_INIT;
@@ -1387,8 +1389,7 @@ static int update(int argc, const char **argv)
 
 	argv_array_push(&fetch_argv, "fetch");
 
-	if (prune != -1)
-		argv_array_push(&fetch_argv, prune ? "--prune" : "--no-prune");
+	argv_push_prune_option(&fetch_argv, &prune_option);
 	if (verbose)
 		argv_array_push(&fetch_argv, "-v");
 	argv_array_push(&fetch_argv, "--multiple");
-- 
1.8.4.3
