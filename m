From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] t3404 & t3411: undo copy&paste
Date: Tue, 27 Jan 2009 22:57:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272254450.14855@racer>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com> <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901271845380.3586@pacific.mpi-cbg.de>
 <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 22:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRvx4-00078B-5v
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 22:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbZA0V5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 16:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbZA0V5H
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 16:57:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:42755 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753939AbZA0V5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 16:57:05 -0500
Received: (qmail invoked by alias); 27 Jan 2009 21:57:02 -0000
Received: from pD9EB30BF.dip0.t-ipconnect.de (EHLO noname) [217.235.48.191]
  by mail.gmx.net (mp003) with SMTP; 27 Jan 2009 22:57:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3u3QNZa/3T2Skc6sgwEAYLS8wu/heNMZzascVim
	1OlHy5NIO8Eo/a
X-X-Sender: gene099@racer
In-Reply-To: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107392>

Hi,

On Tue, 27 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Rather than copying and pasting, which is prone to lead to fixes
> > missing in one version, move the fake-editor generator to t/t3404/.
> >
> > While at it, fix a typo that causes head-scratching: use
> > ${SHELL_PATH-/bin/sh} instead of $SHELL_PATH.
> 
> I've learned to be cautious whenever I see "while at it".

Heh.

> > diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> > new file mode 100644
> > index 0000000..8c8caab
> > --- /dev/null
> > +++ b/t/lib-rebase.sh
> > @@ -0,0 +1,36 @@
> > +#!/bin/sh
> > +
> > +set_fake_editor () {
> > +	echo "#!${SHELL_PATH-/bin_sh}" >fake-editor.sh
> 
> It is unclear why you would want to do this.  It was unclear what "typo"
> you were referring to in your commit log message, either.
> 
> The tests are supposed to run under the shell the user specified, so if
> there is a case you found that $SHELL_PATH is unset, that is a bug we
> would want to fix, and ${SHELL_PATH-/bin/sh} is sweeping the problem under
> the rug to make it harder to fix, isn't it?

I call the scripts directly, and I do not think it would be a good idea to 
force the user to use GIT_TEST_OPTS and make when calling the script 
directly is so much easier.  Plus, this way I can pass "sh -x $SCRIPT" 
easily.

I am really puzzled that it works, BTW.  With an empty SHELL_PATH, 
apparently.

> Besides, it's /bin/sh, not /bin_sh ;-)

Right.  The commit message was right, at least!

> > +	cat >> fake-editor.sh <<\EOF
> > +case "$1" in
> > +*/COMMIT_EDITMSG)
> > +	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
> > +	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
> > +	exit
> > +	;;
> > +esac
> > +test -z "$EXPECT_COUNT" ||
> > +	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
> > +	exit
> > +test -z "$FAKE_LINES" && exit
> > +grep -v '^#' < "$1" > "$1".tmp
> > +rm -f "$1"
> > +cat "$1".tmp
> > +action=pick
> > +for line in $FAKE_LINES; do
> > +	case $line in
> > +	squash|edit)
> > +		action="$line";;
> > +	*)
> > +		echo sed -n "${line}s/^pick/$action/p"
> > +		sed -n "${line}p" < "$1".tmp
> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
> 
> I looked at the output from this and wondered what these "sed -n" shown 
> in the "-v" output were about last night.  I do think it is a good idea 
> to show what edit was done to the insn stream, but I suspect it may be 
> easier to read the output if you did this instead:
> 
> > +		sed -n "${line}p" < "$1".tmp
> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
> > +		sed -n "${line}s/^pick/$action/p" < "$1".tmp


Probably.  It is for debugging, anyway.  As everything you only see with 
-v.

Ciao,
Dscho
