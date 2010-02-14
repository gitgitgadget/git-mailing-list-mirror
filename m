From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/6] tests: Add tests for automatic use of pager
Date: Sun, 14 Feb 2010 06:13:00 -0600
Message-ID: <20100214121300.GF3499@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgdLf-0007jO-IU
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 13:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758469Ab0BNMNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 07:13:08 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:64798 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294Ab0BNMND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 07:13:03 -0500
Received: by iwn39 with SMTP id 39so1366245iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=z4NFgqj+nl/nkiPqKJolsuprwIebqgFUwXiLwBWd0/g=;
        b=U+3unVdI+02wDxpF/kEa+2Nyf4j2NGo+u0RQbIwWJmmXvOwnXsjAKuYrJQk+7Wz81s
         qLEvZwro9D4w4u8cs5u10lu1nE2xu1ThvT3CTAPbJQd8zSMIA6A5Dn4JQI2Sq55C26zI
         CJ8WsbPCvTDn1uttz/oeZaxSSHVnOjW2SnSTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Xbh2wmyBOvF4rUK95PDYYTwVN9hTulXl0A+bLdpbMrQlSUbudo21pVHYtzctp7Txxz
         9UPoakKZVKO6wqs5AvUGyxSWU7nmM+QzTrW2BJdSsnE6sZDPgJ+N3C4xuA3rhFSvAiO1
         k2XAPJ7LleQN6/p6O/+SsmDs/Zk/ELtmaWv+Y=
Received: by 10.231.149.9 with SMTP id r9mr4393814ibv.82.1266149582708;
        Sun, 14 Feb 2010 04:13:02 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5145986iwn.0.2010.02.14.04.13.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 04:13:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115430.GA1849@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139906>

Git=E2=80=99s automatic pagination support has some subtleties; add som=
e tests
to make sure they don=E2=80=99t break.

The tests touch on a few different aspects of git=E2=80=99s pagination
behavior:

 - when git will use a pager by default;
 - the effect of the --paginate and --no-pager options;
 - the effect of pagination on use of color;
 - how the choice of pager is configured.

They does not yet test:

 - use of pager by scripted commands (git svn and git am);
 - effect of the pager.* configuration variables;
 - setting of the LESS variable.

Some features require stdout to be a terminal to be testable without
a (not written) shim using pseudo-terminals.  Thus about half of these
tests are skipped unless $GIT_TEST_OPTS includes --verbose.

The immediate purpose for these tests is to document removal of most
breakage from my jn/editor-pager series (see commit 376f39,
2009-11-20).  Thanks to Sebastian Celis <sebastian@sebastiancelis.com>
for the report.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |  163 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 t/t7006-pager.sh

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
new file mode 100644
index 0000000..5562b70
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
+	if tty <&1 >/dev/null 2>/dev/null
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
+test_expect_success 'some commands do not use a pager' '
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
+test_expect_success 'no pager with --no-pager' '
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
+	TERM=3Dvt100 git log &&
+	colorful paginated.out
+'
+
+rm -f colorful.log
+git config color.ui auto
+test_expect 'color when writing to a file intended for a pager' '
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
