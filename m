From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: simple test for operation in a bare repository
Date: Fri, 05 Feb 2010 01:24:26 +0100
Message-ID: <4B6B653A.8060909@lsrfire.ath.cx>
References: <4B69BD7C.4010608@lsrfire.ath.cx> <4B6A0BDE.2050908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:24:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdBzu-0005os-9N
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 01:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0BEAY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 19:24:29 -0500
Received: from india601.server4you.de ([85.25.151.105]:41282 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab0BEAY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 19:24:28 -0500
Received: from [10.0.1.100] (p57B7DBF5.dip.t-dialin.net [87.183.219.245])
	by india601.server4you.de (Postfix) with ESMTPSA id 11E1D2F803C;
	Fri,  5 Feb 2010 01:24:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B6A0BDE.2050908@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139013>

Am 04.02.2010 00:50, schrieb Ren=E9 Scharfe:
> Am 03.02.2010 19:16, schrieb Ren=E9 Scharfe:
>> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>> ---
>>  t/t7002-grep.sh |   17 +++++++++++++++++
>>  1 files changed, 17 insertions(+), 0 deletions(-)
>=20
> Err, no, that won't do.  Sorry.
>=20
> The test script fails to demonstrate the issue I've run into.  It run=
s
> successfully, but running git grep manually fails:
>=20
> 	$ cd t/trash\ directory.t7002-grep/.git/bare_test_repo/
> 	$ git grep bla HEAD
> 	fatal: This operation must be run in a work tree
>=20
> I have to dig a bit deeper and try to come back with a better test sc=
ript.

OK, I have to admit defeat: I can't come up with a test script.  But
the issue is reproducible: git grep in a bare repository fails when
run with a pager.

	$ mkdir /tmp/a
	$ cd /tmp/a
	$ git init
	Initialized empty Git repository in /tmp/a/.git/
	$ echo a >a
	$ git add a
	$ git commit -m.
	[master (root-commit) e11f955] .
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 a

	$ git clone --bare . ../b
	Initialized empty Git repository in /tmp/b/
	$ cd /tmp/b

	$ git grep a HEAD
	fatal: This operation must be run in a work tree
	$ git grep a HEAD | cat
	HEAD:a:a
	$ git --no-pager grep a HEAD
	HEAD:a:a

Reverting 7e622650 (grep: prepare to run outside of a work tree), or
rather just setting the flag RUN_SETUP for grep in git.c again, makes
the first git grep call succeed, too.

As does the following patch, but I don't know why.  The call chain is
quite deep.  It seems that without the patch the static variable
git_dir in environment.c isn't updated when git finds out that it runs
in a bare repo -- but only if a pager is used.

There are five more sites in git.c, path.c and setup.c where $GIT_DIR
is set directly with setenv().  I wonder if they should better call
set_git_dir() instead, too.


diff --git a/setup.c b/setup.c
index 710e2f3..5fb9b25 100644
--- a/setup.c
+++ b/setup.c
@@ -406,7 +406,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 				cwd[offset] =3D '\0';
 				setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
 			} else
-				setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+				set_git_dir(".");
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
