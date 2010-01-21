From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'rerere forget' work from a subdirectory.
Date: Thu, 21 Jan 2010 00:42:07 -0800
Message-ID: <7v7hrbx31c.fsf@alter.siamese.dyndns.org>
References: <7veill3wgc.fsf@alter.siamese.dyndns.org>
 <4B56F916.7090503@viscovery.net> <4B580F14.5060105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 09:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXscQ-0006lX-1q
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 09:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab0AUImR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 03:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233Ab0AUImR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 03:42:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0AUImQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 03:42:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3A2937CB;
	Thu, 21 Jan 2010 03:42:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7SMnXFoEHhNIULCiaLbHYnx/Gow=; b=IHvUFC
	IBwA3LGIJvWhq2DQZZeBAklxdxdjlcVDj+6K6sfxwY0oJ6KZIfF9LFtNJL1QFs5n
	6It8LSjdYDyfNIQABxKtjLLrom2Cf+9ZA9oEuakkjFEkO/f2Qq6V7R1Cf2duj1s1
	mRRFRknN/AGVOVQOnfJweorfVwvsjrAxGPm2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f4Inw1P+VWv9/yxtkHxZ4Nvw60SEywq1
	kOWZXhbYL6A+rlCZOm3VkIquo9W2n05JEYSstcRBwBdoPeTTjQ+oqjtcl7GOer7H
	hIFR7El58ZaOF641FVLCuetHzGHRKoiijjqy0Tqvmbw/wQbjLzR4+iytaubHwjqz
	pI6RVfqxZYc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E96C5937C7;
	Thu, 21 Jan 2010 03:42:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8969F937C2; Thu, 21 Jan
 2010 03:42:09 -0500 (EST)
In-Reply-To: <4B580F14.5060105@viscovery.net> (Johannes Sixt's message of
 "Thu\, 21 Jan 2010 09\:23\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DECD852E-0668-11DF-A543-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137641>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> It forgot to apply the prefix to the paths given on the command line.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Thanks; will squash this in (which fails without and passes with your patch). 

 t/t2030-unresolve-info.sh |   71 +++++++++++++++++++++++++++++++--------------
 1 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index a38bd6d..cb7effe 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -36,21 +36,22 @@ prime_resolve_undo () {
 	test_must_fail git merge third^0 &&
 	echo merge does not leave anything &&
 	check_resolve_undo empty &&
-	echo different >file &&
-	git add file &&
+	echo different >fi/le &&
+	git add fi/le &&
 	echo resolving records &&
-	check_resolve_undo recorded file initial:file second:file third:file
+	check_resolve_undo recorded fi/le initial:fi/le second:fi/le third:fi/le
 }
 
 test_expect_success setup '
-	test_commit initial file first &&
+	mkdir fi &&
+	test_commit initial fi/le first &&
 	git branch side &&
 	git branch another &&
-	test_commit second file second &&
+	test_commit second fi/le second &&
 	git checkout side &&
-	test_commit third file third &&
+	test_commit third fi/le third &&
 	git checkout another &&
-	test_commit fourth file fourth &&
+	test_commit fourth fi/le fourth &&
 	git checkout master
 '
 
@@ -59,7 +60,7 @@ test_expect_success 'add records switch clears' '
 	test_tick &&
 	git commit -m merged &&
 	echo committing keeps &&
-	check_resolve_undo kept file initial:file second:file third:file &&
+	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	git checkout second^0 &&
 	echo switching clears &&
 	check_resolve_undo cleared
@@ -70,15 +71,15 @@ test_expect_success 'rm records reset clears' '
 	test_tick &&
 	git commit -m merged &&
 	echo committing keeps &&
-	check_resolve_undo kept file initial:file second:file third:file &&
+	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 
 	echo merge clears upfront &&
 	test_must_fail git merge fourth^0 &&
 	check_resolve_undo nuked &&
 
-	git rm -f file &&
+	git rm -f fi/le &&
 	echo resolving records &&
-	check_resolve_undo recorded file initial:file HEAD:file fourth:file &&
+	check_resolve_undo recorded fi/le initial:fi/le HEAD:fi/le fourth:fi/le &&
 
 	git reset --hard &&
 	echo resetting discards &&
@@ -90,7 +91,7 @@ test_expect_success 'plumbing clears' '
 	test_tick &&
 	git commit -m merged &&
 	echo committing keeps &&
-	check_resolve_undo kept file initial:file second:file third:file &&
+	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 
 	echo plumbing clear &&
 	git update-index --clear-resolve-undo &&
@@ -100,7 +101,7 @@ test_expect_success 'plumbing clears' '
 test_expect_success 'add records checkout -m undoes' '
 	prime_resolve_undo &&
 	git diff HEAD &&
-	git checkout --conflict=merge file &&
+	git checkout --conflict=merge fi/le &&
 	echo checkout used the record and removed it &&
 	check_resolve_undo removed &&
 	echo the index and the work tree is unmerged again &&
@@ -110,12 +111,12 @@ test_expect_success 'add records checkout -m undoes' '
 
 test_expect_success 'unmerge with plumbing' '
 	prime_resolve_undo &&
-	git update-index --unresolve file &&
+	git update-index --unresolve fi/le &&
 	git ls-files -u >actual &&
 	test $(wc -l <actual) = 3
 '
 
-test_expect_success 'rerere and rerere --forget' '
+test_expect_success 'rerere and rerere forget' '
 	mkdir .git/rr-cache &&
 	prime_resolve_undo &&
 	echo record the resolution &&
@@ -123,20 +124,46 @@ test_expect_success 'rerere and rerere --forget' '
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
 	test -f .git/rr-cache/$rerere_id/postimage &&
-	git checkout -m file &&
+	git checkout -m fi/le &&
 	echo resurrect the conflict &&
-	grep "^=======" file &&
+	grep "^=======" fi/le &&
 	echo reresolve the conflict &&
 	git rerere &&
-	test "z$(cat file)" = zdifferent &&
+	test "z$(cat fi/le)" = zdifferent &&
 	echo register the resolution again &&
-	git add file &&
-	check_resolve_undo kept file initial:file second:file third:file &&
+	git add fi/le &&
+	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
-	git rerere forget file &&
+	git rerere forget fi/le &&
 	! test -f .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
-	echo "$rerere_id	file" >expect &&
+	echo "$rerere_id	fi/le" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rerere and rerere forget (subdirectory)' '
+	rm -fr .git/rr-cache &&
+	mkdir .git/rr-cache &&
+	prime_resolve_undo &&
+	echo record the resolution &&
+	(cd fi && git rerere) &&
+	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
+	rerere_id=${rerere_id%/postimage} &&
+	test -f .git/rr-cache/$rerere_id/postimage &&
+	(cd fi && git checkout -m le) &&
+	echo resurrect the conflict &&
+	grep "^=======" fi/le &&
+	echo reresolve the conflict &&
+	(cd fi && git rerere) &&
+	test "z$(cat fi/le)" = zdifferent &&
+	echo register the resolution again &&
+	(cd fi && git add le) &&
+	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
+	test -z "$(git ls-files -u)" &&
+	(cd fi && git rerere forget le) &&
+	! test -f .git/rr-cache/$rerere_id/postimage &&
+	tr "\0" "\n" <.git/MERGE_RR >actual &&
+	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual
 '
 
