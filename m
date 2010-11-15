From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Mon, 15 Nov 2010 14:21:17 -0800
Message-ID: <7vaalajkiq.fsf@alter.siamese.dyndns.org>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 23:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI7Qb-0006L3-T5
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 23:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933817Ab0KOWV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 17:21:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997Ab0KOWV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 17:21:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 348172271;
	Mon, 15 Nov 2010 17:21:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMFBOwTf7E1wQI67r6oeTPxBhHg=; b=cYJGNj
	phV930KawbenNJVXubseyzBetEohYHUHAQkxpS1coiL1vuUbga3V1YlyqBJjYTVf
	5b4z7FaLHEWgJAQXVXIp5TppXyj0KDl1VtvPcXIeMjmPoMgriuiDRWUGAV86lli9
	jFhCwbLIBmi1ESYeiIwGBtV8sLH6UHyFF3wwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQ6cJeOJJ7gBcbngx1eq6DqRUCysvnuc
	Ol7DreccRnm3mLmjbl6TmHQMFZoPP9CRfgiYSxzYG4akmh75qxOij4BGStU3s9mJ
	tRZ7o1/pcrWsGAILDj79biQeRZoq69qKRdm05fgf7nkPuoID9+IiiN94SndxOXJJ
	6Cqvz1Afae0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1344F2270;
	Mon, 15 Nov 2010 17:21:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B6BE226F; Mon, 15 Nov 2010
 17:21:27 -0500 (EST)
In-Reply-To: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Mon\,  8 Nov 2010 16\:29\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2723AEA-F106-11DF-BD70-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161518>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> When comparing numbers such as "3" to "$(wc -l)", we should check for
> numerical equality using -eq instead of string equality using = because
> some implementations of wc output extra whitespace.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>  The alternative would be to use 3 = $(wc -l) (sans quotes), but other parts
>  of the test used the -eq method.

... which looks a tad ugly.

How about doing something like below after merging Jonathan's fb3340a
(test-lib: introduce test_line_count to measure files, 2010-10-31) instead?

-- >8 --
test_line_count: learn how to read from a pipe

And use it in t6022 to fix

    test $number = "$(pipe | wc -l)"

which should be spelled without double quotes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/README                |    4 ++-
 t/t6022-merge-rename.sh |   64 +++++++++++++++++++++++-----------------------
 t/test-lib.sh           |    5 +++-
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/t/README b/t/README
index 1a78982..74c892d 100644
--- a/t/README
+++ b/t/README
@@ -501,8 +501,10 @@ library for your script to use.
    helpful output when the test is run with "-v" option.
 
  - test_line_count (= | -lt | -ge | ...) <length> <file>
+   test_line_count (= | -lt | -ge | ...) <length> !<cmd>
 
-   Check whether a file has the length it is expected to.
+   Check whether a file or output of a command has the length it is
+   expected to.
 
  - test_path_is_file <file> [<diagnosis>]
    test_path_is_dir <dir> [<diagnosis>]
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 0c8eddc..c632510 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -306,8 +306,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~HEAD instead" output &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count = 2 "!git ls-files -u" &&
+	test_line_count = 2 "!git ls-files -u dir/file-in-the-way" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -328,8 +328,8 @@ test_expect_success 'Same as previous, but merged other way' '
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count = 2 "!git ls-files -u" &&
+	test_line_count = 2 "!git ls-files -u dir/file-in-the-way" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -363,8 +363,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-not-in-way &&
 
-	test 3 = "$(git ls-files -u | wc -l)" &&
-	test 3 = "$(git ls-files -u dir | wc -l)" &&
+	test_line_count = 3 "!git ls-files -u" &&
+	test_line_count = 3 "!git ls-files -u dir" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -381,9 +381,9 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	git checkout -q renamed-file-has-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
-	test 5 = "$(git ls-files -u | wc -l)" &&
-	test 3 = "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count = 5 "!git ls-files -u" &&
+	test_line_count = 3 "!git ls-files -u dir | grep -v file-in-the-way" &&
+	test_line_count = 2 "!git ls-files -u dir/file-in-the-way" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -417,9 +417,9 @@ test_expect_success 'Same as previous, but merged other way' '
 	git checkout -q dir-in-way^0 &&
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
-	test 5 = "$(git ls-files -u | wc -l)" &&
-	test 3 = "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
-	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+	test_line_count = 5 "!git ls-files -u" &&
+	test_line_count = 3 "!git ls-files -u dir | grep -v file-in-the-way" &&
+	test_line_count = 2 "!git ls-files -u dir/file-in-the-way" &&
 
 	test_must_fail git diff --quiet &&
 	test_must_fail git diff --cached --quiet &&
