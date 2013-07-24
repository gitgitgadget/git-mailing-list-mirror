From: Drew Northup <n1xim.email@gmail.com>
Subject: [PATCH V2] TIG: Fix to reinstate proper operation with no arguments
Date: Wed, 24 Jul 2013 08:50:27 -0400
Message-ID: <1374670227-15677-1-git-send-email-n1xim.email@gmail.com>
References: <51EFC8B1.20405@gmail.com>
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Drew Northup <n1xim.email@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 14:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1yX6-0005mJ-5U
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 14:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab3GXMvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 08:51:04 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:61142 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3GXMvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 08:51:02 -0400
Received: by mail-ve0-f181.google.com with SMTP id jz10so319111veb.40
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nSLaspiSRCkm8sruUiOFK6gPeYEU0jxWpPNfHtpgeyk=;
        b=IZAtgTLGy/VrdRZ6oPGure9IUTap4nWy3MtzGCV+qNiZ6QfxvShD7JUoNeXBp/kQGk
         qqyjSvgLJOexfwj4l/r+jHRRnURDSlrPJDHBr8AD8R/aGcvXt6mf/hoAvzt8K1l5N6QT
         c8wHgBH5yxkfUCg64hED6/hJuvux4zcDqLL4tt+m/i6vh1TWIq+yyRf8LzKrNvhbI75N
         BJr2jMI3FuG3RfFyItXNRthkldqsya0yjBFZhptsp8jiWFMQacyofMS6q7UguTY1mhnd
         RUhuc03m2OXiaNBDuM7n7Fdkc8ZCFg7uwJAtZOn/jANWnwc0HM10TRvwzej1ph6lL6Bg
         IyxQ==
X-Received: by 10.52.71.239 with SMTP id y15mr1118416vdu.85.1374670261458;
        Wed, 24 Jul 2013 05:51:01 -0700 (PDT)
Received: from atom.sys-os.org (pool-70-16-204-240.man.east.myfairpoint.net. [70.16.204.240])
        by mx.google.com with ESMTPSA id p5sm14163890vek.1.2013.07.24.05.51.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 05:51:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <51EFC8B1.20405@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231095>

Since c7d67ab running "tig" with no options has failed with the
error "tig: No revisions match the given arguments." This was due
to a change in how the arguments for the back-end git call was
being constructed. This change caused the blank field left in
place of "(encoding_arg)" when it is empty to not overwrite
"buf" which then caused the value in "buf" to be copied into
dst_argv twice. The resulting git command failed if there was no
available revision named "log" as shown in the trace.

>From the TIG_TRACE log:
git log log --no-color --pretty=raw --parents --parents --
fatal: bad revision 'log'

This fix works by properly and fully initializing "buf" before each use.

github issue # 167

Helped-by: Jonas Fonseca <fonseca@diku.dk>
Signed-off-by: Drew Northup <n1xim.email@gmail.com>
---

This should apply cleanly to the tig public master whether the
mkstemps() patch I wrote has been applied or not. (As of the time I
am sending this for review I haven't yet applied the latest fix to
my mkstemps() patch that has been submitted for git itself.)

This time, knowing for sure now that format->buf is not being used in
the extant code path for any other purpose, I went ahead and
initialized the whole thing to be sure that we don't find any other
ghosts hiding in that buffer between uses. Just initializing the
first byte fixes the near term problem but does not prevent the buffer
initialization issue that this bug highlighted from rising up again
later on.

 tig.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tig.c b/tig.c
index ba9ba98..c65bc43 100644
--- a/tig.c
+++ b/tig.c
@@ -3104,8 +3104,12 @@ format_expand_arg(struct format_context *format, const char *name)
 static bool
 format_append_arg(struct format_context *format, const char ***dst_argv, const char *arg)
 {
+	int i;
 	format->bufpos = 0;
 
+	for (i = 0; i < SIZEOF_STR; i++)
+		format->buf[i] = 0;
+
 	while (arg) {
 		char *next = strstr(arg, "%(");
 		int len = next ? next - arg : strlen(arg);
-- 
1.8.0
