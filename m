From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed
Date: Sun, 22 Jan 2012 23:17:10 +0400
Organization: St.Petersburg State University
Message-ID: <20120122191710.GA17366@mini.zxlink>
References: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru>
 <7v8vl3ic6o.fsf@alter.siamese.dyndns.org>
 <20120120063450.GA15371@mini.zxlink>
 <7vbopyhmlx.fsf@alter.siamese.dyndns.org>
 <20120120071936.GA22112@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Sun Jan 22 20:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp2tl-0007Fa-HX
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 20:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2AVTQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 14:16:13 -0500
Received: from forward11.mail.yandex.net ([95.108.130.93]:41515 "EHLO
	forward11.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab2AVTQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 14:16:12 -0500
Received: from smtp13.mail.yandex.net (smtp13.mail.yandex.net [95.108.130.68])
	by forward11.mail.yandex.net (Yandex) with ESMTP id 81BB7E81492;
	Sun, 22 Jan 2012 23:16:08 +0400 (MSK)
Received: from smtp13.mail.yandex.net (localhost [127.0.0.1])
	by smtp13.mail.yandex.net (Yandex) with ESMTP id 5D9C6E403E1;
	Sun, 22 Jan 2012 23:16:08 +0400 (MSK)
Received: from unknown (unknown [83.171.93.24])
	by smtp13.mail.yandex.net (nwsmtp/Yandex) with ESMTP id G7LeNWIp-G8LeeTCP;
	Sun, 22 Jan 2012 23:16:08 +0400
X-Yandex-Spam: 1
Received: from kirr by mini.zxlink with local (Exim 4.77)
	(envelope-from <kirr@mini.zxlink>)
	id 1Rp2uc-0003Zx-Ny; Sun, 22 Jan 2012 23:17:10 +0400
Content-Disposition: inline
In-Reply-To: <20120120071936.GA22112@mini.zxlink>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188970>

On Fri, Jan 20, 2012 at 11:19:36AM +0400, Kirill Smelkov wrote:
> On Thu, Jan 19, 2012 at 11:14:18PM -0800, Junio C Hamano wrote:
> > Kirill Smelkov <kirr@navytux.spb.ru> writes:
> > 
> > >> I do not necessarily buy your "so we HAVE TO, OR ELSE".
> > >> 
> > >> Even though I can understand "We can sort the list of tests _if_ we do not
> > >> want them executed in seemingly random order when running 'make -j1'", I
> > >> tend to think that *if* is a big one.  Aren't these tests designed not to
> > >> depend on each other anyway?
> > >
> > > Yes, they don't depend on each other, but what's the point in not
> > > sorting them? I usually watch test progress visually, and if tests are
> > > sorted, even with make -j4 they go more or less incrementally by their t
> > > number.
> > >
> > > On my netbook, adding $(sort ...) adds approximately 0.008s to make
> > > startup, so imho there is no performance penalty to adding that sort.
> > 
> > Heh, who said anything about performance?
> > 
> > I was pointing out that your justification "we HAVE TO" was wrong.
> > 
> > If you are doing this for perceived prettyness and not as a fix for any
> > correctness issue, I want to see the patch honestly described as such;
> > that's all.
> 
> I agree about rewording.
> 
> 
> > By the way, if I recall correctly, $(sort) in GNU make not just sorts but
> > as a nice side effect removes duplicates. So if we used a(n fictional)
> > construct in our Makefile like this:
> > 
> >     T = $(wildcard *.sh a.*)
> > 
> > that might produce duplicates (i.e. "a.sh" might appear twice), which
> > might leave us two identical pathnames in $T and cause us trouble.  Even
> > if we do not have such a use currently, rewriting $(wildcard) like your
> > patch does using $(sort $(wildcard ...)) may be a good way to future-proof
> > our Makefile, and if you justify your patch that way, it would be a
> > possible correctness hardening, not just cosmetics, and phrasing it with
> > "HAVE TO" may be justifiable.
> > 
> > Care to try if $(wildcard *.sh a.*) give you duplicated output with newer
> > GNU make? I am lazy but am a bit curious ;-)
> 
> Sure. Please give me time untill evening (GMT+0400), or maybe till the
> weekend.

Hello up there again. You are actually right about sort also working as uniq,
e.g. for the following Makefile

	T	:= $(wildcard *.sh a.*)
	$(info "T      : $T")
	$(info "sort(T): $(sort $T)")
	$(error 1)

I'm getting duplicates for a.sh and $(sort) removes it

	$ ls
	0.sh  a.sh  b.sh  c.sh  Makefile
	
	$ make -v |head -1
	GNU Make 3.82.90
	
	$ make	#           v         v
	"T      : 0.sh c.sh a.sh b.sh a.sh"
	"sort(T): 0.sh a.sh b.sh c.sh"
	Makefile:4: *** 1.  Stop.


BUT for older make the duplicate is there too:

	$ /usr/bin/make -v | head -1
	GNU Make 3.81				# this one has its base from 2006

	$ /usr/bin/make # v           v
	"T      : 0.sh a.sh b.sh c.sh a.sh"
	"sort(T): 0.sh a.sh b.sh c.sh"
	Makefile:4: *** 1.  Stop.


so yes earlier $(wildcard) sorted the result and no, it sorted it not globally,
but separately for each pattern, so in presence of multiple pattern one could
not rely on implicit auto-uniq even for older make.

If we'd like to protect ourselves from duplicates, the sort should be there for
all makes.


Updated patch follows (sorry for my bad english, I'm too sleepy to get this
into shape even by mine standards...)

---- 8< ----
From: Kirill Smelkov <kirr@navytux.spb.ru>
Date: Sun, 4 Sep 2011 00:41:21 +0400
Subject: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed

Starting from GNU Make 3.82 $(wildcard ...) no longer sorts the result
(from NEWS):

    * WARNING: Backward-incompatibility!
      Wildcards were not documented as returning sorted values, but the results
      have been sorted up until this release..  If your makefiles require sorted
      results from wildcard expansions, use the $(sort ...)  function to request
      it explicitly.

    http://repo.or.cz/w/make.git/commitdiff/2a59dc32aaf0681dec569f32a9d7ab88a379d34f

I usually watch test progress visually, and if tests are sorted, even
with make -j4 they go more or less incrementally by their t number. On
the other side, without sorting, tests are executed in seemingly random
order even for -j1. Let's please maintain sane tests order for perceived
prettyness.


Another note is that in GNU Make sort also works as uniq, so after sort
being removed, we might expect e.g. $(wildcard *.sh a.*) to produce
duplicates for e.g. "a.sh". From this point of view, adding sort could
be seen as hardening t/Makefile from accidentally introduced dups.

It turned out that prevous releases of GNU Make did not perform full
sort in $(wildcard), only sorting results for each pattern, that's why
explicit sort-as-uniq is relevant even for older makes.

Signed-off-by: Kirill Smelkov <kirr@navytux.spb.ru>
---
 t/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 9046ec9..66ceefe 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,9 +17,9 @@ DEFAULT_TEST_TARGET ?= test
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
-T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
-TSVN = $(wildcard t91[0-9][0-9]-*.sh)
-TGITWEB = $(wildcard t95[0-9][0-9]-*.sh)
+T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
+TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
+TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 
 all: $(DEFAULT_TEST_TARGET)
 
-- 
1.7.9.rc2.124.ge3180
