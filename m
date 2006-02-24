From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Fri, 24 Feb 2006 04:02:25 -0800
Message-ID: <20060224120225.GE12309@localdomain>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home> <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 13:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCbeZ-0007fi-Or
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 13:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWBXMC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 07:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBXMC2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 07:02:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:15756 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750796AbWBXMC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 07:02:28 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A33237DC005;
	Fri, 24 Feb 2006 04:02:25 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Feb 2006 04:02:25 -0800
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16696>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/21/06, Sam Vilain <sam@vilain.net> wrote:
> > Alex Riesen wrote:
> > >>>Does not work here (ActiveState Build 811, Perl 5.8.6):
> > >>>$ perl -e 'open(F, "-|")'
> > >>>'-' is not recognized as an internal or external command,
> > >>>operable program or batch file.
> > >>Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.
> > > Sometimes an upgrade is just out of question. Besides, that'd mean an
> > > upgrade to another operating system, because very important scripts
> > > over here a just not portable to anything else but
> > >     "ActiveState Perl on Windows (TM)"
> > > I just have no choice.
> >
> > Sure, but perhaps IPC::Open2 or some other CPAN module has solved this
> > problem already.
> 
> IPC::Open2 works! Well "kind of": there are still strange segfaults regarding
> stack sometimes. And I don't know yet whether and how the arguments are escaped
> (Windows has no argument array. It has that bloody stupid one-line command line)

It seems that ActiveState has more problems with pipes than it does with fork.
If it supports redirects reasonably well, this avoids pipes entirely and
may be more stable as a result (but possibly slower):

# IO::File is standard in Perl 5.x, new_tmpfile
# returns an open filehandle to an already unlinked file

use IO::File;
my $out = IO::File->new_tmpfile;
file
my $pid = fork;
defined $pid or die $!;
if (!$pid) {
	# redirects STDOUT to $out file
	open STDOUT, '>&', $out or die $!;
	exec('foo','bar');
}
waitpid $pid, 0;
seek $out, 0, 0;
while (<$out>) {
	...
}

Writing and reading from a tempfile are very fast for me in Linux, and probably
not much slower than pipes.  Of course I'm still assuming file descriptors stay
shared after a 'fork', which may be asking too much on Windows.  Using something
from File::Temp to get a temp filename would still work.

-- 
Eric Wong
