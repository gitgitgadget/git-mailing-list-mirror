From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin
Date: Sat, 24 Mar 2012 21:19:48 -0400
Message-ID: <20120325011948.GC27651@sigill.intra.peff.net>
References: <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
 <20120321201722.GA15021@sigill.intra.peff.net>
 <4F6E3446.9080001@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 03:19:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBc7g-0000FZ-8a
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 03:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab2CYBTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 21:19:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58766
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206Ab2CYBTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 21:19:51 -0400
Received: (qmail 30042 invoked by uid 107); 25 Mar 2012 01:20:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Mar 2012 21:20:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Mar 2012 21:19:48 -0400
Content-Disposition: inline
In-Reply-To: <4F6E3446.9080001@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193854>

On Sat, Mar 24, 2012 at 09:53:26PM +0100, Ivan Todoroski wrote:

> From c4bb55f9f27569faa368d823ca6fe4b236e37cd6 Mon Sep 17 00:00:00 2001
> From: Ivan Todoroski <grnch@gmx.net>
> Date: Sat, 24 Mar 2012 15:13:05 +0100
> Subject: [PATCH/RFC 1/2] fetch-pack: new option to read refs from stdin

You can drop these lines; they are redundant with the actual email
headers.

> ---
>  Documentation/git-fetch-pack.txt |    9 ++++++++
>  builtin/fetch-pack.c             |   44 ++++++++++++++++++++++++++++++++++++--
>  fetch-pack.h                     |    3 ++-
>  3 files changed, 53 insertions(+), 3 deletions(-)

Give more of a commit message. Why is this option useful (I know, of
course, from our previous discussion. But keep in mind the audience of
developers reading "git log" a year from now).

> +--stdin::
> +	Take the list of refs from stdin, one per line. If there
> +	are refs specified on the command line in addition to this
> +	option, then the refs from stdin are processed after those
> +	on the command line.
> +	If '--stateless-rpc' is specified together with this option
> +	then the list of refs must be in packet format (pkt-line)
> +	with a flush packet terminating the list.

Nice. Thanks for taking the time not just to solve your problem, but to
give sane semantics in the non-stateless-rpc case.

I think there is a minor formatting bug in the above. Asciidoc will make
your two paragraphs into a single one, won't it? I think you need to do
the (horribly ugly):

  --stdin::
      First paragraph.
  +
  Second paragraph.

to appease asciidoc.

> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -23,7 +23,7 @@ static struct fetch_pack_args args = {
>  };
>  
>  static const char fetch_pack_usage[] =
> -"git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
> +"git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";

Not a problem you introduced, but maybe it is time for us to cut down
this gigantic line (it's 180 characters even before your patch!). Even
breaking it across lines at 80 columns would help.

> @@ -972,6 +976,42 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	if (!dest)
>  		usage(fetch_pack_usage);
>  
> +	if (args.refs_from_stdin) {
> +		char ref[1000];

Ick. Is there any reason not to use a strbuf here? 1000 is probably
plenty, but we are generally moving towards removing such limits where
possible.

You'd also get to use strbuf_getline and strbuf_trim in the
newline-delimited case.

-Peff
