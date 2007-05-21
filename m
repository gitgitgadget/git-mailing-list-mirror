From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 21:54:48 +0200
Message-ID: <4651F908.2000608@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <46502EF7.6000708@lsrfire.ath.cx> <20070521060231.GI3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 21:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqDzB-0000Z2-W4
	for gcvg-git@gmane.org; Mon, 21 May 2007 21:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935872AbXEUTzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 15:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935560AbXEUTzk
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 15:55:40 -0400
Received: from main.gmane.org ([80.91.229.2]:43173 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935863AbXEUTzj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 15:55:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HqDyP-0003n5-Ms
	for git@vger.kernel.org; Mon, 21 May 2007 21:55:20 +0200
Received: from p508e6609.dip.t-dialin.net ([80.142.102.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 May 2007 21:55:17 +0200
Received: from rene.scharfe by p508e6609.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 May 2007 21:55:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508e6609.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070521060231.GI3141@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48044>

Shawn O. Pearce schrieb:
> Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>> Shawn O. Pearce schrieb:
>>> git-describe is more human-friendly than a SHA-1...
>> Yes, and the Makefile does even more than that: it adds a version fi=
le,
>> a spec file and another version file for git-gui.
>>
>> The first two are probably useful for most projects that actually do
>> versioned releases.  We could have a simple parser that reads a
>> template, replaces @@VERSION@@ with a git-describe output string and
>> adds the result as a synthetic file to the archive.  It's not exactl=
y
>> trivial -- e.g., how to specify git-describe options, template file =
and
>> synthetic name, all in one command line parameter? -- but it's doabl=
e.
>=20
> Maybe something just as simple as allowing the user to specify a
> shell script in-tree that we unpack and run for them?  That script
> prints to stdout the content of the file to include.

I doubt executing a shell script is simple. :-D  You'd possibly get
different results on different platforms (dare I mention Windows?).

The template system I mentioned would be a kind of scripting language
itself, but in this case we define its syntax and can guarantee
consistency everywhere git runs.  And since it would only have four
types of tokens (@@VERSION@@, @@COMMITID@@, @@@@ and string literals) i=
t
could be fast and simple.

We could implement it as a checkout converter, preferably one that is
only applied by git-archive.  Then we'd rename git.spec.in to git.spec,
assign the "specfile" attribute to it and let git-archive replace the
string @@VERSION@@ with git-describe's output.  git-checkout would not
expand the special strings, so you can simply edit and version the file
as you can do with git.spec.in now.  Michael would have a file
containing only @@COMMITID@@ to solve his original problem.  Make sense=
?

> So now we're also really talking about, what should git-archive
> do for a subproject?  Sometimes you really do want to repackage
> and redistribute the subproject as part of the superproject's
> tarball. Sometimes you don't.  I think in the case of git.git and
> git-gui.git we want to include the subproject.  ;-)

Oh, yes, subprojects.  git-archive currently exports them as empty
directories.  Using tar's append command you could simply build the
project+subproject archive in the Makefile.  That wouldn't work well
with gitweb, though.  Perhaps a --include-subproject=3D<path> option is
needed?

Ren=E9
