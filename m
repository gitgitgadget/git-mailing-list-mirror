From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <avila.jn@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length calculation
Date: Tue, 15 Jan 2013 20:14:28 +0100
Message-ID: <201301152014.28433.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 20:15:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBz2-0004j9-5w
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab3AOTPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 14:15:18 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:33180 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab3AOTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 14:15:16 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 2E1FF77D0AA
	for <git@vger.kernel.org>; Tue, 15 Jan 2013 20:15:10 +0100 (CET)
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id D652F4B0168
	for <git@vger.kernel.org>; Tue, 15 Jan 2013 20:14:31 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc3jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213664>

Thank you for the explanation.

I did not monitor the system calls when writing that patch. 
Where is the perf framework?

As the mistake is located in the "find_basename" function, I would propose a 
fix directly into it so that the output fits what the other functions expect.

Something in the line of:

diff --git a/attr.c b/attr.c
index d6d7190..b6e72f3 100644
--- a/attr.c
+++ b/attr.c
@@ -572,7 +572,7 @@ static const char *find_basename(const char *path)
                if (*cp == '/' && cp[1])
                        last_slash = cp;
        }
-       return last_slash ? last_slash + 1 : path;
+       return last_slash ? last_slash : path;
 }
 
 static void prepare_attr_stack(const char *path)
@@ -770,6 +770,10 @@ static void collect_all_attrs(const char *path)
                check_all_attr[i].value = ATTR__UNKNOWN;
 
        basename = find_basename(path);
+       /* the slash is included in the basename
+          so that it can be matched by a directory pattern */
+       if (basename != path)
+               basename++;
        pathlen = strlen(path);
        rem = attr_nr;
        for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
