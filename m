From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 3/3] test: fix t5560 on FreeBSD
Date: Fri, 11 Apr 2014 01:28:19 -0700
Message-ID: <0101ef71fafab90325bb799cb8ad80e@74d39fa044aa309eaea14b9f57fe79c>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 10:28:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWpE-0003Dh-00
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 10:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbaDKI2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 04:28:34 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37930 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbaDKI2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 04:28:30 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so5024948pde.29
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OOwq4LsXHqbWcUcxqfEy0TRmySJ0/hGy64AujjAXB4E=;
        b=YQne1nE220mx/e9qEd7Hs9fYNdZX33JSy2uBx1eSf3fF6+DoJekDdZQh81bsX6ljZ2
         TtxHCSq1mk8JUochHSKRhDRh1kxyzpD1P7ImlNEM/jCKGKYv6nsnKPArZJcU2dKj2ieU
         qy7HlqlXm1cUlMRtT3izQ0sI+TongRt+Dj3Y8yF2uxDG3DOkTJGBNZZJFgVEjfb4EkKK
         hOBPbQD7278PNiZoq+W0SzFr3DZBdBBdeb0Jg1zWsaHRfmdOw/kuLavI5LqLdQMNCGlE
         x8a+ycF9Yo56YGZRiroxikU5o8PogTJn4HXTkfflyqzaWttCwrgFFhae2XXq47AolgV4
         ycSQ==
X-Received: by 10.68.163.100 with SMTP id yh4mr25811944pbb.122.1397204910290;
        Fri, 11 Apr 2014 01:28:30 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ky8sm14002027pbc.64.2014.04.11.01.28.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 01:28:29 -0700 (PDT)
In-Reply-To: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246071>

Since fd0a8c2e (first appearing in v1.7.0), the
t/t5560-http-backend-noserver.sh test has used a backslash escape
inside a ${} expansion in order to specify a literal '?' character.

Unfortunately the FreeBSD /bin/sh does not interpret this correctly.

In a POSIX compliant shell, the following:

x='one?two?three'
echo "${x#*\?}"

Would be expected to produce this:

two?three

When using the FreeBSD /bin/sh instead you get this:

one?two?three

In fact the FreeBSD /bin/sh treats the backslash as a literal
character to match so that this:

y='one\two\three'
echo "${y#*\?}"

Produces this unexpected value:

wo\three

In this case the backslash is not only treated literally, it also
fails to defeat the special meaning of the '?' character.

Instead, we can use the [...] construct to defeat the special meaning
of the '?' character and match it exactly in a way that works for the
FreeBSD /bin/sh as well as other POSIX /bin/sh implementations.

Changing the example like so:

x='one?two?three'
echo "${x#*[?]}"

Produces the expected output using the FreeBSD /bin/sh.

Therefore, change the use of \? to [?] in order to be compatible with
the FreeBSD /bin/sh which allows t/t5560-http-backend-noserver.sh to
pass on FreeBSD again.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

---
 t/t5560-http-backend-noserver.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9be9ae34..5abd11a5 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -9,8 +9,8 @@ test_have_prereq GREP_STRIPS_CR && export GREP_OPTIONS=-U
 
 run_backend() {
 	echo "$2" |
-	QUERY_STRING="${1#*\?}" \
-	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%\?*}" \
+	QUERY_STRING="${1#*[?]}" \
+	PATH_TRANSLATED="$HTTPD_DOCUMENT_ROOT_PATH/${1%%[?]*}" \
 	git http-backend >act.out 2>act.err
 }
 
-- 
tg: (532c2992..) t/freebsd-t5560 (depends on: t/revert-99855ddf)
