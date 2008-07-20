From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Sun, 20 Jul 2008 15:55:58 -0700
Message-ID: <7vhcak2mip.fsf@gitster.siamese.dyndns.org>
References: <200807202111.48332.johannes.sixt@telecom.at>
 <200807202334.36506.johannes.sixt@telecom.at>
 <7vzloc2odx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhq0-00025R-3J
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYGTW4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYGTW4F
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:56:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYGTW4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:56:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 581AD37C1B;
	Sun, 20 Jul 2008 18:56:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9BBDD37C1A; Sun, 20 Jul 2008 18:56:00 -0400 (EDT)
In-Reply-To: <7vzloc2odx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jul 2008 15:15:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07587848-56AF-11DD-8AA6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89255>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
>
>> On Sonntag, 20. Juli 2008, Johannes Sixt wrote:
>>> -git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o
>>> strbuf.o usage.o wrapper.o shell.o
>>> +git-shell$X: abspath.o ctype.o 
>>> exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o $(COMPAT_OBJS)
>>
>> Unfortunately, that's only half the deal. If we compile with NO_PREAD=1, this 
>> needs read_in_full(),...
>
> Well, if compat/* implementations use anything outside compat/ left and
> right, then all bets are off.

If compat/ layer tries to really be about "compatibility", they should not
be using things like xmalloc() that call release_pack_meory() that is in
sha1_file.c.  From a quick glance, mingw.c, mmap.c, pread.c are major
offenders, but others such as setenv.c seem to be carefully written.

Perhaps we should apply a variant of your patch to allow linking from
compat/ routines to git-shell, so that people affected by the compat layer
functions that call outside compat layer have incentive to fix them.

 Makefile |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2b670d7..551bde9 100644
--- a/Makefile
+++ b/Makefile
@@ -324,6 +324,7 @@ endif
 export PERL_PATH
 
 LIB_FILE=libgit.a
+COMPAT_LIB = compat/lib.a
 XDIFF_LIB=xdiff/lib.a
 
 LIB_H += archive.h
@@ -1203,8 +1204,11 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)
+$(COMPAT_LIB): $(COMPAT_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(COMPAT_OBJS)
+
+git-shell$X: abspath.o ctype.o exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o $(COMPAT_LIB)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(COMPAT_LIB)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
@@ -1402,7 +1406,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		$(LIB_FILE) $(XDIFF_LIB)
+		$(LIB_FILE) $(XDIFF_LIB) $(COMPAT_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
