From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3] pull: handle --log=<n>
Date: Thu, 21 May 2015 18:36:17 +0800
Message-ID: <20150521103617.GA6159@yoshi.chippynet.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
 <5661061272076a1883cfde1087be4a42@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 12:36:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvNq1-0002uR-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 12:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbbEUKgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 06:36:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35962 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbEUKgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 06:36:24 -0400
Received: by pabts4 with SMTP id ts4so101038473pab.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fRjkMxB5H7+Mn9HAXmZyA/l2naiXs3hYxZzvVQvj+6s=;
        b=0CTLaWkxX+abeT66p4g7HsTAwXhUPJhoSMj7Vom91EAfXXdCiXQ6B5gv/a36BBsIY8
         hfBXRq0fFg+W/+YiK4j0OHcz5GFrf2gu8tbH7udbIcNIjg133iLlj8XzNqLwgqMbatE5
         mFha8M9k1z/zMgU3MuzAjo5+KKU1WNNm86gvfcWcmzk5U3a1jAByzmUGFf+sQuuNrYvN
         2CFTgz963qTcW0DQXl2pddaXUJWR6ULMeVjGIAxj/HJXpifRtlS8ZicnDPWNQPKau77q
         MvODth4LCwzrEHvMMM9BVgssqfFFr2oCDV97kizQ/EsWWQBAjHmKA9rZMETO+snU6ZV+
         2STA==
X-Received: by 10.70.33.200 with SMTP id t8mr4221357pdi.15.1432204583811;
        Thu, 21 May 2015 03:36:23 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18857290pdb.32.2015.05.21.03.36.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 03:36:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5661061272076a1883cfde1087be4a42@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269579>

On Mon, May 18, 2015 at 10:53 PM, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> On 2015-05-18 15:39, Paul Tan wrote:
>> diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
>> index 8cccecc..eebb8c9 100755
>> --- a/t/t5524-pull-msg.sh
>> +++ b/t/t5524-pull-msg.sh
>> @@ -17,6 +17,9 @@ test_expect_success setup '
>>               git commit -m "add bfile"
>>       ) &&
>>       test_tick && test_tick &&
>> +     echo "second" >afile &&
>> +     git add afile &&
>> +     git commit -m "second commit" &&
>>       echo "original $dollar" >afile &&
>>       git add afile &&
>
> I completely forgot to send a mail last time where I wanted to mention the test_commit function. I *think* that above invocation is equivalent to
>
>     test_commit "second commit" afile second
>
> with the additional benefit that `test_tick` is called automatically. Maybe you want to use that more concise function call?

Hmm, it says that 'second commit' is not a valid tag name ;-) Okay, I can work around it by making the commit message "second".

On another note though, I think I need to add a "test_tick" for the commit just below as well:

        echo "original $dollar" >afile &&
        git add afile &&c
        git commit -m "do not clobber $dollar signs"

So, here's the re-rolled patch.

--- >8 ---
Since efb779f (merge, pull: add '--(no-)log' command line option,
2008-04-06) git-pull supported the (--no-)log switch and would pass it
to git-merge.

96e9420 (merge: Make '--log' an integer option for number of shortlog
entries, 2010-09-08) implemented support for the --log=<n> switch, which
would explicitly set the number of shortlog entries. However, git-pull
does not recognize this option, and will instead pass it to git-fetch,
leading to "unknown option" errors.

Fix this by matching --log=* in addition to --log and --no-log.

Implement a test for this use case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh         |  4 ++--
 t/t5524-pull-msg.sh | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9ed01fd..5ff4545 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -81,8 +81,8 @@ do
 		diffstat=--no-stat ;;
 	--stat|--summary)
 		diffstat=--stat ;;
-	--log|--no-log)
-		log_arg=$1 ;;
+	--log|--log=*|--no-log)
+		log_arg="$1" ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..9bc7821 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -16,7 +16,9 @@ test_expect_success setup '
 		test_tick &&
 		git commit -m "add bfile"
 	) &&
-	test_tick && test_tick &&
+	test_tick &&
+	test_commit second afile &&
+	test_tick &&
 	echo "original $dollar" >afile &&
 	git add afile &&
 	git commit -m "do not clobber $dollar signs"
@@ -32,4 +34,18 @@ test_expect_success pull '
 )
 '
 
+test_expect_success '--log=1 limits shortlog length' '
+(
+	cd cloned &&
+	git reset --hard HEAD^ &&
+	test "$(cat afile)" = original &&
+	test "$(cat bfile)" = added &&
+	git pull --log=1 &&
+	git log -3 &&
+	git cat-file commit HEAD >result &&
+	grep Dollar result &&
+	! grep second result
+)
+'
+
 test_done
-- 
2.1.4
