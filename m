From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/12] git submodule update: Move branch calculation to where it's needed
Date: Thu, 15 Oct 2015 18:52:04 -0700
Message-ID: <1444960333-16003-4-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCA-0002He-33
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbbJPBwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:25 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33604 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbJPBwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:20 -0400
Received: by pabrc13 with SMTP id rc13so104120098pab.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aUR5XxR54khy+pQMDYYtpktbBD7gPT7V9dIetWZ1noA=;
        b=Ew6O/QHEz/baHZrxpSyEE142AAU726u4kZnCHp6PirrQuNlNCAswi98JZBsrJeiHfw
         ZndRJAlDOb7pravJwQu3xdguXMwSmp5XArxyV0+3/0RUgWeNpRdTxfx3Mp0ixASFx6Ll
         dYrbXhsGlmcHFVu0tWGqaN0kwbFAOraoQGfihYcfyEWE0e4hv9kKhY/G5R3f0CYQhbJK
         mr9PLxWELFRbgNAmYtSLniI6qKPUBd6P0bEf9rPTqk6SAV/kRKgfUFNMLMfqydOSdJx+
         44Vi605r/QK05brVhDUWQKRqy58C9V80KK5hR55q+pWaRCwdYbdt3oYRPrWaXoROWgAU
         kHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aUR5XxR54khy+pQMDYYtpktbBD7gPT7V9dIetWZ1noA=;
        b=My4skmH60TaNIDdVKe1fvnRR9DE8IHPb89pbetMRr3VkDIg1OSiAwC5IyUkxHoT9Nd
         TI397zyJZh8wfXNiEQXR4tk4SjRNvGWOzfVRG4DoxQ2Fyv3SBzCGeLB/PFpU3I5bJjV/
         dCkxnZ6IXpkWFab07lLTei67duBl+C1rzlOsRih/Tb3CSYJY7yaATy3/5WyjIdOZvADp
         McKWb3joVotkApSUDs/xnOZNeNg3u7ixUGeFdFA58d/8s4uVqObn4YnKKjfMEBSMd3pw
         jsmMo4FGYMWoOkLgDwLDwONtY5FDD4DNenLu8rRy8NtFcQbrLnhjrJ0OlVp2LRPjoyPw
         woFQ==
X-Gm-Message-State: ALoCoQlxncsnLc99QpT2SX7hFfVXcHlavhF8T0azrKezHW/d9tYV4JlE7yLE9z0tkPPf4ZtDj0PQ
X-Received: by 10.68.136.103 with SMTP id pz7mr13490024pbb.114.1444960339746;
        Thu, 15 Oct 2015 18:52:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id ir5sm6252125pbc.13.2015.10.15.18.52.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279716>

The branch variable is used only once so calculate it only when needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index eea27f8..56a0524 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -668,7 +668,6 @@ cmd_update()
 		fi
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
 		then
 			update_module=$update
@@ -718,6 +717,7 @@ Maybe you want to use 'update --init'?")"
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
 			remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
+			branch=$(get_submodule_config "$name" branch master)
 			sha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
 			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
-- 
2.5.0.277.gfdc362b.dirty
