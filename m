From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 14:18:33 +0530
Message-ID: <4E9FE061.3080601@gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com> <1319058208-17923-4-git-send-email-artagnon@gmail.com> <7v8vogbgai.fsf@alter.siamese.dyndns.org> <20111020080328.GA12337@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 10:51:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGoLH-0000Xs-Rr
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 10:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab1JTIvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 04:51:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36480 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1JTIvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 04:51:04 -0400
Received: by ywf7 with SMTP id 7so2568937ywf.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7ohItgEpdnGoV1V4J3g0RPNeUiVoiI6rDnU+ZG2/hZM=;
        b=bYEcXnfkvDpkbarz/sBib55OLRgieyrgPqhP0xiB5GN2jVVw1hISzMj3fTRXXRbrlB
         DQesnfBHTFfahhF4EuyVsA7V7s0YqVTpJbAAT43t7LNpwKu2njTXQ9OLUB8RjEghvaM1
         icge0h3UviPFV3AYocMnLAyV9SJRVH3KGoo0s=
Received: by 10.68.39.130 with SMTP id p2mr18689416pbk.104.1319100663951;
        Thu, 20 Oct 2011 01:51:03 -0700 (PDT)
Received: from [10.111.9.225] ([203.110.240.41])
        by mx.google.com with ESMTPS id e10sm8155252pbq.10.2011.10.20.01.50.55
        (version=SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 01:51:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20111010 Icedove/3.1.15
In-Reply-To: <20111020080328.GA12337@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184016>

Hi Jonathan and Junio,

Jonathan Nieder writes:
> Junio C Hamano wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>> Check that the commit name argument to a "pick" or "revert" action in
>>> '.git/sequencer/todo' is not too long
> [...]
>> Given that this function is going to be fixed properly so that it does not
>> even need to use the "on-stack buffer", is this really necessary?
>
> Right, I don't think it is.  Keeping a testcase sounds worthwhile,
> though.

Okay.  How about putting this after 5/6?

-- 8< --
Subject: [PATCH] t3510: guard against buffer overflows in parser

To guard against a buffer overflow in the parser, verify that
instruction sheets with overly long object names are parsed.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3510-cherry-pick-sequence.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 0e29e03..39b55c1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,9 @@ test_description='Test cherry-pick continuation features
 
 . ./test-lib.sh
 
+# Repeat first match 10 times
+_r10='\1\1\1\1\1\1\1\1\1\1'
+
 pristine_detach () {
        git cherry-pick --reset &&
        git checkout -f "$1^0" &&
@@ -211,6 +214,17 @@ test_expect_success 'malformed instruction sheet 2' '
        test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'malformed instruction sheet 3' '
+       pristine_detach initial &&
+       test_must_fail git cherry-pick base..anotherpick &&
+       echo "resolved" >foo &&
+       git add foo &&
+       git commit &&
+       sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
+       cp new_sheet .git/sequencer/todo &&
+       test_must_fail git cherry-pick --continue
+'
+
 test_expect_success 'commit descriptions in insn sheet are optional' '
        pristine_detach initial &&
        test_must_fail git cherry-pick base..anotherpick &&
-- 
1.7.6.351.gb35ac.dirty
