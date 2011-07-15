From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Fri, 15 Jul 2011 11:19:13 +0200
Message-ID: <4E200611.9010005@alum.mit.edu>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 11:19:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QheYM-000761-DG
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 11:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965359Ab1GOJTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 05:19:17 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44781 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965245Ab1GOJTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 05:19:16 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6F9JE2l002370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 11:19:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4E1EB5E9.1070902@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177195>

On 07/14/2011 11:24 AM, Michael Haggerty wrote:
> On 07/14/2011 09:16 AM, Michael Haggerty wrote:
>> I have noticed that "git filter-branch" gets pathologically slow whe=
n it
>> operates on a repository that has many references in a complicated
>> directory hierarchy.  The time seems to go like O(N^3), where N is t=
he
>> number of references being rewritten.
>=20
> New information: Once I have "primed" a git repository using the
> attached script, a command like the following takes about 90 ms:
>=20
>     git rev-parse refs/heads/a4/b1/c0414^0
>=20
> strace reveals that it is calling stat64() then lstat64() on every
> directory and every file under .git/refs.

It looks like the time is being taken up by attempted object
replacement.  The --no-replace-objects option makes the lookup fast aga=
in:

$ time git rev-parse
refs/heads/a4/b1/c0414^0c9d42cb64d465f354c1fa6eea5825ebb6d0483a7

real	0m0.093s
user	0m0.064s
sys	0m0.032s
$ time git --no-replace-objects rev-parse refs/heads/a4/b1/c0414^0
c9d42cb64d465f354c1fa6eea5825ebb6d0483a7

real	0m0.007s
user	0m0.000s
sys	0m0.012s

The guilty code path is here:

> #0  get_ref_dir (submodule=3D0x0, base=3D0x81384dd "refs", list=3D0x0=
) at refs.c:260
> #1  0x080f8a63 in get_loose_refs (submodule=3D0x0) at refs.c:368
> #2  0x080f912f in do_for_each_ref (submodule=3D0x0, base=3D<value opt=
imized out>, fn=3D<value optimized out>, trim=3D13, flags=3D0, cb_data=3D=
0x0) at refs.c:663
> #3  0x080f92db in for_each_replace_ref (fn=3D0x80fd1c0 <register_repl=
ace_ref>, cb_data=3D0x0) at refs.c:782
> #4  0x080fd174 in prepare_replace_object (sha1=3D0xbfffde68 "\311\324=
,\266MF_5L\037\246=EE=A5=82^\273m\004\203\247") at replace_object.c:86
> #5  do_lookup_replace_object (sha1=3D0xbfffde68 "\311\324,\266MF_5L\0=
37\246=EE=A5=82^\273m\004\203\247") at replace_object.c:103
> #6  0x080e7920 in lookup_replace_object (sha1=3D0xbfffde68 "\311\324,=
\266MF_5L\037\246=EE=A5=82^\273m\004\203\247") at cache.h:774
> #7  parse_object (sha1=3D0xbfffde68 "\311\324,\266MF_5L\037\246=EE=A5=
=82^\273m\004\203\247") at object.c:191
> #8  0x080bcf2a in lookup_commit_reference_gently (sha1=3D0xbfffde68 "=
\311\324,\266MF_5L\037\246=EE=A5=82^\273m\004\203\247", quiet=3D0) at c=
ommit.c:30
> #9  0x080bcf89 in lookup_commit_reference (sha1=3D0xbfffde68 "\311\32=
4,\266MF_5L\037\246=EE=A5=82^\273m\004\203\247") at commit.c:39
> #10 0x0810e2a8 in get_parent (name=3D<value optimized out>, len=3D<va=
lue optimized out>, sha1=3D<value optimized out>) at sha1_name.c:456
> #11 get_sha1_1 (name=3D<value optimized out>, len=3D<value optimized =
out>, sha1=3D<value optimized out>) at sha1_name.c:663
> #12 0x0810e9dd in get_sha1_with_context_1 (name=3D0xbffff48c "refs/he=
ads/a4/b1/c0414^0", sha1=3D0xbffff098 "\310\360\377\277\001C\021\b\300\=
265=E4=B7=82\364\377\277", oc=3D0xbfffefec, only_to_die=3D0, prefix=3D0=
x0) at sha1_name.c:1123
> #13 0x0810f290 in get_sha1_with_context (name=3D0xbffff48c "refs/head=
s/a4/b1/c0414^0", sha1=3D0xbffff098 "\310\360\377\277\001C\021\b\300\26=
5=E4=B7=82\364\377\277") at cache.h:824
> #14 get_sha1 (name=3D0xbffff48c "refs/heads/a4/b1/c0414^0", sha1=3D0x=
bffff098 "\310\360\377\277\001C\021\b\300\265=E4=B7=82\364\377\277") at=
 sha1_name.c:987
> #15 0x080a258a in cmd_rev_parse (argc=3D2, argv=3D0xbffff2a4, prefix=3D=
0x0) at builtin/rev-parse.c:715
> #16 0x0804b917 in run_builtin (argc=3D<value optimized out>, argv=3D<=
value optimized out>) at git.c:302
> #17 handle_internal_command (argc=3D<value optimized out>, argv=3D<va=
lue optimized out>) at git.c:460
> #18 0x0804c00a in main (argc=3D2, argv=3D0xbffff2a4) at git.c:545

The replace_object machinery is causing the whole loose reference cache
to be populated even though it is only interested in references under
refs/replace (which, in this case, doesn't even exist).

A many possible improvements come to mind, in increasing order of
intrusiveness and generality:

0. Individual users can use --no-replace-objects or
GIT_NO_REPLACE_OBJECTS to reduce their pain, especially when running
git-filter-branch.  But this is cumbersome and error-prone.

1. Change git-filter-branch (and any other long-running commands?) to d=
o
an initial check for the presence of replace references (packed or
loose), and if there are none, set GIT_NO_REPLACE_OBJECTS automatically=
=2E
 This would of course fail if any of the user's scripts try to set up
replace references.  (Side note: perhaps the git-replace command should
complain if GIT_NO_REPLACE_OBJECTS is turned on?  It would almost alway=
s
indicate a mistake.)  It also wouldn't help in repositories that *have*
replace references.

2. Add an option to git-filter-branch to have it pack references
occasionally.  This could even be made the default behavior if nobody
objects to having their references packed without their conscious decis=
ion.

3. Optimize the specific case where there is no refs/replace
directory--if this directory is missing, then defer populating the loos=
e
refs cache in the hope that it will never be needed.

4. Optimize reading of loose refs in general--change get_loose_refs() t=
o
take a "base" parameter, and defer populating the loose refs cache if
the directory corresponding to "base" is absent.  This would salvage th=
e
worst cases, but would always force the whole loose refs cache to be
read even in cases when only part of it is needed.

5. Organize the loose refs cache in memory as a tree, and only populate
the parts of it that are accessed.  This should also speed up iteration
through a subtree by avoiding a linear search through all loose referen=
ces.

Unfortunately, none of these improvements would change the fact that th=
e
packed refs always have to be read in full, and thus that *basically
all* git commands scale like O(total number of references).  But packed
refs are so much faster than loose refs that this is probably acceptabl=
e.

I'd be willing to work on this problem if I get a little bit of feedbac=
k
from more experienced git developers about which approach would be
acceptable / preferred.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
