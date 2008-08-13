From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch for NO_R_TO_GCC_LINKER
Date: Wed, 13 Aug 2008 15:12:34 -0700
Message-ID: <7vbpzwlg31.fsf@gitster.siamese.dyndns.org>
References: <c475e2e60808130342r452fae1cm7d08d8d2206d0468@mail.gmail.com>
 <7vy730n0ac.fsf@gitster.siamese.dyndns.org>
 <c475e2e60808131420h5b7350abq188b3f8a53b51d98@mail.gmail.com>
 <7vhc9olh4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Giovanni Funchal" <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 00:13:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTObL-000362-AW
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 00:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbYHMWMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYHMWMm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 18:12:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbYHMWMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 18:12:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DBD4958F4E;
	Wed, 13 Aug 2008 18:12:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9169358F4D; Wed, 13 Aug 2008 18:12:36 -0400 (EDT)
In-Reply-To: <7vhc9olh4n.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 13 Aug 2008 14:50:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F211E81E-6984-11DD-B4F5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92285>

Junio C Hamano <gitster@pobox.com> writes:

> "Giovanni Funchal" <gafunchal@gmail.com> writes:
>
>> My changes should not break a lot of people's setups. Most people will
>> find the new default better because it works straight on
>> linux/windows.
>
> My understanding is that Linux/Windows people won't be using
> NO_R_TO_GCC_LINKER.  What I was afraid of breaking was people who have
> their own config.mak (which is included by Makefile) to customize the way
> the linkage works, setting NO_R_TO_GCC_LINKER appropriately.  Doesn't your
> change to the Makefile in a way not to pay attention to the variable break
> them?

In other words, wouldn't a patch like this (based on your change to
configure.ac, but I only hacked autoconf in very distant past so the
details may be wrong) be with much less impact to existing users and
achieve the same autodetection that configure.ac currently does not do?

I am not sure about another aspect of your change, which changes the use
of "-Wl,-rpath=$(path)" to "-Wl,-rpath,$(path)".  If both of them always
work (or neither of them and -R works), that would be great.  Otherwise,
if we need to detect one platform that accepts only -Wl,-rpath,$(path) and
other ones that accept only -Wl,-rpath=$(path), then it would make more
sense to check them separately in configure.ac, and override CC_LD_DYNPATH
directly, in which case Makefile needs to be modified as well.

 config.mak.in |    1 +
 configure.ac  |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index b776149..c079864 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -7,6 +7,7 @@ AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH = @TCLTK_PATH@
+NO_R_TO_GCC_LINKER = @no_r_to_gcc_linker@
 
 prefix = @prefix@
 exec_prefix = @exec_prefix@
diff --git a/configure.ac b/configure.ac
index 7c2856e..a23a7f6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,6 +103,28 @@ GIT_PARSE_WITH(tcltk))
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
+# which switch to pass runtime path to dynamic libraries to the linker
+AC_CACHE_CHECK([if linker supports -R], ld_dashr, [
+   SAVE_LDFLAGS="${LDFLAGS}"
+   LDFLAGS="${SAVE_LDFLAGS} -R /"
+   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_dashr=yes], [ld_dashr=no])
+   LDFLAGS="${SAVE_LDFLAGS}"
+])
+if test "$ld_dashr" = "yes"; then
+   AC_SUBST(no_r_to_gcc_linker, [ ])
+else
+   AC_CACHE_CHECK([if linker supports -Wl,rpath,], ld_wl_rpath, [
+      SAVE_LDFLAGS="${LDFLAGS}"
+      LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
+      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_wl_rpath=yes], [ld_wl_rpath=no])
+      LDFLAGS="${SAVE_LD_FLAGS}"
+   ])
+   if test "$ld_wl_rpath" = "yes"; then
+      AC_SUBST(no_r_to_gcc_linker, [YesPlease])
+   else
+      AC_MSG_ERROR([no linker support for runtime path to dynamic libraries])
+   fi
+fi
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
