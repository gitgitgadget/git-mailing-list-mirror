From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Fri, 27 Jul 2007 21:54:22 -0700
Message-ID: <7vvec5uo01.fsf@assigned-by-dhcp.cox.net>
References: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
	<20070727170300.t01ku4u2sg04sgsk@webmail.tu-harburg.de>
	<18090.44123.905869.974967@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 06:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEeJw-0006w4-Np
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 06:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXG1EyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 00:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXG1EyY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 00:54:24 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65350 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbXG1EyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 00:54:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728045424.NAPY1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 00:54:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UsuN1X00J1kojtg0000000; Sat, 28 Jul 2007 00:54:22 -0400
In-Reply-To: <18090.44123.905869.974967@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 28 Jul 2007 12:39:23 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53992>

Paul Mackerras <paulus@samba.org> writes:

> Christian Stimming writes:
>
>> Similar to the discussion in git-gui, all user-visible strings are  
>> passed through the [mc ...] procedure to have them translated by msgcat.
>> 
>> Signed-off-by: Christian Stimming <stimming@tuhh.de>
>> ---
>> @Paul: Are you interested in applying this? If yes, I'd happily  
>
> Yes, it doesn't look too bad.  The patch seemed to be line-wrapped and
> whitespace-damaged, though.
>
>> provide the Makefile rules for string extraction and translation  
>> catalog updates, but I'd like to hear a proposal or decision on where  
>> to place them. Should the po files for translation go into the po/  
>> subdirectory? And then a proposal/decision of where to install the  
>> compiled .msg catalogs will be necessary.
>
> Yes indeed.  Junio?

Before talking about installation location, let me worry a bit
about integration.

This is a bit tricky because of the way gitk.git project was
absorbed in git.git repository.  Historically we have assumed
that gitk would always stay a single file project, but with
po/*.{po,msg} and gettext toolchain we would also need a
Makefile target or two for maintaining i18n infrastructure for
gitk.

I think we could do one of three things.

 1. In git.git, move the location gitk.git is absorbed one level
    down, to gitk/ subdirectory.  This can have two variants.

 1.a Your gitk.git repository could match this move; from being
     a single file project, it would become a single directory,
     gitk/, initially with a single file under it
     (i.e. gitk/gitk), and then i18n coordinator (Christian?)
     and i18n group would provide you with gitk/Makefile and
     gitk/po/*.po files.  I could just merge the result of such
     move without any trick if this happens;

 1.b Your gitk.git repository can stay in the current shape of
     having a single file gitk in it, with Makefile and po/*.po
     files supplied by the i18n group.  I would have to merge
     such a repository with subtree strategy just like I handle
     the absorption of git-gui.git project.

 2. Your gitk.git could stay without the actual i18n except the
    [mc ...] changes, and po/*.po and gettext toolchain calls
    can be directly be in git.git project.  In git.git, gitk
    would continue to be merged from you at the toplevel.

My preference is 1.b, as the longer term plan (when everybody
has git 1.5.2 or newer) is to eject git-gui.git project from
git.git proper, and use the subproject feature to have
git-gui.git in git.git; it would be good if gitk.git can be
handled the same way, and the layout 1.b would make it the
easiest, as it matches how we treat git-gui.git project now.

About the installation location, I would say we can mimick what
git-gui i18n team does and use $(sharedir)/gitk/lib/msgs to
install the message files.

> Is it possible to include the translations, or at least the more
> common translations, in the Tcl code itself?  So far I have managed to
> have gitk be self-contained, in that it doesn't need any external data
> files, which simplifies installation and is a useful attribute in some
> situations.

Anything is possible, but I think that is cumbersome to arrange
and probably wasteful at runtime.  You will end up carrying
lines of form:

	::msgcat::mcset xx "Origial" "Translation in language xx"

for all languages in the same gitk script.  Worse, these mcset
lines are not something translators directly work on; rather,
they are output of msgfmt program.

> Also I would want to be sure that gitk wouldn't crash or fail to
> function if it can't find its message catalogs.

You also expressed in a separate message about "catching package
require msgcat to avoid breakage".  I think msgcat package is
part of the standard Tcl distribution since 8.1; how old a
tcl/tk do you support?

In any case, I would very much appreciate if any of these will
*NOT* happen before 1.5.3.  git-gui 0.8.0 which is scheduled to
be in 1.5.3 will not have i18n.
