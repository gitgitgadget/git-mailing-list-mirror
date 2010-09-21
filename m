From: Jeff King <peff@peff.net>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases
 with symlinks
Date: Tue, 21 Sep 2010 14:56:13 -0400
Message-ID: <20100921185613.GB28567@sigill.intra.peff.net>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr>
 <7vpqwa254i.fsf@alter.siamese.dyndns.org>
 <20100920180046.GA1790@sigill.intra.peff.net>
 <7vaanbuggr.fsf@alter.siamese.dyndns.org>
 <20100921184241.GA28567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 20:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy80r-0001MD-8p
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 20:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0IUS4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 14:56:15 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42294 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab0IUS4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 14:56:14 -0400
Received: (qmail 10379 invoked by uid 111); 21 Sep 2010 18:56:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 18:56:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 14:56:13 -0400
Content-Disposition: inline
In-Reply-To: <20100921184241.GA28567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156742>

On Tue, Sep 21, 2010 at 02:42:41PM -0400, Jeff King wrote:

> diff --git a/diff.c b/diff.c
> index 6fb18ae..58c4477 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1771,8 +1771,14 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two, char *pre
>  
>  static void diff_filespec_load_driver(struct diff_filespec *one)
>  {
> -	if (!one->driver)
> +	if (one->driver)
> +		return;
> +
> +	if (S_ISLNK(one->mode))
> +		one->driver = userdiff_find_by_name("SYMLINK");
> +	else
>  		one->driver = userdiff_find_by_path(one->path);
> +
>  	if (!one->driver)
>  		one->driver = userdiff_find_by_name("default");
>  }
> @@ -1820,7 +1826,7 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
>  {
>  	if (!DIFF_FILE_VALID(one))
>  		return NULL;
> -	if (!S_ISREG(one->mode))
> +	if (!S_ISREG(one->mode) && !S_ISLNK(one->mode))
>  		return NULL;
>  	diff_filespec_load_driver(one);
>  	if (!one->driver->textconv)

Actually, thinking about this a little more, I wonder if the test for
S_ISREG should perhaps have been in diff_filespec_load_driver from the
very beginning. With the current code, I can do:

  $ echo 'binary content' >file.bin
  $ ln -s file.bin link.bin
  $ echo '*.bin diff=bin' >.gitattributes
  $ git config diff.bin.binary true
  $ git add -N .
  $ git diff
  diff --git a/.gitattributes b/.gitattributes
  index e69de29..d38ad2e 100644
  --- a/.gitattributes
  +++ b/.gitattributes
  @@ -0,0 +1 @@
  +*.bin diff=bin
  diff --git a/file.bin b/file.bin
  index e69de29..f55142d 100644
  Binary files a/file.bin and b/file.bin differ
  diff --git a/link.bin b/link.bin
  index e69de29..dce41ec 120000
  Binary files a/link.bin and b/link.bin differ

which does not seem right. We are again acting on the symlink's
contents, which are a text pathname, as if they represented the content
of that pathname.

So I think that is a bug, albeit one that is relatively uncommon to
trigger. S_ISGITLINK files may have the same issues, but perhaps not, as
I think they get routed out of the regular diff codepath early.

-Peff
