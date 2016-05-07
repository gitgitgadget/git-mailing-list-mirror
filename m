From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] Git/SVN: die when there is no commit metadata
Date: Sat,  7 May 2016 08:58:43 +0200
Message-ID: <1462604323-18545-1-git-send-email-chriscool@tuxfamily.org>
Cc: Thierry Suzanne <thierry@yellownemo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	"Michael G . Schwern" <schwern@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:59:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aywCv-0003DV-3Z
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 08:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbcEGG7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 02:59:13 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37203 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEGG7M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 02:59:12 -0400
Received: by mail-wm0-f51.google.com with SMTP id a17so107999265wme.0
        for <git@vger.kernel.org>; Fri, 06 May 2016 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=I+8j8FBKzhs9e+HLuPxEaX0EFNsfCOrKf0aodlAfNY0=;
        b=b0FgYHCZ3WhuulmHcQuZnt9g4IkjrLUZsCiNovLtktLo0x3VMYvqWe5AJcAtrdZCqP
         j3+KD63Hw1mqlsWlw9+fjwzv2AEcTkEqu0GfPlTiixPEZAxoHmPM5dC3/ZC+2O3rnd9l
         XWHxqTi0Fe3WfiHioWueODd78nc+Y4bRI1+pWuKnezFVZPDrSjxgohkHS5VRsCIAMEoQ
         fvSODTmab6iyiHFMljrxKJEXmO/oGROb7XF3/iNWoGeBrfb5qiXhl+KzJyRJ9SylSN05
         kn/1c63FABw4jlbT2hoO/2XfJkc4hpDMpcbR5RgEv4lVt6PZdgv95pZI0Ri6nnR8S4lB
         K1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+8j8FBKzhs9e+HLuPxEaX0EFNsfCOrKf0aodlAfNY0=;
        b=lMl0z7bmWEcy/r7WG9aflS95O3vyXoRC8c0xnmA0noedFx1k35xEepoWdvMHUf0spu
         cVeA7fEfRFBwxq6PI2UFrAhdCnO5IUOs8lNBDawolhwlyipJoU2RrPydyDAv59WaxrL3
         y7eYQA7K7fGjgaJ1vig+HQXFRcRJTwq3RM1GPkBWIBW9k6+8bV+AFXrlfZCBfZX0CtsW
         divG3ABG2t4FwUd3pf3r8WcECYnNDU1c1kHBxqc4YYoKBOfRoeLHFBL6W8S0ZsAiecUQ
         t0he79aejItLdTaUbVAE/orTpwu7WijtWb7r/gl65A11GGgF2ZfjCUghKpp4ipzpd1YR
         c7eA==
X-Gm-Message-State: AOPr4FUev0UL/yBNuc1usASgzaPVS3jalf5YHfp82EqpqxwXGfWteXml2mVVELdc5bTZSw==
X-Received: by 10.194.122.199 with SMTP id lu7mr25199822wjb.40.1462604350435;
        Fri, 06 May 2016 23:59:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d23sm12265196wmd.1.2016.05.06.23.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 May 2016 23:59:09 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293886>

When passing a bad --trunk option to `git svn clone`, like for example the
same URL that we are cloning:

  C:\Windows\system32>git svn clone
  https://mycompany.svn.beanstalkapp.com/myproject --no-metadata -A
  c:\temp\svn_to_git_users.txt
  --trunk=https://mycompany.svn.beanstalkapp.com/myproject
  --tags=https://mycompany.svn.beanstalkapp.com/myproject/tags
  --branches=https://mycompany.svn.beanstalkapp.com/myproject/branches
  c:\code\Git_myproject

One gets an "Use of uninitialized value $u in substitution (s///)" error:

  [...]
  W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/MS WCSF
  Contrib/src/Services
  W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/RealWorldControls/References
  r530 = c276e3b039d8e38759c6fb17443349732552d7a2 (refs/remotes/origin/trunk)
  Found possible branch point:
  https://mycompany.svn.beanstalkapp.com/myproject/trunk =>
  https://mycompany.svn.beanstalkapp.com/myproject/branches/20080918_DBDEPLOY,
  529
  Use of uninitialized value $u in substitution (s///) at
  /mingw32/share/perl5/site_perl/Git/SVN.pm line 101.
  Use of uninitialized value $u in concatenation (.) or string at
  /mingw32/share/perl5/site_perl/Git/SVN.pm line 101.
  refs/remotes/origin/trunk:
  'https://mycompany.svn.beanstalkapp.com/myproject' not found in ''
  C:\Windows\system32>

Let's fix that by just die()ing when we have an uninitialized value because we
cannot get commit metadata from a ref.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/SVN.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index b2c14e2..d94d01c 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -97,7 +97,8 @@ sub resolve_local_globs {
 				    "existing: $existing\n",
 				    " globbed: $refname\n";
 			}
-			my $u = (::cmt_metadata("$refname"))[0];
+			my $u = (::cmt_metadata("$refname"))[0] or die
+			    "$refname: no associated commit metadata\n";
 			$u =~ s!^\Q$url\E(/|$)!! or die
 			  "$refname: '$url' not found in '$u'\n";
 			if ($pathname ne $u) {
-- 
2.8.0.rc2
