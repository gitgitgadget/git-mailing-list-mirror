From: Jeff King <peff@peff.net>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 15:24:13 -0500
Message-ID: <20121112202413.GD4623@sigill.intra.peff.net>
References: <20121111232820.284510@gmx.net>
 <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0Ya-0000iJ-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2KLUYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:24:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44962 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab2KLUYS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:24:18 -0500
Received: (qmail 13515 invoked by uid 107); 12 Nov 2012 20:25:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 15:25:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 15:24:13 -0500
Content-Disposition: inline
In-Reply-To: <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209518>

On Mon, Nov 12, 2012 at 01:55:46PM -0500, Drew Northup wrote:

> On Sun, Nov 11, 2012 at 6:28 PM, glpk xypron <xypron.glpk@gmx.de> wrote:
> > Gitweb can be used to generate an RSS feed.
> >
> > Arbitrary tags can be inserted into the XML document describing
> > the RSS feed by careful construction of the URL.
> [...]
> Something like this may be useful to defuse the "file" parameter, but
> I presume a more definitive fix is in order...
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 10ed9e5..af93e65 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1447,6 +1447,10 @@ sub validate_pathname {
>         if ($input =~ m!\0!) {
>                 return undef;
>         }
> +       # No XSS <script></script> inclusions
> +       if ($input =~ m!(<script>)(.*)(</script>)!){
> +               return undef;
> +       }
>         return $input;
>  }

This is the wrong fix for a few reasons:

  1. It is on the input-validation side, whereas the real problem is on
     the output-quoting side. Your patch means I could not access a file
     called "<script>foo</script>". What we really want is to have the
     unquoted name internally, but then make sure we quote it when
     outputting as part of an HTML (or XML) file.

  2. Script tags are only part of the problem. They are what make it
     obviously a security vulnerability, but it is equally incorrect for
     us to show the filename "<b>foo</b>" as bold. I would also not be
     surprised if there are other cross-site attacks one can do without
     using <script>.

  3. Your filter is too simplistic. At the very least, it would not
     filter out "<SCRIPT>". I am not up to date on all of the
     sneaking-around-HTML-filters attacks that are available these days,
     but I wonder if one could also get around it using XML entities or
     similar.

I think the right answer is going to be a well-placed call to esc_html.
This already happens automatically when we go through the CGI
element-building functions, but obviously we failed to make the call
when building the output manually.  This is a great reason why template
languages which default to safe expansion should always be used.
Unfortunately, gitweb is living in 1995 in terms of web frameworks.

-Peff