@@ -457,7 +457,7 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 	git checkout -q rename-dest^0 &&
 	test_must_fail git merge --strategy=recursive source-conflict &&
 
-	test 1 = "$(git ls-files -u | wc -l)" &&
+	test_line_count = 1 "!git ls-files -u" &&
 
 	test_must_fail git diff --quiet &&
 
@@ -496,13 +496,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked
 	mkdir one &&
 	test_must_fail git merge --strategy=recursive rename-two &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
+	test_line_count = 2 "!git ls-files -u" &&
+	test_line_count = 1 "!git ls-files -u one" &&
+	test_line_count = 1 "!git ls-files -u two" &&
 
 	test_must_fail git diff --quiet &&
 
-	test 4 = $(find . | grep -v .git | wc -l) &&
+	test_line_count = 4 "!find . -type d -name .git -prune -o -print" &&
 
 	test -d one &&
 	test -f one~rename-two &&
@@ -516,13 +516,13 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 	git clean -fdqx &&
 	test_must_fail git merge --strategy=recursive rename-two &&
 
-	test 2 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
+	test_line_count = 2 "!git ls-files -u" &&
+	test_line_count = 1 "!git ls-files -u one" &&
+	test_line_count = 1 "!git ls-files -u two" &&
 
 	test_must_fail git diff --quiet &&
 
-	test 3 = $(find . | grep -v .git | wc -l) &&
+	test_line_count = 3 "!find . -type d -name .git -prune -o -print" &&
 
 	test -f one &&
 	test -f two &&
@@ -558,12 +558,12 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename^0 &&
 	test_must_fail git merge --strategy=recursive second-rename &&
 
-	test 5 = "$(git ls-files -s | wc -l)" &&
-	test 3 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
-	test 1 = "$(git ls-files -u original | wc -l)" &&
-	test 2 = "$(git ls-files -o | wc -l)" &&
+	test_line_count = 5 "!git ls-files -s" &&
+	test_line_count = 3 "!git ls-files -u" &&
+	test_line_count = 1 "!git ls-files -u one" &&
+	test_line_count = 1 "!git ls-files -u two" &&
+	test_line_count = 1 "!git ls-files -u original" &&
+	test_line_count = 2 "!git ls-files -o" &&
 
 	test -f one/file &&
 	test -f two/file &&
@@ -598,11 +598,11 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename-redo^0 &&
 	test_must_fail git merge --strategy=recursive second-rename-redo &&
 
-	test 3 = "$(git ls-files -u | wc -l)" &&
-	test 1 = "$(git ls-files -u one | wc -l)" &&
-	test 1 = "$(git ls-files -u two | wc -l)" &&
-	test 1 = "$(git ls-files -u original | wc -l)" &&
-	test 0 = "$(git ls-files -o | wc -l)" &&
+	test_line_count = 3 "!git ls-files -u" &&
+	test_line_count = 1 "!git ls-files -u one" &&
+	test_line_count = 1 "!git ls-files -u two" &&
+	test_line_count = 1 "!git ls-files -u original" &&
+	test_line_count = 0 "!git ls-files -o" &&
 
 	test -f one &&
 	test -f two &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a417bdf..3088322 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -613,7 +613,10 @@ test_line_count () {
 	if test $# != 3
 	then
 		error "bug in the test script: not 3 parameters to test_line_count"
-	elif ! test $(wc -l <"$3") "$1" "$2"
+	elif	case "$3" in
+		!*)	! test $( eval "${3#!}" | wc -l ) "$1" "$2" ;;
+		*)	! test $( wc -l <"$3" ) "$1" "$2" ;;
+		esac
 	then
 		echo "test_line_count: line count for $3 !$1 $2"
 		cat "$3"
