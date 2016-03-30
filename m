From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 V3] MSVC: Use shipped headers instead of fallback definitions
Date: Wed, 30 Mar 2016 11:19:01 -0700
Message-ID: <xmqqbn5vu8ve.fsf@gitster.mtv.corp.google.com>
References: <56FAACD4.9080504@cs-ware.de> <56FAB9FD.7080409@cs-ware.de>
	<56FB93B9.7090306@gmail.com> <56FBBA80.8090908@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>, blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 20:19:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alKi1-0003sG-9X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 20:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbcC3STH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 14:19:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753517AbcC3STG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 14:19:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A95A350E55;
	Wed, 30 Mar 2016 14:19:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Suum1CI4bMVXxTlkKgmTr3sW6bU=; b=ApwhBQ
	kqudekk05vt66JcviDGSplCrJlLsiJ9qwY+Jk+1wXwOD5GmVSaiXUd0NroNl2+en
	y/p9S0m8BA0siiOY6HY2KwXhmrI6MczVl+ZZCptqybGSjqU+8AomYYXTFqnWwIFt
	5guczyKtwqAetc+0ALOeCBRFrNyYqW6+HoBzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GAQCu1q5y01w2fvcB0i9dsd6Eaeav4l8
	vTtL7kQSeS+VdzuJnqBsTT9Dyyoyz5GmIPSzb1uR9Rz0iCKUeMOhfBH0jQIxfaik
	j7tQgy9IUsVSwvbczQ1eI5TDKGKmIyaKCmDLJNxPhfn0ynFhi6hAUmqpBv6sMnNz
	lBQhsdbv03U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9313C50E54;
	Wed, 30 Mar 2016 14:19:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F029450E52;
	Wed, 30 Mar 2016 14:19:02 -0400 (EDT)
In-Reply-To: <56FBBA80.8090908@cs-ware.de> (Sven Strickroth's message of "Wed,
	30 Mar 2016 13:37:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E19EF972-F6A3-11E5-98D6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290334>

Sven Strickroth <sven@cs-ware.de> writes:

> diff --git a/compat/mingw.h b/compat/mingw.h
> index 6b6d695..137f42e 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -415,7 +415,7 @@ int mingw_offset_1st_component(const char *path);
>  extern void build_libgit_environment(void);
>  extern const char *program_data_config(void);
>  #define git_program_data_config program_data_config
> -#ifndef __MINGW64_VERSION_MAJOR
> +#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
>  #define PRIuMAX "I64u"
>  #define PRId64 "I64d"
>  #else

I'll wiggle this in, but you seem to be building on top of some
unrelated work (please avoid sending such a patch in the future).

Thanks, all of you.

-- >8 --
From: Sven Strickroth <sven@cs-ware.de>
Date: Wed, 30 Mar 2016 13:37:36 +0200
Subject: [PATCH] MSVC: use shipped headers instead of fallback definitions

VS2010 comes with stdint.h [1]
VS2013 comes with inttypes.h [2]

[1] https://stackoverflow.com/a/2628014/3906760
[2] https://blogs.msdn.microsoft.com/vcblog/2013/07/19/c99-library-support-in-visual-studio-2013/

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Acked-by: Sebastian Schuberth <sschuberth@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/mingw.h                  | 2 +-
 compat/vcbuild/include/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index c008694..1de70ff 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -406,7 +406,7 @@ static inline void convert_slashes(char *path)
 int mingw_offset_1st_component(const char *path);
 #define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
-#ifndef __MINGW64_VERSION_MAJOR
+#if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
 #else
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index c65c2cd..3a959d1 100644
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
2.8.0-215-gd29a7d9
