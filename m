From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 0/5] git bisect old/new
Date: Tue, 23 Jun 2015 14:54:39 +0200
Message-ID: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 23 19:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7S1G-0008Ek-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbbFWR3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:29:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46811 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761AbbFWR3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:29:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5NHTeVs023172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2015 19:29:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NHTg48009522;
	Tue, 23 Jun 2015 19:29:42 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z7S10-0004Dt-0O; Tue, 23 Jun 2015 19:29:42 +0200
X-Mailer: git-send-email 2.4.4.414.ge37915c
In-Reply-To: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Jun 2015 19:29:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5NHTeVs023172
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435685385.57792@og3WSTVsfmg1NfMHhxhp9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272465>

Hi,

I fixed a few minor issues in v6. Patch between my version and v6 is
below. I also pushed my branch here:

  https://github.com/moy/git/tree/bisect-terms

Not visible in the patch below: I squashed PATCH 5 into PATCH 3 to
avoid the pattern "break stuff and then repair it".

The first two patches seem ready.

PATCH 4 (add old/new) is still buggy. When starting a bisection with

  git bisect start $old $new

the command "git bisect visualize" does not work (it shows no commit).

I consider PATCH 5 as WIP, I think it would need a lot of polishing
and testing to be mergeable. I think a reasonable objective for now it
to get old/new working in the user-interface, and drop PATCH 5 from
the series when it gets merged. The existance of PATCH 5 is a very
good thing even if it doesn't get merged:

* The fact that it's possible to do it on top of the series shows that
  we make the code more generic. I think it's important that
  regardless of features, the code moves in the right direction.

* The patch can be taken over later by someone else.

