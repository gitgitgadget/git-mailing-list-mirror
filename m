From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 12/31] "guilt header": more robust header selection.
Date: Fri, 16 May 2014 16:45:59 +0200
Message-ID: <1400251578-17221-13-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJTz-0007Ab-UP
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442AbaEPOvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:51:31 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:44334 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbaEPOvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:51:18 -0400
Received: by mail-la0-f49.google.com with SMTP id pv20so2024598lab.36
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvJ3JJ1YcSlE4yyTE0fpOU8TZWzWxASX3ULzk+mBGc8=;
        b=mkespxFHreAshP8pvJUjCLxoXKDXOd5qGIShjIVNe2B6dQ0o6+DfEr8x2Msdjt+i5r
         QD5DWDuv5Zxfno+I1fYJr4i02z/9OwrX2nIaCD5YsDBlOO8i0CVpphDyWzVhgRGw4bVl
         XekxDKVtLrBoQJvBJ2hsSkzh9KeLQqgN3cBXjPSVPThvLreN6PpqRXGMDCBvFMGP0MNd
         ltHtmP/xjICQZ/uGaTnPEURtmCCDd4BK0qlBXjiIQxBoAG8mD62QeITrPHqpCmc06I+N
         otFpfx7Oo1Z43tgoSrqQYawE+4PrmC8YsxdIBO04g5hU7O6gDI2gBztSWnWTbIpOHhgM
         CTdg==
X-Gm-Message-State: ALoCoQloL8UlaIP7pHbx/z8Mtq3u5RKjiH1ykCn3r0LOqO3A/Hb2QXUxyGAQ7hMw2+zI9JFXBu7/
X-Received: by 10.152.199.39 with SMTP id jh7mr12598754lac.18.1400251877038;
        Fri, 16 May 2014 07:51:17 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.51.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:51:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249320>

If you run something like "guilt header '.*'" the command would crash,
because the grep comand that tries to ensure that the patch exist
would detect a match, but the later code expected the match to be
exact.

Fixed by comparing exact strings.

And as a creeping feature "guilt header" will now try to use the
supplied patch name as an unachored regexp if no exact match was
found.  If the regexp yields a unique match, it is used; if more than
one patch matches, the names of all patches are listed and the command
fails.  (Exercise left to the reader: generalized this so that "guilt
push" also accepts a unique regular expression.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-header | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/guilt-header b/guilt-header
index 41e00cc..c3d24f9 100755
--- a/guilt-header
+++ b/guilt-header
@@ -45,10 +45,33 @@ esac
 [ -z "$patch" ] && die "No patches applied."
 
 # check that patch exists in the series
-ret=`get_full_series | grep -e "^$patch\$" | wc -l`
-if [ $ret -eq 0 ]; then
-	die "Patch $patch is not in the series"
+TMP_FULL_SERIES=`get_tmp_file series`
+get_full_series > "$TMP_FULL_SERIES"
+found_patch=
+while read x; do
+	if [ "$x" = "$patch" ]; then
+		found_patch="$patch"
+		break
+	fi
+done < "$TMP_FULL_SERIES"
+if [ -z "$found_patch" ]; then
+	TMP_MATCHES=`get_tmp_file series`
+	grep "$patch" < "$TMP_FULL_SERIES" > "$TMP_MATCHES"
+	nr=`wc -l < $TMP_MATCHES`
+	if [ $nr -gt 1 ]; then
+		echo "$patch does not uniquely identify a patch. Did you mean any of these?" >&2
+		sed 's/^/  /' "$TMP_MATCHES" >&2
+		rm -f "$TMP_MATCHES" "$TMP_FULL_SERIES"
+		exit 1
+	elif [ $nr -eq 0 ]; then
+		rm -f "$TMP_MATCHES" "$TMP_FULL_SERIES"
+		die "Patch $patch is not in the series"
+	fi
+	found_patch=`cat $TMP_MATCHES`
+	rm -f "$TMP_MATCHES"
 fi
+rm -f "$TMP_FULL_SERIES"
+patch="$found_patch"
 
 # FIXME: warn if we're editing an applied patch
 
-- 
1.8.3.1
