From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: Unusual behavior from git describe
Date: Sat, 30 Jul 2011 12:23:30 -0400
Message-ID: <CA+jCPNfsQ2oqDzTpJL4ck0vNBJnfXwb+aaSrzStrs55kq+CTHA@mail.gmail.com>
References: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
	<CAGdFq_hYiBoqNmNtBKBqNN4XLLKwxDMHJfAUwdHB_iCcya=DOQ@mail.gmail.com>
	<CA+jCPNfwwhM8R-bB_VnwpaijSMf3BNydH35SqZt3dRb-P1AOmg@mail.gmail.com>
	<CAGdFq_imU3_=E1LK-AG33Tj70iOJBTmt2_qdUKVHL9DVW2yJRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 18:23:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnCK8-00012E-5c
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab1G3QXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 12:23:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39945 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab1G3QXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 12:23:31 -0400
Received: by vws1 with SMTP id 1so3606465vws.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wFyLPSuDcDB9UjPi3dmcrtDEQy+48zreUlKvLHuBfWo=;
        b=t6g4FbKYRg4YzrhHyu8cVjZ5kSwz1z/2YrmzF6PkgJ/N+3K8T8zvuVMMRufr3YRfJl
         bbwWtjvidGc4L0Ok/XqIBVWaTrBTSiBY5zTeI6roF/lER/rfIYFbyWRu+/S8S8AgqyHg
         nr1M0ZPQ21JLJbxIfW3EB+xRv9kISn0R0uZuY=
Received: by 10.52.21.172 with SMTP id w12mr2686873vde.348.1312043010912; Sat,
 30 Jul 2011 09:23:30 -0700 (PDT)
Received: by 10.52.155.74 with HTTP; Sat, 30 Jul 2011 09:23:30 -0700 (PDT)
In-Reply-To: <CAGdFq_imU3_=E1LK-AG33Tj70iOJBTmt2_qdUKVHL9DVW2yJRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178211>

On Sat, Jul 30, 2011 at 9:32 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Does it perhaps touch some of the tracked files? That way it would
> make sense git at first thinks it's dirty (since the lstat info
> changed), but then 'git status' will actually check the contents of
> the file and notice that they're equal? Just guessing here though.

Sounds like you're on the right track.  git diff-index reveals that
the index is stale

========>8==============>8=========
:100644 100644 781975ec321be574e0b016c9e699804430a4cefc
0000000000000000000000000000000000000000 M	MANIFEST.in
:100644 100644 bddeac47f9d67e8496a7e1d76f3e024e644ee332
0000000000000000000000000000000000000000 M	fabfile.py
...
:100644 100644 4f09e2dbb7b0b7aeb0063468bd1931e5c969d2d6
0000000000000000000000000000000000000000 M	flaskapi/__init__.py
:100644 100644 e4cc0de216a9c5a68ca87650bbe0be24f327df27
0000000000000000000000000000000000000000 M	version.py
===============>8==============>8==

It looks like this was caused by setuptools hardlinking files into a
temp directory and then deleting the links, as demonstrated by:

% git diff-index HEAD --
% ln MANIFEST.in file && rm file
% git diff-index HEAD --
:100644 100644 781975ec321be574e0b016c9e699804430a4cefc
0000000000000000000000000000000000000000 M	MANIFEST.in

I've tried adding a call to refresh_index() in describe.c but it
doesn't seem to have any effect on the results. (Patch below.)  Any
idea what the proper fix is for this?

--
Allan

diff --git a/builtin/describe.c b/builtin/describe.c
index 66fc291..73e98ed 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -462,8 +462,11 @@ int cmd_describe(int argc, const char **argv,
const char *prefix)
                die(_("No names found, cannot describe anything."));

        if (argc == 0) {
-               if (dirty &&
!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1, diff_index_args,
prefix))
-                       dirty = NULL;
+               if (dirty) {
+                   refresh_index(&the_index,
REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+                   if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) -
1, diff_index_args, prefix))
+                           dirty = NULL;
+               }
                describe("HEAD", 1);
        } else if (dirty) {
                die(_("--dirty is incompatible with committishes"));
