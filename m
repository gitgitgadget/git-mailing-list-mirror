From: Igor Murzov <igor@gplsoft.org>
Subject: [PATCH] fix some resource leaks discovered by cppcheck
Date: Fri,  2 Apr 2010 00:01:09 +0400
Message-ID: <1270152069-28816-1-git-send-email-igor@gplsoft.org>
Cc: Igor Murzov <igor@gplsoft.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 22:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxQZm-0001eM-0K
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 22:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796Ab0DAUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 16:01:09 -0400
Received: from unixoid.tversu.ru ([82.179.130.136]:58052 "EHLO
	unixoid.tversu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758768Ab0DAUBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 16:01:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by unixoid.tversu.ru (Postfix) with ESMTP id 83DDD7307A;
	Fri,  2 Apr 2010 00:03:40 +0400 (MSD)
Received: from localhost.localdomain (89-179-111-80.broadband.corbina.ru [89.179.111.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by unixoid.tversu.ru (Postfix) with ESMTP id 5395A1F9C3;
	Fri,  2 Apr 2010 00:03:40 +0400 (MSD)
X-Mailer: git-send-email 1.7.0.4
X-Bogosity: Ham, tests=bogofilter, spamicity=0.499553, version=1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143745>

---
 builtin/fmt-merge-msg.c |    2 ++
 builtin/rerere.c        |    1 +
 transport.c             |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 9d52400..7c9ee96 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -373,6 +373,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die_errno("could not read input file");
+	if(in != stdin)
+		fclose(in);
 	ret = fmt_merge_msg(merge_summary, &input, &output);
 	if (ret)
 		return ret;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 34f9ace..de76d48 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -64,6 +64,7 @@ static void garbage_collect(struct string_list *rr)
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
+	closedir(dir);
 }
 
 static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
diff --git a/transport.c b/transport.c
index 8ce3936..1c61145 100644
--- a/transport.c
+++ b/transport.c
@@ -134,6 +134,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 			list = &(*list)->next;
 		}
 	}
+	fclose(f);
 }
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
-- 
1.7.0.3.313.g87b3c.dirty
