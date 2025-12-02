Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262128726E
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671271; cv=none; b=oTCXPSM/PRRM3qag7iq1rvV5glTb2fr03HWcs7byc0EabQ4uVxkSZnjQPjMvhCg38B+8PpU7Lke8eGkpB2eAwQOg/TkoWfjPAiMkX0GaJhnlkCPCXW2I7tofPjmLPVezXCmUD0GBSa8LxuA8oO3usGNgYXuyWkI6FDwyXf3GEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671271; c=relaxed/simple;
	bh=3Dv4W5u9aIbsy7vVK9C7kEao90VKe0cFgWCgcJhlwzo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hdksBL8baFfk2uu1adJVZ1o9hSzL/b1M7ZBRMxjiUKPLsT1P3bjA6iYZvN+Re43JGmu6YOQ/Q8iRZp9YqbzPqTLvFy1Rrzv80kMzjROayZ3VAcMLtO7XifCRHPyW4HRFELqMFnsMuE+EVZiDRJ9HYTRC+IqO1XrJpzmV8tPYgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dLH5l18GPzRnmP;
	Tue,  2 Dec 2025 11:27:39 +0100 (CET)
Message-ID: <7c642644-09a5-4a50-931b-a630d459932d@kdbg.org>
Date: Tue, 2 Dec 2025 11:27:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] merge with Scheme regexp; fix bugs
From: Johannes Sixt <j6t@kdbg.org>
To: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Scott L. Burson" <Scott@sympoiesis.com>, git@vger.kernel.org
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <86315aa3e36afa1ee741a2c9b9e95a71ca569302.1764211096.git.gitgitgadget@gmail.com>
 <b6656e6d-d1e8-4ebe-821f-9211643a71ab@kdbg.org>
Content-Language: en-US
In-Reply-To: <b6656e6d-d1e8-4ebe-821f-9211643a71ab@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.11.25 um 17:09 schrieb Johannes Sixt:
> Am 27.11.25 um 03:38 schrieb Scott L. Burson via GitGitGadget:
>>  	 /*
>> -	  * R7RS valid identifiers include any sequence enclosed
>> -	  * within vertical lines having no backslashes
>> +	  * The union of R7RS and Common Lisp symbol syntax: allows arbitrary
>> +	  * strings between vertical bars, including escaped backslashes and
>> +	  * vertical bars.
>>  	  */
>> -	 "\\|([^\\\\]*)\\|"
>> +	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
> 
> Without the C quoting we have
> 
> 	\|([^\\]|\\\\|\\\|)*\|
> 
> So, this is everthing from | up to the next |, except that \| does not
> stop scanning and \\ is also considered so that \\| is not regarded as \
> followed by \|. Good.

Actually, no. Regular expressions don't choose the first match if a
different alternative gives a longer match in total. For example, for
the change

-  (let ((|one two| |three four|)))
+  (let ((|1 two| |three four|)))

we get to see the word diff

  (let (([-|one two| |three four|-]{+|1 two| |three four|+})))

but the desired result is

  (let (([-|one two|-]{+|1 two|+} |three four|)))

The problem isn't new with the proposed change, but if we change the RE,
we could fix this at the same time. I think it helps to include | in the
bracket expression. It may be worth its own patch that also adds a test
in t/t4034/scheme/.

The worddiff test case is a bit too sloppy. I've tightened it in the
patch below. You may want to make it the first of your series. (If you
do, don't forget to apply your sign-off when you cherry-pick the
commit.) It is also available here:
https://github.com/j6t/git/tree/userdiff-scheme
(commit 8f6cb42a02cc).

----- 8< -----
userdiff: tighten word-diff test case of the scheme driver

The scheme driver separates identifiers only at parentheses of all
sorts and whitespace, except that vertical bars act as brackets that
enclose an identifier.

The test case attempts to demonstrate the vertical bars with a change
from 'some-text' to '|a greeting|'. However, this misses the goal
because the same word coloring would be applied if '|a greeting|'
were parsed as two words.

Have an identifier between vertical bars with a space in both the pre-
and the post-image and change only one side of the space to show that
the single word exists between the vertical bars.

Also add cases that change parentheses of all kinds in a sequence of
parentheses to show that they are their own word each.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4034/scheme/expect | 5 +++--
 t/t4034/scheme/post   | 1 +
 t/t4034/scheme/pre    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t4034/scheme/expect b/t/t4034/scheme/expect
index 496cd5de8c..138abe9f56 100644
--- a/t/t4034/scheme/expect
+++ b/t/t4034/scheme/expect
@@ -2,10 +2,11 @@
 <BOLD>index 74b6605..63b6ac4 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,6 +1,6 @@<RESET>
+<CYAN>@@ -1,7 +1,7 @@<RESET>
 (define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
   ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
   (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
-  (define <RED>some-text<RESET><GREEN>|a greeting|<RESET> "hello")
+  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
+  ({<RED>}<RESET>(([<RED>]<RESET>(func-n)<RED>[<RESET>]))<RED>{<RESET>})
   (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
     (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
index 63b6ac4f87..0e3bab101d 100644
--- a/t/t4034/scheme/post
+++ b/t/t4034/scheme/post
@@ -2,5 +2,6 @@
   ; This is a (moderately) cool function.
   (that\place (+ 3 4))
   (define |a greeting| "hello")
+  ({(([(func-n)]))})
   (let ((c (add1 first)))
     (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
index 74b6605357..03d77c7c43 100644
--- a/t/t4034/scheme/pre
+++ b/t/t4034/scheme/pre
@@ -1,6 +1,7 @@
 (define (myfunc a b)
   ; This is a really cool function.
   (this\place (+ 3 4))
-  (define some-text "hello")
+  (define |the greeting| "hello")
+  ({}(([](func-n)[])){})
   (let ((c (+ a b)))
     (format "one more than the total is %d" (add1 c))))
-- 
2.52.0.rc0.206.g6c0125c11f

