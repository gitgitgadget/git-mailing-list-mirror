From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] tests: local config file should be honored from
 subdirs of toplevel
Date: Sat, 26 Jun 2010 14:25:37 -0500
Message-ID: <20100626192537.GC20051@burratino>
References: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 21:25:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSb0m-0000Fx-Jw
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 21:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab0FZTZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 15:25:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64952 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0FZTZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 15:25:51 -0400
Received: by iwn41 with SMTP id 41so3106690iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S3ThgxHV6d1BFAf7kmoDdA8LuzcFsQUR3n0ABtEVn6g=;
        b=EA23WKj6TchiiatqZD29+kluJpQjeuvg5I9l5Yz6SabrOwEZc3ib9VF0mlZSBdu+Js
         kOKMrpcbV7kP7tfjlopbHoVzv64qVq/IsgnOPPnI8p0lE1M03WOvueB1GfWGzT7npg8q
         ZjPt+7yHidc7PAmIiDfs3SbzqfAci+TOxy6+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oKfqLirfGRtyPwqO5CEddtCLYKPDTQSn+2XqcDDmDyJaTWpmPw968oJnuoThGghV6R
         IFWDyPVbbyZIftdtHYcZJZLrviH2iFUlF/VNH5TBcPt464xQoAO6U3q+ZRPc4u75fYnH
         o7YkFVmsdRoVCQ3HFh9rafTBU/0rga+uOLFmY=
Received: by 10.231.36.9 with SMTP id r9mr2440612ibd.105.1277580351109;
        Sat, 26 Jun 2010 12:25:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm13102556ibu.18.2010.06.26.12.25.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 12:25:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100626192203.GA19973@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149774>

When git is passed the --paginate option, starting up a pager requires
deciding what pager to start, which requires access to the core.pager
configuration.  If --paginate is handled before searching for the
git dir, this configuration will be missed.

In other words, with --paginate and only with --paginate, any
repository-local core.pager setting is being ignored [*].

[*] unless the git directory is ./.git or GIT_DIR or GIT_CONFIG was
set explicitly.

Add a test to demonstrate this counterintuitive behavior.  Noticed
while reading over a patch by Duy that fixes it.

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Improved-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7006-pager.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4420f91..2b106be 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -259,6 +259,28 @@ test_core_pager_overrides() {
 	"
 }
=20
+test_core_pager_subdir() {
+	parse_args "$@"
+
+	$test_expectation TTY "$cmd - core.pager from subdirectory" "
+		unset GIT_PAGER;
+		rm -f core.pager_used &&
+		rm -fr sub ||
+		cleanup_fail &&
+
+		PAGER=3Dwc &&
+		stampname=3D\$(pwd)/core.pager_used &&
+		export PAGER stampname &&
+		git config core.pager 'wc >\"\$stampname\"' &&
+		mkdir sub &&
+		(
+			cd sub &&
+			$full_command
+		) &&
+		test -e core.pager_used
+	"
+}
+
 test_GIT_PAGER_overrides() {
 	parse_args "$@"
=20
@@ -277,21 +299,25 @@ test_GIT_PAGER_overrides() {
 test_default_pager        expect_success 'git log'
 test_PAGER_overrides      expect_success 'git log'
 test_core_pager_overrides expect_success 'git log'
+test_core_pager_subdir    expect_success 'git log'
 test_GIT_PAGER_overrides  expect_success 'git log'
=20
 test_default_pager        expect_success 'git -p log'
 test_PAGER_overrides      expect_success 'git -p log'
 test_core_pager_overrides expect_success 'git -p log'
+test_core_pager_subdir    expect_failure 'git -p log'
 test_GIT_PAGER_overrides  expect_success 'git -p log'
=20
 test_default_pager        expect_success test_must_fail 'git -p'
 test_PAGER_overrides      expect_success test_must_fail 'git -p'
 test_core_pager_overrides expect_success test_must_fail 'git -p'
+test_core_pager_subdir    expect_failure test_must_fail 'git -p'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
=20
 test_default_pager        expect_success test_must_fail 'git -p nonsen=
se'
 test_PAGER_overrides      expect_success test_must_fail 'git -p nonsen=
se'
 test_core_pager_overrides expect_success test_must_fail 'git -p nonsen=
se'
+test_core_pager_subdir    expect_failure test_must_fail 'git -p nonsen=
se'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p nonsen=
se'
=20
 test_done
--=20
1.7.1.579.ge2549
