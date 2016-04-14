From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Port `submodule init` to C
Date: Thu, 14 Apr 2016 11:18:27 -0700
Message-ID: <1460657909-1329-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, pclouds@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 20:19:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlr1-00033L-BF
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbcDNSSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:18:54 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36024 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbcDNSSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:18:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id er2so18554095pad.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CTTerbSgwFt4c7Tie7pi1DxF38TIeR1BRiQwpL93iEo=;
        b=HgUUE7EQX0PO1eSgwpEcsen7ygGI2eT4+6ayqofD36MFgcQS4ugczzvGaUDj5SLNG+
         Y03cDkxRiJ/vkJx/slp4biaYqDNxHxJsj3JjkwHaG4cmNMZ0O3KuMowHVGdPeOTW+d4L
         mQeFJdU/tuTEUwtc5Ix+G0iuEhivXl31eRrYxbuSTLJTqpzw6pF+OZBBpgAHGOVa2qSF
         jIsnklaruloQz2LY2ETNCMkx6h8DRsqKRiuYlQhzdfxco+TmoHgdD3jLl7dJfPTUsr/G
         lC1KHmEyO+6l5ulctslF92smDUgKRji2qsX0Qy0w8Y1lhgM15qHP3PLua8r2biYQnYd0
         7dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CTTerbSgwFt4c7Tie7pi1DxF38TIeR1BRiQwpL93iEo=;
        b=WIu43NUTohjxkePkr6AFMTVJQ/qscvVqz4/0t9uqaxe339H1DDRSk5rKNswJavsBRD
         Z7lXEihO4sSP+auMFK9Cx6/mxaY5Ridu8d6ETYyCICaoyoYhYUG731TMaCetHBAMmp/a
         7QOPTo9pEvhVjutONyvoOpd2EtOi+rXYr2v+4I5yYA1NklD0MqnAo0Hucc3oRair8EAA
         xYSTWMw+8Yt23HarYJv9/WQ8zE+18o/BLaX5Te8VELBBmUATSprCF2yzHSGcrGf1mD6m
         MjL6XCAkw5LF5y+NVVN1JegbACwzK3lBxD9PwmQZVCfSjd+PF8VgDykZE6O8/ltH9e90
         d4Pw==
X-Gm-Message-State: AOPr4FXTyh4MOaJNwNyHgXCs8/ZTu41q3HY7OAOkbZnyHN06Q67CnwAetwx00dP+1oZYT5uc
X-Received: by 10.66.146.164 with SMTP id td4mr23144689pab.47.1460657931028;
        Thu, 14 Apr 2016 11:18:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:74d2:d897:f991:78d5])
        by smtp.gmail.com with ESMTPSA id r70sm6179744pfb.74.2016.04.14.11.18.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Apr 2016 11:18:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.26.g0341e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291545>

This is another round for sb/submodule-init.

Changes since last round:
* Also iterate over the submodules in the C helper. With that missing piece
  `git submodule init` is completely handled in C now except for the usage
  string and the command->subcommand selection. (i.e. when calling
  `git submodule init`, we still go through git.c -> git-submodule.sh
  -> submodule--helper.c, but we do not go back into the shell after parsing
  `init` and calling module_init for it.
* This applies on another base commit, such that we make use of the tests
  written in origin/sb/submodule-path-misc-bugs. (I am not sure if I have too
  many series in flight stomping on each other here)
* This time I actually fix what Ramsay was hinting at:
  strbuf_detach(&sb, NULL) instead of strbuf_detach(&sb, 0);

Where do these patches apply?
=============================

I ran the following commands for a new starting point of this series:

    git checkout --detach origin/sb/submodule-parallel-update
    git merge origin/sb/submodule-helper-clone-regression-fix
    git merge origin/sb/submodule-path-misc-bugs

The second merge produces 2 conflicts, which can be resolved like this:
(I am unsure about the second comment in strbuf.h though)
diff --cc builtin/fetch.c
index 5aa1c2d,e4639d8..0000000
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@@ -37,7 -37,8 +37,8 @@@ static int prune = -1; /* unspecified *
  static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
  static int tags = TAGS_DEFAULT, unshallow, update_shallow;
 -static int max_children = 1;
 +static int max_children = -1;
+ static enum transport_family family;
  static const char *depth;
  static const char *upload_pack;
  static struct strbuf default_rla = STRBUF_INIT;
diff --cc strbuf.h
index d4f2aa1,f72fd14..0000000
--- a/strbuf.h
+++ b/strbuf.h
@@@ -387,15 -387,10 +387,16 @@@ extern ssize_t strbuf_read_file(struct 
  extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
  
  /**
 + * Write the whole content of the strbuf to the stream not stopping at
 + * NUL bytes.
 + */
 +extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
 +
 +/**
-  * Read a line from a FILE *, overwriting the existing contents
-  * of the strbuf. The second argument specifies the line
-  * terminator character, typically `'\n'`.
+  * Read a line from a FILE *, overwriting the existing contents of
+  * the strbuf.  The strbuf_getline*() family of functions share
+  * this signature, but have different line termination conventions.
+  *
   * Reading stops after the terminator or at EOF.  The terminator
   * is removed from the buffer before returning.  Returns 0 unless
   * there was nothing left before EOF, in which case it returns `EOF`.

As sb/submodule-parallel-update and sb/submodule-helper-clone-regression-fix
both touch builtin/submodule--helper.c, so we need those.

We need origin/sb/submodule-path-misc-bugs as it tests `submodule add`
output.

Thanks,
Stefan

Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 322 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 127 +----------------
 submodule.c                 |  21 +++
 submodule.h                 |   1 +
 t/t0060-path-utils.sh       |  43 ++++++
 5 files changed, 392 insertions(+), 122 deletions(-)

-- 
2.8.0.26.g0341e85
