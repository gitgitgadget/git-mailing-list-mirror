From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 6/6] git-grep: Bail out when -P is used with -F or -E
Date: Mon,  9 May 2011 23:52:08 +0200
Message-ID: <1304977928-7142-7-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYO9-0000Ry-16
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab1EIVw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43749 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab1EIVwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:53 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so6215970wwa.1
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=zqu1ZSCRvuqM+HKGVuXV1j7RVV4tW1FUN+S2kZa7vfY=;
        b=pEEfxc6agNfIacQvdrzcr3p+wcMOr+bpMmLv0sSZPldO9DNrgho15mjKCD86zdFZgv
         pXwbPt1FvQer5fOw+R9c2/mYRYdbOSuJWYNSLQWuHycyAGZmukGbDkStvgsy/SepRPSw
         tHn/jX85NVEei0t1UCaigEHNbaTvc9dvy+bVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tRk0276loTMfE+K0phJVK3TBXtLJG1/8oAzt5fr/iU7Tuf6tlV/2BDikGzkbCmvpHy
         /x4oFiRKYv9mvOd6BkUeBKoz5bjQS+i0nqRCL9cAtpXaMOI++qhqf99dN749I7PYDQf5
         QVs87N8svX+A7nLUm2iTa17u0sTv6d0dboIDw=
Received: by 10.216.174.65 with SMTP id w43mr3082820wel.95.1304977973003;
        Mon, 09 May 2011 14:52:53 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id y29sm4017261wbd.38.2011.05.09.14.52.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173257>

This patch makes git-grep die() when -P is used on command line togethe=
r
with -E/--extended-regexp or -F/--fixed-strings.

This also makes it bail out when grep.extendedRegexp is enabled.

But `git grep -G -P pattern` and `git grep -E -G -P pattern` still work
because -G and -E set opts.regflags during parse_options() and there is
no way to detect `-G` or `-E -G`.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 builtin/grep.c  |    4 +++-
 t/t7810-grep.sh |   16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6831975..8f26026 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -925,9 +925,11 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
+	if (opt.regflags !=3D REG_NEWLINE && opt.pcre)
+		die(_("cannot mix --extended-regexp and --perl-regexp"));
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
-	if ((opt.regflags !=3D REG_NEWLINE) && opt.fixed)
+	if ((opt.regflags !=3D REG_NEWLINE || opt.pcre) && opt.fixed)
 		die(_("cannot mix --fixed-strings and regexp"));
=20
 #ifndef NO_PTHREADS
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index e845218..2a31eca 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -637,4 +637,20 @@ test_expect_success LIBPCRE 'grep -P -w pattern' '
 	test_cmp expected actual
 '
=20
+test_expect_success LIBPCRE 'grep -P -F returns error' '
+	test_expect_code 128 git grep -P -F main
+'
+
+test_expect_success LIBPCRE 'grep -P -E returns error' '
+	test_expect_code 128 git grep -P -E main
+'
+
+test_expect_failure LIBPCRE 'grep -P -G returns error' '
+	test_expect_code 128 git grep -P -G main
+'
+
+test_expect_failure LIBPCRE 'grep -P -E -G returns error' '
+	test_expect_code 128 git grep -P -E -G main
+'
+
 test_done
--=20
1.7.3.4
