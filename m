From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Sat, 28 Jul 2012 17:43:23 +0200
Message-ID: <20120728154320.GA98893@book.hvoigt.net>
References: <5001644F.10901@web.de> <87y5mkm935.fsf@thomas.inf.ethz.ch> <899A52DB-E548-44CD-8624-A715DDB17032@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Torsten B?gershausen <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 17:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv9BX-0002Bi-En
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab2G1Pn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jul 2012 11:43:26 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:39304 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2G1PnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:43:25 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sv9Ap-0001FP-IG; Sat, 28 Jul 2012 17:43:23 +0200
Content-Disposition: inline
In-Reply-To: <899A52DB-E548-44CD-8624-A715DDB17032@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202445>

Hi,

just to verify that this is unlikely just a hardware issue on one machi=
ne. I
today experienced this failure on master as well.

On Mon, Jul 16, 2012 at 06:06:26PM +0200, Torsten B?gershausen wrote:
>=20
> Am 16.07.2012 um 09:57 schrieb Thomas Rast:
>=20
> > Torsten B=F6gershausen <tboegi@web.de> writes:
> > What OS X are you running?  I started a loop
> >=20
> >  while : ; do ./t1450-fsck.sh || break; done
> >=20
> > and it hasn't failed yet.  It is
> >=20
> >  $ uname -a
> >  Darwin mackeller.inf.ethz.ch 11.4.0 Darwin Kernel Version 11.4.0: =
Mon Apr  9 19:32:15 PDT 2012; root:xnu-1699.26.8~1/RELEASE_X86_64 x86_6=
4
> >=20
>  uname -a
> Darwin birne.lan 10.8.0 Darwin Kernel Version 10.8.0: Tue Jun  7 16:3=
3:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386 i386

$ uname -a
Darwin book.hvoigt.net 10.8.0 Darwin Kernel Version 10.8.0: Tue Jun  7 =
16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386 i386

My bisect run did also not reveal anything useful. I tried to use valgr=
ind.
Interestingly just by prepending my valgrind directory to the PATH the =
test
passes. When changing PATH further it sometimes passes and sometimes no=
t.
Reopening a new shell it reliably fails.

The commit I am experiencing this with is cdd159b. This one reliably fa=
ils for
me with the correct path setting :-)

To me this smells a little bit like using a dangling pointer or uniniti=
alized
memory since threading seems to be out of the game. A dangling pointer =
only
available on a certain OS X version?

If I modify the PATH after adding the valgrind bin folder so that it ma=
tches
the same amount of characters as before I get the failure again.

It seems the error only occurs if my PATH is exactly 280 characters lon=
g. E.g.:

export PATH=3D/usr/local/valgrind/bin:/Users/hvoigt/.local/bin:/usr/bin=
:/bin:/usr/local/bin:/sw/bin/:/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaa

When running under valgrind test 13 (the original one) passes but 2 fai=
ls. Not
sure if this is a false positive[1].

If I add those eight bytes here the tests pass for me without valgrind:

diff --git a/environment.c b/environment.c
index 85edd7f..988f836 100644
--- a/environment.c
+++ b/environment.c
@@ -131,7 +131,7 @@ static void setup_git_env(void)
        }
        git_index_file =3D getenv(INDEX_ENVIRONMENT);
        if (!git_index_file) {
-               git_index_file =3D xmalloc(strlen(git_dir) + 7);
+               git_index_file =3D xmalloc(strlen(git_dir) + 7 + 8);
                sprintf(git_index_file, "%s/index", git_dir);
        }
        git_graft_file =3D getenv(GRAFT_ENVIRONMENT);

But maybe thats just a coincidence and totally unrelated.

The valgrind error can be fixed by this change:

