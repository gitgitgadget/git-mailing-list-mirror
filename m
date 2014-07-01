From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] use skip_prefix to avoid magic numbers
Date: Tue, 1 Jul 2014 13:35:02 -0400
Message-ID: <20140701173502.GA12777@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
 <20140618194750.GH22622@sigill.intra.peff.net>
 <xmqqa993b8so.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:35:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X21xW-0003Vq-Bh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128AbaGARfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:35:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:54314 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755253AbaGARfD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:35:03 -0400
Received: (qmail 16417 invoked by uid 102); 1 Jul 2014 17:35:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Jul 2014 12:35:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2014 13:35:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa993b8so.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252729>

On Mon, Jun 23, 2014 at 02:44:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/connect.c b/connect.c
> > index 94a6650..37ff018 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -140,12 +141,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> >  		if (!len)
> >  			break;
> >  
> > -		if (len > 4 && starts_with(buffer, "ERR "))
> > -			die("remote error: %s", buffer + 4);
> > +		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
> > +			die("remote error: %s", arg);
> 
> Makes one wonder if we should do something special to a line with
> only "ERR " and nothing else on it, which the other end may have
> meant us to give a blank line to make the output more readable.

I don't think that would buy us much. We have always accepted only a
single ERR line and died immediately. So any changes of that nature
would have to be made in the client, and then servers would have to wait
N time units before it was safe to start using the feature (otherwise
old clients just get the blank line!).

I also don't think blank lines by themselves are useful. You'd want them
in addition to being able to handle multiple lines. So a nicer fix is
more along the lines of "accept multiple ERR lines, including blank
lines, followed by a terminating line ("ERRDONE" or something).

Then servers can do:

  ERR unable to access foo.git: Printer on fire
  ERR
  ERR You may have misspelled the repository name. Did you mean:
  ERR
  ERR  foobar.git
  ERRDONE

Old clients would see the first line and die. Newer clients would print
the helpful hint. Servers would just need to make sure that the first
line stands on its own to cover both cases.

> A fix, if one turns out to be needed, is outside the scope of this
> patch, though, I think.

Yeah, definitely a separate topic.

It is not something I think anybody has asked for, but I can imagine a
site like GitHub making use of it (we already show custom errors for
http, but there's no room beyond the single ERR line). And teaching the
clients now expands the options for servers later. So it might be worth
doing just as a potential feature.

-Peff
