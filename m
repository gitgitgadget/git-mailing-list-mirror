From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] mv: let 'git mv file no-such-dir/' error out
Date: Wed, 04 Dec 2013 09:44:53 +0100
Message-ID: <vpqa9ghhunu.fsf@anie.imag.fr>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8CfvdT2LgRHax3P6k94C3S9ScB4fuNRm7bZWGXRW=NqKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 09:45:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo858-0003fe-0w
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 09:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab3LDIpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 03:45:08 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35806 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab3LDIpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 03:45:07 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rB48irJH002168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Dec 2013 09:44:53 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rB48ircg022965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 4 Dec 2013 09:44:53 +0100
In-Reply-To: <CACsJy8CfvdT2LgRHax3P6k94C3S9ScB4fuNRm7bZWGXRW=NqKA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 3 Dec 2013 17:06:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Dec 2013 09:44:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB48irJH002168
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1386751496.15002@3zuhMmk/y5goZGMmstMCZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238765>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 3, 2013 at 3:32 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> Git used to trim the trailing slash, and make the command equivalent to
>> 'git mv file no-such-dir', which created the file no-such-dir (while the
>> trailing slash explicitly stated that it could only be a directory).
>>
>> This patch skips the trailing slash removal for the destination path. The
>> path with its trailing slash is passed to rename(2), which errors out
>> with the appropriate message:
>>
>>   $ git mv file no-such-dir/
>>   fatal: renaming 'file' failed: Not a directory
>
> There's something we probably should check. In d78b0f3 ([PATCH]
> git-mv: add more path normalization - 2006-08-16), it mentions about
>
> git mv something/ somewhere/
>
> there's no test in that commit so I don't know the actual input and
> expected outcome.

To me, the expected outcome is "behave like Unix's mv" (which works with
or without the trailing slash if somewhere exists).

> If "somewhere" is a directory, it errors out with this patch and works
> without it.

I can't reproduce. I've added this to my patch (indeed, the area wasn't
well tested), and the tests pass.

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e5c8084..3bfdfed 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -70,12 +70,31 @@ test_expect_success \
 rm -f idontexist untracked1 untracked2 \
      path0/idontexist path0/untracked1 path0/untracked2 \
      .git/index.lock
+rmdir path1
 
 test_expect_success \
-    'moving to target with trailing slash' \
+    'moving to absent target with trailing slash' \
     'test_must_fail git mv path0/COPYING no-such-dir/ &&
      test_must_fail git mv path0/COPYING no-such-dir// &&
-     git mv path0/ no-such-dir/'
+     git mv path0/ no-such-dir/ &&
+     test_path_is_dir no-such-dir'
+
+test_expect_success \
+    'clean up' \
+    'git reset --hard'
+
+test_expect_success \
+    'moving to existing untracked target with trailing slash' \
+    'mkdir path1 &&
+     git mv path0/ path1/ &&
+     test_path_is_dir path1/path0/'
+
+test_expect_success \
+    'moving to existing tracked target with trailing slash' \
+    'mkdir path2 &&
+     >path2/file && git add path2/file &&
+     git mv path1/path0/ path2/ &&
+     test_path_is_dir path2/path0/'
 
 test_expect_success \
     'clean up' \

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
