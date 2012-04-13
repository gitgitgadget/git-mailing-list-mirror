From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] checkout --detached test: write supporting files before
 start of tests
Date: Fri, 13 Apr 2012 18:25:35 -0500
Message-ID: <20120413232535.GB13995@burratino>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIps9-00029O-Ug
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab2DMXZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 19:25:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36931 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756971Ab2DMXZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 19:25:39 -0400
Received: by iagz16 with SMTP id z16so4890418iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aGphbVKuRxcuWoHYbuX6CbBGFVygGdrpr50w5FQlGzk=;
        b=CBij2SsnKPZEfDO5AFUF8J9Aat7v1TF3XQ7PIaNwoj0JFRpA91NACiBv9TtlO93t9V
         iUwjiSJOl7rxYz77swHcQIk4/qwixgTm1lTw2bQOfQlyAlN69qumeq/XOLnNAfSMQbsI
         PjhhlEd7Kb+jWbpwVaIb4N6cBZBuixxps6uM5tm/6jHO5StATvcIrh3aDtk85lE04GtB
         IToN4zOs07p/w50ROhS0RL7ax1RBzgwHtUwT73Cx66EHXg9x1LBh+OAyvY0AXGjFPADv
         A+y1A2Kg1GuIpjky5V2p/TD3yIk/Fg2iFgjBSZyWnIjYkqHuPt/8Iho9O75G/jk4drlQ
         PV9g==
Received: by 10.50.212.97 with SMTP id nj1mr3067655igc.65.1334359539280;
        Fri, 13 Apr 2012 16:25:39 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id md6sm294261igc.0.2012.04.13.16.25.38
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 16:25:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120413225901.GA13220@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195453>

As a general rule, git's tests use the following layout:

 - first, setting the --help description and including test-lib
   and other libraries

 - next, writing static files and setting variables that will last
   through the entire script, and defining helper functions

 - next, the test assertions themselves

This way it is visually obvious where the code for each test assertion
begins and ends and there is no temptation to use command substitution
to do nontrivial work outside of the test_expect_success / failure
blocks.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Jeff King wrote:

>> --- a/t/t2020-checkout-detach.sh
>> +++ b/t/t2020-checkout-detach.sh
>> @@ -126,4 +126,17 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
>>  	check_no_orphan_warning stderr
>>  '
>>
>> +cat >expect <<'EOF'
>> +Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
>> +EOF
>> +test_expect_success 'tracking count is accurate after orphan check' '
>> +	reset &&
>> +	git branch child master^ &&
>> +	git config branch.child.remote . &&
>> +	git config branch.child.merge refs/heads/master &&
>> +	git checkout child^ &&
>> +	git checkout child >stdout &&
>> +	test_cmp expect stdout
>
> Should use test_i18ncmp to handle people who force tests to run in
> other locales (like the fake GETTEXT_POISON locale).  Quick patch
> follows.

... and here's a patch on top to address an unrelated nit.

 t/t2020-checkout-detach.sh |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index b37ce25c..c2c34664 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -3,6 +3,10 @@
 test_description='checkout into detached HEAD state'
 . ./test-lib.sh
 
+cat >master-1-ahead.message <<'EOF'
+Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
+EOF
+
 check_detached () {
 	test_must_fail git symbolic-ref -q HEAD >/dev/null
 }
@@ -138,10 +142,8 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 	check_no_orphan_warning stderr
 '
 
-cat >expect <<'EOF'
-Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
-EOF
 test_expect_success 'tracking count is accurate after orphan check' '
+	cp master-1-ahead.message expect &&
 	reset &&
 	git branch child master^ &&
 	git config branch.child.remote . &&
-- 
1.7.10
