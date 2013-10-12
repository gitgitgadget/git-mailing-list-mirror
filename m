From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: [PATCH v3] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Sat, 12 Oct 2013 23:48:16 +0300
Message-ID: <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 12 22:48:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV66m-0006JF-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 22:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab3JLUsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 16:48:17 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:37334 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3JLUsQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 16:48:16 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so4542370lbh.37
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=6xz5s3QcGpYeX4PIgUiYLzJqqHojkCMvq9K9dK8wIT8=;
        b=AFQ+0VsfwTby1ISR/BIzeqArA3NYYnvU+w62Kd5V+K+ilIkQJEgZoaHJqSlMWL+GCJ
         UwT1G74euYObuLKOQYdPObNCwDrJOC85QSLs5CGj6Frvq1x3euP+MOfOWY8KmqbF+w6H
         V0iknZJVSVXJR3F/MwPznYJxn1qJLc3LRpoP/7HupZC3+ItQ6IiERVIY+cpMOkN34ERQ
         NkmEyJu/BYLX08BAwVOgrvzc2UTUYLv01LfxU+DOjqkBQwwBNsGb7uS1h+9eO0mvMGkD
         H77QMrmDevhO5q/Zto9kWeYp0dn8xbv2lph8amtSAlkWZBnFJQ32q5YX0Mn8vYpTqpeC
         lNVA==
X-Received: by 10.152.28.7 with SMTP id x7mr3765842lag.26.1381610894295;
        Sat, 12 Oct 2013 13:48:14 -0700 (PDT)
Received: from [192.168.0.14] (cs27064221.pp.htv.fi. [89.27.64.221])
        by mx.google.com with ESMTPSA id k6sm51621606lae.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 13:48:13 -0700 (PDT)
In-Reply-To: <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236055>

"git diff -M --stat" can detect rename and show renamed file name like
"foofoofoo => barbarbar", but if destination filename is long the line
is shortened like "...barbarbar" so there is no way to know whether the
file is renamed or existed in the source commit.
This commit makes it visible like "...foo => ...bar".

Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
---
 diff.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index a04a34d..3aeaf3e 100644
--- a/diff.c
+++ b/diff.c
@@ -1643,13 +1643,57 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		len = name_width;
 		name_len = strlen(name);
 		if (name_width < name_len) {
-			char *slash;
-			prefix = "...";
-			len -= 3;
-			name += name_len - len;
-			slash = strchr(name, '/');
-			if (slash)
-				name = slash;
+			char *arrow = strstr(name, " => ");
+			if (arrow) {
+				int prefix_len = (name_width - 4) / 2;
+				int f_omit;
+				int f_brace = 0;
+				char *pre_arrow = alloca(name_width + 10);
+				char *post_arrow = arrow + 4;
+				char *prefix_buf = alloca(name_width + 10);
+				char *pre_arrow_slash = NULL;
+
+				if (arrow - name < prefix_len) {
+					prefix_len = (int)(arrow - name);
+					f_omit = 0;
+				} else {
+					prefix_len -= 3;
+					f_omit = 1;
+					if (name[0] == '{') {
+						prefix_len -= 1;
+						f_brace = 1;
+					}
+				}
+				prefix_len = ((prefix_len >= 0) ? prefix_len : 0);
+				strncpy(pre_arrow, arrow - prefix_len, prefix_len);
+				pre_arrow[prefix_len] = '\0';
+				pre_arrow_slash = strchr(pre_arrow, '/');
+				if (f_omit && pre_arrow_slash)
+					pre_arrow = pre_arrow_slash;
+				sprintf(prefix_buf, "%s%s%s => ", (f_brace ? "{" : ""), (f_omit ? "..." : ""), pre_arrow);
+				prefix = prefix_buf;
+
+				if (strlen(post_arrow) > name_width - strlen(prefix)) {
+					char *post_arrow_slash = NULL;
+
+					post_arrow += strlen(post_arrow) - (name_width - strlen(prefix) - 3);
+					strcat(prefix_buf, "...");
+					post_arrow_slash = strchr(post_arrow, '/');
+					if (post_arrow_slash)
+						post_arrow = post_arrow_slash;
+					name = post_arrow;
+					name_len = (int) (name_width - strlen(prefix));
+				}
+				len -= strlen(prefix);
+			} else {
+				char *slash = NULL;
+				prefix = "...";
+				len -= 3;
+				name += name_len - len;
+				slash = strchr(name, '/');
+				if (slash)
+					name = slash;
+			}
 		}
 
 		if (file->is_binary) {
-- 
1.8.4.475.g867697c
