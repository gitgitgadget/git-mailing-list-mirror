From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/16] remote-hg: add support for tag objects
Date: Mon, 22 Apr 2013 16:55:14 -0500
Message-ID: <1366667724-567-7-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOko-0002YA-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab3DVV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:58:26 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:36216 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3DVV6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:58:25 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so1595508oag.3
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5LXLjO/gEUGuaopas4T5EZVIEju+DnGHwI9oRcXeqmU=;
        b=qkg3SM/r6Ksq1L9bn13NhLhpiBCBBShUWrjQEeUI/NdUPxA7aqkYX5hU5TlOIhC5m2
         6A80tbOmA0o4kxRkjtQImmnvHXxWUW0MEppCNYjUN/e6OiWYVhAkPzfRrKIOydypKTsb
         aIcXNkhFGysy3UnZ1KeuMIt2Sfkir9b201GschpdYWxvWkAPm07ShBKRGOkW2prvbjXf
         n6gCrwPalDJIUKEk4FUg0ncPPu78v9OJLlqyzJJpom2lmUzeH48Gxy25T9uNvVBSvD3x
         h1ZZnqUITV8DYc6fI3gIQQT0vvDLWiMD1I3TY4F/Yf7lGJSAVNcjT4m90/8KmoSu0pRA
         YGYQ==
X-Received: by 10.182.113.164 with SMTP id iz4mr1737613obb.87.1366667905057;
        Mon, 22 Apr 2013 14:58:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id x10sm20867945oes.6.2013.04.22.14.58.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:58:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222103>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index bd93f82..4a1c637 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -722,7 +722,7 @@ def parse_tag(parser):
     data = parser.get_data()
     parser.next()
 
-    # nothing to do
+    parsed_tags[name] = (tagger, data)
 
 def do_export(parser):
     global parsed_refs, bmarks, peer
@@ -758,9 +758,11 @@ def do_export(parser):
             continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
+            author, msg = parsed_tags.get(tag, (None, None))
             if mode == 'git':
-                msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
-                parser.repo.tag([tag], node, msg, False, None, {})
+                if not msg:
+                    msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
+                parser.repo.tag([tag], node, msg, False, author[0], {})
             else:
                 parser.repo.tag([tag], node, None, True, None, {})
             print "ok %s" % ref
@@ -815,6 +817,7 @@ def main(args):
     global marks, blob_marks, parsed_refs
     global peer, mode, bad_mail, bad_name
     global track_branches, force_push, is_tmp
+    global parsed_tags
 
     alias = args[1]
     url = args[2]
@@ -857,6 +860,7 @@ def main(args):
     blob_marks = {}
     parsed_refs = {}
     marks = None
+    parsed_tags = {}
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.2.1.790.g4588561
