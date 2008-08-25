From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH] Makefile: always provide a fallback when hardlinks fail
Date: Mon, 25 Aug 2008 17:42:21 +0200
Message-ID: <D4374620-C6D8-4CB3-8A7D-C5449BB8E8D1@web.de>
References: <0EFF470D-341A-4619-910A-0F9C663D0B51@web.de> <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/mixed; boundary=Apple-Mail-17-853573048
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:44:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXeF2-0007eU-GL
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 17:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbYHYPnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 11:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYHYPnY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 11:43:24 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52780 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYHYPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 11:43:23 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id E8662EC21914;
	Mon, 25 Aug 2008 17:42:43 +0200 (CEST)
Received: from [91.18.116.152] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KXeDL-0001Zu-00; Mon, 25 Aug 2008 17:42:43 +0200
In-Reply-To: <7vljyv6gyo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX195cVWsspHRlJODTrfCLyhRJ496dDGz5RqV/RKo
	sMv/24nf9RECRD27tcbdJtHLUNs65Wq4YJeWCteY2j1zjBw+Cz
	mspqc2qT8q40s+Jjzx/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93636>


--Apple-Mail-17-853573048
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable


Am 17.08.2008 um 13:03 schrieb Junio C Hamano:

> Andreas F=E4rber <andreas.faerber@web.de> writes:
>
>> BFS does not support hardlinks, so suppress the resulting error
>> messages.
>
> Hmm, this is not specific to BFS.  [...]
>
> Your patch seems to be whitespace damaged.  Here is an alternative.
>
> Note.
>
> We currently install $(bindir)/git to $(gitexecdir)/git, make =20
> hardlinks to
> "git-<cmd>" from "git" inside $(gitexecdir), and then finally remove =20=

> "git"
> in $(gitexecdir).
>
> We could avoid this ugliness by:
>
> (1) install "$(gitexecdir)/git-add" (or any other single built-in) by
>     trying hardlink "$(bindir)/git", and if it fails by copying;
>
> (2) for the rest of built-ins, install "$(gitexecdir)/git-<cmd>" by =20=

> trying
>     ln "$(gitexecdir)/git-add" "$(gitexecdir)/git-<cmd>", then
>     ln -s "git-add" "$(gitexecdir)/git-<cmd>", then finally
>     cp "$(gitexecdir)/git-add" "$(gitexecdir)/git-<cmd>".
>
> That is not what I did, but it should be the right thing to do.  It is
> already very late in the release cycle, and this whole thing can be =20=

> done
> after 1.6.0 final; we do not have to hurry.

I've tried to implement what you've outlined above.

On Haiku this now results in symlinks within the build dir for the =20
builtins including git-add, and in symlinks for all builtins but git-=20
add in $prefix/libexec/git-core.

---
From: Andreas Faerber <andreas.faerber@web.de>
Date: Mon, 25 Aug 2008 17:33:03 +0200
Subject: [PATCH] Makefile: always provide a fallback when hardlinks fail

We make hardlinks from "git" to "git-<cmd>" built-ins and have been
careful to avoid cross-device links when linking "git-<cmd>" to =20
gitexecdir.

However, we were not prepared to deal with a build directory that is
incapable of making hard links within itself. This patch corrects it.

Instead of temporarily linking "git" to gitexecdir, directly link "git-=20=

add",
falling back to "cp". Try hardlinking that as "git-<cmd>", falling back
to symlinks or "cp" on error.

While at it, avoid 100+ error messages from hardlink failures when we =20=

are
going to fall back to symlinks or "cp" by redirecting the standard error
to /dev/null.

Signed-off-by: Andreas F=E4rber <andreas.faerber@web.de>
---
  Makefile |   22 +++++++++++-----------
  1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 7a6cbb6..fb4863c 100644
--- a/Makefile
+++ b/Makefile
@@ -1110,7 +1110,10 @@ help.o: help.c common-cmds.h GIT-CFLAGS
  		'-DGIT_INFO_PATH=3D"$(infodir_SQ)"' $<

  $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
+	$(QUIET_BUILT_IN)$(RM) $@ && \
+	ln git$X $@ 2>/dev/null || \
+	ln -s git$X $@ 2>/dev/null || \
+	cp git$X $@

  common-cmds.h: ./generate-cmdlist.sh command-list.txt

@@ -1371,16 +1374,13 @@ ifneq (,$X)
  endif
  	bindir=3D$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
  	execdir=3D$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && =
\
-	if test "z$$bindir" !=3D "z$$execdir"; \
-	then \
-		ln -f "$$bindir/git$X" "$$execdir/git$X" || \
-		cp "$$bindir/git$X" "$$execdir/git$X"; \
-	fi && \
-	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln =
"$$execdir/git=20
$X" "$$execdir/$p" ;) } && \
-	if test "z$$bindir" !=3D "z$$execdir"; \
-	then \
-		$(RM) "$$execdir/git$X"; \
-	fi && \
+	{ $(RM) "$$execdir/git-add$X" && \
+		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
+		cp git-add$X "$$execdir/git-add$X"; } && \
+	{ $(foreach p,$(patsubst git-add,,$(BUILT_INS)), $(RM) =
"$$execdir/=20
$p" && \
+		ln "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null || \
+		ln -s "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null =
|| \
+		cp "$$execdir/git-add$X" "$$execdir/$p" || exit;) } && \
  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"

  install-doc:
--=20
1.6.0.1.91.gaea6


--Apple-Mail-17-853573048
Content-Disposition: attachment;
	filename=0001-Makefile-always-provide-a-fallback-when-hardlinks-f.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Makefile-always-provide-a-fallback-when-hardlinks-f.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20aea60501ba1651f7ba51de8381db5355d6df472b=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Andreas=20Faerber=20<andreas.faerber@web.de>=0A=
