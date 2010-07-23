From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] rebase: protect against diff.renames configuration
Date: Fri, 23 Jul 2010 12:06:13 -0500
Message-ID: <20100723170613.GF2507@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLiT-0007mM-Lv
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760135Ab0GWRHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:07:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45939 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0GWRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:07:13 -0400
Received: by qyk7 with SMTP id 7so285947qyk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QEKvdQEw7P1tjgwbtu2ZXhUf1E8eSNxJPKjKmkX9NCQ=;
        b=PqlG0+cmKbw/cscCbWKN9yq1pAs1P1na5jS2Gjjcql/0Slhj1w/7HFRe/pv1ffBOc4
         /oJb58eXll/Zq2sLfdA/MIKxYaANGIVg6JoHCwyqmVitLgnNk/E6ary1oaga//3ZT9nv
         To3sbG1ekmkLhDUNAPY+xKFU0fsdPIeZAXORo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jz0RXL5UuzJLp1jJtPl2RZvkeNZBd6kA/USJG9auiKekfTiRP9HukEuOHFAgcvNX/H
         LUDHcRNRI3D988nuhWCIQRPtTeLtWIkvbmSaPi1I7a/LenZTzMCa2d25secTBfZ7t0Xs
         482+3piPHJ9gafdprdGnvr0FYgdkpR/BPb0yc=
Received: by 10.224.82.3 with SMTP id z3mr2784112qak.345.1279904832693;
        Fri, 23 Jul 2010 10:07:12 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id fb41sm462908qcb.27.2010.07.23.10.07.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:07:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100723170103.GA2507@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151553>

From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 10 Nov 2008 16:15:49 -0800

We currently do not disable diff.renames configuration while rebase
internally runs "format-patch" to feed "am -3".

The end user configuration for "diff" should not affect the result
produced by the higher level command that is related to "diff" only
because internally it is implemented in terms of it.

For that matter, I have a feeling that format-patch should not even look
at diff.renames, but we seem to have been doing this for a long time so
there is no easy way to fix this thinko.

In any case, here is a much straightforward fix for "rebase".

[jn: with test case from David]

Reported-by: David D. Kilzer <ddkilzer@kilzer.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-rebase.sh     |    2 +-
 t/t3400-rebase.sh |   24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ab4afa7..386be43 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -543,7 +543,7 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		$root_flag "$revisions" |
+		--no-renames $root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 083d768..a19aeb6 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -19,7 +19,16 @@ test_expect_success 'prepare repository with topic branches' '
 	echo First >A &&
 	git update-index --add A &&
 	git commit -m "Add A." &&
-	git checkout -b my-topic-branch &&
+	git checkout -b force-3way &&
+	echo Dummy >Y &&
+	git update-index --add Y &&
+	git commit -m "Add Y." &&
+	git checkout -b filemove &&
+	git reset --soft master &&
+	mkdir D &&
+	git mv A D/A &&
+	git commit -m "Move A." &&
+	git checkout -b my-topic-branch master &&
 	echo Second >B &&
 	git update-index --add B &&
 	git commit -m "Add B." &&
@@ -128,6 +137,19 @@ test_expect_success 'rebase a single mode change' '
 	GIT_TRACE=1 git rebase master
 '
 
+test_expect_success 'rebase is not broken by diff.renames' '
+	git config diff.renames copies &&
+	test_when_finished "git config --unset diff.renames" &&
+	git checkout filemove &&
+	GIT_TRACE=1 git rebase force-3way
+'
+
+test_expect_success 'setup: recover' '
+	test_might_fail git rebase --abort &&
+	git reset --hard &&
+	git checkout modechange
+'
+
 test_expect_success 'Show verbose error when HEAD could not be detached' '
 	>B &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
-- 
1.7.2.rc3
