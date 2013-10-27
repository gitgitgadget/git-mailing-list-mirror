From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/10] transport-helper: updates
Date: Sun, 27 Oct 2013 01:05:11 -0600
Message-ID: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKW9-0006fP-GK
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3J0HMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:03 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:36348 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J0HMC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:02 -0400
Received: by mail-oa0-f54.google.com with SMTP id o20so2436685oag.41
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iIyzvslWtGfHENCuZENdMLVoMlp2fdwaFyCkPl01nqs=;
        b=T3wflGt7JnB/Qyz2ZXnKMwtag3q1TUQ6SuNe5YV9Uleh8enDV6eI+FAFY0L23hlSQj
         zNShTzRNFky8Kme4tUPMQdQ4ecPGpz3YhPydk5O6cuVty4X8dQypC6E42Rh8LKOhMMIP
         mY7R+NOfD3niCLQcu3O17rvcQnDxEGlcb/cEXpDR3M625u1oXSWJCCz1sw4VebqZ6Z5T
         9Nh8UmAJA7vqxCYiuTfWTHj7m1D6VZq6Nf8xI8dJno5xM9CFlafFuD//R9SN+w0g5uIW
         nlPKOw/iAk+4eX7dZhUYZU3Y0S/QBKfA8GsWMo/vaNEPLFl4UkS4+LACw/6Ogv5swaJh
         q0lA==
X-Received: by 10.182.129.42 with SMTP id nt10mr9586885obb.19.1382857921252;
        Sun, 27 Oct 2013 00:12:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id jz7sm22401021oeb.4.2013.10.27.00.11.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236779>

Hi,

Here are the patches that allow transport helpers to be completely transparent;
renaming branches, deleting them, custom refspecs, --force, --dry-run,
reporting forced update, everything works.

Some of these were were sent before and rejected without a reason, but here
they are again in case anybody is interested.

This time rebased on top of the latest master, plus a few fixes.

Diff from v3:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9b728ca..60d4c80 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -686,7 +686,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
        struct commit *commit;
        char *export_filename = NULL, *import_filename = NULL;
        uint32_t lastimportid;
-       struct string_list refspecs_list;
+       struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
        struct option options[] = {
                OPT_INTEGER(0, "progress", &progress,
                            N_("show progress after <n> objects")),
diff --git a/transport-helper.c b/transport-helper.c
index d94eaf4..91636d5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -836,9 +836,6 @@ static int push_refs_with_export(struct transport *transport,
                char *private;
                unsigned char sha1[20];
 
-               if (ref->deletion)
-                       die("remote-helpers do not support ref deletion");
-
                private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
                if (private && !get_sha1(private, sha1)) {
                        strbuf_addf(&buf, "^%s", private);

Felipe Contreras (10):
  transport-helper: add 'force' to 'export' helpers
  transport-helper: fix extra lines
  transport-helper: check for 'forced update' message
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches
  transport-helper: don't update refs in dry-run

 Documentation/git-fast-export.txt |  4 ++++
 Documentation/git-fast-import.txt |  3 +++
 builtin/fast-export.c             | 47 ++++++++++++++++++++++++++++++++++++++-
 fast-import.c                     | 13 ++++++++---
 t/t5801-remote-helpers.sh         | 10 ++++++++-
 t/t9300-fast-import.sh            | 18 +++++++++++++++
 t/t9350-fast-export.sh            | 18 +++++++++++++++
 transport-helper.c                | 47 ++++++++++++++++++++++++++-------------
 8 files changed, 140 insertions(+), 20 deletions(-)

-- 
1.8.4-fc
