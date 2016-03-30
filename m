From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH 2/2 V3] MSVC: Use shipped headers instead of fallback
 definitions
Date: Wed, 30 Mar 2016 13:37:36 +0200
Message-ID: <56FBBA80.8090908@cs-ware.de>
References: <56FAACD4.9080504@cs-ware.de> <56FAB9FD.7080409@cs-ware.de>
 <56FB93B9.7090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, blees@dcon.de
X-From: git-owner@vger.kernel.org Wed Mar 30 13:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alERY-0001z0-HB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 13:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcC3Lho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 07:37:44 -0400
Received: from srv1.79p.de ([213.239.234.118]:39728 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbcC3Lhn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 07:37:43 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [141.20.25.102] (dig102.informatik.hu-berlin.de [141.20.25.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id A79EF224474;
	Wed, 30 Mar 2016 13:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1459337858;
	bh=B+834y1HAc0UR7XvmOR31RW6+VmF4WJ/2lKMNR6QYEA=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=vdUwHOZRsQUSh3ZFlljD6PVXFJdzIfQ5gP60VzVdjnxn4vfL19aJimvsU9k/ykhFz
	 v7AK3UsyUfjUR482vvcqW6Ck8NTl7KOZ3T9MD+PaNDstnWRTNkGk8kuc7QlkabPSSa
	 QLq/eB/LGBFUXs0dAar8HhKLlMIf9w/wnASw09S/2OHvroGTbnlK4hhBGW9+lgv6ar
	 54LpZA0Me0G8rgRga/+gI7tGIhMNoo0oOZx7WlFJD9MwQ/rg1ien1/epdp6b2hOZzK
	 PIB9MWRKLK7Z+3VnUxubzFzIHYPJW9JH2eN0OC9HXuuqHPFWF5mwp/jcQzQNhcjklf
	 ObSoxo8icH4/w==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56FB93B9.7090306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290300>

VS2010 comes with stdint.h [1]
VS2013 comes with inttypes.h [2]

[1] https://stackoverflow.com/a/2628014/3906760
[2] https://blogs.msdn.microsoft.com/vcblog/2013/07/19/c99-library-support-in-visual-studio-2013/

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
---
 compat/mingw.h                  | 2 +-
 compat/vcbuild/include/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 6b6d695..137f42e 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -415,7 +415,7 @@ int mingw_offset_1st_component(const char *path);
 extern void build_libgit_environment(void);
 extern const char *program_data_config(void);
 #define git_program_data_config program_data_config
-#ifndef __MINGW64_VERSION_MAJOR
+#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
 #else
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index c65c2cd..b7cc48c 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -45,11 +45,15 @@ typedef unsigned long long uintmax_t;
 
 typedef int64_t off64_t;
 
+#if !defined(_MSC_VER) || _MSC_VER < 1600
 #define INTMAX_MIN  _I64_MIN
 #define INTMAX_MAX  _I64_MAX
 #define UINTMAX_MAX _UI64_MAX
 
 #define UINT32_MAX 0xffffffff  /* 4294967295U */
+#else
+#include <stdint.h>
+#endif
 
 #define STDIN_FILENO  0
 #define STDOUT_FILENO 1
-- 
2.7.4.windows.1
