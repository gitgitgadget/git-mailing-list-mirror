From: Jeff King <peff@peff.net>
Subject: Re: Re* [RFC/PATCH] extend meaning of "--root" option to index
	comparisons
Date: Sun, 21 Sep 2008 09:56:16 -0400
Message-ID: <20080921135616.GA25238@sigill.intra.peff.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <48CECA42.1050209@drmicha.warpmail.net> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net> <20080918092152.GA18732@coredump.intra.peff.net> <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com> <20080919142537.GA1287@coredump.intra.peff.net> <7vskrvswxp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 15:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhPRM-0001jX-Bs
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 15:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbYIUN4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbYIUN4W
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 09:56:22 -0400
Received: from peff.net ([208.65.91.99]:4805 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYIUN4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 09:56:21 -0400
Received: (qmail 30349 invoked by uid 111); 21 Sep 2008 13:56:19 -0000
Received: from c-75-75-5-148.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.5.148)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 21 Sep 2008 09:56:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Sep 2008 09:56:16 -0400
Content-Disposition: inline
In-Reply-To: <7vskrvswxp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96396>

On Fri, Sep 19, 2008 at 01:27:46PM -0700, Junio C Hamano wrote:

>  (1) A user getting an error message from "git init && git log" may be
>      annoyed, but he very well knows there is no history yet _anyway_.
>      This initial annoyance will pass immediately after creating any
>      commit, so I do not think it is a big issue.

I think there is an additional case of script writers, who want their
scripts to fail gracefully or otherwise do the right thing with an
initial commit. Right now they have to special-case the initial commit.
I don't know if it is possible to have sane enough behavior that the
special case can be eliminated, or if it will simply make things worse.

>      "bad default revision 'HEAD'" is a cryptic way to give that indicaion
>      that can be improved but that is a separate issue.  Rewording it so
>      that it explains the situation better in user's terms would be a
>      worthy improvement.

I agree that would be an improvement.

>  (2) "--root" is about "do we show a creation event as a huge diff from
>      emptyness?".  Yes, we turn it on for "git log" but it does not have
>      anything to do with the issue of yet to be born branch, where there
>      isn't even a big creation event yet.

What about index comparisons? What should an index comparison to a
branch yet-to-be-born look like? Right now it is an error.

> I am reluctant to agree with the opinion that "git log" should be _silent_
> in a world without any history.

It feels a bit more Unix-y to me. That is, if I am asking for some set
of commits, and there are _no_ commits in the set, then I expect no
output. That makes sense for text processing.

> -	argc = setup_revisions(argc, argv, rev, "HEAD");
> +	argc = setup_revisions(argc, argv, rev, NULL);
> +	if (!rev->pending.nr) {
> +		add_head_to_pending(rev);
> +		if (!rev->pending.nr) {
> +			printf("No commits (yet).\n");
> +			exit(0);
> +		}
> +	}

I like the idea of an improved message, but such a message should
definitely not go to stdout; it would feed nonsense to a command like
"git log | my_log_filter".

-Peff
