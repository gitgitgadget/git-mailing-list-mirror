From: Tom Miller <jackerran@gmail.com>
Subject: [PATCH 2/3] fetch --prune: Always print header url
Date: Wed, 18 Dec 2013 15:22:55 -0600
Message-ID: <1387401776-30994-2-git-send-email-jackerran@gmail.com>
References: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Cc: Tom Miller <jackerran@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 22:23:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOaY-0005U0-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab3LRVXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:23:18 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:52106 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab3LRVXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:23:14 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so208340qcx.32
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2juRABj9na88iH8S4ugYXIevjNoxpxKKrbY+X4lkU8M=;
        b=PSM1nbKSTwlX7xTHNCU5Jr4wgmR9dspqsQFO9zRwDGEq4v5oU1LyAfLzPJ61OXI4O8
         voXv/KgsiA7n4+nOLPpxoPoOdIFRL0PYhTBE/oQu89EQT1M4QzgFdiKvmtfS6qmynTq7
         6Vend4QuNgLShqIJp6V4JYDQFHPdV6SouOgFwtMd5GdtVtlt/vY03VfLbPkkZ7S36n6r
         o9gnkO44xM3ODmQOSInJMamshBhvqBn2Uog4iQXdZh9EfJWCtRX6fxogAIr/C/jtQYZQ
         KKkzZ0+xGWnJSlaxPZplQS54qv9vh6ioYYPKLq1ZKU3CL9yv1GEVNNIpQbfuOBdq/KX+
         MEoQ==
X-Received: by 10.49.76.66 with SMTP id i2mr57683435qew.35.1387401793413;
        Wed, 18 Dec 2013 13:23:13 -0800 (PST)
Received: from localhost.localdomain (24-197-19-70.static.leds.al.charter.com. [24.197.19.70])
        by mx.google.com with ESMTPSA id 4sm3512957qak.11.2013.12.18.13.23.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 13:23:13 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1.163.gd7aced9
In-Reply-To: <1387401776-30994-1-git-send-email-jackerran@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239487>

If fetch --prune is run with no new refs to fetch, but it has refs
to prune. Then, the header url is not printed as it would if there were
new refs to fetch. the following is example output showing this
behavior:

$ git fetch --prune --dry-run origin
 x [deleted]         (none)     -> origin/world

After this patch the output of fetch --prune should look like this:

$ git fetch --prune --dry-run origin
From https://github.com/git/git
 x [deleted]         (none)     -> origin/test

Signed-off-by: Tom Miller <jackerran@gmail.com>
---
 builtin/fetch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b3145f6..e50b697 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -732,7 +732,8 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
-static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
+static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
+			const char *raw_url)
 {
 	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
@@ -744,6 +745,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 		if (!dry_run)
 			result |= delete_ref(ref->name, NULL, 0);
 		if (verbosity >= 0) {
+			print_url(raw_url);
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
 				TRANSPORT_SUMMARY(_("[deleted]")),
 				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
@@ -878,11 +880,12 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (ref_count) {
-			prune_refs(refs, ref_count, ref_map);
+			prune_refs(refs, ref_count, ref_map, transport->url);
 		} else {
 			prune_refs(transport->remote->fetch,
 				   transport->remote->fetch_refspec_nr,
-				   ref_map);
+				   ref_map,
+				   transport->url);
 		}
 	}
 	free_refs(ref_map);
-- 
1.8.5.1.163.gd7aced9
