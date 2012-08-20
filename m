From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: git on HP NonStop
Date: Mon, 20 Aug 2012 22:51:38 +0200
Message-ID: <001901cd7f15$98c6ab50$ca5401f0$@schmitz-digital.de>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr> <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de> <503217F2.5070105@viscovery.net> <7vfw7hle6l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Jan Engelhardt'" <jengelh@inai.de>, <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Yx4-0007lA-GH
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 22:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab2HTUvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 16:51:51 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:63347 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab2HTUvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 16:51:49 -0400
Received: from DualCore (dsdf-4db55923.pool.mediaWays.net [77.181.89.35])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LoqDL-1TaAfV1lvP-00glBZ; Mon, 20 Aug 2012 22:51:42 +0200
In-Reply-To: <7vfw7hle6l.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHB61oVp3im4Dlw7d/lKpMa4E4AEgJhlvNkAetPHqoCQtTARwHvED+rAsdKdxQC5ubl3ZcI2i0A
Content-Language: de
X-Provags-ID: V02:K0:2qxe/I+kSmlSFrZn92Vi5UMUYjVGbyYUogiy0/KsTVm
 qDsTuVMvXhu9Ibck8GJIMTrU+rr845d86miiQ/nqQ9WwVA1bFG
 5ngKz7XaACQXncMRH82CRAcfuhNyH1W+9ILDcOjF910+YfBRl5
 wQqQKos9lLJA+izpHPi43nGgTnlBJa7i4z3IhJbU1dR1QBefst
 0LWYS9rNVP216NSWESLhym1FWJ7T+VJvNNs4jsaWIWRG8kz9pP
 e/Jt9qBRdk/iJPElJRek+90W/uMB03dVF9+UNYgmEVh/lIeMQF
 MPzh69jVerYppnRaSmOAt9M1CJqhXbrasrrfciXPAiG3WE0qXd
 U55WXzXsQ4lHlfdRZJpQu7QNMRvdihHXti71wghzyaAQAQmS+2
 UWczH5PtP2NfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203873>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, August 20, 2012 6:30 PM
> To: Johannes Sixt
> Cc: Joachim Schmitz; 'Jan Engelhardt'; git@vger.kernel.org
> Subject: Re: git on HP NonStop
> 
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Am 8/20/2012 12:36, schrieb Joachim Schmitz:
> >> int var = var;
> >> char *othervar = othervar;
> >>
> >> ...
> >>
> >> What is the reason for using that self-init stuff? I don't think it
> >> is really portable, is it?
> >
> > It is used to avoid "var may be used uninitialized" warnings for some
> > compilers. Officially (according to the C standard), it is undefined
> > behavior. But I've observed considerable resistance by Junio to fix
> > this properly.
> 
> I had resisted
> 
> 	-	int foo = foo;
>         +	int foo = 0;
> 
> in the past.  If some compiler is not seeing that "foo" is never used
uninitialized,
> such a compiler will generate an unnecessary initialization, so it is not
a
> _proper_ fix anyway (in fact, I do not think a proper fix exists, short of
> simplifying the code so that less sophisticated compilers can see that
"foo" is
> never used uninitialized).
> 
> So, no, I never resisted a "proper" fix.  I resisted swapping an
unsatisfactory
> workaround with another.
> 
> Between the two unsatisfactory workarounds, the latter (explicit and
> unnecessary assignment to an innocuous value) is lessor of two evils, so I
do not
> particularly mind it, though.  Indeed, I think more recent history shows
that we
> have such changes.

OK, so let's have a look at code, current git,
builtin/cat-file.c, line 196:
        void *contents = contents;

This variable is set later in an if branch (if (print_contents == BATCH),
but not in the else branch. It is later used always under the same condition
as the one under which it is set.
Apparently is is malloc_d storage (there a "free(content);"), so there's no
harm al all in initializing it with NULL, even if it only appeases a stupid
compiler.

The next one, builtin/fast-export.c, line 486:
                struct commit *commit = commit;
it is set in a switch statement, but not in every case, as far as I can see.
Hmm, maybe it is, and I just get lost in the code
And it is used directly after the switch, hopefully set to something
reasonable.
Why take the risk and not set it to NULL?

Next one, builtin/rev-list.c, line 390:
                int reaches = reaches, all = all;

                revs.commits = find_bisection(revs.commits, &reaches, &all,
                                              bisect_find_all);

Seem pretty pointless to initialize them, provided find_bisection doesn't
read them. Does it?
I'm too Next one, lazy to check... I'd just set them to 0 and stop worrying.

Next one, fast-import.c, line 2268:
        struct object_entry *oe = oe;

os gets set in en if and an else branch, but not in then intermediate else
if branch!
It is checked for !NULL later, so it should really get initialized to NULL
in the first place!

Same file, line 2437, same variable name, same story!
Same file, line 2616, variable e, it is used in an if branch but set after
that! 
Same file again, line 2917, variable oe again. Same story as above.

Next file, ll-merge.c, line
        static const struct ll_merge_options default_opts;
Somewhat different story here, compiler warning claims " const variable
"default_opts" requires an initializer"
Possible fix:
        static const struct ll_merge_options default_opts = {0};

next file, match-trees.c, line 75ff:
                const unsigned char *elem1 = elem1;
                const unsigned char *elem2 = elem2;
                const char *path1 = path1;
                const char *path2 = path2;
                unsigned mode1 = mode1;
                unsigned mode2 = mode2;
Some get set, some not, depending on code path, but all get used, with
possibly bogus content.

Next file, merge-recursive.c, line 1903:
        struct tree *mrtree = mrtree;
passed on my address to another function, which hopefully knows how to treat
it. It woult be learer and simpler to just have
        struct tree *mrtree = NULL;
wouldn't it?

Next file, run-command.c, line 272:
        int failed_errno = failed_errno;
Set deeply nested in some cases. Seems to be used reasonably, but again, why
take chanses= 0 is a goot errno ;-)

Next file, submodule.c, line 265:
        struct commit *left = left, *right = right;
As far as I can see it is not set properly before it gets used in some
cases.

Next filen, transport.c, line 106:
                int cmp = cmp, len;
I seem to see code paths whet it is used without being set properly

Next file, vcs-svn/svndiff.c, line 299.... oh, that one has been fixed and
initialized to -1.

Next (and last) file, wt-status.c, line 267:
        int status = status;
It apparently does get set properly before use. So here it once may once
again just make a compiler happy to set it to 0.

Bye, Jojo
