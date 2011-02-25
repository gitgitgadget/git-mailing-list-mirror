From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] commit: error out for missing commit message template
Date: Fri, 25 Feb 2011 03:07:57 -0600
Message-ID: <20110225090756.GI23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-28-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pster-0006B8-J8
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357Ab1BYJIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 04:08:10 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45606 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167Ab1BYJIG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 04:08:06 -0500
Received: by vxi39 with SMTP id 39so1197198vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=stCx4oxk/6a/U4D9AlE4ETE2WVaB+ia9gCGnpevgvHY=;
        b=uqcYREQp4b7hdHVg6+xGnZ9nEH+aGmmBf46JN63XGHIZ1SscJnvfatT5ABCyhBls9H
         QuJQvTqM5jyS8Rhv7VcssBFdyzaZ+io1PckvqvYG4EorXub9tG0nxWS199zjFe7hODyB
         KhnNJo7VClmqu/GH5Kb6Cj3UaQSs1zEo39aR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dgmGVSWloC3IQf3WZHOzXMIVtJ+1M5WJ4RDwheaRK2m6OrW3xQIz17hmV8h0q1MbTt
         gEs6uYHbRQjVL9REGJR9nVHxvc7zg092yKbS4vCoAyFgjwcevwNtekD6YLOktymk7dDU
         t4RcORK5bX2OQdfwDXKmal7wyzkFF9bNmp1wE=
Received: by 10.52.159.38 with SMTP id wz6mr3571673vdb.19.1298624884308;
        Fri, 25 Feb 2011 01:08:04 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id a6sm252497vcm.22.2011.02.25.01.08.01
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 01:08:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-28-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167889>

When "git commit" was rewritten in C (v1.5.4-rc0~78^2~30,
2007-11-08), a subtle bug in --template was introduced.  If the
file named by a --template parameter is missing, previously git
would error out with a message:

	Commit template file does not exist.

but in the C version the --template parameter gets ignored and
the default template is used.

t7500 has two tests for this case which would have caught it, except
that with the default $EDITOR, the commit message template is left
unmodified, causing 'git commit' to error out and the test to
succeed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -725,15 +725,15 @@ static int prepare_to_commit(const char *index_=
file, const char *prefix,
[...]
> -				"%s"
> -				"# Author:    %s\n",
> +				_("%s"
> +				"# Author:    %s\n"),

The above change causes the commit message template to be nonempty,
excluding comments, so bare "git commit" succeeds, exposing this
longstanding bug.

 builtin/commit.c  |    2 +-
 t/t7500-commit.sh |   14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d7f55e3..1a1fb73 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -634,7 +634,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
 			die_errno("could not read SQUASH_MSG");
 		hook_arg1 =3D "squash";
-	} else if (template_file && !stat(template_file, &statbuf)) {
+	} else if (template_file) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die_errno("could not read '%s'", template_file);
 		hook_arg1 =3D "template";
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index d551b77..5976f59 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -28,13 +28,21 @@ test_expect_success 'a basic commit in an empty tre=
e should succeed' '
 test_expect_success 'nonexistent template file should return error' '
 	echo changes >> foo &&
 	git add foo &&
-	test_must_fail git commit --template "$PWD"/notexist
+	(
+		GIT_EDITOR=3D"echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		test_must_fail git commit --template "$PWD"/notexist
+	)
 '
=20
 test_expect_success 'nonexistent template file in config should return=
 error' '
 	git config commit.template "$PWD"/notexist &&
-	test_must_fail git commit &&
-	git config --unset commit.template
+	test_when_finished "git config --unset commit.template" &&
+	(
+		GIT_EDITOR=3D"echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		test_must_fail git commit
+	)
 '
=20
 # From now on we'll use a template file that exists.
--=20
1.7.4.1
