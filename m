From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sat, 8 Nov 2014 03:45:27 -0500
Message-ID: <20141108084526.GA18912@peff.net>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 09:45:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn1eI-00030i-Kp
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 09:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbaKHIp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 03:45:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:37872 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753373AbaKHIp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 03:45:29 -0500
Received: (qmail 29987 invoked by uid 102); 8 Nov 2014 08:45:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 02:45:29 -0600
Received: (qmail 1189 invoked by uid 107); 8 Nov 2014 08:45:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 03:45:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 03:45:27 -0500
Content-Disposition: inline
In-Reply-To: <20141108083040.GA15833@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 08, 2014 at 03:30:40AM -0500, Jeff King wrote:

> So just to be clear, the behavior we want is that:
> 
>   echo foo >some-new-path
>   git add some-new-path
>   git checkout HEAD -- .
> 
> will delete some-new-path (whereas the current code turns it into an
> untracked file). What should:
> 
>   git checkout HEAD -- some-new-path
> 
> do in that case? With the current code, it actually barfs, complaining
> that nothing matched some-new-path (because it is not part of HEAD, and
> therefore we don't consider it at all), and aborts the whole operation.
> I think we would want to delete some-new-path in that case, too.

Also, t2022.3 has me very confused.

It is explicitly checking that if we have "subdir/foo" unmerged in the
index, and we "git checkout $tree -- subdir", and $tree does not mention
"foo", that we _leave_ foo in place.

That seems very counter-intuitive to me. If you asked to make "subdir"
look like $tree, then we should clobber it. That change comes from
e721c15 (checkout: avoid unnecessary match_pathspec calls, 2013-03-27),
where it is mentioned as a _bugfix_. That in turn references 0a1283b
(checkout $tree $path: do not clobber local changes in $path not in
$tree, 2011-09-30), which explicitly goes against the goal we are
talking about here. It is not "make my index and working tree look like
$tree" at all.

So now I'm doubly confused about what we want to do.

If we want to retain that behavior, I think we can still cover these
cases by marking items missing from $tree as "to remove" during the
diff/"update the index" phase, and then being more gentle with "to
remove" files (e.g., not clobbering changed worktree files unless "-f"
is given).

I am not sure that provides a sane user experience, though. Why is it OK
to clobber local changes to a file if we are replacing it with other
content, but _not_ if we are replacing it with nothing?  Either the
content we are losing is valuable or not, but it has nothing to do with
what we are replacing. And Junio argued in the thread linked elsewhere
that the point of "git checkout $tree -- $path" is to clobber what is in
$path, which I would agree with.

I think the argument made in 0a1283b is that "git checkout $tree $path"
is not "make $path like $tree", but rather "pick bits of $path out of
$tree". Which would mean this whole deletion thing we are talking about
is completely contrary to that.

So which is it?

-Peff
