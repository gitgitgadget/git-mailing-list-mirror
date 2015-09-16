From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Wed, 16 Sep 2015 16:42:26 -0400
Message-ID: <20150916204226.GE3915@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154950.GG29753@sigill.intra.peff.net>
 <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:42:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJXL-0001ss-RN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbbIPUmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:42:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:60343 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752652AbbIPUmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:42:35 -0400
Received: (qmail 25674 invoked by uid 102); 16 Sep 2015 20:42:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 15:42:35 -0500
Received: (qmail 23153 invoked by uid 107); 16 Sep 2015 20:42:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:42:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 16:42:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278066>

On Wed, Sep 16, 2015 at 12:52:26PM -0700, Junio C Hamano wrote:

> > diff --git a/remote.c b/remote.c
> > index 5ab0f7f..1b69751 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -297,7 +297,6 @@ static void read_branches_file(struct remote *remote)
> >  	int n = 1000;
> >  	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
> >  	char *s, *p;
> > -	int len;
> 
> Hmm, we would punish those with ridiculously long remote name by
> truncating at n but that is OK.

Yeah, though that is nothing new.

In some of the cases, as you've seen, I dug further in cleaning things
up. But in others I did the minimal fix (especially in this case, the
limitations are only about the deprecated "branches" and "remotes"
file), mostly to try to keep the scope of work sane.

> We use buffer[BUFSIZ] to read various things in this file, not just
> $GIT_DIR/branches/* files, with fgets(), which may be better done if
> we switched to strbuf_getline().  Then we can also use trim family
> of calls from the strbuf API suite.
>
> Move to strbuf_getline() may be a doubly attractive proposition,
> with a possible change to strbuf_getline() to make it also remove CR
> that immediately precedes LF [*1*], helping DOSsy platforms.

I'll take a look and see how painful this is.

-Peff
