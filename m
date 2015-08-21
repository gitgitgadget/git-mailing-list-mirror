From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] format_config: simplify buffer handling
Date: Fri, 21 Aug 2015 15:40:01 -0400
Message-ID: <20150821194001.GA26466@sigill.intra.peff.net>
References: <20150820144504.GA22935@sigill.intra.peff.net>
 <20150820144733.GB11913@sigill.intra.peff.net>
 <xmqqvbc85yi3.fsf@gitster.dls.corp.google.com>
 <xmqqr3mw5yg1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:40:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsAh-0002sK-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbbHUTkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:40:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:48314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752446AbbHUTkE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:40:04 -0400
Received: (qmail 16569 invoked by uid 102); 21 Aug 2015 19:40:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 14:40:04 -0500
Received: (qmail 4081 invoked by uid 107); 21 Aug 2015 19:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 15:40:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 15:40:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3mw5yg1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276322>

On Fri, Aug 21, 2015 at 10:43:58AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I wonder if we can do this instead
> >
> > 	if (!omit_values) {
> > -		if (show_keys)
> > +		if (show_keys && value_)
> > 			strbuf_addch(buf, key_delim);
> >
> > though.  That would eliminate the need for rolling back.
> 
> No we cannot.  "config --bool --get-regexp" could get a NULL value_
> and has to turn it to " true".
> 
> Sorry for the noise.

Right, I had the same thought and reached the same conclusion.

By the way, I do not think the rollback by itself is gross, it is just
that it has to reproduce the "show_keys" logic. That is, it _really_
wants to be:

  else {
	  /* nothing to show; rollback delim */
	  if (we_added_delim)
		  strbuf_setlen(buf, buf->len - 1);
  }

and I use "show_keys" as a proxy for "did we add it". Which is
reproducing the logic that you quoted above, and if the two ever get out
of sync, it will be a bug. So you could write it as:

  int we_added_delim = 0;
  if (show_keys) {
	strbuf_addch(buf, key_delim);
	we_added_delim = 1;
  }

I didn't, because it's ugly, and the function is short enough and
unlikely enough to change that it probably won't matter.

You could perhaps also write it as:

  size_t baselen = buf->len;
  if (show_keys)
	strbuf_addch(buf, key_delim);
  ...
  else {
	/* rollback delim */
	strbuf_setlen(buf, baselen);
  }

-Peff
