From: Salikh Zakirov <salikh.zakirov@gmail.com>
Subject: [PATCH] git-add -u paths... now works from subdirectory
Date: Thu, 16 Aug 2007 02:01:43 +0900
Message-ID: <20070815170143.GA3068@makoto.usen.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Aug 15 19:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMGV-0007kB-5w
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 19:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934160AbXHORCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 13:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933777AbXHORCC
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 13:02:02 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:2104 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934144AbXHORB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 13:01:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1755140rvb
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 10:01:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=Iv4M+Pwbo/KMCQ66KeUgjpK9b+S43MHxf6TIWA814WZ0J28GYZ2TGA5Vo094u2jNFVqeF3n0kaBpLL17pPLUOoW66g9ekN5lhTOCdiFEG7L0InJd10Ldat3N8GbKPWlNSsEGKdff4C4QfXFTSSIwivSB0lMgc3+KAFRNwsZObBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=pM+LhApLYg55OEMGD2P/oxFLUOqNIM/kwWo32ozVQu/hIW5YiWMp+eftbUilMapHJGma8v8SWhgeXeBj2keYhVR8zonjlBZ6yL7MhCaa2jw7gLOaj8BH+8j5UzqJ9Ba07tNEHF27gebp8FQCDFpU/kj2pp4BHljLS1PiC/yxh+E=
Received: by 10.141.202.12 with SMTP id e12mr287738rvq.1187197318597;
        Wed, 15 Aug 2007 10:01:58 -0700 (PDT)
Received: from makoto ( [221.115.75.108])
        by mx.google.com with ESMTPS id l17sm2531743rvb.2007.08.15.10.01.56
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Aug 2007 10:01:57 -0700 (PDT)
Received: by makoto (sSMTP sendmail emulation); Thu, 16 Aug 2007 02:01:43 +0900
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55925>

git-add used to take the path limiters, but always considered them
as top-level paths, and thus didn't work from subdirectories.
However, using git-add -u from subdirectories is very convenient,
especially when development is done from within a subdirectory,
(e.g. for easier grepping), as it allows to use a universal
incantation 'git-add -u .' from anywhere.

Documentaion for git-add does not mention if the paths were supposed to be
relative to current directory of from the top, and the relative paths are far
more intuitive.

Signed-off-by: Salikh Zakirov <salikh@gmail.com>
---

The trivial test added with this patch failed before the patch and passes
after. All tests pass with this modification on my machine (Linux/i686).

Note that the potentially incorrect 'git-add -u ; git commit' behaviour is not
affected by this patch and still can cause horribly incorrect commits.

 builtin-add.c         |    8 ++++----
 t/t2200-add-update.sh |    8 ++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 82c806a..a09771f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -109,12 +109,12 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-static void update(int verbose, const char **files)
+static void update(int verbose, const char *prefix, const char **files)
 {
 	struct rev_info rev;
-	init_revisions(&rev, "");
+	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data = get_pathspec(rev.prefix, files);
+	rev.prune_data = get_pathspec(prefix, files);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &verbose;
@@ -216,7 +216,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	if (take_worktree_changes) {
-		update(verbose, argv + i);
+		update(verbose, prefix, argv + i);
 		goto finish;
 	}
 
diff --git t/t2200-add-update.sh t/t2200-add-update.sh
index 0a703af..93c007d 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -35,4 +35,12 @@ test_expect_success 'update did not touch other tracked files' \
 test_expect_success 'update did not touch untracked files' \
   'test "`git diff-files --name-status dir/other`" = ""'
 
+test_expect_success 'more changes' 'echo modified >> dir/sub'
+
+test_expect_success 'update from subdirectory' \
+  '(cd dir; git add -u sub)'
+
+test_expect_success 'update touched correct path' \
+  'test "`git diff-files --name-status dir/sub`" = ""'
+
 test_done
-- 
1.5.3.rc5.24.gac513