diff --git a/bisect.c b/bisect.c
index 7492fdc..ab09650 100644
--- a/bisect.c
+++ b/bisect.c
@@ -921,7 +921,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp) {
-		if (errno==2) {
+		if (errno == ENOENT) {
 			*read_bad = "bad";
 			*read_good = "good";
 			return;
diff --git a/git-bisect.sh b/git-bisect.sh
index 7da22b1..8ef2b94 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -541,7 +541,7 @@ get_terms () {
 		{
 		read NAME_BAD
 		read NAME_GOOD
-		}<"$GIT_DIR/BISECT_TERMS"	
+		} <"$GIT_DIR/BISECT_TERMS"
 	fi
 }
 
@@ -605,8 +605,8 @@ bisect_terms () {
 			echo "1" >"$GIT_DIR/TERMS_DEFINED"
 			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
 		else
-			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it. 
-Use 'git bisect terms' to see the current terms. 
+			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it.
+Use 'git bisect terms' to see the current terms.
 Otherwise, to start a new bisection with new terms, please use 'git bisect reset' and set the terms before the start")"
 		fi ;;
 	*)
diff --git a/revision.c b/revision.c
index 27750ac..f22923f 100644
--- a/revision.c
+++ b/revision.c
@@ -2083,18 +2083,28 @@ extern void read_bisect_terms(const char **bad, const char **good);
 
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	char bisect_refs_path[256];
-	strcpy(bisect_refs_path, "refs/bisect/");
-	strcat(bisect_refs_path, name_bad);
-	return for_each_ref_in_submodule(submodule, bisect_refs_path, fn, cb_data);
+	struct strbuf bisect_refs_buf = STRBUF_INIT;
+	const char *bisect_refs_str;
+	int status;
+	strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
+	strbuf_addstr(&bisect_refs_buf, name_bad);
+	bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
+	status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
+	free((char *)bisect_refs_str);
+	return status;
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	char bisect_refs_path[256];
-	strcpy(bisect_refs_path, "refs/bisect/");
-	strcat(bisect_refs_path, name_good);
-	return for_each_ref_in_submodule(submodule, bisect_refs_path, fn, cb_data);
+	struct strbuf bisect_refs_buf = STRBUF_INIT;
+	const char *bisect_refs_str;
+	int status;
+	strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
+	strbuf_addstr(&bisect_refs_buf, name_bad);
+	bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
+	status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
+	free((char *)bisect_refs_str);
+	return status;
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index d91116e..289dbb0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -781,12 +781,12 @@ test_expect_success 'bisect start with one new and old' '
 	git bisect new &&
 	git bisect new >bisect_result &&
 	grep "$HASH2 is the first new commit" bisect_result &&
-	git bisect log > log_to_replay.txt &&
+	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with old and new' '
-	git bisect replay log_to_replay.txt > bisect_result &&
+	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first new commit" bisect_result &&
 	git bisect reset
 '
@@ -806,12 +806,12 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-	git bisect log > log_to_replay.txt &&
+	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with term1 and term2' '
-	git bisect replay log_to_replay.txt > bisect_result &&
+	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
 	git bisect reset
 '
@@ -823,7 +823,7 @@ test_expect_success 'bisect start term1 term2' '
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-	git bisect log > log_to_replay.txt &&
+	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 

Subject: [PATCH v7 0/5] git bisect old/new

Hi,

I fixed a few minor issues in v6. Patch between my version and v6 is
below. I also pushed my branch here:

  https://github.com/moy/git/tree/bisect-terms

diff --git a/bisect.c b/bisect.c
index 7492fdc..ab09650 100644
--- a/bisect.c
+++ b/bisect.c
@@ -921,7 +921,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp) {
-		if (errno==2) {
+		if (errno == ENOENT) {
 			*read_bad = "bad";
 			*read_good = "good";
 			return;
diff --git a/git-bisect.sh b/git-bisect.sh
index 7da22b1..8ef2b94 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -541,7 +541,7 @@ get_terms () {
 		{
 		read NAME_BAD
 		read NAME_GOOD
-		}<"$GIT_DIR/BISECT_TERMS"	
+		} <"$GIT_DIR/BISECT_TERMS"
 	fi
 }
 
@@ -605,8 +605,8 @@ bisect_terms () {
 			echo "1" >"$GIT_DIR/TERMS_DEFINED"
 			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
 		else
-			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it. 
-Use 'git bisect terms' to see the current terms. 
+			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it.
+Use 'git bisect terms' to see the current terms.
 Otherwise, to start a new bisection with new terms, please use 'git bisect reset' and set the terms before the start")"
 		fi ;;
 	*)
diff --git a/revision.c b/revision.c
index 27750ac..f22923f 100644
--- a/revision.c
+++ b/revision.c
@@ -2083,18 +2083,28 @@ extern void read_bisect_terms(const char **bad, const char **good);
 
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	char bisect_refs_path[256];
-	strcpy(bisect_refs_path, "refs/bisect/");
-	strcat(bisect_refs_path, name_bad);
-	return for_each_ref_in_submodule(submodule, bisect_refs_path, fn, cb_data);
+	struct strbuf bisect_refs_buf = STRBUF_INIT;
+	const char *bisect_refs_str;
+	int status;
+	strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
+	strbuf_addstr(&bisect_refs_buf, name_bad);
+	bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
+	status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
+	free((char *)bisect_refs_str);
+	return status;
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	char bisect_refs_path[256];
-	strcpy(bisect_refs_path, "refs/bisect/");
-	strcat(bisect_refs_path, name_good);
-	return for_each_ref_in_submodule(submodule, bisect_refs_path, fn, cb_data);
+	struct strbuf bisect_refs_buf = STRBUF_INIT;
+	const char *bisect_refs_str;
+	int status;
+	strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
+	strbuf_addstr(&bisect_refs_buf, name_bad);
+	bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
+	status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
+	free((char *)bisect_refs_str);
+	return status;
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index d91116e..289dbb0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -781,12 +781,12 @@ test_expect_success 'bisect start with one new and old' '
 	git bisect new &&
 	git bisect new >bisect_result &&
 	grep "$HASH2 is the first new commit" bisect_result &&
-	git bisect log > log_to_replay.txt &&
+	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with old and new' '
-	git bisect replay log_to_replay.txt > bisect_result &&
+	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first new commit" bisect_result &&
 	git bisect reset
 '
@@ -806,12 +806,12 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-	git bisect log > log_to_replay.txt &&
+	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with term1 and term2' '
-	git bisect replay log_to_replay.txt > bisect_result &&
+	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
 	git bisect reset
 '
@@ -823,7 +823,7 @@ test_expect_success 'bisect start term1 term2' '
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-	git bisect log > log_to_replay.txt &&
+	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
Antoine Delaite (5):
  bisect: correction of typo
  bisect: replace hardcoded "bad|good" by variables
  bisect: simplify the addition of new bisect terms
  bisect: add the terms old/new
  bisect: allows any terms set by user

 Documentation/git-bisect.txt |  67 +++++++++++++-
 bisect.c                     |  94 +++++++++++++++-----
 git-bisect.sh                | 207 +++++++++++++++++++++++++++++++++++--------
 revision.c                   |  26 +++++-
 t/t6030-bisect-porcelain.sh  |  83 ++++++++++++++++-
 5 files changed, 413 insertions(+), 64 deletions(-)
 mode change 100755 => 100644 git-bisect.sh

-- 
2.4.4.414.ge37915c
