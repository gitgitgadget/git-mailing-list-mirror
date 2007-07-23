From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Mon, 23 Jul 2007 22:48:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707232242430.14781@racer.site>
References: <46A3F43C.3030101@gmail.com>  <Pine.LNX.4.64.0707230141080.14781@racer.site>
 <1b46aba20707231421k54ad2796i5c2f21cf11b4bea5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID5ld-0003eH-JZ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 23:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbXGWVsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 17:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755760AbXGWVsd
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 17:48:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:47034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754599AbXGWVsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 17:48:32 -0400
Received: (qmail invoked by alias); 23 Jul 2007 21:48:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 23 Jul 2007 23:48:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VC9UkZRpVj1ifH2BB3ogj4slnlTnDKjduK53PAM
	qM94F4cdxdBjAS
X-X-Sender: gene099@racer.site
In-Reply-To: <1b46aba20707231421k54ad2796i5c2f21cf11b4bea5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53488>

Hi,

On Mon, 23 Jul 2007, Carlos Rica wrote:

> 2007/7/23, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > On Mon, 23 Jul 2007, Carlos Rica wrote:
> > > +static int run_gpg_verify(const char *buf, unsigned long size, int
> > verbose)
> > > +{
> > > +     struct child_process gpg;
> > > +     const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
> > > +     char *path, *eol;
> > > +     size_t len;
> > > +     int fd, ret;
> > > +
> > > +     path = xstrdup(git_path("VTAG_TMP"));
> > > +     fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > > +     if (fd < 0)
> > > +             return error("could not create temporary file '%s': %s",
> > > +                                             path, strerror(errno));
> > > +     if (write_in_full(fd, buf, size) < 0)
> > > +             return error("failed writing temporary file '%s': %s",
> > > +                                             path, strerror(errno));
> > > +     close(fd);
> > 
> > I just tested something like "gpg --verify - - < <filename>" and it
> > worked...
> 
> I couldn't verify tags using "gpg --verify  -  -  <file" as you
> pointed in your response.

As discussed on IRC, my test did not use a detached signature, while tags 
_do_ use a detached signature.

Oh, well.  I retract my suggestion.  But I slightly disagree that having 
to write a temporary file is good for security, as the gpg man page 
suggests:

--verify [[sigfile]  [signed-files]]
         [...] To read the signed stuff from stdin, use - as the second 
	filename.  For security reasons a detached signature cannot read 
	the signed material from stdin without denoting it in the above 
	way.

So we have to live, or die, with the temporary file.

Just one request: please use lock_file, to prevent multiple instances from 
getting confused...  Even if that cannot be 100% secure: if you write to 
the file, and only then start gpg, there is still the odd chance for an 
attacker.  Even if you created the file with 0600 (very wise, BTW).

Ciao,
Dscho
