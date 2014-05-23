From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE
 costruct
Date: Fri, 23 May 2014 22:40:41 +0200
Message-ID: <537FB249.8050708@web.de>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com> <xmqqmwe8jr44.fsf@gitster.dls.corp.google.com> <20140523184405.GE12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, dak@gnu.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnwGo-0005bZ-BM
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbaEWUkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:40:47 -0400
Received: from mout.web.de ([212.227.15.4]:56269 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbaEWUkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:40:46 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M8oFY-1Wbon80nxU-00CBCu; Fri, 23 May 2014 22:40:42
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140523184405.GE12314@google.com>
X-Provags-ID: V03:K0:g6g6PtFFWX5K5HPaxEiviHk1rhwDX34Upi6yvjhoPXQbGN1pVNH
 z6fkyICOzSsN8jefVfMbfpeZyBLt7KdK+lyo5PmXN6pKGPc2df6OekhrqfppflvRLqWwM5Q
 x8N1Ycoso5n7k8scaXM1dKhkhx1d6Mpk/d9jsggGAaaaGp0RwqpWW6VgolKgVAkG+VLlHhS
 BhnSrm8ODJGbp44qVd9qQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250030>

On 2014-05-23 20.44, Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> Elia Pinto <gitter.spiros@gmail.com> writes:
> 
>>> Found by check-non-portable-shell.pl
>>
>> Thanks.
>>
>> Makes me wonder why these two were missed, though.
> 
> Good catch.  check-non-portable-shell.pl uses an anchored regex:
> 
> 	/^\s*export\s+[^=]*=/
> 
> Perhaps something like
> 
> 	/\bexport\s+[A-Za-z0-9_]*=/
> 
> without anchoring would work better.
> 
> -- >8 --
> Subject: test-lint: find unportable sed, echo, test, and export usage after &&
> 
> Instead of anchoring these checks with "^\s*", just check that the
> usage is preceded by a word boundary.  So now we can catch
> 
> 	test $cond && export foo=bar
Thanks for digging.

I wonder if we could keep the anchoring (to reduce false positives)
and try to catch a line "command1 && command2" at the same time:

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 45971f4..f64e054 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -16,12 +16,12 @@ sub err {
 
 while (<>) {
        chomp;
-       /^\s*sed\s+-i/ and err 'sed -i is not portable';
-       /^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)';
-       /^\s*declare\s+/ and err 'arrays/declare not portable';
-       /^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
+       /(^|&&)\s*sed\s+-i/ and err 'sed -i is not portable';
+       /(^|&&)\s*echo\s+-n/ and err 'echo -n is not portable (please use printf)';
+       /(^|&&)\s*declare\s+/ and err 'arrays/declare not portable';
+       /(^|&&)\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
        /test\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
-       /^\s*export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
+       /(^|&&)\s*export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
        # this resets our $. for each file
        close ARGV if eof;
 }
