From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Fri, 13 Aug 2010 23:44:50 +0200
Message-ID: <4C65BCD2.6000701@kdbg.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org> <4C63BD9B.6000608@viscovery.net> <20100812224044.GK2029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@MIT.EDU>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:45:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok23e-0005Pm-Jd
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab0HMVow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:44:52 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25833 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab0HMVow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:44:52 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 22F071000F;
	Fri, 13 Aug 2010 23:44:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <20100812224044.GK2029@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153515>

Am 13.08.2010 00:40, schrieb Jonathan Nieder:
> Johannes Sixt wrote:
>> Am 8/12/2010 1:35, schrieb Junio C Hamano:
>
>>> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>>>   - apply: Handle traditional patches with space in filename
>>>   - t4135 (apply): use expand instead of pr for portability
>>>   - tests: Test how well "git apply" copes with weird filenames
>>>   - apply: Split quoted filename handling into new function
>>>
>>> Looked Ok.  Will merge to 'next'.
>>
>> The test cases that work with files with tabs must have a prerequisite;
>> see t3600-rm.sh.
>
> Would this work?
>
> -- 8<  --
> Subject: t4135 (apply): filenames with tabs are not usable on NTFS
>
> Move the code setting up the FUNNYNAMES prerequisite from
> v1.3.0-rc1~67 (workaround fat/ntfs deficiences for t3600-rm.sh,
> 2006-03-03) to test-lib and use it.
>
> Reported-by: Johannes Sixt<j6t@kdbg.org>
> Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>

No, it needs this squashed in (warning, whitespace damaged), except that 
the prerequisite EXPAND is nowhere defined - it is only a hint for you(?) 
that we need something else there because we don't have expand on Windows.

I don't know why the test with quotes fails. It must be a bug in MSYS 
bash, because the file system does not have any problems with quotes in 
file names.

diff --git a/t/t4135-apply-weird-filenames.sh 
b/t/t4135-apply-weird-filenames.sh
index 5c7165e..6730a30 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -88,10 +88,10 @@ try_filename() {
  try_filename 'plain'            'postimage.txt'
  try_filename 'with spaces'      'post image.txt'
  try_filename 'with tab'         'post	image.txt' FUNNYNAMES
-try_filename 'with backslash'   'post\image.txt'
-try_filename 'with quote'       '"postimage".txt' '' success failure success
+try_filename 'with backslash'   'post\image.txt' BSLASHPSPEC
+try_filename 'with quote'       '"postimage".txt' FUNNYNAMES success 
failure success

-test_expect_success FULLDIFF 'whitespace-damaged traditional patch' '
+test_expect_success EXPAND,FULLDIFF 'whitespace-damaged traditional patch' '
  	reset_preimage &&
  	reset_subdirs &&
  	echo postimage >b/postimage.txt &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1e5640b..d50e787 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -963,8 +963,8 @@ test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
  f1='newline
  embedded'
  if
-	>"$f1" 2>/dev/null &&
-	>'tab	embedded' 2>/dev/null
+	{ >"$f1"; } 2>/dev/null &&
+	{ >'tab	embedded'; } 2>/dev/null
  then
  	test_set_prereq FUNNYNAMES
  fi

Without the braces in this check the error message is still printed. I 
didn't test whether just writing 2>/dev/null first would suppress it as well.

BTW, I would prefer to keep the test in t3600 and t4135, that it doesn't 
happen for every other test script unnecessarily.

-- Hannes
