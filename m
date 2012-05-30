From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] rebase: report invalid commit correctly
Date: Wed, 30 May 2012 18:39:42 +0200
Message-ID: <1338395982-5448-1-git-send-email-kusmabite@gmail.com>
References: <7v7gvt1xz6.fsf@alter.siamese.dyndns.org>
Cc: manuelah@opera.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 18:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZlwK-0004Vc-DM
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 18:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab2E3Qj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 12:39:58 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61355 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab2E3Qj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 12:39:57 -0400
Received: by lbbgm6 with SMTP id gm6so141033lbb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=W5KaNPLUzdLxhogcgr3ZVsRMUx76sD8n8BaGX2jCa2s=;
        b=e+hRpaPkU/u52UtBwnVZ/ZvjL2+Qr7ZF6TjKEsoM+YFCta2bEC/iVZWUeSniU/QXZ9
         7Ek+6wvSHw5m/XOyjCd7HPVU+n+E0JzjoNoa8WdDy7HriwyqBPMbAk2eD3szs32o4r6N
         mev1wiJv23eST1ioUVhDNg4NzvqcBQ1RdF8wgeJ2x8vQ4BoZHr4/1LFEGT47457xfg1h
         mliaGGw89U08QdmQOAyYFBabtauFK2koUxO64FK07bLcKNP2aFzyp2g86D4XUOzqDHo9
         0SlejSifPSHsgm/AFMPf2YRNs5IiritIlCvqjkDSjj7+W/2BaJDdH9LoVHvq1VG55Npn
         o+hg==
Received: by 10.152.147.33 with SMTP id th1mr16628799lab.9.1338395995682;
        Wed, 30 May 2012 09:39:55 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id j5sm561995lbg.1.2012.05.30.09.39.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 09:39:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.msysgit.1.1147.g20e60f3
In-Reply-To: <7v7gvt1xz6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198816>

In 9765b6a (rebase: align variable content, 2011-02-06), the code
to error out was moved up one level. Unfortunately, one reference
to a function parameter wasn't rewritten as it should, leading to
the wrong parameter being errored on.

This error was propagated by 71786f5 (rebase: factor out reference
parsing, 2011-02-06) and merged in 78c6e0f (Merge branch
'mz/rebase', 2011-04-28).

Correct this by reporting $onto_name istead.

Reported-By: Manuela Hutter <manuelah@opera.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's a proper patch, I guess.

On Wed, May 30, 2012 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Indeed. This looks like the result of a bad merge-resolution, but I
>> could be mistaken.
>
> It looks like 9765b6a (rebase: align variable content, 2011-02-06)
> originally botched it, which propagated to 71786f5 (rebase: factor
> out reference parsing, 2011-02-06) in the series, and finally merged
> at 78c6e0f (Merge branch 'mz/rebase', 2011-04-28).
>

Thanks for digging, this was very helpful for the commit message.

 git-rebase.sh             | 2 +-
 t/t3406-rebase-message.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..3267c92 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -423,7 +423,7 @@ case "$onto_name" in
 	;;
 *)
 	onto=$(git rev-parse --verify "${onto_name}^0") ||
-	die "Does not point to a valid commit: $1"
+	die "Does not point to a valid commit: $onto_name"
 	;;
 esac
 
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index fe5f936..6898377 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -62,4 +62,9 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
         ! grep "^ fileX |  *1 +$" diffstat.txt
 '
 
+test_expect_success 'rebase --onto outputs the invalid ref' '
+	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
+	grep "invalid-ref" err
+'
+
 test_done
-- 
1.7.10.msysgit.1.1147.g20e60f3
