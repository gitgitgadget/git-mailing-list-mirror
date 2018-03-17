Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32731F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 08:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCQIRr (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 04:17:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:35379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbeCQIRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 04:17:46 -0400
Received: from Sonnenschein.localdomain ([87.175.177.109]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lkwc9-1eMwni42RJ-00anbe; Sat, 17 Mar 2018 09:17:44 +0100
From:   Clemens Buchacher <drizzd@gmx.net>
To:     git@vger.kernel.org
Cc:     manlio.perillo@gmail.com, johannes.schindelin@gmx.de,
        Clemens Buchacher <drizzd@gmx.net>
Subject: [PATCH 1/2] completion: improve ls-files filter performance
Date:   Sat, 17 Mar 2018 09:17:03 +0100
Message-Id: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K0:ucEryXvipC6YcW/Cd4ubnzUs62Oswi4MO+79iMiSsUL9LbdsrlJ
 gTmMjw3n0wn0jgJCIZK9UjsHsS6nZDMeXMpnUh982ppY/9O+dnWCK+y8uTEuYmizWFL6okg
 BLivdV7KOqelS4SSpQM54oCsb0mDgcFimxGJfjUgytrLP2QPGKbuhtFjSy82aGcsF8rnfc4
 qm9XC0vla44/ejfafjB4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nWeVgeMrqQg=:+AI26PWKmoS8s4XWd8ykoQ
 6gAecnGwfWP6+aOlwLJ2ARUtHTcGE/iGcgk8/TFTL83tbiV+V67jYqi/0G4yI3z59gQylfWiv
 ur8kaCZZWsh90w7LG8odDuRNvex+3lOiULEup+p8sRenGZAAZr6I5qktt5lRmJfHVSeos2c5W
 c7GR/4r+jB5qC/GWrR5j0qPUXDpGa9o/ZHP67Rb4Q5RhfGIcwRIQJI1OlPQGS0psZtPCevBuO
 mXUwO5UF2r1SkOjLg1PoYBOmoNI5CbeSZH4yOFb/MrAscyP0pd0fRaxHTInxd3l01r4JAaENF
 h2vCk7xUdgudclGvpUiHPAt6pJKZXKn6gWPVAQxfyab4hiNTIII/t6fxFp3JlTfOGModhfe7b
 6KrrRi/O4zY5/6B0EhcNAjS2WHy377rLKryYDS7MHlKLaKW9A30VWtp6T0zxG16bskiqVvP8f
 96fk1n51SkZku/lrBclolqxGk2S/o0IjnWM8lanw44Gu/JO7sDHKAhgrHyTELYWV0BliFKTmh
 8TZI/QlZxw7oMYY0gqomKNHFSOBtLt+qcU5xlCM89XjJqJFKSfKYVPwts8seMt7dXlptvH8H9
 m/wtNkw2S3wE89FuS62nXK+9BE8hnYTJS/ihOcmgoSV3l3905kuJnHL4ag3KspJEMiQBOWYIB
 +NoUJ52dmdzFT02zffm5OLBsHZ7dCvVHcqZdLkQVjNe6LZnumDSeCJbKsFet1qRtYaA6JAh4v
 CqzgcmwTX4SPBdMjV/bPwKGk3igrEZIBm1Dq1LJZzdMio7ePHXr2DhVrJ6zzgV+oU0HKv2y23
 s5EyUlAszwNHIvUj8KQ48DxufcvyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From the output of ls-files, we remove all but the leftmost path
component and then we eliminate duplicates. We do this in a while loop,
which is a performance bottleneck when the number of iterations is large
(e.g. for 60000 files in linux.git).

$ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git

real    0m11.876s
user    0m4.685s
sys     0m6.808s

Using an equivalent sed script improves performance significantly:

$ COMP_WORDS=(git status -- ar) COMP_CWORD=3; time _git

real    0m1.372s
user    0m0.263s
sys     0m0.167s

The measurements were done with mingw64 bash, which is used by Git for
Windows.

Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
---
 contrib/completion/git-completion.bash | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da95b8..e3ddf27 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -384,12 +384,7 @@ __git_index_files ()
 	local root="${2-.}" file
 
 	__git_ls_files_helper "$root" "$1" |
-	while read -r file; do
-		case "$file" in
-		?*/*) echo "${file%%/*}" ;;
-		*) echo "$file" ;;
-		esac
-	done | sort | uniq
+	sed -e '/^\//! s#/.*##' | sort | uniq
 }
 
 # Lists branches from the local repository.
-- 
2.7.4