Date:=20Mon,=2025=20Aug=202008=2017:33:03=20+0200=0ASubject:=20[PATCH]=20=
Makefile:=20always=20provide=20a=20fallback=20when=20hardlinks=20fail=0A=
MIME-Version:=201.0=0AContent-Type:=20text/plain;=20charset=3Dutf-8=0A=
Content-Transfer-Encoding:=208bit=0A=0AWe=20make=20hardlinks=20from=20=
"git"=20to=20"git-<cmd>"=20built-ins=20and=20have=20been=0Acareful=20to=20=
avoid=20cross-device=20links=20when=20linking=20"git-<cmd>"=20to=20=
gitexecdir.=0A=0AHowever,=20we=20were=20not=20prepared=20to=20deal=20=
with=20a=20build=20directory=20that=20is=0Aincapable=20of=20making=20=
hard=20links=20within=20itself.=20This=20patch=20corrects=20it.=0A=0A=
Instead=20of=20temporarily=20linking=20"git"=20to=20gitexecdir,=20=
directly=20link=20"git-add",=0Afalling=20back=20to=20"cp".=20Try=20=
hardlinking=20that=20as=20"git-<cmd>",=20falling=20back=0Ato=20symlinks=20=
or=20"cp"=20on=20error.=0A=0AWhile=20at=20it,=20avoid=20100+=20error=20=
messages=20from=20hardlink=20failures=20when=20we=20are=0Agoing=20to=20=
fall=20back=20to=20symlinks=20or=20"cp"=20by=20redirecting=20the=20=
standard=20error=0Ato=20/dev/null.=0A=0ASigned-off-by:=20Andreas=20=
F=C3=A4rber=20<andreas.faerber@web.de>=0A---=0A=20Makefile=20|=20=20=20=
22=20+++++++++++-----------=0A=201=20files=20changed,=2011=20=
insertions(+),=2011=20deletions(-)=0A=0Adiff=20--git=20a/Makefile=20=
b/Makefile=0Aindex=207a6cbb6..fb4863c=20100644=0A---=20a/Makefile=0A+++=20=
b/Makefile=0A@@=20-1110,7=20+1110,10=20@@=20help.o:=20help.c=20=
common-cmds.h=20GIT-CFLAGS=0A=20=09=09'-DGIT_INFO_PATH=3D"$(infodir_SQ)"'=20=
$<=0A=20=0A=20$(BUILT_INS):=20git$X=0A-=09$(QUIET_BUILT_IN)$(RM)=20$@=20=
&&=20ln=20git$X=20$@=0A+=09$(QUIET_BUILT_IN)$(RM)=20$@=20&&=20\=0A+=09ln=20=
git$X=20$@=202>/dev/null=20||=20\=0A+=09ln=20-s=20git$X=20$@=20=
2>/dev/null=20||=20\=0A+=09cp=20git$X=20$@=0A=20=0A=20common-cmds.h:=20=
./generate-cmdlist.sh=20command-list.txt=0A=20=0A@@=20-1371,16=20=
+1374,13=20@@=20ifneq=20(,$X)=0A=20endif=0A=20=09bindir=3D$$(cd=20=
'$(DESTDIR_SQ)$(bindir_SQ)'=20&&=20pwd)=20&&=20\=0A=20=09execdir=3D$$(cd=20=
'$(DESTDIR_SQ)$(gitexec_instdir_SQ)'=20&&=20pwd)=20&&=20\=0A-=09if=20=
test=20"z$$bindir"=20!=3D=20"z$$execdir";=20\=0A-=09then=20\=0A-=09=09ln=20=
-f=20"$$bindir/git$X"=20"$$execdir/git$X"=20||=20\=0A-=09=09cp=20=
"$$bindir/git$X"=20"$$execdir/git$X";=20\=0A-=09fi=20&&=20\=0A-=09{=20=
$(foreach=20p,$(BUILT_INS),=20$(RM)=20"$$execdir/$p"=20&&=20ln=20=
"$$execdir/git$X"=20"$$execdir/$p"=20;)=20}=20&&=20\=0A-=09if=20test=20=
"z$$bindir"=20!=3D=20"z$$execdir";=20\=0A-=09then=20\=0A-=09=09$(RM)=20=
"$$execdir/git$X";=20\=0A-=09fi=20&&=20\=0A+=09{=20$(RM)=20=
"$$execdir/git-add$X"=20&&=20\=0A+=09=09ln=20git-add$X=20=
"$$execdir/git-add$X"=202>/dev/null=20||=20\=0A+=09=09cp=20git-add$X=20=
"$$execdir/git-add$X";=20}=20&&=20\=0A+=09{=20$(foreach=20p,$(patsubst=20=
git-add,,$(BUILT_INS)),=20$(RM)=20"$$execdir/$p"=20&&=20\=0A+=09=09ln=20=
"$$execdir/git-add$X"=20"$$execdir/$p"=202>/dev/null=20||=20\=0A+=09=09=
ln=20-s=20"$$execdir/git-add$X"=20"$$execdir/$p"=202>/dev/null=20||=20\=0A=
+=09=09cp=20"$$execdir/git-add$X"=20"$$execdir/$p"=20||=20exit;)=20}=20=
&&=20\=0A=20=09./check_bindir=20"z$$bindir"=20"z$$execdir"=20=
"$$bindir/git-add$X"=0A=20=0A=20install-doc:=0A--=20=0A1.6.0.1.91.gaea6=0A=
=0A=

--Apple-Mail-17-853573048
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit




--Apple-Mail-17-853573048--
