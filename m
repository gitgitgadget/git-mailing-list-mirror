From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 14/13] wildmatch: fix tests that fail on Windows due to path
 mangling
Date: Sun, 04 Nov 2012 22:00:31 +0100
Message-ID: <5096D76F.5090907@kdbg.org>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com> <1350282362-4505-1-git-send-email-pclouds@gmail.com> <1350282362-4505-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV7Jb-0001uU-Cg
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 22:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab2KDVAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 16:00:53 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:38313 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751275Ab2KDVAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 16:00:53 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 73D3C1193F9
	for <git@vger.kernel.org>; Sun,  4 Nov 2012 22:00:51 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B999813004E;
	Sun,  4 Nov 2012 22:00:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EED6119F40E;
	Sun,  4 Nov 2012 22:00:31 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <1350282362-4505-13-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209040>

Patterns beginning with a slash are converted to Windows paths before
test-wildmatch gets to see them. Use a different first character. This
does change the meaning of the test because the slash is special. But:

- The first pair of changed lines the test is about '*' matching an empty
  string, which does not need the slash.

- The second pair of changed lines the test is about a sequence of '*/',
  and I think we can afford to test without the leading slash.

One case is unchanged:

    match 1 x '/foo' '**/foo'

Even though the test is about ** matching zero levels at the beginning of
a path, on Windows, '**' actually matches something because /foo is
converted to c:\path\to\msys\foo. Let's be lazy and let this pass.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 After this change, there are still 3 failing tests that are in connection
 with [[:xdigit:]]. Don't know, yet, what's going on there.

 t/t3070-wildmatch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index e6ad6f4..74c0f7c 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -95,8 +95,8 @@ match 0 0 ']' '[!]-]'
 match 1 x 'a' '[!]-]'
 match 0 0 '' '\'
 match 0 x '\' '\'
-match 0 x '/\' '*/\'
-match 1 x '/\' '*/\\'
+match 0 x '-\' '*-\'
+match 1 x '-\' '*-\\'
 match 1 1 'foo' 'foo'
 match 1 1 '@foo' '@foo'
 match 0 0 'foo' '@foo'
@@ -187,8 +187,8 @@ match 0 0 '-' '[[-\]]'
 match 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
 match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
 match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 1 1 '/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' '/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 0 0 '/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' '/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 1 1 'adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' '*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 0 0 'adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' '*/*/*/*/*/*/12/*/*/*/m/*/*/*'
 match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n*t'
 match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*n*t'
 
-- 
1.8.0.rc0.45.g6c9d890
