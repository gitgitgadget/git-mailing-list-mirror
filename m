From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/3] request-pull: find matching tag or branch name on remote side
Date: Mon, 16 Feb 2015 19:16:08 +0100
Message-ID: <1424110568-29479-4-git-send-email-bonzini@gnu.org>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 19:16:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNQDk-0008Dp-0G
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 19:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103AbbBPSQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 13:16:26 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40427 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbbBPSQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 13:16:24 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so27798897wib.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9PBwNSKYUA2F+zmhXhnpf4O8Rope1feYIVrl+4V1hLQ=;
        b=Iv5SAfulcfFfr89xiX42VEluG+9bnL2OSYIeaYE3ePgl7suaVjbQ9eVsqql8JffnIt
         jpOUZa055NexFHp2KxOHwin5FUGU4EEXOyraKsO+o3EFBwVAxGhhMukfJ/yN3FPXcZ2G
         q/eg7lWSoiTnZYUBnkqP43sxa12NM6SaFApEYyr03CukE7fsZzNBVPZv5JBHrSgI+M9O
         By97kHSroZrr8v+Kh35fmBO5wT+7ylLXdAOcQbsE6uciRcAxfVGLNyzCu6c4doylWlnp
         YSxgB253pu65hcr3w7zqMxaO9ha76VN2kzzvKDLirTYQFMVNVpr6Qymd409GgJ2twxUY
         Ao4A==
X-Received: by 10.180.82.40 with SMTP id f8mr15147884wiy.60.1424110583202;
        Mon, 16 Feb 2015 10:16:23 -0800 (PST)
Received: from donizetti.redhat.com (net-93-66-73-217.cust.vodafonedsl.it. [93.66.73.217])
        by mx.google.com with ESMTPSA id et4sm23920115wjd.15.2015.02.16.10.16.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2015 10:16:22 -0800 (PST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263909>

From: Paolo Bonzini <pbonzini@redhat.com>

If the third argument is not passed to "git request-pull", the
find_matching_ref script will look for HEAD in the remote side
which does not work.  Instead, default to the ref names found
via "git show-ref" or "git tag".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 git-request-pull.sh     | 14 ++++++++++----
 t/t5150-request-pull.sh |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index a507006..fcbe383 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -54,8 +54,6 @@ fi
 local=${3%:*}
 local=${local:-HEAD}
 remote=${3#*:}
-pretty_remote=${remote#refs/}
-pretty_remote=${pretty_remote#heads/}
 head=$(git symbolic-ref -q "$local")
 head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
 head=${head:-$(git tag --points-at "$local" | sed 's,^,refs/tags/,')}
@@ -64,6 +62,14 @@ head=${head:-$(git rev-parse --quiet --verify "$local")}
 # None of the above? Bad.
 test -z "$head" && die "fatal: Not a valid revision: $local"
 
+#
+# If $3 was not there, the remote name should be the same
+# as the locally detected name
+#
+remote=${remote:-$head}
+pretty_remote=${remote#refs/}
+pretty_remote=${pretty_remote#heads/}
+
 # This also verifies that the resulting head is unique:
 # "git show-ref" could have shown multiple matching refs..
 headrev=$(git rev-parse --verify --quiet "$head"^0)
@@ -111,12 +117,12 @@ find_matching_ref='
 	}
 '
 
-ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+ref=$(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "$remote" "$headrev")
 
 if test -z "$ref"
 then
 	echo "warn: No match for commit $headrev found at $url" >&2
-	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
+	echo "warn: Are you sure you pushed '$remote' there?" >&2
 	status=1
 fi
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 8b19279..11ba8ff 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -178,7 +178,7 @@ test_expect_success 'request asks HEAD to be pulled' '
 		read repository &&
 		read branch
 	} <digest &&
-	test -z "$branch"
+	test "$branch" = "tags/full"
 
 '
 
-- 
2.3.0
