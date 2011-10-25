From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 18:00:27 +0200
Message-ID: <201110251800.28054.trast@student.ethz.ch>
References: <20111024201153.GA1647@x4.trippels.de> <201110251550.22248.trast@student.ethz.ch> <87y5w9ayoa.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	<git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIjQa-0004NG-Mh
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab1JYQAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 12:00:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:5868 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab1JYQAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 12:00:31 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 25 Oct
 2011 18:00:25 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 25 Oct
 2011 18:00:28 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <87y5w9ayoa.fsf@rho.meyering.net>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184215>

Jim Meyering wrote:
> Thomas Rast wrote:
> > [GCC moves access to a file-static variable across pthread_mutex_lock()]
> 
> Thanks for the investigation.
> Actually, isn't gcc -O2's code-motion justified?
> While we *know* that those globals may be modified asynchronously,
> builtin/grep.c forgot to tell gcc about that.

I'm somewhat unwilling to believe that:

* "volatile" enforces three unrelated things, see e.g. [1].

* Removing "static" would do the same as it prevents the compiler from
  proving at compile-time that pthread_mutex_lock() cannot affect the
  variable in question.

  If this is correct, it also means that all code in all pthreads
  tutorials I can find works merely by the accident of not declaring
  their variables "static".

  Furthermore, a future smarter compiler with better link-time
  optimization might again prove the same and eliminate the
  "superfluous" load.

However, as a result of the discussion I now have a shorter testcase:

  #include <pthread.h>

  int y;
  static int x;

  pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;

  void test ()
  {
          y = x;
          pthread_mutex_lock(&m);
          x = x + 1;
          pthread_mutex_unlock(&m);
  }

GCC 4.6.1 on F16 again assumes 'x' was not modified across the lock.
I also tested GCC 4.5.1 and 4.4.5, which instead issue a direct
add-to-memory instruction

        addl    $1, x(%rip)

in the locked part.

In the event that you and GCC 4.6.1 are right, I still vote for
removing 'static' instead of adding 'volatile' so as to allow basic
optimizations.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
