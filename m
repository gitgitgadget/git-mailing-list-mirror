From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: git on HP NonStop
Date: Wed, 22 Aug 2012 18:38:09 +0200
Message-ID: <002b01cd8084$8459abc0$8d0d0340$@schmitz-digital.de>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr> <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de> <503217F2.5070105@viscovery.net> <7vfw7hle6l.fsf@alter.siamese.dyndns.org> <001901cd7f15$98c6ab50$ca5401f0$@schmitz-digital.de> <7vy5l9f186.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Johannes Sixt'" <j.sixt@viscovery.net>,
	"'Jan Engelhardt'" <jengelh@inai.de>, <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Dws-0007Hm-5g
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab2HVQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:38:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51010 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab2HVQiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:38:21 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lu2Cs-1TlufB1KEw-011UT5; Wed, 22 Aug 2012 18:38:16 +0200
In-Reply-To: <7vy5l9f186.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHB61oVp3im4Dlw7d/lKpMa4E4AEgJhlvNkAetPHqoCQtTARwHvED+rAsdKdxQC5ubl3QG7ob31Al/IT/2W6u0BsA==
Content-Language: de
X-Provags-ID: V02:K0:ypx2p4YJgg93Sx8nzVvssy+qL/3LJOLs4TdrMsyQaR9
 TifFtMCyhSw3hY+L0gMPUv8XwJT4F6jbxgg5l/+E5DyTnkGKH2
 LnOno2Rh5+TeOcKRDwgHPNELceRYMuXhey+Vkvw+LTFS7vijbO
 PAWYi7UG2gqqbMleJzkSaJIUkqVSy8FZO4fMTV8SFeUeJ9brTB
 6NRtiQYtSHbVZTj5FzfnIi+y32DLEhM4M2liFRJEUHR+NHojGF
 6rS6xUyzdna3dYK6p5t/nCxboXicxci3ENSV6CDJG03WZtKsrl
 oDgs41I/OXNK8y+QKQkKR71LtTMBmGoxGReI378xKZsE8GUx9Z
 zUXcbEPripZfoaU1ea17eO3TzyyrlNnNu8izaj4nGwOrbP5+k9
 9L1OeEWJdQFhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204027>



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, August 21, 2012 4:06 AM
> To: Joachim Schmitz
> Cc: 'Johannes Sixt'; 'Jan Engelhardt'; git@vger.kernel.org
> Subject: Re: git on HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > OK, so let's have a look at code, current git, builtin/cat-file.c,
> > line 196:
> >         void *contents = contents;
> >
> > This variable is set later in an if branch (if (print_contents ==
> > BATCH), but not in the else branch. It is later used always under the
> > same condition as the one under which it is set.
> > Apparently is is malloc_d storage (there a "free(content);"), so
> > there's no harm al all in initializing it with NULL, even if it only
> > appeases a stupid compiler.
> 
> It actually is harmful.  See below.

Harmful to initialize with NULL or to use that undefined behavoir?

I checked what our compiler does here: after having warned about "vlues us
used before it is set: it actually dies seem to have initializes the value
to 0 resp. NULL.
So here there's no harm done in avoiding undefined behavior and set it to 0
resp NULL in the first place.

> > The next one, builtin/fast-export.c, line 486:
> >                 struct commit *commit = commit; it is set in a switch
> > statement, but not in every case, as far as I can see.
> > Hmm, maybe it is, and I just get lost in the code And it is used
> > directly after the switch, hopefully set to something reasonable.
> > Why take the risk and not set it to NULL?
> 
> Ditto.
> 
> > Next one, builtin/rev-list.c, line 390:
> >                 int reaches = reaches, all = all;
> >
> >                 revs.commits = find_bisection(revs.commits, &reaches,
&all,
> >                                               bisect_find_all);
> >
> > Seem pretty pointless to initialize them, provided find_bisection
> > doesn't read them. Does it?
> 
> That is why they are not initializations but marks to the compiler to
signal "you
> may be stupid enough to think they are used before initialized or
assigned, but
> that is not the case".  Initializing them would be pointless.
> 
> > Next one, fast-import.c, line 2268:
> >         struct object_entry *oe = oe;
> >
> > os gets set in en if and an else branch, but not in then intermediate
> > else if branch!
> 
> Look again.  If the recent code is too complex for you to understand, go
back to
> 10e8d68 (Correct compiler warnings in fast-import., 2007-02-06) and read
the
> function.
> 
> The control flow of the early part of that function dictates that either
oe is
> assigned *or* inline_data is set to 1.  When inline_data is false, oe is
always
> set.
> 
> The compiler was too stupid to read that, and that is why the
> (confusing) idiom to mark it for the stupid compiler was used.
> 
> There are a few reasons why I do not think this self-assignment idiom or
> initializing the variable to an innocuous-looking random value is a
particularly
> good thing to do when you see compiler warnings.
> 
> If the compiler suspects the variable might be unused, you should always
look
> at it and follow the flow yourself.  Once you know it is a false alarm,
you can
> use the idiom to squelch the warning, and it at the same serves as a note
to
> others that you verified the flow and made sure it is a false warning.
> 
> When the next person wants to touch the code, if the person knows the use
of
> the idiom, it only serves as a warning to be extra careful not to
introduce a new
> codepath that reads the variable without setting, as the compiler no
longer
> helps him.  If the person who touches the code is as clueless as the
compiler
> and cannot follow the codepath to see the variable is never used
uninitialized,
> the result will be a lot worse.
> 
> That is the reason why I do not think the idiom to squelch the compiler is
such a
> good thing.  Careless people touch the code, so "oe = oe" initialization
carefully
> placed in the original version does not necessarily stay as a useful
> documentation.
> 
> But if you use "oe = NULL" as a way to squelch the warning in the first
place, it
> is no better than "oe = oe".  In a sense, it is even worse, as it just
looks like any
> other initialization and gives a false impression that the remainder of
the code
> is written in such a way that it tolerates oe being NULL in any codepath,
or
> there is some assignment before that before the code reaches places where
oe
> cannot be NULL.  That is different from what "oe = oe" initializaion
documents--
> -in the codepath protected by "if (inline_data)", it isn't just "oe can
safely be
> NULL there"; instead it is "oe can safely be *any* value there, because we
don't
> use it".  Of course, if you explicitly initialized oe to NULL, even if you
introduce
> a codepath where oe cannot be NULL later, you won't get a warning from the
> compiler, so it is no better than "oe = oe".
> 
> And that is the reason why I do not think initialization to an
innocuous-looking
> random value (e.g. NULL) is a good answer, either.
> 
> When both are not good, replacing "oe = oe" with "oe = NULL" didn't make
> much sense, especially when the former _could_ be used better by more
> careful people.  And that is the resistance J6t remembers.
> 
> But when recent compilers started to warn "oe = oe" that itself is
undefined,
> the equation changed.  The idiom ceased to be a way to squelch the
incorrect
> compiler warning (which was the primary point of its use---the
documentation
> value is secondary, as what we document is "we are squelching a false
alarm",
> but we no longer are squelching anything).
> 
> See 4a5de8d (vcs-svn: avoid self-assignment in dummy initialization of
pre_off,
> 2012-06-01), and 58ebd98 (vcs-svn/svndiff.c: squelch false "unused"
warning
> from gcc, 2012-01-27) that it updated, for an example of how we are
migrating
> away from "oe = oe" idiom.
> 
> In any case, I already said initializing to 0 is OK in my previous
message, I think,
> so if you are seeing warning from the compiler on uninitialized variables
in
> your new code, you know you should
> 
>  (1) first follow the codepath to make sure it is a false alarm (if
>      it isn't, fix the code);
> 
>  (2) then see if you can simplify your code so that it is crystal
>      clear even to the stupid compiler that you are not using an
>      uninitialized variable; and
> 
>  (3) if you can't, then initialize it to some known bad value,
>      avoiding the "oe = oe" idiom.
> 
> Is there anything more to discuss on this topic?

Which of the ones I told you about should get fixed?

Bye, Jojo
