From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Wed, 9 Feb 2011 21:22:19 +0100
Message-ID: <201102092122.19178.trast@student.ethz.ch>
References: <201102091538.46594.trast@student.ethz.ch> <20110209190900.GA8314@sigill.intra.peff.net> <201102092016.55078.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 09 21:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnGYV-0008K0-Bp
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 21:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab1BIUWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 15:22:21 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:24446 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab1BIUWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 15:22:21 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 9 Feb
 2011 21:22:19 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 9 Feb
 2011 21:22:19 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <201102092016.55078.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166439>

Thomas Rast wrote:
> I'll have to put off the more involved experimentation somewhat :-(

Or not.

Anyway, I managed to load the relevant parts of t7006 in an
interactive shell, and used

  i=0
  while test_terminal git --no-pager log >out.$i 2>&1; do
    i=$(($i+1))
    echo $i
  done

to trigger the race.  With

  test_terminal () {
    sudo "$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
  }

which is the closest to dtruss I can get without actually using it, I
hit the race very quickly, usually in ~5 runs.  But using either one
of

  test_terminal () {
    sudo dtruss "$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
  }

  test_terminal () {
    sudo dtruss -f "$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
  }

slows down things so much that it did not hit the race in useful time
(about 100 runs).  I also tried running 'dtruss -n perl' in another
terminal and hoping it will hit a wall eventually, which does run a
bit faster but also got nowhere in about 350 runs.

Running 'dtruss -n git' instead did hit the issue, and I have the
output saved away, but I'm not sure what I'd be looking for.  After
all, the git process becomes a zombie:

  47606 s006  S+     0:00.13 /usr/bin/perl /Users/trast/git/t/test-terminal.perl git --no-pager log
  47607 s006  Z+     0:00.00 (git)
  47608 s006  Z+     0:00.00 (perl5.10.0)

The output for pid 47607 ends in:

  47607/0x1f7fec5:  write_nocancel(0x1, "Author: A U Thor <author@example.com>\n\0", 0x26)                 = 38 0
  47607/0x1f7fec5:  write_nocancel(0x1, "Date:   Thu Apr 7 15:13:13 2005 -0700\n\0", 0x26)                 = 38 0
  47607/0x1f7fec5:  write_nocancel(0x1, "\n\0", 0x1)               = 1 0
  47607/0x1f7fec5:  write_nocancel(0x1, "    initial\n\0", 0xC)            = 12 0
  47607/0x1f7fec5:  fstat64(0x1, 0x7FFF5FBFE8A0, 0x0)              = 0 0
  47607/0x1f7fec5:  fstat64(0x1, 0x7FFF5FBFEF60, 0x0)              = 0 0
  47607/0x1f7fec5:  close_nocancel(0x1)            = 0 0

Which seems rather unsurprising really :-(

Finally, attaching dtruss after hitting the race gives no output when
I finally kill it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
