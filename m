From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Add is_absolute_path() and make_absolute_path()
Date: Sat, 28 Jul 2007 02:03:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707280202260.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
 <Pine.LNX.4.64.0707271955450.14781@racer.site> <7vvec5y3i0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 03:03:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEaiD-0001vf-0x
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 03:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbXG1BDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 21:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbXG1BDO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 21:03:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:49062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965126AbXG1BDN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 21:03:13 -0400
Received: (qmail invoked by alias); 28 Jul 2007 01:03:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 28 Jul 2007 03:03:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3wRNWOhe3iS/Ct9LPFIrmnhPmrRcVZImJt+7zQO
	Ozm3gv9CzGOMEk
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvec5y3i0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53986>

Hi,

On Fri, 27 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/path.c b/path.c
> > index c4ce962..0f7012f 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -292,3 +292,65 @@ int adjust_shared_perm(const char *path)
> >  		return -2;
> >  	return 0;
> >  }
> > +
> > +/* We allow "recursive" symbolic links. Only within reason, though. */
> > +#define MAXDEPTH 5
> > +
> > +const char *make_absolute_path(const char *path)
> > +{
> > +	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
> > +	char cwd[1024] = "";
> > +	int buf_index = 1, len;
> > +
> > +	int depth = MAXDEPTH;
> > +	char *last_elem = NULL;
> > +	struct stat st;
> > +
> > +	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
> > +		die ("Too long path: %.*s", 60, path);
> > +
> > +	while (depth--) {
> > +		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
> > +			char *last_slash = strrchr(buf, '/');
> > +			*last_slash = '\0';
> > +			last_elem = xstrdup(last_slash + 1);
> 
> What happens when incoming path is just "abc"?  Does your test
> script checks that case?

No, and you already guessed it: there will be a segmentation fault.

Will fix.

Ciao,
Dscho
