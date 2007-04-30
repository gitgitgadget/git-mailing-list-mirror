From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Mon, 30 Apr 2007 15:12:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301508550.29859@racer.site>
References: Pine.LNX.4.64.0704281303371.28708@iabervon.org
 <46339819.8030007@freedesktop.org> <Pine.LNX.4.64.0704291416370.28708@iabervon.org>
 <4635003F.7080408@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 15:13:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiVgi-00029y-Na
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 15:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423239AbXD3NNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423240AbXD3NNF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 09:13:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:49973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423239AbXD3NND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 09:13:03 -0400
Received: (qmail invoked by alias); 30 Apr 2007 13:13:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 30 Apr 2007 15:13:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kpJkZoNxkUFsdbzz2kirP0LsGvayujxNKUItqzL
	hrJta3BQStew9f
X-X-Sender: gene099@racer.site
In-Reply-To: <4635003F.7080408@freedesktop.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45867>

Hi,

On Sun, 29 Apr 2007, Josh Triplett wrote:

> Daniel Barkalow wrote:
> > On Sat, 28 Apr 2007, Josh Triplett wrote:
> >> Daniel Barkalow wrote:
> >>> It was implemented in commit.c; move it with the other x memory functions.
> >> [...]
> >>> +static inline char *xstrndup(const char *str, int len)
> >>> +{
> >>> +	char *ret = xmalloc(len + 1);
> >>> +	memcpy(ret, str, len);
> >>> +	ret[len] = '\0';
> >>> +	return ret;
> >>> +}
> >>> +
> >> I don't know if it matters, but this definition of xstrndup, like the 
> >> version in commit.c, doesn't match the definition of strndup.  
> >> strndup duplicates a string, copying up to n characters or the length 
> >> of the string.  This xstrndup always copies n characters, reading 
> >> past the end of the string if it doesn't have at least n characters.
> > 
> > Good catch. Replacing the memcpy with strncpy solves this, right? 
> > (Potentially allocating a bit of extra memory if someone is actually 
> > using it on too short a string for some reason, of course).
> 
> That would work, but it seems bad to allocate excess memory.  How about 
> just using strlen and setting len to that if shorter, before doing the 
> xmalloc and memcpy?  Yes, that makes two passes over the string, but I 
> don't see any way around that.

Unless I am missing something, I think this should work:

static inline char *xstrndup(const char *str, int len)
{
	char *result = strndup(str, len);
	if (result == NULL)
		die ("xstrndup(): out of memory");
	return result;
}

Hmm?

Ciao,
Dscho

P.S.: If you feel real paranoid about it, you might insert

	if (result == NULL) {
		release_pack_memory(len, -1);
		result = strndup(str, len);
	}

before the if (...), but I think that's overkill.
