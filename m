From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 12/28] "guilt header": more robust header selection.
Date: Fri, 21 Mar 2014 08:31:50 +0100
Message-ID: <1395387126-13681-13-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:35:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtz1-0004dR-SD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759950AbaCUHe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:34:58 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:48233 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886AbaCUHdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:18 -0400
Received: by mail-la0-f47.google.com with SMTP id y1so1396602lam.34
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tt2VfBe89JW47LGno+wiuh3lZEvxJzmRgS7YdE4oeX4=;
        b=XISSLGZsi5f+hf8fIZ01VW0cE2a60cll+7XloVD13u/kDGwgjWOF5lEXr8IYMdT797
         fXYBNdJ6fNdi3zpmcflXcN284GEFG2Z3ZnarQIPvIzOPIW5z6JOjwBxNy2pnbNGBEtNZ
         Xv+xv290zI6mbhcRuX8XlCROU1nH2r1d37f32HLFDvJLjGc9FjV+lCFZYxuxXWfpGDZK
         lAc2LxcwwO3GXAFegz4dzOSuvu6AGG3f/k74ShhLuON4EgFpVeU+wgVPLnL1jZ1t6YPQ
         W7Ib9LjD5NStSN/dx1UiN9jzDgqErbj6voU+YrsuS8m74lc2a+B+eiOuT5mOc1c6/Cod
         fyCg==
X-Gm-Message-State: ALoCoQnb4aK7Stzq4RvmAH3JMi9TWtWBNALd0FnjK3X5aiLrXSqTkSPJD+9pg35C2hHBwes6UWoY
X-Received: by 10.152.116.43 with SMTP id jt11mr488753lab.41.1395387197180;
        Fri, 21 Mar 2014 00:33:17 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244673>

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
 guilt-header | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/guilt-header b/guilt-header
index 41e00cc..2e96406 100755
--- a/guilt-header
+++ b/guilt-header
@@ -45,10 +45,37 @@ esac
 [ -z "$patch" ] && die "No patches applied."
 
 # check that patch exists in the series
-ret=`get_full_series | grep -e "^$patch\$" | wc -l`
-if [ $ret -eq 0 ]; then
-	die "Patch $patch is not in the series"
+full_series=`get_tmp_file series`
+get_full_series > "$full_series"
+found_patch=
+while read x
+do
+	if [ "$x" = "$patch" ]
+	then
+		found_patch="$patch"
+		break
+	fi
+done < "$full_series"
+if [ -z "$found_patch" ]
+then
+	TMP_MATCHES=`get_tmp_file series`
+	grep "$patch" < "$full_series" > "$TMP_MATCHES"
+	nr=`wc -l < $TMP_MATCHES`
+	if [ $nr -gt 1 ]
+	then
+		echo "$patch does not uniquely identify a patch. Did you mean any of these?" >&2
+		sed 's/^/  /' "$TMP_MATCHES" >&2
+		rm -f "$TMP_MATCHES"
+		exit 1
+	elif [ $nr -eq 0 ]
+	then
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
