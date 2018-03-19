Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0DDA1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967339AbeCSQts (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:49:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:53065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934025AbeCSQtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:49:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhB9P-1eIIEO0HYt-00oWEB; Mon, 19
 Mar 2018 17:49:39 +0100
Date:   Mon, 19 Mar 2018 17:49:22 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mingw: abort on invalid strftime formats
Message-ID: <66189602d022dd1911b5f5d98594506b80bb81ff.1521478106.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MvQ+YAP3BX4RCMcjHFkNyoScL6MJuQRT+AOZ9ldIvD/+gcyHejx
 9RdTUUeo+nBpA8ou9NNA2NJyBYCjkosxlDv/gDyBgJfUbNeUmI8EVF6eCLRbqZhgOtyKvux
 awux2lKGXhHDCPNEVo54wsTRCsGe23DySrvbK1dKBb/qZfb7RpAbdomZW+YiW7V6XWYHOAt
 YNNbEhW+UD3u1IAS2lwwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QOqVDEfidJU=:OCQC23KDziqqAetm6GKlfy
 Nw39jhnDe6bXSUM+yN6WGfifxdOyg2IAtOO9TDeR8Z7W0pRQzgp5wZcwCLseaYyquYUpGPwBz
 uQ92SMYYx4OvYx8H/APISEfbqhd4Tz8eE98tMSHcZ9gqX4LxMPkhNujnbnLGuOw+S146f6m+E
 MRqzESpkjd0dkhq0Dk1SylChUxlBFM0oiHn159q540hgaThPWyLo0ghNiTOihNYKQS6LE1iLU
 DP+D/NAiAPNdKOLI+25v5eCjof9w7JNVA4UycXieeE4XheZ5GoSh8cqCu33G5HCtTl7STSG2E
 w1wE35+u6omN/eTuo2irfoJ+fTRcwSb+NCiIW4WKMI7l4eZaJ8x3q1rdA3fi1Sw0V45QUpWa7
 NdNMmoVgkCrr8+NLzgguujDxDnquChYTsU1xaR/tLrD7oWKa7GrAbe32cf3BjiHRO/1VoGVB6
 NLsw6D5+uludeE7FG6KSpf9yqXF0JqiPlNDs8xIUB2Bnw2VWEwmisV44HpxmSV1jMhVVelSDE
 H/nv/mKznEx1xDGHeBLVSOoG1rKh7jELwUEzT9zHRYJ8LpfQl+fCv4MkOJ0vTdqmkDibYkAF7
 rdC+YRUc/AO5i6lt2IKzrzimYcWYo+kOCVcj4gwKeP84iACi4flj9ztB6d5EhdVzUsj7wkSni
 K9I6TPqgGIGjLuYCQrDE+NuRLrDLjLaHmXbtr7LKIfh5NGMaNVtXgKVLbUmtpgcyPEjQORs2P
 kSET4STLD9JDIDqb0+fIeoIU5GL8zJX4Buaxq4wYRc+iWaoRQdIVmdrzOcrLmNldQ7iSFuDrM
 mEgElaX+6kCzGrHkPKpvbYCIlgoB/2t9EMHTFpQCGRJk6UNYoY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, strftime() does not silently ignore invalid formats, but
warns about them and then returns 0 and sets errno to EINVAL.

Unfortunately, Git does not expect such a behavior, as it disagrees
with strftime()'s semantics on Linux. As a consequence, Git
misinterprets the return value 0 as "I need more space" and grows the
buffer. As the larger buffer does not fix the format, the buffer grows
and grows and grows until we are out of memory and abort.

Ideally, we would switch off the parameter validation just for
strftime(), but we cannot even override the invalid parameter handler
via _set_thread_local_invalid_parameter_handler() using MINGW because
that function is not declared. Even _set_invalid_parameter_handler(),
which *is* declared, does not help, as it simply does... nothing.

So let's just bite the bullet and override strftime() for MINGW and
abort on an invalid format string. While this does not provide the
best user experience, it is the best we can do.

See https://msdn.microsoft.com/en-us/library/fe06s4ak.aspx for more
details.

This fixes https://github.com/git-for-windows/git/issues/863

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is a really old patch (from 2016) that I had not managed to
	contribute to git.git yet...

 compat/mingw.c | 11 +++++++++++
 compat/mingw.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2d44d21aca8..a67872babf3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -761,6 +761,17 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	return rc;
 }
 
+#undef strftime
+size_t mingw_strftime(char *s, size_t max,
+		      const char *format, const struct tm *tm)
+{
+	size_t ret = strftime(s, max, format, tm);
+
+	if (!ret && errno == EINVAL)
+		die("invalid strftime format: '%s'", format);
+	return ret;
+}
+
 unsigned int sleep (unsigned int seconds)
 {
 	Sleep(seconds*1000);
diff --git a/compat/mingw.h b/compat/mingw.h
index e03aecfe2e6..571019d0bdd 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -361,6 +361,9 @@ int mingw_fstat(int fd, struct stat *buf);
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
+size_t mingw_strftime(char *s, size_t max,
+		   const char *format, const struct tm *tm);
+#define strftime mingw_strftime
 
 pid_t mingw_spawnvpe(const char *cmd, const char **argv, char **env,
 		     const char *dir,

base-commit: 0afbf6caa5b16dcfa3074982e5b48e27d452dbbb
-- 
2.16.1.windows.4

Published-As: https://github.com/dscho/git/releases/tag/mingw-strftime-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-strftime-v1
