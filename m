From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [msysGit] Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 23 Jan 2015 22:24:17 +0100
Message-ID: <54C2BC01.2030307@web.de>
References: <20150114211712.GE1155@peff.net>	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>	<20150115222719.GA19021@peff.net>	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>	<20150115235752.GB25120@peff.net>	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>	<20150116013256.GA25894@peff.net>	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>	<xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>	<54C170E9.4010401@web.de> <xmqqlhkusc4h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YElii-0005Rh-95
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 22:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbbAWVYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2015 16:24:44 -0500
Received: from mout.web.de ([212.227.17.11]:53058 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbbAWVYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 16:24:43 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MRU72-1Y8CAE1WvY-00SeNV; Fri, 23 Jan 2015 22:24:19
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqlhkusc4h.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:gDSzJi5OK5KP+2grEbtPc/eObfpulaaAJhpY6lmD4ZvEsmSvGR3
 wD90tWShOuBLefM6iv+amOHmeSbWFMTg2L8hLNbRUc7GDkPUnlFEYbp5QH5x4jLk80nMnzg
 /9LEAtQLqeeH6O4RaJmHZL2y1eYEBpdntlKZ5uT23qeuILxQvl2mUOjaIF+CDtRYRXVysX6
 z9UlKsyKVWdnbNOx7QKQg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262962>

On 2015-01-22 23.07, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> If I run that sequence manually:
>> chmod 755 .
>> touch x
>> chmod a-w .
>> rm x
>> touch y
>>
>> x is gone, (but shoudn't according to POSIX)
>> y is not created, "access denied"
>=20
> Good (or is that Sad?).
>=20
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1039,7 +1039,17 @@ test_lazy_prereq NOT_ROOT '
>>  # When the tests are run as root, permission tests will report that
>>  # things are writable when they shouldn't be.
>>  test_lazy_prereq SANITY '
>> -       test_have_prereq POSIXPERM,NOT_ROOT
>> +       mkdir ds &&
>> +       touch ds/x &&
>> +       chmod -w ds &&
>> +       if rm ds/x
>> +       then
>> +               chmod +w ds
>> +               false
>> +       else
>> +               chmod +w ds
>> +               true
>> +       fi
>>  '
>=20
> It looks like a better approach overall.
>=20
> Because we cannot know where $(pwd) is when lazy prereq is evaluated
> (it typically is at the root of the trash hierarchy, but not always)
> and we would not want to add, leave or remove random files in the
> working tree that are not expected by the tests proper (e.g. a test
> that counts untracked paths are not expecting ds/ to be there), your
> actual "fix" may need to be a bit more careful, though.
>=20
> Thanks.
>=20

Hm,
I think there are 2 different possiblities to go further,
either to always switch off SANITY for CYGWIN (or Windows in general).
I haven't tested anything, the idea came up while writing this email.

The other way is to go away from the hard coded "we know we are root,
so SANITY must be false, or we know that Windows is not 100% POSIX",
and probe the OS/FS dynamically.

The following probably deserves the price for the most clumsy prerequis=
ite
ever written.
(Copy&Paste of a real patch into the mailer, not sure if it applies)

It has been tested under Mac OS, root@Mac OS, Cygwin / Msysgit
What do you think ?



-- >8 --
Subject: [PATCH 1/2] test-lib.sh: Improve SANITY

SANITY was not set when running as root,
but this is not 100% reliable for CYGWIN:

A file is allowed to be deleted when the containing
directory does not have write permissions.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/test-lib.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 93f7cad..b8f736f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1038,8 +1038,26 @@ test_lazy_prereq NOT_ROOT '
=20
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
+# Special check for CYGWIN (or Windows in general):
+# A file can be deleted, even if the containing directory does'nt
+# have write permissions
 test_lazy_prereq SANITY '
-	test_have_prereq POSIXPERM,NOT_ROOT
+	dsdir=3D$$ds
+	mkdir $dsdir &&
+	touch $dsdir/x &&
+	chmod -w $dsdir &&
+	if rm $dsdir/x
+	then
+		chmod +w $dsdir
+		rm -rf $dsdir
+		echo >&2 SANITY=3Dfalse
+		false
+	else
+		chmod +w $dsdir
+		rm -rf $dsdir
+		echo >&2 SANITY=3Dtrue
+		true
+	fi
 '
=20
 GIT_UNZIP=3D${GIT_UNZIP:-unzip}
--=20


Subject: [PATCH 2/2] t2026 needs SANITY

When running as root 'prune directories with unreadable gitdir' in t202=
6 fails.
Protect this TC with SANITY

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t2026-prune-linked-checkouts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-c=
heckouts.sh
index 170aefe..2936d52 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -33,7 +33,7 @@ EOF
 	! test -d .git/worktrees
 '
=20
-test_expect_success POSIXPERM 'prune directories with unreadable gitdi=
r' '
+test_expect_success SANITY 'prune directories with unreadable gitdir' =
'
 	mkdir -p .git/worktrees/def/abc &&
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
