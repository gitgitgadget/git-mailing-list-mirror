From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/3] test-terminal: set output terminals to raw mode
Date: Mon, 12 Dec 2011 20:01:35 +0100
Message-ID: <201112122001.36303.trast@student.ethz.ch>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch> <04a77f48dd5d5afebbe625ed25ebecd57b6a8840.1323713230.git.trast@student.ethz.ch> <20111212182318.GE31793@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaB8E-0002aB-IC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab1LLTBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:01:41 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:56834 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237Ab1LLTBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:01:41 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 20:01:36 +0100
Received: from thomas.inf.ethz.ch (80.219.158.96) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 20:01:39 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111212182318.GE31793@elie.hsd1.il.comcast.net>
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186931>

Jonathan Nieder wrote:
> Thomas Rast wrote:
> 
> > Not setting them to raw mode causes funny things to happen, such as
> > \n -> \r\n translation:
> [...]
> > To avoid this, set the (pseudo)terminal to raw mode.  Note that the
> > IO::Pty docs recommend doing it on both master and slave.
> 
> Good idea, so for what it's worth,
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Does this change the behavior in
> <https://rt.cpan.org/Ticket/Display.html?id=65692> (oh please oh
> please)?

I don't think so.  I tested this tweak of the script:

  perl -MIO::Pty -MFile::Copy -e '
    for (my $i = 0;; $i++) {
      my $master = new IO::Pty;
      my $slave = $master->slave;
      $master->set_raw();
      $slave->set_raw();
      if (fork == 0) {
        close $master or die "close: $!";
        open STDOUT, ">&", $slave or die "dup2: $!";
        close $slave or die "close: $!";
        exec("echo", "hi", $i) or die "exec: $!";
      }
      close $slave or die "close: $!";
      copy($master, \*STDOUT) or die "copy: $!";
      close $master or die "close: $!"; wait;
    }
  '

That's over ssh on

  $ uname -a
  Darwin mackeller.inf.ethz.ch 11.1.0 Darwin Kernel Version 11.1.0: Tue Jul 26 16:07:11 PDT 2011; root:xnu-1699.22.81~1/RELEASE_X86_64 x86_64

What's odd is that when I was logged in at university (over Gbit
ethernet, but still over ssh), the unmodified version wouldn't even
get off the ground.  I may just have been dreaming however.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
