From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: Fetch the direct sha1 first
Date: Fri, 19 Feb 2016 10:57:33 -0800
Message-ID: <1455908253-1136-1-git-send-email-sbeller@google.com>
Cc: dborowitz@google.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:57:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqFN-0003wE-CC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427916AbcBSS5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:57:41 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36399 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422838AbcBSS5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:57:40 -0500
Received: by mail-pf0-f177.google.com with SMTP id e127so55615545pfe.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jridkIZdWDy6hmifMzww2H2RSIH3xLEZb68aEZcCHWo=;
        b=TfLKCZBr5Ofa20Rw78+9WE6csLKltS7EpNiAJeIw1WsnZny9+opmVygsuejeeO+lue
         86+a6N1xrKXsY/B0yeTX+Y2kHz8lBbizBQiVUJjXvIQL0RkJ7YtIarAvqSfEyXcldrzu
         7bhdSID/1MJlXfXtPd+0wBLyDEMrV4RiqWZCP/MgbK6LFD6BwE9G5cx6Sr/Km0sKvAmJ
         i1k9cTqcOrU67zoSzVQ0ITWU2huQOknfHvl8QqfT80Ll2qZBdTH2gvk3elvIqg4OmIzM
         5j5yUJyxmUXL3wyMMOYnnL+5psu5iprTC1Y/5GD9EYWnGWDPmNoZEYR6t6j4kOahvYeM
         Lt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jridkIZdWDy6hmifMzww2H2RSIH3xLEZb68aEZcCHWo=;
        b=Ob9D4jbBaT/yCzE1E03ML+0+M31fcuNVyJVp+x/IgHlV9JV7JkSiifEirowlLEFI2V
         n2McuYVwc0cJaYM1cDhF3zOkmmP+8jtV0/hnYSbAa16pIUNg1SQRw/I96GxNxNHm6Y/T
         j+jHG+OEFLU17SOCJj5PTqq6PeDZIBLlO9qWpovjLMwB3LC24Ag15K98r1bq26tVKTN8
         p56WrwLr15+5x/C0RgX31q1f4L4ZA87++cfAd37NZ5GZ4NKoo3GPsjaRmNpmIL8gvniF
         0ajC05S9+F9PLNGGsuQQcFvi04SZycfMMt033b+RdoVPKNBXupVqejw5YVe7tbB1n9IH
         dlVg==
X-Gm-Message-State: AG10YOQGx93oivAriPr8H6wf0PvOCW2bVApVIor0w9AZ4eR+rFpC2kKQQQwwVGCkrcw5pbkC
X-Received: by 10.98.33.199 with SMTP id o68mr20043887pfj.125.1455908259623;
        Fri, 19 Feb 2016 10:57:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9499:df1f:834d:69bf])
        by smtp.gmail.com with ESMTPSA id o10sm19531481pap.37.2016.02.19.10.57.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:57:38 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286739>

When reviewing a change in Gerrit, which also updates a submodule,
a common review practice is to download and cherry-pick the patch locally
to test it. However when testing it locally, the 'git submodule update'
may fail fetching the correct submodule sha1 as the corresponding commit
in the submodule is not yet part of the project history, but also just a
proposed change.

To ease this, try fetching by sha1 first and when that fails (in case of
servers which do not allow fetching by sha1), fall back to the default
behavior we already have.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I think it's best to apply this on origin/master, there is no collision
with sb/submodule-parallel-update.

Also I do not see a good way to test this both in correctness as well
as performance degeneration. If the first git fetch fails, the second
fetch is executed, so it should behave as before this patch w.r.t. correctness.

Regarding performance, the first fetch should fail quite fast iff the fetch
fails and then continue with the normal fetch. In case the first fetch works
fine getting the exact sha1, the fetch should be faster than a default fetch
as potentially less data needs to be fetched.

Thanks,
Stefan

 git-submodule.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..ee0b985 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -746,8 +746,9 @@ Maybe you want to use 'update --init'?")"
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
 				(clear_local_git_env; cd "$sm_path" &&
+					remote_name=$(get_default_remote)
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
+					 test -z "$rev") || git-fetch $remote_name $rev || git-fetch)) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
-- 
2.7.0.rc0.34.ga06e0b3.dirty
