From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] tests: Add tests for automatic use of pager
Date: Fri, 19 Feb 2010 01:18:58 -0600
Message-ID: <20100219071857.GF29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiN8b-0007ou-JN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0BSHSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:18:52 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:46745 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab0BSHSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:18:51 -0500
Received: by yxe38 with SMTP id 38so7208822yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Uy634GGeLfrLNG6Yyl4bAVLOLLUEe4GEj9gGWOaf9pQ=;
        b=CRHhrwjLdLjuivdy0gNgk31Sxv8mpXTbU95Z+ZGhXyuIe6C2KPdbydq/GGp9u1QJzH
         8jJP9UKd3ATRWJUwjIGlmoCzZF1V4DBQtHmuT28mqs4WXB6Ozr4vaZup/s+ECC2WM1F5
         s3FnFqIPAhNG3NUOZWAdue7VzZzLMPdWciGTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qgOIpdSA6hpeupbpl7KMMELZLYoybXAKdESA9YBHp+YT7KsXnaLLyY3ll6hIRtzzlt
         S18BGKwyf0g7Rw1y+FVjbsscuuaEbbUU9g2YSAwLCOEdIBpmYfVX8/PcJcV3yAfPx5w4
         UBk615G1YQ77YxMcbJ+ojhOOqZ9SUT2b+0SJw=
Received: by 10.101.193.7 with SMTP id v7mr11048276anp.183.1266563929875;
        Thu, 18 Feb 2010 23:18:49 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm2382164gxk.8.2010.02.18.23.18.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:18:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140424>

Git=E2=80=99s automatic pagination support has some subtleties.  Add so=
me
tests to make sure we don=E2=80=99t break:

 - when git will use a pager by default;
 - the effect of the --paginate and --no-pager options;
 - the effect of pagination on use of color;
 - how the choice of pager is configured.

This does not yet test:

 - use of pager by scripted commands (git svn and git am);
 - effect of the pager.* configuration variables;
 - setting of the LESS variable.

Some features involve checking whether stdout is a terminal, so many
of these tests are skipped unless output is passed through to the
terminal (i.e., unless $GIT_TEST_OPTS includes --verbose).

The immediate purpose for these tests was to avoid making things worse
after the breakage from my jn/editor-pager series (see commit 376f39,
2009-11-20).  Thanks to Sebastian Celis <sebastian@sebastiancelis.com>
for the report.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7006-pager.sh |  163 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 t/t7006-pager.sh

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
new file mode 100644
index 0000000..2e9cb9d
--- /dev/null
+++ b/t/t7006-pager.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+test_description=3D'Test automatic use of a pager.'
+
+. ./test-lib.sh
+
+rm -f stdout_is_tty
+test_expect_success 'is stdout a terminal?' '
+	if test -t 1
+	then
+		: > stdout_is_tty
+	fi
+'
+
+if test -e stdout_is_tty
+then
+	test_set_prereq TTY
+else
+	say stdout is not a terminal, so skipping some tests.
+fi
+
+unset GIT_PAGER GIT_PAGER_IN_USE
+git config --unset core.pager
+PAGER=3D'cat > paginated.out'
+export PAGER
+
+test_expect_success 'setup' '
+	test_commit initial
+'
+
+rm -f paginated.out
+test_expect_success TTY 'some commands use a pager' '
+	git log &&
+	test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'some commands do not use a pager' '
+	git rev-list HEAD &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success 'no pager when stdout is a pipe' '
+	git log | cat &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success 'no pager when stdout is a regular file' '
+	git log > file &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'git --paginate rev-list uses a pager' '
+	git --paginate rev-list HEAD  &&
+	test -e paginated.out
+'
+
+rm -f file paginated.out
+test_expect_success 'no pager even with --paginate when stdout is a pi=
pe' '
+	git --paginate log | cat &&
+	! test -e paginated.out
+'
+
+rm -f paginated.out
+test_expect_success TTY 'no pager with --no-pager' '
+	git --no-pager log &&
+	! test -e paginated.out
+'
+
+# A colored commit log will begin with an appropriate ANSI escape
+# for the first color; the text "commit" comes later.
+colorful() {
+	read firstline < $1
+	! expr "$firstline" : "^[a-zA-Z]" >/dev/null
+}
+
+rm -f colorful.log colorless.log
+test_expect_success 'tests can detect color' '
+	git log --no-color > colorless.log &&
+	git log --color > colorful.log &&
+	! colorful colorless.log &&
+	colorful colorful.log
+'
+
+rm -f colorless.log
+git config color.ui auto
+test_expect_success 'no color when stdout is a regular file' '
+	git log > colorless.log &&
+	! colorful colorless.log
+'
+
+rm -f paginated.out
+git config color.ui auto
+test_expect_success TTY 'color when writing to a pager' '
+	TERM=3Dvt100 test_terminal git log &&
+	colorful paginated.out
+'
+
+rm -f colorful.log
+git config color.ui auto
+test_expect_success 'color when writing to a file intended for a pager=
' '
+	TERM=3Dvt100 GIT_PAGER_IN_USE=3Dtrue git log > colorful.log &&
+	colorful colorful.log
+'
+
+unset PAGER GIT_PAGER
+git config --unset core.pager
+test_expect_success 'determine default pager' '
+	less=3D$(git var GIT_PAGER) &&
+	test -n "$less"
+'
+
+if expr "$less" : '^[a-z]*$' > /dev/null && test_have_prereq TTY
+then
+	test_set_prereq SIMPLEPAGER
+fi
+
+unset PAGER GIT_PAGER
+git config --unset core.pager
+rm -f default_pager_used
+test_expect_success SIMPLEPAGER 'default pager is used by default' '
+	cat > $less <<-EOF &&
+	#!$SHELL_PATH
+	: > default_pager_used
+	EOF
+	chmod +x $less &&
+	PATH=3D.:$PATH git log &&
+	test -e default_pager_used
+'
+
+unset GIT_PAGER
+git config --unset core.pager
+rm -f PAGER_used
+test_expect_success TTY 'PAGER overrides default pager' '
+	PAGER=3D": > PAGER_used" &&
+	export PAGER &&
+	git log &&
+	test -e PAGER_used
+'
+
+unset GIT_PAGER
+rm -f core.pager_used
+test_expect_success TTY 'core.pager overrides PAGER' '
+	PAGER=3D: &&
+	export PAGER &&
+	git config core.pager ": > core.pager_used" &&
+	git log &&
+	test -e core.pager_used
+'
+
+rm -f GIT_PAGER_used
+test_expect_success TTY 'GIT_PAGER overrides core.pager' '
+	git config core.pager : &&
+	GIT_PAGER=3D": > GIT_PAGER_used" &&
+	export GIT_PAGER &&
+	git log &&
+	test -e GIT_PAGER_used
+'
+
+test_done
--=20
1.7.0
