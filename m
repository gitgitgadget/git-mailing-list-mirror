From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 11:53:43 -0500
Message-ID: <20151109165343.GA29179@sigill.intra.peff.net>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
 <20151104064021.GB16605@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
 <20151109155538.GC27224@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 17:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvphX-0006Ig-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 17:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbbKIQxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 11:53:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:54989 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751675AbbKIQxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 11:53:46 -0500
Received: (qmail 6505 invoked by uid 102); 9 Nov 2015 16:53:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 10:53:45 -0600
Received: (qmail 16983 invoked by uid 107); 9 Nov 2015 16:54:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 11:54:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 11:53:43 -0500
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281056>

On Mon, Nov 09, 2015 at 08:34:27AM -0800, Victor Leschuk wrote:

> > Why don't we leave it at 8, then? That's the conservative choice, and
> > once we have --threads, people can easily experiment with different
> > values and we can follow-up with a change to the default if need be.
>
> I'd propose the following:
>
>     if (list.nr || cached) {
>         num_threads = 0; /* Can not multi-thread object lookup */
>     }
>     else if (num_threads < 0 && online_cpus() <= 1) {
>         num_threads = 0; /* User didn't set threading option and we have <= 1 of hardware cores */
>     }

OK, so you are presumably initializing:

  static int num_threads = -1;

>     else if (num_threads == 0) {
>         num_threads = GREP_NUM_THREADS_DEFAULT; /* User explicitly choose default behavior */
>     }
>     else if (num_threads < 0) {  /* Actually this one should be checked earlier so no need to double check here */
>         die(_("Ivalid number of threads specified (%d)"), num_threads)
>     }

What happens if the user has not specified a value (nr_threads == -1)?
Here you die, but shouldn't you take the default thread value?

I wonder if it would be simpler to just default to 0, and then treat
negative values the same as 0 (which is what pack.threads does). Like:

  if (list.nr || cached)
	num_threads = 1;
  if (!num_threads)
	num_threads = GREP_NUM_THREADS_DEFAULT;

and then later, instead of use_threads, do:

  if (num_threads <= 1) {
	... do single-threaded version ...
  } else {
        ... do multi-threaded version ...
  }

That matches the logic in builtin/pack-objects.c.

-Peff
