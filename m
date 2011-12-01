From: Phil Hord <hordp@cisco.com>
Subject: Re: clean bug on ignored subdirectories with no tracked files?
Date: Thu, 01 Dec 2011 18:35:52 -0500
Message-ID: <4ED80F58.20003@cisco.com>
References: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com> <7vy5vbj4rb.fsf@alter.siamese.dyndns.org> <CAG+J_DwKeWntmi22vHS6CRud6Lo0P_+D5u5ih2Bbc50ekYji5w@mail.gmail.com> <7vy5v9fgel.fsf@alter.siamese.dyndns.org> <7vty5xff6l.fsf@alter.siamese.dyndns.org> <CAG+J_DzBgQTdCoj8Y185+=+SpMMYgPXQXkta=o-Rson2xL8ytQ@mail.gmail.com> <CABURp0qv7MB-ZQvvSZQi43nAy1ZaR75-19T2Sd1JBT14Y_dG7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>, Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 00:45:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWGJm-0004D8-5P
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 00:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab1LAXpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 18:45:25 -0500
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:44910 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab1LAXpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 18:45:24 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2011 18:45:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2028; q=dns/txt;
  s=iport; t=1322783124; x=1323992724;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=HpYwGXQibwNIV2yPFZm0mgIRPcuqtr8LyfxywQ7nzR8=;
  b=Juf5m0heeN8JSF/CVBUm62JoE9wuWMdIj2UUQ8ca2zp0SfrBbm+N9gMC
   uBg2zRyNiFJsopnBXH4UJWF3LcxO0SHynY5d99LYgxIAN+KlxI3IZ6ZjD
   y5sFSWBl6qUoVFvxFhfzrn4UEIqJqNbGTHlJmZhkZX7cppWuqZHIz8ou4
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAIkO2E6tJXG//2dsb2JhbABDqwOBBYFyAQEBAQMSAWYQCxcBCSUPAhAuCAYBDAEFAgEBHqEzAZ5DiyAEiCiML4VDhReHVg
X-IronPort-AV: E=Sophos;i="4.71,281,1320624000"; 
   d="scan'208";a="40500194"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-7.cisco.com with ESMTP; 01 Dec 2011 23:35:52 +0000
Received: from [64.100.104.65] (dhcp-64-100-104-65.cisco.com [64.100.104.65])
	by rcdn-core2-4.cisco.com (8.14.3/8.14.3) with ESMTP id pB1NZqDT018338;
	Thu, 1 Dec 2011 23:35:52 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <CABURp0qv7MB-ZQvvSZQi43nAy1ZaR75-19T2Sd1JBT14Y_dG7w@mail.gmail.com>
X-Enigmail-Version: 1.3.3
X-TagToolbar-Keys: D20111201183552933
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186199>


On Mon, Nov 21, 2011 at 3:03 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Mon, Nov 21, 2011 at 2:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "clean" without "-x" is meant to preserve untracked but expendable paths
>> (e.g. build products), so if something is removed that is untracked but
>> matches the ignore pattern, then that is a bug to be fixed.  Care to roll
>> a patch to fix it?
> Okay, just confirming it is a bug. I'll add this e-mail to my todo
> list, but I don't have time for a patch anytime soon. 

I think the fix is in dir.c (treat_directory), but I'm not sure how yet.

How's this for starters?

-- >8 --
Subject: [PATCH] clean: Test known breakage of .gitignore and -d

git-clean -d is used to remove untracked directories.  If the
directory still contains .gitignored files it should not be removed.
But git is broken here if neither the ignored files nor the directory
are explicitly ignored.

Document this known breakage with a test for both cases.

Noticed-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7300-clean.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 800b536..e29e383 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -14,6 +14,7 @@ test_expect_success 'setup' '
 	mkdir -p src &&
 	touch src/part1.c Makefile &&
 	echo build >.gitignore &&
+	echo /foo/bar >>.gitignore &&
 	echo \*.o >>.gitignore &&
 	git add . &&
 	git commit -m setup &&
@@ -264,6 +265,20 @@ test_expect_success 'git clean -d src/ examples/' '
 
 '
 
+test_expect_failure 'git clean -d leaves .gitignored files alone' '
+
+	mkdir -p objs foo/bar &&
+	touch objs/foo.o &&
+	touch foo/gone &&
+	touch foo/bar/baz &&
+	git clean -nd &&
+	git clean -d &&
+	test ! -f foo/gone &&
+	test -f foo/bar/baz &&
+	test -f objs/foo.o
+
+'
+
 test_expect_success 'git clean -x' '
 
 	mkdir -p build docs &&
-- 
1.7.8.rc4
