From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward
 slashes
Date: Sat, 2 Apr 2016 21:03:14 +0200
Message-ID: <57001772.7090007@kdbg.org>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de>
 <56F8E435.3020304@kdbg.org> <alpine.DEB.2.20.1603281712470.4690@virtualbox>
 <56FAD506.4050701@kdbg.org> <xmqqwpolvyml.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 21:03:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amQpR-0003Gs-LJ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 21:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbcDBTDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 15:03:17 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:49247 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbcDBTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 15:03:16 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3qcnhL5thNz5tlQ;
	Sat,  2 Apr 2016 21:03:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 106525220;
	Sat,  2 Apr 2016 21:03:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqwpolvyml.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290606>

Am 29.03.2016 um 22:05 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> This part of your 45bf3297 (t1300: fix the new --show-origin tests on
>> Windows)
>>
>> @@ -1205,6 +1205,9 @@ test_expect_success POSIXPERM,PERL 'preserves existing per
>>            "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
>>   '
>>   
>> +! test_have_prereq MINGW ||
>> +HOME="$(pwd)" # convert to Windows path
>> +
>>   test_expect_success 'set up --show-origin tests' '
>>          INCLUDE_DIR="$HOME/include" &&
>>          mkdir -p "$INCLUDE_DIR" &&
>>
>> is actually a much more concise version of my proposed patch,
>> although the result still misuses $HOME where it does not have
>> to. In fact, if I revert 5ca6b7bb (config --show-origin: report
>> paths with forward slashes), the tests still pass. But since it
>> does not make a difference save for a few microseconds more or
>> less during startup, it is not worth the churn at this point.
> 
> Well, from the point of view of codebase cleanliness, if we can do
> without 5ca6b7bb4, we would be much better off in the longer term,
> so I would say it would be wonderful if we can safely revert it.

Although I am convinced that the change is not necessary for
correctness, I can buy the justification that we should produce forward
slashes for consistency. There are a number of occasions where we
present paths to the user, and we do show forward-slashes in all cases
that I found. We should keep the commit.

But then let's do this:

---- 8< ----
Subject: [PATCH] Windows: shorten code by re-using convert_slashes()

Make a few more spots more readable by using the recently introduced,
Windows-specific helper.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 abspath.c      | 5 +----
 compat/mingw.c | 9 ++-------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/abspath.c b/abspath.c
index 5edb4e7..2825de8 100644
--- a/abspath.c
+++ b/abspath.c
@@ -167,7 +167,6 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 	strbuf_add(&path, pfx, pfx_len);
 	strbuf_addstr(&path, arg);
 #else
-	char *p;
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
 	strbuf_reset(&path);
 	if (is_absolute_path(arg))
@@ -175,9 +174,7 @@ const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
 	else if (pfx_len)
 		strbuf_add(&path, pfx, pfx_len);
 	strbuf_addstr(&path, arg);
-	for (p = path.buf + pfx_len; *p; p++)
-		if (*p == '\\')
-			*p = '/';
+	convert_slashes(path.buf + pfx_len);
 #endif
 	return path.buf;
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 54c82ec..0413d5c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -763,15 +763,12 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 
 char *mingw_getcwd(char *pointer, int len)
 {
-	int i;
 	wchar_t wpointer[MAX_PATH];
 	if (!_wgetcwd(wpointer, ARRAY_SIZE(wpointer)))
 		return NULL;
 	if (xwcstoutf(pointer, wpointer, len) < 0)
 		return NULL;
-	for (i = 0; pointer[i]; i++)
-		if (pointer[i] == '\\')
-			pointer[i] = '/';
+	convert_slashes(pointer);
 	return pointer;
 }
 
@@ -2112,9 +2109,7 @@ static void setup_windows_environment()
 		 * executable (by not mistaking the dir separators
 		 * for escape characters).
 		 */
-		for (; *tmp; tmp++)
-			if (*tmp == '\\')
-				*tmp = '/';
+		convert_slashes(tmp);
 	}
 
 	/* simulate TERM to enable auto-color (see color.c) */
-- 
2.7.0.118.g90056ae
