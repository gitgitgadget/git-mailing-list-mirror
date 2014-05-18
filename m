From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 12/33] "guilt header": more robust header selection.
Date: Sun, 18 May 2014 23:59:48 +0200
Message-ID: <1400450409-30998-13-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:06:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9E1-00048e-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbaERWGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:06:30 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45248 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbaERWG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:06:29 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so3477451lbg.32
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uvX6VrpNnXHRl04zb/EvzUDflDVEJoGNISHbFmVezwQ=;
        b=lNuTRcDmbYRigC85RXF9Zf1Ly/Odxa7LwyBsaENb3UPXwV1JoELT56lHV68sN2s9tB
         DfGCcFyMyfZOE2qt1XPN/mb0rrAjynwYnmyzZ+vz0xMYjHu25BtwSIRo4NatMlQBtDp6
         D4OTh6Wl05V1DhdoozZJrksVBq0rdxuGkqCIbPJZ/5N0vysrg2QXmhNqnSkU8HFfJ57B
         AOBDi5UhAsrj6INeJ9HCc8/LV9mgf8vt5M/+KtbvVj0QIB5zbS86sXV748fKA2CxrBtr
         Fnp70PKI3//9frSXEgF5ZNEonp1vOpeamkOWk/fBW38C3RZBfXYJU8CIx7Yfhob90bYM
         kjgQ==
X-Gm-Message-State: ALoCoQl0sCBdWA0jNsNebP/1W7nZLR4y4oPpOAMB7B0+meZqBW6lw7QOjf/HP/EbcOsjBFmgDLS9
X-Received: by 10.153.5.37 with SMTP id cj5mr3630563lad.48.1400450788079;
        Sun, 18 May 2014 15:06:28 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.06.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:06:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249527>

If you run something like "guilt header '.*'" the command would crash,
because the grep comand that tries to ensure that the patch exist
would detect a match, but the later code expected the match to be
exact.

Fixed by comparing exact strings.

And as a creeping feature "guilt header" will now try to use the
supplied patch name as an unanchored regexp if no exact match was
found.  If the regexp yields a unique match, it is used; if more than
one patch matches, the names of all patches are listed and the command
fails.  (Exercise left to the reader: generalized this so that "guilt
push" also accepts a unique regular expression.)

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
