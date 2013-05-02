From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] sha1_name: reorganize get_sha1_basic()
Date: Fri,  3 May 2013 01:17:58 +0530
Message-ID: <1367524078-13266-1-git-send-email-artagnon@gmail.com>
References: <CALkWK0=1qxWWRT9ic_4uVg_ZF_5T0_ogpWwTHotqxWqsi9GOnA@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 21:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzTo-00036A-QA
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 21:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761267Ab3EBTro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 15:47:44 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:52239 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760167Ab3EBTrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 15:47:43 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so464399daj.3
        for <git@vger.kernel.org>; Thu, 02 May 2013 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1xpFOqnHB0QN7Bt7fqe1v6sPDbd0wcy9tbLJIBc+mAQ=;
        b=L+zgTXHVhTDTwjec1uo77WTAKoOTTqnE+5dzF6GgWC1eV5sSJNGKGpWNJqOsVJJ4y9
         n+8r3R615xg1oI678zm0/RxzkWvoGQ1P8o63CwNsvs02X9dYz3o4P/Hxmk6VPJk0IHEW
         CXCtZXS9XgC/nt3/Pu5ifEFxeoxenrDwt5h/qLQDUHGDOnuzw7HzGmdLbnBAwX+ohai1
         JE6lS+mlkzU0Ra4WbbIhnhP0HH710TwICKTGBF70959LaepZyDTcQZ9RacWD2+Y5aGyK
         DZpw+U/4F9/aG0COlTyFshJo0UV8PG+6twUxkc1KiINiJl92DDaZuByUPDl3bHoKpx+d
         FtLg==
X-Received: by 10.68.136.198 with SMTP id qc6mr5756424pbb.117.1367524062883;
        Thu, 02 May 2013 12:47:42 -0700 (PDT)
Received: from localhost.localdomain ([122.164.42.189])
        by mx.google.com with ESMTPSA id ya4sm8451248pbb.24.2013.05.02.12.47.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 12:47:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.20.g061a98c.dirty
In-Reply-To: <CALkWK0=1qxWWRT9ic_4uVg_ZF_5T0_ogpWwTHotqxWqsi9GOnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223257>

A small suggestion.  Squash this in if you like; optionally submit it
as a separate part.

diff --git a/sha1_name.c b/sha1_name.c
index 6428001..109ab41 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -448,11 +448,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
        if (len && str[len-1] == '}') {
                for (at = len-2; at >= 0; at--) {
                        if (str[at] == '@' && str[at+1] == '{') {
-                               if (at == 0 && str[2] == '-') {
-                                       nth_prior = 1;
-                                       continue;
-                               }
-                               if (!upstream_mark(str + at, len - at)) {
+                               if (str[at+2] == '-') {
+                                       if (at != 0)
+                                               return -1;
+                                       else
+                                               nth_prior = 1;
+                               } else if (!upstream_mark(str + at, len - at)) {
                                        reflog_len = (len-1) - (at+2);
                                        len = at;
                                }
@@ -497,10 +498,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
                unsigned long co_time;
                int co_tz, co_cnt;
 
-               /* a @{-N} placed anywhere except the start is an error */
-               if (str[at+2] == '-')
-                       return -1;
-
                /* Is it asking for N-th entry, or approxidate? */
                for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
                        char ch = str[at+2+i];
