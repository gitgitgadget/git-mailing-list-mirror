From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter instead of mmap
Date: Sat, 16 Aug 2014 18:26:08 +0200
Message-ID: <FA3F1197-25C5-42E4-9418-1C821D430819@zib.de>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de> <1407303134-16635-3-git-send-email-prohaska@zib.de> <20140816102703.GD7857@serenity.lan>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:27:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIgol-00040n-Dl
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaHPQ0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:26:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:54032 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaHPQ0z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Aug 2014 12:26:55 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7GGQGUq016707;
	Sat, 16 Aug 2014 18:26:16 +0200 (CEST)
Received: from [192.168.1.200] (95-91-208-130-dynip.superkabel.de [95.91.208.130])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7GGQEQs016647
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 16 Aug 2014 18:26:15 +0200 (CEST)
In-Reply-To: <20140816102703.GD7857@serenity.lan>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53EF8628.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53EF8628.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53EF8628.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255325>


On Aug 16, 2014, at 12:27 PM, John Keeping <john@keeping.me.uk> wrote:

>> +test_expect_success HAVE_MAX_MEM_USAGE \
>> +'filtering large input to small output should use little memory' '
>> +	git config filter.devnull.clean "cat >/dev/null" &&
>> +	git config filter.devnull.required true &&
>> +	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
>> +	echo "30MB filter=devnull" >.gitattributes &&
>> +	max_mem_usage_is_lt_KB 15000 git add 30MB
>> +'
> 
> This test fails for me:
> 
> -- 8< --
> expecting success: 
>        git config filter.devnull.clean "cat >/dev/null" &&
>        git config filter.devnull.required true &&
>        for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
>        echo "30MB filter=devnull" >.gitattributes &&
>        max_mem_usage_is_lt_KB 15000 git add 30MB
> 
> Command used too much memory (expected limit 15000KB, actual usage 15808KB).
> not ok 8 - filtering large input to small output should use little memory
> -- >8 --
> 
> This is on Linux 3.16 x86_64 with GCC 4.8.3 and glibc 2.19.  My GCC also
> has "-fstack-protector" and "-D_FORTIFY_SOURCE=2" enabled by default;
> turning those off for Git decreased the memory usage by about 500KB but
> not enough to make the test pass.  Of course, all of the libraries Git
> is linking are also compiled with those flags...
> 
> Is the 15MB limit supposed to be imposed somewhere or is it just a guide
> of how much memory we expect Git to use in this scenario?

The test should confirm that the the file that is added is not mmapped to memory.  The process size should be relatively small independently of the size of the file that is added.  I wanted to keep the file size small.  The chosen sizes worked for me on Mac and Linux.

A simple solution could be to increase the size of the test file and the limit.  I'd suggest to squash the diff below.  The test should still run reasonably fast with a 50 MB test file.

Junio, shall I send a whole updated patch series?

	Steffen


diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 2cb2414..43de87d 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -243,9 +243,9 @@ test_expect_success HAVE_MAX_MEM_USAGE \
 'filtering large input to small output should use little memory' '
        git config filter.devnull.clean "cat >/dev/null" &&
        git config filter.devnull.required true &&
-       for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
-       echo "30MB filter=devnull" >.gitattributes &&
-       max_mem_usage_is_lt_KB 15000 git add 30MB
+       for i in $(test_seq 1 50); do printf "%1048576d" 1; done >50MB &&
+       echo "50MB filter=devnull" >.gitattributes &&
+       max_mem_usage_is_lt_KB 35000 git add 50MB
 '
