From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/15] commit: record buffer length in cache
Date: Tue, 10 Jun 2014 01:27:13 -0400
Message-ID: <20140610052713.GA2978@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181538.GO20315@sigill.intra.peff.net>
 <20140610.071237.852310668484562387.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	sunshine@sunshineco.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:27:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuEau-0004tf-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbaFJF1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 01:27:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:40759 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754971AbaFJF1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 01:27:15 -0400
Received: (qmail 2466 invoked by uid 102); 10 Jun 2014 05:27:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 00:27:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 01:27:13 -0400
Content-Disposition: inline
In-Reply-To: <20140610.071237.852310668484562387.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251158>

On Tue, Jun 10, 2014 at 07:12:37AM +0200, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> >
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -2313,7 +2313,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
> >  		    ident, ident, path,
> >  		    (!contents_from ? path :
> >  		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
> > -	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
> > +	set_commit_buffer(commit, msg.buf, msg.len);
> 
> I find the above strange. I would have done something like:
> 
> -	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
> +	size_t size;
> +	char *buf = strbuf_detach(&msg, &size);
> +	set_commit_buffer(commit, buf, size);

It is a little strange. You can't do:

  set_commit_buffer(commit, strbuf_detach(&msg, NULL), msg.len);

because the second argument resets msg.len as a side effect. Doing it
your way is longer, but perhaps is a bit more canonical. In general, one
should call strbuf_detach to ensure that the buffer is allocated (and
does not point to slopbuf). That's guaranteed here, because we just put
contents into the buffer, but it's probably more hygienic to use the
more verbose form.

-Peff
