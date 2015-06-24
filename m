From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v8 0/5] Bisect terms
Date: Wed, 24 Jun 2015 17:17:37 +0200
Message-ID: <1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 24 17:18:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7mRC-000885-9i
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 17:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbbFXPSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 11:18:02 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54960 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbbFXPSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 11:18:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5OFHqQL001987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jun 2015 17:17:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5OFHrV9030605;
	Wed, 24 Jun 2015 17:17:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z7mQz-0006Xr-Q4; Wed, 24 Jun 2015 17:17:53 +0200
X-Mailer: git-send-email 2.4.4.414.g59d82e6
In-Reply-To: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 24 Jun 2015 17:17:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5OFHqQL001987
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435763872.81979@FDO4ePsJ1EcFFBSmOall+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272554>

This is a minor iteration over v7 to take into account Junio and
Eric's comments, AND fix an important typo that I introduced in the
strbuf code conversion (I used name_good instead of name_bad). This
fixes the "git bisect visualize" bug I found earlier. I played a bit
with the result and didn't find any bug.

Except for the last patch, it seems at least close to mergeable.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ef0c03c..a37336e 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -134,7 +134,7 @@ You must run `git bisect start` without commits as argument and run
 commits.
 
 Alternative terms: use your own terms
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the builtins terms bad/good and new/old do not satisfy you, you can
 set your own terms.
diff --git a/revision.c b/revision.c
index f22923f..24ce842 100644
--- a/revision.c
+++ b/revision.c
@@ -2083,27 +2083,21 @@ extern void read_bisect_terms(const char **bad, const char **good);
 
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	struct strbuf bisect_refs_buf = STRBUF_INIT;
-	const char *bisect_refs_str;
+	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
-	strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
-	strbuf_addstr(&bisect_refs_buf, name_bad);
-	bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
-	status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
-	free((char *)bisect_refs_str);
+	strbuf_addf(&bisect_refs, "refs/bisect/%s", name_bad);
+	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	strbuf_release(&bisect_refs);
 	return status;
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	struct strbuf bisect_refs_buf = STRBUF_INIT;
-	const char *bisect_refs_str;
+	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
-	strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
-	strbuf_addstr(&bisect_refs_buf, name_bad);
-	bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
-	status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
-	free((char *)bisect_refs_str);
+	strbuf_addf(&bisect_refs, "refs/bisect/%s", name_good);
+	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
+	strbuf_release(&bisect_refs);
 	return status;
 }
 


Antoine Delaite (5):
  bisect: correction of typo
  bisect: replace hardcoded "bad|good" by variables
  bisect: simplify the addition of new bisect terms
  bisect: add the terms old/new
  bisect: allow any terms set by user

 Documentation/git-bisect.txt |  67 +++++++++++++-
 bisect.c                     |  94 +++++++++++++++-----
 git-bisect.sh                | 207 +++++++++++++++++++++++++++++++++++--------
 revision.c                   |  20 ++++-
 t/t6030-bisect-porcelain.sh  |  83 ++++++++++++++++-
 5 files changed, 407 insertions(+), 64 deletions(-)
 mode change 100755 => 100644 git-bisect.sh

-- 
2.4.4.414.g59d82e6
