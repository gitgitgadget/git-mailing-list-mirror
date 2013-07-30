From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one action multiple times
Date: Tue, 30 Jul 2013 20:00:51 +0200
Message-ID: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 30 20:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4EE1-0005Sn-8O
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 20:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab3G3SAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 14:00:41 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:48058 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab3G3SAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 14:00:40 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so3159309wgh.21
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=m6aY1VN9Xk8XQn0M1uwiyjVoD1MIp80vJX57hKy5dks=;
        b=k2fjybSJEkSNYCVeExN04jK5ggghAK9sDuuhg0qGM+qbpotnLyD++qwbPupy3a11df
         3fIhhdP5f/A9QcYidhduHEHVenn4LJayLotifJ9VZLB8u9HydZNBoRA6wfNzyStRCmWU
         jXpd2zXxAbwyHB7E3d8rjS8CHwmVJqrvA6HO4Fkv6Y9IZUHH/tLNYR0RbfrAxbjz4cgX
         5AXLmvUis4zImm3EVJb29X3mLEJc0fHss/kOX8PgEnuZ4/xY7ws8FeFyr9TOLuJ7mA5y
         2b9DcDx7A7/fvYJOEBKcDc74Qy0pRjAfUTnU3YQNVXFkPOPyhkcM0rCCx+wvzfow4kwm
         DfBA==
X-Received: by 10.194.87.9 with SMTP id t9mr49462543wjz.39.1375207239724;
        Tue, 30 Jul 2013 11:00:39 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id hb2sm30096105wib.0.2013.07.30.11.00.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 11:00:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231376>

As of b04ba2bb (parse-options: deprecate OPT_BOOLEAN, 2011-09-27),
the OPT_BOOLEAN was deprecated.
While I am going to replace the OPT_BOOLEAN by the proposed OPT_BOOL or
the OPT_COUNTUP to keep existing behavior, this commit is actually a
bug fix!

In line 499 we have:
	if (list + delete + verify > 1)
		usage_with_options(git_tag_usage, options);
Now if we give one of the options twice, we'll get the usage information.
(i.e. 'git tag --verify --verify <tagname>' and
'git --delete --delete <tagname>' yield usage information and do not
do the intended command.)

This could have been fixed by rewriting the line to
	if (!!list + !!delete + !!verify > 1)
		usage_with_options(git_tag_usage, options);
or as it happened in this patch by having the parameters not
counting up for each occurrence, but the OPT_BOOL just setting the
variables to either 0 if the option is not given or 1 if the option is
given multiple times.

However we could discuss if the negated options do make sense here, or if
we don't want to allow them here, as this seems valid (before and after
this patch):
	git tag --no-verify --delete <tagname>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index b3942e4..d155c9d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -442,12 +442,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN('l', "list", &list, N_("list tag names")),
+		OPT_BOOL('l', "list", &list, N_("list tag names")),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
 				N_("print <n> lines of each tag message"),
 				PARSE_OPT_OPTARG, NULL, 1 },
-		OPT_BOOLEAN('d', "delete", &delete, N_("delete tags")),
-		OPT_BOOLEAN('v', "verify", &verify, N_("verify tags")),
+		OPT_BOOL('d', "delete", &delete, N_("delete tags")),
+		OPT_BOOL('v', "verify", &verify, N_("verify tags")),
 
 		OPT_GROUP(N_("Tag creation options")),
 		OPT_BOOL('a', "annotate", &annotate,
@@ -455,7 +455,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &msg, N_("message"),
 			     N_("tag message"), parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_BOOLEAN('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
+		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
 		OPT_STRING('u', "local-user", &keyid, N_("key id"),
-- 
1.8.4.rc0.1.g8f6a3e5
