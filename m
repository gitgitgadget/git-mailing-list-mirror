From: Jeff King <peff@peff.net>
Subject: Re: [regression] Re: [PATCHv2 10/15] drop length limitations on
 gecos-derived names and emails
Date: Thu, 24 Jan 2013 20:05:59 -0500
Message-ID: <20130125010559.GA27657@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
 <20120521231017.GJ10981@sigill.intra.peff.net>
 <20130124232146.GA17458@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org,
	Mihai Rusu <dizzy@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 02:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyXkO-0003B8-UI
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 02:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab3AYBGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 20:06:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48723 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab3AYBGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 20:06:01 -0500
Received: (qmail 29813 invoked by uid 107); 25 Jan 2013 01:07:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 20:07:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 20:05:59 -0500
Content-Disposition: inline
In-Reply-To: <20130124232146.GA17458@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214475>

On Thu, Jan 24, 2013 at 03:21:46PM -0800, Jonathan Nieder wrote:

> This broke /etc/mailname handling.  Before:
> 
> 	$ git var GIT_COMMITTER_IDENT
> 	Jonathan Nieder <jrn@mailname.example.com> 1359069165 -0800
> 
> After:
> 
> 	$ git var GIT_COMMITTER_IDENT
> 	Jonathan Nieder <mailname.example.com> 1359069192 -0800

Ick. I wonder how that slipped through...I know I was testing with
/etc/mailname when developing the series, because I'm on a Debian
system. We do even check this code path in t7502 (if you have the
AUTOIDENT prereq), but of course we can't verify the actual value
automatically, because it could be anything. So I guess I just missed it
during my manual testing, and the automated testing is insufficient to
catch this particular breakage.

> > -	if (!fgets(buf, len, mailname)) {
> > +	if (strbuf_getline(buf, mailname, '\n') == EOF) {
> 
> This clears the strbuf.

Right. Definitely the problem.

> How about something like this as a quick fix?
> 
> Reported-by: Mihai Rusu <dizzy@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> diff --git a/ident.c b/ident.c
> index 73a06a1..cabd73f 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -41,6 +41,7 @@ static void copy_gecos(const struct passwd *w, struct strbuf *name)
>  static int add_mailname_host(struct strbuf *buf)
>  {
>  	FILE *mailname;
> +	struct strbuf mailnamebuf = STRBUF_INIT;
>  
>  	mailname = fopen("/etc/mailname", "r");
>  	if (!mailname) {
> @@ -49,14 +50,17 @@ static int add_mailname_host(struct strbuf *buf)
>  				strerror(errno));
>  		return -1;
>  	}
> -	if (strbuf_getline(buf, mailname, '\n') == EOF) {
> +	if (strbuf_getline(&mailnamebuf, mailname, '\n') == EOF) {
>  		if (ferror(mailname))
>  			warning("cannot read /etc/mailname: %s",
>  				strerror(errno));
> +		strbuf_release(&mailnamebuf);
>  		fclose(mailname);
>  		return -1;
>  	}
>  	/* success! */
> +	strbuf_addbuf(buf, &mailnamebuf);
> +	strbuf_release(&mailnamebuf);
>  	fclose(mailname);
>  	return 0;
>  }

I think that is the only reasonable fix. Thanks for figuring it out.

We could expand the test in t7502 to check for "@" in the email, but it
feels weirdly specific to this bug. Either way,

Acked-by: Jeff King <peff@peff.net>

(with a proper commit message, of course).

-Peff
