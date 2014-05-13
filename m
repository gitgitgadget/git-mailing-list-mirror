From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 12/29] "guilt header": more robust header selection.
Date: Tue, 13 May 2014 22:30:48 +0200
Message-ID: <1400013065-27919-13-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJQP-0004n2-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbaEMUfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:35:30 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:47127 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaEMUfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:35:25 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so722502lab.29
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtqEi4XS77d2J0C/doSy0a42nMSz13dmvWHIZ6LJ03E=;
        b=aarzbNpuKnjmrRN6PZNI7UrSXIBbyrV/w9TpeD5j5sd0Ix/iguB+luJUbins0nsCqe
         cHwW8ZVP5o5rQuQUkSvgKzfr6pkyEMngYGjft3SRkdDEK/w2q8J/APVI4CdBt12WdWa2
         3RqWaZTofxSs/KH4knd9IXw0wr8u8lF0CDriIuEwZmMTA+2V81cW64gNq6/zNcPk+KyL
         oh7ZIR/I5qLRlEadOtJ69C9hgdggGO06YmgC/oVyb5FYkjmfkM9+Bsr6/BTzBelxVdcx
         f8HADK+OiSGtGnnSsbEmZAw+N+uFoloYmvoh6Kb728NeRi3CRPw2MhzlipcUV+qUKLUi
         NHEA==
X-Gm-Message-State: ALoCoQmRaJHRmrY7D//1mi+nHY8I4iU98Jlg+OHVp+jOvS0KXo8huE0NOdPzuygWimOS7YEG8G/M
X-Received: by 10.112.67.35 with SMTP id k3mr29900900lbt.17.1400013323670;
        Tue, 13 May 2014 13:35:23 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.35.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:35:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248829>

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
 guilt-header | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/guilt-header b/guilt-header
index 41e00cc..4701b31 100755
--- a/guilt-header
+++ b/guilt-header
@@ -45,10 +45,32 @@ esac
 [ -z "$patch" ] && die "No patches applied."
 
 # check that patch exists in the series
-ret=`get_full_series | grep -e "^$patch\$" | wc -l`
-if [ $ret -eq 0 ]; then
-	die "Patch $patch is not in the series"
+full_series=`get_tmp_file series`
+get_full_series > "$full_series"
+found_patch=
+while read x; do
+	if [ "$x" = "$patch" ]; then
+		found_patch="$patch"
+		break
+	fi
+done < "$full_series"
+if [ -z "$found_patch" ]; then
+	TMP_MATCHES=`get_tmp_file series`
+	grep "$patch" < "$full_series" > "$TMP_MATCHES"
+	nr=`wc -l < $TMP_MATCHES`
+	if [ $nr -gt 1 ]; then
+		echo "$patch does not uniquely identify a patch. Did you mean any of these?" >&2
+		sed 's/^/  /' "$TMP_MATCHES" >&2
+		rm -f "$TMP_MATCHES"
+		exit 1
+	elif [ $nr -eq 0 ]; then
+		rm -f "$TMP_MATCHES"
+		die "Patch $patch is not in the series"
+	fi
+	found_patch=`cat $TMP_MATCHES`
+	rm -f "$TMP_MATCHES"
 fi
+patch="$found_patch"
 
 # FIXME: warn if we're editing an applied patch
 
-- 
1.8.3.1
