From: Tomohiro Koana <kntmhr.1221@gmail.com>
Subject: [PATCH] Falis on commit --amend when already pushed
Date: Thu, 15 Oct 2015 13:09:15 +0900
Message-ID: <CACbztPOSZBaqLLUERS_yfvAEPmxS2PZs0fYTy7E_9HfLi9UGmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 06:09:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmZqz-0000nX-2N
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 06:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbbJOEJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 00:09:16 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35172 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbJOEJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 00:09:16 -0400
Received: by iofl186 with SMTP id l186so77619144iof.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Zx0VGKYB25nwSnRehqV/scl2AiRKvRT7LnxG5GKGoZA=;
        b=RbLDZ37yT0ar/vPMepeqwBm18b3/8C2gnG2+IhtigGM8GAM8Pyw53O9Vso2TZ9LYmZ
         jplw+rs7eGV1FouMa8pyzYPkAMiZplznuWDoXx0t4cdC6L+vTbSwyH79+XJXTdUnC3K6
         8dKy4daqNgbFo06hJn8lpxyp0lEpbXgkkhioGChgsmGfx/q1vcAov6t54RHsW1tWINbT
         qahXFcjhcHqLe+Bm1suJMYuLbzqaIZtI3yEuoCy8jrhBjdXF/3komvbpgWCEKGQl3l5P
         KZPL2J3QKvODWR0C9p1ELOFY8MN0O1DcVz0RmCJ5eA4A+JU+XidZfqrae2DiBC7MAAN4
         nsSw==
X-Received: by 10.107.129.25 with SMTP id c25mr4995546iod.12.1444882155256;
 Wed, 14 Oct 2015 21:09:15 -0700 (PDT)
Received: by 10.79.96.198 with HTTP; Wed, 14 Oct 2015 21:09:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279644>

Hello all,

I'm a third year student at the University of Tokyo and, in our
"Diving into open-source software" class, my friends and I decided to
work with git. Our final, hopefully, is contributing to git.

One improvement that we thought of was not letting users to amend
commit when the commit is already pushed to the remote server.

--- a/builtin/commit.c

+++ b/builtin/commit.c

@@ -32,6 +32,7 @@

 #include "sequencer.h"

 #include "notes-utils.h"

 #include "mailmap.h"

+#include "remote.h"



 static const char * const builtin_commit_usage[] = {

  N_("git commit [<options>] [--] <pathspec>..."),

@@ -1125,6 +1126,9 @@ static int parse_and_validate_options(int argc,
const char *argv[],

        struct wt_status *s)

 {

  int f = 0;

+ int ours, theirs;

+ const char *full_base;

+ struct branch *branch = branch_get(NULL);



  argc = parse_options(argc, argv, prefix, options, usage, 0);

  finalize_deferred_config(s);

@@ -1149,6 +1153,12 @@ static int parse_and_validate_options(int argc,
const char *argv[],

  else if (whence == FROM_CHERRY_PICK)

  die(_("You are in the middle of a cherry-pick -- cannot amend."));

  }

+

+ stat_tracking_info(branch, &ours, &theirs, &full_base);

+ if (amend && ours == 0) {

+ die(_("This commit is already pushed to the remote -- cannot amend."));

+ }

+

  if (fixup_message && squash_message)

  die(_("Options --squash and --fixup cannot be used together"));

  if (use_message)
