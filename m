From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH 2/2] Get rid of online_cpus() when determining grep threads num
Date: Tue, 15 Dec 2015 18:31:40 +0300
Message-ID: <1450193500-22468-3-git-send-email-vleschuk@accesssoftek.com>
References: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, gitster@pobox.com, john@keeping.me.uk,
	peff@peff.net, pclouds@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 16:32:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ra3-00017n-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 16:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbbLOPbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 10:31:50 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35817 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965229AbbLOPbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 10:31:49 -0500
Received: by mail-lb0-f175.google.com with SMTP id u9so8001068lbp.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fpEXyWX+M3ItR+mWyXFFfuusLM612qfSN2JfnP8KT/A=;
        b=p+1IjmrOGaFGlFdrxU+OiETTk3pyhDxvJUb1UQELNYFAlndMP4bo1DeVM+c65ObbI8
         rKjUhpJu8MHcP3NReazpeTKLMZJEYRmgHuo36J5zdQnuY54J9vvVdf6xLNfT5obFXQdS
         Iedwa1MTF1w8G5fyQ01ZRvODYCt/haf0ETaZUGpCrlh6rAdt2N25/A1H4m2CAOOhi6eF
         cmx1LjlQM05chGMt2X//uPX+jl2Z16OpDkuo7rHIMv0k0+ScwfvHemKSy0j4ls8aJKBh
         MwTTC36MagITqKD468S8yGAnEK4fwQ6nLuDwtphNe1mcIabuNYrsmkqkuQeltd/l7FYK
         99OA==
X-Received: by 10.112.184.45 with SMTP id er13mr15867618lbc.133.1450193507340;
        Tue, 15 Dec 2015 07:31:47 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id dz6sm284182lbb.17.2015.12.15.07.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2015 07:31:45 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a8rZo-0005rE-Nk; Tue, 15 Dec 2015 18:31:44 +0300
X-Mailer: git-send-email 2.6.3.369.g3e7f205.dirty
In-Reply-To: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282480>

Number of threads now doesn't depend on online_cpus(),
e.g. if specific number is not configured GREP_NUM_THREADS_DEFAULT (8)
threads will be used even on 1-core CPU.

Reason: multithreading can improve performance even on single core machines
as IO is also a major factor here. Using multiple threads can significantly
boost grep performance when working on slow filesystems (or repo isn't cached)
or through network (for example repo is located on NFS).

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e9aebab..1315905 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -827,7 +827,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 #ifndef NO_PTHREADS
-	if (list.nr || cached || online_cpus() == 1 || show_in_pager) {
+	if (list.nr || cached || show_in_pager) {
 		/* Can not multi-thread object lookup */
 		num_threads = 0;
 	}
-- 
2.6.3.369.g3e7f205.dirty
