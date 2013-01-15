From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 04/19] reset: don't allow "git reset -- $pathspec" in bare repo
Date: Mon, 14 Jan 2013 21:47:36 -0800
Message-ID: <1358228871-7142-5-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOP-0007EL-JZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab3AOFs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:29 -0500
Received: from mail-qc0-f202.google.com ([209.85.216.202]:55885 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab3AOFs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:27 -0500
Received: by mail-qc0-f202.google.com with SMTP id s25so588773qcq.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=sjTrbv9WtQxMzPP5x1TeAspzSp92aWCf/v17ZzU4lq8=;
        b=KuruLBXr68XEb3Q5IiarP3S1isTcxpl1h41qW8RyeEaHdZQSgdaEznm635oeHHBnlL
         tuEMh+mcYM0yxodne3CBsUUABXyPwUrM5IMAVVj2NEKqGxa8AnIphbARs0m54jfig9nj
         CFTKwFEd/zh2F0SQ4DMGtiXJscKAraVpoyqP8e6BU4M3DSH5bPvsZEGV3Z1ynZ5oXVBx
         xOMljsg2tR4AyvbjCp6R1YexTc7ez884V0Is49lp9rg8Wi6wZ37OZdzUVBOdJT9FVkR3
         3tz8akC+38jXMbMCdgpJxNmmrYESnu8eEvWHZLwCIKXNwtMxSnISriOHp8n8poLiz2DI
         5I7A==
X-Received: by 10.236.135.51 with SMTP id t39mr18357322yhi.6.1358228906392;
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id p19si819052yhi.1.2013.01.14.21.48.26
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 3B5EA100047;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id E0DB0101449; Mon, 14 Jan 2013 21:48:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkkyYcmoBmuzDcfrmfhFkjR2OAEpDP3YrElWw95YSx/zIrHFccOa0128KJEAQvX8jXekTBTQfnNPulrH01HYKC4b5djNntDOjrRdw477dswKckiQ15QREuRrnIVpMtFajFPeObcDfpzG1lEbMTwiNwillbriIVDTUCOvNGROOj88GuOGiuplrABAGDtdm5dKsrjoIC7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213577>

Running e.g. "git reset ." in a bare repo results in an index file
being created from the HEAD commit. The differences compared to the
index are then printed as usual, but since there is no worktree, it
will appear as if all files are deleted. For example, in a bare clone
of git.git:

  Unstaged changes after reset:
  D       .gitattributes
  D       .gitignore
  D       .mailmap
  ...

This happens because the check for is_bare_repository() happens after
we branch off into read_from_tree() to reset with paths. Fix by moving
the branching point after the check.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 045c960..664fad9 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -295,8 +295,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		else if (reset_type != NONE)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
-		return read_from_tree(pathspec, sha1,
-				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
@@ -308,6 +306,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
+	if (pathspec)
+		return read_from_tree(pathspec, sha1,
+				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-- 
1.8.1.1.454.gce43f05
