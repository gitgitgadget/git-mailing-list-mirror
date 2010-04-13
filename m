From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/9] t7006: test pager configuration for several git
 commands
Date: Mon, 12 Apr 2010 21:17:35 -0500
Message-ID: <20100413021734.GB4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vh7-0005ox-ID
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab0DMCRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 22:17:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36770 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab0DMCRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:17:35 -0400
Received: by pva18 with SMTP id 18so3540730pva.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sv+yUixRWRDS3byHV5Gg8jNvAAiBoG59MMzAzrUAqR8=;
        b=nvgA7JhHDZo53Wbw+NGl5iS+TNiaQKxMh1yFkg+50y7cCsEYFVWtJgq9q1PgS4s+12
         cxN6AtdAohy67+EKHfe/Uh+cfsVR5sclZj89QHta/LkwRDivYQkW6i3z4zDcMqEcAjh6
         y2jqAaxK0KhEus0UUeJzjeON4Pv3uSrfPC6d4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l9jaBQqIWgVeYCwcuBCVRVaMhWiwZ40GMXt7FwapCam7c4DcAfvqZKIoHrzTp7kxuc
         KyiLMI71hZJIXWy7jX+pUKMUe7BbTs1/r2ZotfDMdQHbkesF+d5dAc0jqx6Mm99NtBTn
         Ad7Tt45lECMbLhOR/oBdDUSwQx6NKeNmH+3gk=
Received: by 10.114.30.6 with SMTP id d6mr4269231wad.135.1271125055102;
        Mon, 12 Apr 2010 19:17:35 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 22sm4489721iwn.0.2010.04.12.19.17.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:17:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144780>

Test choice of pager at several stages of repository setup.  This
way we can have some (admittedly uninteresting) examples in mind when
considering future changes to the setup procedure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |  151 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f804ed..403c260 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -131,78 +131,87 @@ then
 	test_set_prereq SIMPLEPAGER
 fi
 
-unset PAGER GIT_PAGER
-git config --unset core.pager
-rm -f default_pager_used
-test_expect_success SIMPLEPAGER 'default pager is used by default' '
-	cat > $less <<-EOF &&
-	#!$SHELL_PATH
-	wc > default_pager_used
-	EOF
-	chmod +x $less &&
-	PATH=.:$PATH test_terminal git log &&
-	test -e default_pager_used
-'
-
-unset GIT_PAGER
-git config --unset core.pager
-rm -f PAGER_used
-test_expect_success TTY 'PAGER overrides default pager' '
-	PAGER="wc > PAGER_used" &&
-	export PAGER &&
-	test_terminal git log &&
-	test -e PAGER_used
-'
-
-unset GIT_PAGER
-rm -f core.pager_used
-test_expect_success TTY 'core.pager overrides PAGER' '
-	PAGER=wc &&
-	export PAGER &&
-	git config core.pager "wc > core.pager_used" &&
-	test_terminal git log &&
-	test -e core.pager_used
-'
-
-unset GIT_PAGER
-rm -f core.pager_used
-rm -fr sub
-test_expect_success TTY 'core.pager in subdir' '
-	PAGER=wc &&
-	stampname=$(pwd)/core.pager_used &&
-	export PAGER stampname &&
-	git config core.pager "wc > \"\$stampname\"" &&
-	mkdir sub &&
-	(
-		cd sub &&
-		test_terminal git log
-	) &&
-	test -e "$stampname"
-'
+test_pager_choice() {
+	if test $# = 1
+	then
+		cmd=$1
+		full_cmd="test_terminal $cmd"
+	else
+		cmd=$2
+		full_cmd="test_must_fail test_terminal $cmd"
+	fi
 
-unset GIT_PAGER
-rm -f core.pager_used
-rm -fr sub
-test_expect_failure TTY 'core.pager in subdir with --paginate' '
-	PAGER=wc &&
-	stampname=$(pwd)/core.pager_used &&
-	export PAGER stampname &&
-	git config core.pager "wc > \"\$stampname\"" &&
-	mkdir sub &&
-	(
-		cd sub &&
-		test_terminal git --paginate log
-	) &&
-	test -e "$stampname"
-'
+	case "$cmd" in
+	*-p*)
+		test_expect_expected=test_expect_failure
+		;;
+	*)
+		test_expect_expected=test_expect_success
+		;;
+	esac
+
+	unset PAGER GIT_PAGER
+	git config --unset core.pager
+	rm -f default_pager_used
+	test_expect_success SIMPLEPAGER "$cmd - default pager is used by default" "
+		cat > $less <<-\EOF &&
+		#!$SHELL_PATH
+		wc > default_pager_used
+		EOF
+		chmod +x $less &&
+		PATH=.:\$PATH $full_cmd &&
+		test -e default_pager_used
+	"
+
+	unset GIT_PAGER
+	git config --unset core.pager
+	rm -f PAGER_used
+	test_expect_success TTY "$cmd - PAGER overrides default pager" "
+		PAGER='wc > PAGER_used' &&
+		export PAGER &&
+		$full_cmd &&
+		test -e PAGER_used
+	"
+
+	unset GIT_PAGER
+	rm -f core.pager_used
+	test_expect_success TTY "$cmd - core.pager overrides PAGER" "
+		PAGER=wc &&
+		export PAGER &&
+		git config core.pager 'wc > core.pager_used' &&
+		$full_cmd &&
+		test -e core.pager_used
+	"
+
+	unset GIT_PAGER
+	rm -f core.pager_used
+	rm -fr sub
+	$test_expect_expected TTY "$cmd - core.pager in subdir" "
+		PAGER=wc &&
+		stampname=\$(pwd)/core.pager_used &&
+		export PAGER stampname &&
+		git config core.pager 'wc > \"\$stampname\"' &&
+		mkdir sub &&
+		(
+			cd sub &&
+			$full_cmd
+		) &&
+		test -e \"\$stampname\"
+	"
+
+	rm -f GIT_PAGER_used
+	test_expect_success TTY "$cmd - GIT_PAGER overrides core.pager" "
+		git config core.pager wc &&
+		GIT_PAGER='wc > GIT_PAGER_used' &&
+		export GIT_PAGER &&
+		$full_cmd &&
+		test -e GIT_PAGER_used
+	"
+}
 
-rm -f GIT_PAGER_used
-test_expect_success TTY 'GIT_PAGER overrides core.pager' '
-	git config core.pager wc &&
-	GIT_PAGER="wc > GIT_PAGER_used" &&
-	export GIT_PAGER &&
-	test_terminal git log &&
-	test -e GIT_PAGER_used
-'
+test_pager_choice 'git log'
+test_pager_choice 'git -p log'
+test_pager_choice test_must_fail 'git -p'
+test_pager_choice test_must_fail 'git -p nonsense'
 
 test_done
-- 
1.7.0.4
