From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 1 Feb 2013 01:36:38 -0500
Message-ID: <20130201063638.GD29973@sigill.intra.peff.net>
References: <15540714.372461359682286477.JavaMail.weblogic@epml08>
 <7vmwvodd71.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jongman.heo@samsung.com, Thomas Rast <trast@student.ethz.ch>,
	git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 07:37:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1AFJ-0007Z7-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 07:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab3BAGgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2013 01:36:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55209 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab3BAGgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 01:36:42 -0500
Received: (qmail 18576 invoked by uid 107); 1 Feb 2013 06:38:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 01:38:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 01:36:38 -0500
Content-Disposition: inline
In-Reply-To: <7vmwvodd71.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215211>

On Thu, Jan 31, 2013 at 05:40:02PM -0800, Junio C Hamano wrote:

> =ED=97=88=EC=A2=85=EB=A7=8C <jongman.heo@samsung.com> writes:
>=20
> > But usually when I build upstream Linux kernel, I don't do "make
> > clean" after git pull..  I didn't expect that I needed "make
> > clean" for git build.
>=20
> We don't expect anybody need "make clean", either.  There is
> something wrong in the dependency.

Agreed, but I cannot see what. If auto-header-dependencies is on, gcc
should find it (it is not even a recursive dependency for
builtin/fetch.c). And if it is not on, we should rebuild based on LIB_H=
,
which includes string-list.h (and always has, as far as I can tell).

Hmm. I do notice one oddity with the computed header dependencies,
though. We build the computed dependency files as a side effect of doin=
g
the actual compilation. So before we have run the compilation once, we
need some way to say "you _must_ build this, because we do even know th=
e
correct dependencies".  And to do that, we have each object file depend
on any missing .depend dirs, which bootstraps the whole process: we
build everything the first time because .depend is missing, and from
then on, we use the correct dependencies.

But that is not quite right. The .depend directory might exist, but be
missing the actual dependency file for a particular object. So if I do:

  $ make ;# builds all objects and dependency files
  $ rm builtin/.depend/fetch.o.d
  $ touch string-list.h
  $ make

we will fail to rebuild builtin/fetch.o properly. It does not see the
dependency on string-list (because we have no .d file), nor does it
realize that it needs to build the .d file (because it only checks that
builtin/.depend exists).

It seems like building each object file should depend on its dependency
file (but only when COMPUTE_HEADER_DEPENDENCIES is on, of course), sinc=
e
otherwise we cannot know if we have the right dependencies or not.

Something like this almost works, I think:

diff --git a/Makefile b/Makefile
index 6b42f66..a329736 100644
--- a/Makefile
+++ b/Makefile
@@ -1843,8 +1843,8 @@ missing_dep_dirs :=3D $(filter-out $(wildcard $(d=
ep_dirs)),$(dep_dirs))
 	@mkdir -p $@
=20
 missing_dep_dirs :=3D $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs)=
)
-dep_file =3D $(dir $@).depend/$(notdir $@).d
-dep_args =3D -MF $(dep_file) -MMD -MP
+dep_file =3D $(dir $1).depend/$(notdir $1).d
+dep_args =3D -MF $(call dep_file, $@) -MMD -MP
 ifdef CHECK_HEADER_DEPENDENCIES
 $(error cannot compute header dependencies outside a normal build. \
 Please unset CHECK_HEADER_DEPENDENCIES and try again)
@@ -1909,9 +1909,9 @@ $(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
 endif
=20
 ifndef CHECK_HEADER_DEPENDENCIES
-$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs)
+$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(call dep_file, %.o=
)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAG=
S) $<
-$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs)
+$(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(call dep_file,%.=
o)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAG=
S) $<
 endif
=20

But not quite. The problem is that we put the dep file for foo/bar.o
into foo/.depend/bar.o. But when we call the dep_file function for the
dependency, it sees only "%.o", not "foo/bar.o", so it can't properly
split it apart. I don't think there is a way to force expansion before
calling the function.

And of course I have no idea if this was the problem that we saw,
anyway. I have no idea how one would get into this situation short of
manually removing the dependency file.

-Peff
