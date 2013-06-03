From: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC v2] reflog: show committer date in verbose mode
Date: Mon,  3 Jun 2013 09:58:20 +0800
Message-ID: <517a09251fbbc81073fbd53f04a3f4b58cb8b3f7.1370224175.git.worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 03 03:58:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjK2i-0002jO-0I
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 03:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab3FCB6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 21:58:36 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:58296 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab3FCB6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 21:58:35 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so4865041pdb.40
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 18:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HufYBQd7XgZSbpXvtbGAB3nNZcgH/e+7QgaQRbnmJmk=;
        b=Mh9hg4gFJG0ksoVcI52Fzgkg6cB7lkjqv0AF7+BmxbVed6O2E+wfiZrl6502CxmCiK
         7iG0yr8eKwboUEVLC7uBewKAKLRJUid3SnegU5a4Haw5g526lBX1ASn7wrIaivJTKE4G
         WqAQUijMf2VUo+WQZyLzyOgnhlO6/r2wsQuvaNJHzM+xYtCOLPEmvJMXucwX1xzt7yR0
         u6X8PLnXlhny8eJQQa0X9zXIaMpt/iN34ge5A6VRjtBzVBeznbks2V5SI10mJGQmWKc8
         Wn5BD29sNE3XlBzKNhdERlmFy84DA2iy3pwiCD12A7ICQJar+tu7YPE7oUIq4Je4hmNP
         xcww==
X-Received: by 10.66.144.5 with SMTP id si5mr22650737pab.6.1370224714497;
        Sun, 02 Jun 2013 18:58:34 -0700 (PDT)
Received: from localhost.localdomain ([114.248.131.179])
        by mx.google.com with ESMTPSA id gi2sm56808254pbb.2.2013.06.02.18.58.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 18:58:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.490.gfd67a58.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226203>

By default, reflog won't show committer date and for some cases won't
show commit log either. It will be helpful to show them all by passing
a more complicated pretty formatter to `git reflog` like this:

    $ git reflog show \
      --pretty="%Cred%h%Creset %gd: %gs%n  >> %Cblue%ci (%cr)%Creset: %s"

It will be nice to add this pretty formatter automatically when run
`git reflog` in verbose mode. And in order to support verbose mode, add
new flag "verbose" in struct rev_info.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---

For example:

$ git reflog show -3 master
727a4 master@{0}: merge kernel/master: Fast-forward
edca41 master@{1}: merge kernel/master: Fast-forward
5e49f master@{2}: merge kernel/master: Fast-forward

$ git reflog show -3 -v master
727a4 master@{0}: merge kernel/master: Fast-forward
    Wed May 29 15:21:47 2013 -0700 (by Junio C Hamano, at 4 days ago)
edca41 master@{1}: merge kernel/master: Fast-forward
    Fri May 24 11:34:46 2013 -0700 (by Junio C Hamano, at 9 days ago)
5e49f master@{2}: merge kernel/master: Fast-forward
    Tue May 21 09:33:24 2013 -0700 (by Junio C Hamano, at 12 days ago)

$ git reflog show -3 -v -v master

727a4 master@{0}: merge kernel/master: Fast-forward
    Wed May 29 15:21:47 2013 -0700 (by Junio C Hamano, at 4 days ago)
    Sync with maint
edca41 master@{1}: merge kernel/master: Fast-forward
    Fri May 24 11:34:46 2013 -0700 (by Junio C Hamano, at 9 days ago)
    Git 1.8.3
5e49f master@{2}: merge kernel/master: Fast-forward
    Tue May 21 09:33:24 2013 -0700 (by Junio C Hamano, at 12 days ago)
    remote-hg: fix order of configuration comments

 builtin/log.c | 15 +++++++++++++++
 revision.c    |  1 +
 revision.h    |  1 +
 3 files changed, 17 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd3f10..d611b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -615,6 +615,21 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.use_terminator = 1;
 	rev.always_show_header = 1;
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
+	if (rev.verbose && !rev.pretty_given) {
+		struct strbuf formatter = STRBUF_INIT;
+		rev.verbose_header = 1;
+		rev.pretty_given = 1;
+		strbuf_addf(&formatter, "%s%%h%s %%gd: %%gs%%n",
+			    diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
+			    diff_get_color_opt(&rev.diffopt, DIFF_RESET));
+		strbuf_addf(&formatter, "    %s%%cd%s (by %%cn, at %%cr)",
+			    diff_get_color_opt(&rev.diffopt, DIFF_METAINFO),
+			    diff_get_color_opt(&rev.diffopt, DIFF_RESET));
+		if (rev.verbose > 1)
+			strbuf_addstr(&formatter, "%n    %s");
+		get_commit_format(formatter.buf, &rev);
+		strbuf_release(&formatter);
+	}
 
 	return cmd_log_walk(&rev);
 }
diff --git a/revision.c b/revision.c
index 518cd..f7483 100644
--- a/revision.c
+++ b/revision.c
@@ -1514,6 +1514,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
+		revs->verbose++;
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
diff --git a/revision.h b/revision.h
index a313a..dc4d8 100644
--- a/revision.h
+++ b/revision.h
@@ -119,6 +119,7 @@ struct rev_info {
 			show_notes_given:1,
 			show_signature:1,
 			pretty_given:1,
+			verbose:3,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
 			use_terminator:1,
-- 
1.8.3.490.gfd67a58.dirty
