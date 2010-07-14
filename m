From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] git --paginate: paginate external commands again
Date: Wed, 14 Jul 2010 17:55:12 -0500
Message-ID: <20100714225512.GA13636@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 00:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZAs8-000834-Sl
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 00:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757130Ab0GNW4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 18:56:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47674 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab0GNW4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 18:56:05 -0400
Received: by vws5 with SMTP id 5so329991vws.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7v2/w9HVYZXsna3L3qvMYma0YhkOqFZlW8hOrpARyLo=;
        b=wqD9NZvVpnfg1PjXpO6a/yrWAytlFHazg881/BBzP5uX4LHPjeRgLOCYePxRKnUHyi
         nPnWbFjZzwjQS/kiD/3RmfcgkJpwGyQDurXxWiyhnCR1usTJxTVkUjaa9bNDsMBYJu0B
         e7Ggrl5xvzKDtiCgLt4Z/DIkFCs3YPRsNKYz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TmrSGmspeepFQY9El9ci58RfzhgR4KQnzEDyc+LjK881LjLghJk6eVFy74L62wZOZk
         5zli2b+ORmaIKOFlbEaB50xbX0op/g19lIIQXWtPFQAQtj4B5l6JqpAa7QjUCxOueKU3
         eI0OfdRoTIwHTprBsPp/FUD6BzCqC4PNXJwzI=
Received: by 10.224.47.75 with SMTP id m11mr10309485qaf.54.1279148162621;
        Wed, 14 Jul 2010 15:56:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id fb41sm1521900qcb.15.2010.07.14.15.56.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 15:56:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v630hyf5r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151040>

73e25e7c (git --paginate: do not commit pager choice too early,
2010-06-26) failed to take some cases into account.

1b. Builtins that do not use RUN_SETUP (like git config) do
    not find GIT_DIR set correctly when the pager is launched
    from run_builtin().  So the core.pager configuration is
    not honored from subdirectories of the toplevel for them.

4a. External git commands (like git request-pull) relied on the
    early pager launch to take care of handling the -p option.
    Ever since 73e25e7c, they do not honor the -p option at all.

4b. Commands invoked through ! aliases (like ls) were also relying
    on the early pager launch.

=46ix (4a) by launching the pager (if requested) before running such a
=E2=80=9Cdashed external=E2=80=9D.  For simplicity, this still does not=
 search for a
=2Egit directory before running the external command; when run from a
subdirectory of the toplevel, therefore, the =E2=80=9C[core] pager=E2=80=
=9D
configuration is still not honored.

=46ix (4b) by launching pager if requested before carrying out such an
alias.  Actually doing this has no effect, since the pager (if any)
would have already been launched in a failed attempt to try a
dashed external first.  The choice-of-pager-not-honored-from-
subdirectory bug still applies here, too.

(1b) is not a regression.  There is no need to fix it yet.

Noticed by Junio.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> I hate an enumeration that pretends to be exhausitive but is not.

Sorry about that.

Here=E2=80=99s a patch that could be squashed in or applied on top.

 git.c            |    3 +++
 t/t7006-pager.sh |   47 +++++++++++++++++++++++++++++++++++-----------=
-
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/git.c b/git.c
index 25e7693..99517dd 100644
--- a/git.c
+++ b/git.c
@@ -167,6 +167,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	alias_string =3D alias_lookup(alias_command);
 	if (alias_string) {
 		if (alias_string[0] =3D=3D '!') {
+			commit_pager_choice();
 			if (*argcp > 1) {
 				struct strbuf buf;
=20
@@ -432,6 +433,8 @@ static void execv_dashed_external(const char **argv=
)
 	const char *tmp;
 	int status;
=20
+	commit_pager_choice();
+
 	strbuf_addf(&cmd, "git-%s", argv[0]);
=20
 	/*
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index eefef45..9215c2f 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -334,17 +334,40 @@ test_doesnt_paginate() {
 	"
 }
=20
-test_default_pager        expect_success 'git log'
-test_PAGER_overrides      expect_success 'git log'
-test_core_pager_overrides expect_success 'git log'
-test_core_pager_subdir    expect_success 'git log'
-test_GIT_PAGER_overrides  expect_success 'git log'
-
-test_default_pager        expect_success 'git -p log'
-test_PAGER_overrides      expect_success 'git -p log'
-test_core_pager_overrides expect_success 'git -p log'
-test_core_pager_subdir    expect_success 'git -p log'
-test_GIT_PAGER_overrides  expect_success 'git -p log'
+test_pager_choices() {
+	test_default_pager        expect_success "$@"
+	test_PAGER_overrides      expect_success "$@"
+	test_core_pager_overrides expect_success "$@"
+	test_core_pager_subdir    expect_success "$@"
+	test_GIT_PAGER_overrides  expect_success "$@"
+}
+
+test_expect_success 'setup: some aliases' '
+	git config alias.aliasedlog log &&
+	git config alias.true "!true"
+'
+
+test_pager_choices                       'git log'
+test_pager_choices                       'git -p log'
+test_pager_choices                       'git aliasedlog'
+
+test_default_pager        expect_success 'git -p aliasedlog'
+test_PAGER_overrides      expect_success 'git -p aliasedlog'
+test_core_pager_overrides expect_success 'git -p aliasedlog'
+test_core_pager_subdir    expect_failure 'git -p aliasedlog'
+test_GIT_PAGER_overrides  expect_success 'git -p aliasedlog'
+
+test_default_pager        expect_success 'git -p true'
+test_PAGER_overrides      expect_success 'git -p true'
+test_core_pager_overrides expect_success 'git -p true'
+test_core_pager_subdir    expect_failure 'git -p true'
+test_GIT_PAGER_overrides  expect_success 'git -p true'
+
+test_default_pager        expect_success test_must_fail 'git -p reques=
t-pull'
+test_PAGER_overrides      expect_success test_must_fail 'git -p reques=
t-pull'
+test_core_pager_overrides expect_success test_must_fail 'git -p reques=
t-pull'
+test_core_pager_subdir    expect_failure test_must_fail 'git -p reques=
t-pull'
+test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p reques=
t-pull'
=20
 test_default_pager        expect_success test_must_fail 'git -p'
 test_PAGER_overrides      expect_success test_must_fail 'git -p'
@@ -352,6 +375,6 @@ test_local_config_ignored expect_failure test_must_=
fail 'git -p'
 test_no_local_config_subdir expect_success test_must_fail 'git -p'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
=20
-test_doesnt_paginate      expect_success test_must_fail 'git -p nonsen=
se'
+test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsen=
se'
=20
 test_done
--=20
1.7.2.rc2.532.g65d9b.dirty