diff --git a/sha1_file.c b/sha1_file.c
index 4ccaf7a..631d0dd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -251,7 +251,7 @@ static int link_alt_odb_entry(const char * entry, i=
nt len, const char * relative
        const char *objdir =3D get_object_directory();
        struct alternate_object_database *ent;
        struct alternate_object_database *alt;
-       int pfxlen, entlen;
+       int pfxlen, entlen, objdirlen;
        struct strbuf pathbuf =3D STRBUF_INIT;
=20
        if (!is_absolute_path(entry) && relative_base) {
@@ -298,7 +298,8 @@ static int link_alt_odb_entry(const char * entry, i=
nt len, const char * relative
                        return -1;
                }
        }
-       if (!memcmp(ent->base, objdir, pfxlen)) {
+       objdirlen =3D strlen(objdir);
+       if (!memcmp(ent->base, objdir, pfxlen > objdirlen ? objdirlen :=
 pfxlen)) {
                free(ent);
                return -1;
        }

I will format this into a proper patch independent from this mail.

These are my observations.

Cheers Heiko

[1]
$ ./t1450-fsck.sh --valgrind
[...]
expecting success:=20
	mkdir another &&
	(
		cd another &&
		git init &&
		echo ../../../.git/objects >.git/objects/info/alternates &&
		test_commit C fileC one &&
		git fsck --no-dangling >../actual 2>&1
	) &&
	test_cmp empty actual

Initialized empty Git repository in /Users/hvoigt/Repository/git/t/tras=
h directory.t1450-fsck/another/.git/
=3D=3D42686=3D=3D Invalid read of size 8
=3D=3D42686=3D=3D    at 0x100625064: bcmp (in /usr/lib/libSystem.B.dyli=
b)
=3D=3D42686=3D=3D    by 0x100112846: link_alt_odb_entries (in /Users/hv=
oigt/Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1001129C0: read_info_alternates (in /Users/hv=
oigt/Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100112B8C: prepare_alt_odb (in /Users/hvoigt/=
Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1001148B7: prepare_packed_git (in /Users/hvoi=
gt/Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100116A8B: find_pack_entry (in /Users/hvoigt/=
Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100118008: has_sha1_file (in /Users/hvoigt/Re=
pository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100117DFA: write_sha1_file (in /Users/hvoigt/=
Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100118268: index_mem (in /Users/hvoigt/Reposi=
tory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1001183DC: index_core (in /Users/hvoigt/Repos=
itory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100118586: index_fd (in /Users/hvoigt/Reposit=
ory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1001186DA: index_path (in /Users/hvoigt/Repos=
itory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D  Address 0x100faca78 is 8 bytes inside a block of siz=
e 13 alloc'd
=3D=3D42686=3D=3D    at 0x10029C679: malloc (vg_replace_malloc.c:266)
=3D=3D42686=3D=3D    by 0x1001349CD: xmalloc (in /Users/hvoigt/Reposito=
ry/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1000C23F5: setup_git_env (in /Users/hvoigt/Re=
pository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1000C286B: set_git_dir (in /Users/hvoigt/Repo=
sitory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x100110128: setup_work_tree (in /Users/hvoigt/=
Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1000022F2: run_builtin (in /Users/hvoigt/Repo=
sitory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1000024DA: handle_internal_command (in /Users=
/hvoigt/Repository/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x1000025E8: run_argv (in /Users/hvoigt/Reposit=
ory/git/t/valgrind/../../git)
=3D=3D42686=3D=3D    by 0x10000275F: main (in /Users/hvoigt/Repository/=
git/t/valgrind/../../git)
=3D=3D42686=3D=3D=20
{
   <insert_a_suppression_name_here>
   Memcheck:Addr8
   fun:bcmp
   fun:link_alt_odb_entries
   fun:read_info_alternates
   fun:prepare_alt_odb
   fun:prepare_packed_git
   fun:find_pack_entry
   fun:has_sha1_file
   fun:write_sha1_file
   fun:index_mem
   fun:index_core
   fun:index_fd
   fun:index_path
}
not ok - 2 loose objects borrowed from alternate are not missing
