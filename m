From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git tag a builtin.
Date: Fri, 20 Jul 2007 11:15:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707201110460.14781@racer.site>
References: <469FF6E4.9010501@gmail.com> <7v1wf3zbhj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBpWV-0003wP-P9
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXGTKPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbXGTKPl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:15:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:42955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752338AbXGTKPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:15:41 -0400
Received: (qmail invoked by alias); 20 Jul 2007 10:15:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 20 Jul 2007 12:15:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19w2Os85rdwAOnt3R9A1uctEdutynw8PbKSil7JhU
	j4Zjkwhie5TBNq
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wf3zbhj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53077>

Hi,

On Fri, 20 Jul 2007, Junio C Hamano wrote:

> Carlos Rica <jasampler@gmail.com> writes:
> 
> > This replaces the script "git-tag.sh" with "builtin-tag.c".
> 
> Thanks.  Will queue in 'next', and perhaps with a few nit fixups
> to merge as the first thing after 1.5.3.

Nice!

> launch-editor() would need adjustment for GIT_EDITOR and core.editor 
> which should be straightforward.

Yes.  As a separate commit?  After a couple of revisions, I lost track of 
what I looked at, and what not...  So it would make it easier for me to 
have these changes after the big builtin-tag commit.

> > +		sp = buf = read_sha1_file(sha1, &type, &size);
> > +		if (!buf || !size)
> > +			return 0;
> 
> Theoretically, I can create millions of lightweight tags, all of
> them pointing at a zero-length blob object (or an empty tree
> object) and kill you with memory leak here ;-).

Yes ;-)  Would we really want to say

	if (!buf)
		return 0;
	if (!size) {
		free(buf);
		return 0;
	}

here?  IMHO that is overkill.

> > +		/* skip header */
> > +		while (sp + 1 < buf + size &&
> > +				!(sp[0] == '\n' && sp[1] == '\n'))
> > +			sp++;
> > +		/* only take up to "lines" lines, and strip the signature */
> > +		for (i = 0, sp += 2; i < filter->lines && sp < buf + size &&
> > +				prefixcmp(sp, PGP_SIGNATURE "\n");
> > +				i++) {
> 
> Minor nit; I would have split this to four physical lines, like:
> 
> 		for (i = 0, sp += 2;
> 			i < filter->lines && sp < buf + size &&
> 			prefixcmp(sp, PGP_SIGNATURE "\n");
> 			i++) {
> 
> The places that semicolons appear are more significant gaps when
> reading the code.

I am to blame for that.  That code was outlined by me.

> > +int cmd_tag(int argc, const char **argv, const char *prefix)
> > +{
> > ...
> > +		if (!strcmp(arg, "-F")) {
> > +			unsigned long len;
> > +			int fd;
> > +
> > +			annotate = 1;
> > +			i++;
> > +			if (i == argc)
> > +				die("option -F needs an argument.");
> > +
> > +			if (!strcmp(argv[i], "-"))
> > +				fd = 0;
> > +			else {
> > +				fd = open(argv[i], O_RDONLY);
> > +				if (fd < 0)
> > +					die("could not open '%s': %s",
> > +						argv[i], strerror(errno));
> > +			}
> > +			len = 1024;
> > +			message = xmalloc(len);
> 
> You cannot anticipate how many bytes the user will type (or
> pipe-in), but when you opened the file you could fstat() to see
> how many bytes you would need to hold the contents of that
> file.  Even in stdin case fstat(fd) could tell you the size, but
> I am not sure how to tell if the st_size is reliable.  But for
> the purposes of "git tag", 1k buffer that grows on demand is
> probably cheaper than a fstat() syscall.

For a one-shot program as git-tag, I agree, the current patch is 
sufficient.

Ciao,
Dscho
