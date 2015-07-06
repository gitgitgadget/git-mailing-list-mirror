From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/23] checkout: relocate --to's "no branch specified" check
Date: Mon,  6 Jul 2015 13:30:46 -0400
Message-ID: <1436203860-846-10-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAF6-0007f6-JF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbbGFRbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:39 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38863 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbGFRbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:38 -0400
Received: by igrv9 with SMTP id v9so121039453igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMZWS+0kSdtx0DNR3XH2zLx3VzdnJnzzxJtaS8uBWbo=;
        b=wkdTPgLUWRiKH5dpXPLYJcVeluuETc9iujD+stLMh4RBOk2JLRDj1IFC5iJ1tjItzD
         SEAm+mrS3aBIV+BTcHjPGezyRBjbgCHqUVmkRYS6Lr+mHGFyvfGs8nJBFpkmEmH8Kyad
         pJI6fQYwt4p5Yt5iuG8KwhZZhMsu3hwXyeOXIJV6m9C0UbDltL1cXfPbEw7FfKZyPNYL
         s5VJN/m74GPBeo2NXUEXDqJggFrMUh1Myos2OnyvSx01DLK1OyMfs4xypT/NTnNG5vrB
         roo6LS8r+u47tpcCD7dSg5c+cmA8Pw3ERsIjL5FFp1HTE1LUE6HSRC/Efkh4QKATxsIj
         Vn5w==
X-Received: by 10.50.171.232 with SMTP id ax8mr2503023igc.32.1436203897951;
        Mon, 06 Jul 2015 10:31:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.36
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273413>

The plan is to relocate "git checkout --to" functionality to "git
worktree add", however, this check expects a 'struct branch_info' which
git-worktree won't have at hand. It will, however, have access to its
own command-line from which it can pick up the branch name. Therefore,
as a preparatory step, rather than having prepare_linked_checkout()
perform this check, make it the caller's responsibility.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5ada22a..162c822 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -865,8 +865,6 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	int counter = 0, len, ret;
 	unsigned char rev[20];
 
-	if (!new->commit)
-		die(_("no branch specified"));
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
@@ -1303,8 +1301,11 @@ static int checkout_branch(struct checkout_opts *opts,
 		free(head_ref);
 	}
 
-	if (opts->new_worktree)
+	if (opts->new_worktree) {
+		if (!new->commit)
+			die(_("no branch specified"));
 		return prepare_linked_checkout(opts, new);
+	}
 
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
-- 
2.5.0.rc1.197.g417e668
