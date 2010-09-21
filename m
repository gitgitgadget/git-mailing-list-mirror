From: Jeff King <peff@peff.net>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases
 with symlinks
Date: Tue, 21 Sep 2010 14:42:41 -0400
Message-ID: <20100921184241.GA28567@sigill.intra.peff.net>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr>
 <7vpqwa254i.fsf@alter.siamese.dyndns.org>
 <20100920180046.GA1790@sigill.intra.peff.net>
 <7vaanbuggr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 20:42:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy7nk-0003HM-Fh
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 20:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578Ab0IUSmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 14:42:43 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40626 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab0IUSmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 14:42:42 -0400
Received: (qmail 10177 invoked by uid 111); 21 Sep 2010 18:42:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 18:42:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 14:42:41 -0400
Content-Disposition: inline
In-Reply-To: <7vaanbuggr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156741>

On Tue, Sep 21, 2010 at 10:57:56AM -0700, Junio C Hamano wrote:

> >   [diff "SYMLINK"]
> >     textconv = pointless-munge
> >
> > But again, I have no idea why anyone would want such a feature, so it is
> > not worth thinking too hard about it.
> 
> I agree with you; pointless-munge would just be 'printf "%s\n"' ;-)

Almost. That would print the name of the tempfile; the actual pathname
is the contents of the tempfile (unless you are proposing totally
alternate semantics for the symlink diff section. :) ).

Just for fun, the patch to make this work is as tiny as:

diff --git a/diff.c b/diff.c
index 6fb18ae..58c4477 100644
--- a/diff.c
+++ b/diff.c
@@ -1771,8 +1771,14 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two, char *pre
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
 {
-	if (!one->driver)
+	if (one->driver)
+		return;
+
+	if (S_ISLNK(one->mode))
+		one->driver = userdiff_find_by_name("SYMLINK");
+	else
 		one->driver = userdiff_find_by_path(one->path);
+
 	if (!one->driver)
 		one->driver = userdiff_find_by_name("default");
 }
@@ -1820,7 +1826,7 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
-	if (!S_ISREG(one->mode))
+	if (!S_ISREG(one->mode) && !S_ISLNK(one->mode))
 		return NULL;
 	diff_filespec_load_driver(one);
 	if (!one->driver->textconv)

after which I successfully tested with:

  git init repo && cd repo &&
  echo content >file.txt &&
  ln -s file.txt link.txt &&
  echo '*.txt diff=txt' >.gitattributes &&
  git add . && git commit -m foo &&
  git config diff.txt.textconv "sed 's/^/converted: /'" &&
  git config diff.SYMLINK.textconv "perl -pe 's/$/\n/'" &&
  git show

It works with the whole range of diff config, so you could do something
as awesomely stupid as:

  $ git config diff.SYMLINK.binary true
  $ git show link.txt
  ...
  diff --git a/link.txt b/link.txt
  new file mode 120000
  index 0000000..4c33073
  Binary files /dev/null and b/link.txt differ

If you really wanted the "dereference my symlinks" behavior, you could
do:

  git config diff.SYMLINK.textconv 'sh -c "cat `cat $1`" -'

but that is not quite right; you would actually need to dereference
relative symlinks with respect to the link itself, which textconv never
gets (plus you would probably want to handle broken links more
gracefully).

Anyway, as I said at the beginning, for me this was just for fun. I find
the intended use rather silly, but maybe somebody else is interested. I
do think it's the right way of implementing such a feature, because we
already turn off textconv when making patches that are meant to be
applied rather than viewed. However, I didn't do any testing or give
much thought to whether this would affect any unintended code paths.

-Peff
