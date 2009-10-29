From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
	debug
Date: Thu, 29 Oct 2009 08:11:52 -0700
Message-ID: <20091029151152.GX10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-4-git-send-email-spearce@spearce.org> <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3WfP-0007vy-Ud
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbZJ2PLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755184AbZJ2PLs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:11:48 -0400
Received: from george.spearce.org ([209.20.77.23]:51083 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbZJ2PLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:11:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 85649381FF; Thu, 29 Oct 2009 15:11:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131598>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > diff --git a/pkt-line.c b/pkt-line.c
> > index bd603f8..893dd3c 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -124,12 +124,14 @@ static int packet_length(const char *linelen)
> >  int packet_read_line(int fd, char *buffer, unsigned size)
> >  {
> >  	int len;
> > -	char linelen[4];
> > +	char linelen[5];
> >  
> >  	safe_read(fd, linelen, 4);
> >  	len = packet_length(linelen);
> > -	if (len < 0)
> > -		die("protocol error: bad line length character");
> > +	if (len < 0) {
> > +		linelen[4] = '\0';
> > +		die("protocol error: bad line length character: %s", linelen);
> > +	}
> 
> Since this is not called recursively, you can make linelen[] static

Sure.  But it wasn't static before.  It was stack allocated.  Its a
5 byte stack allocation.  Its not a lot of data to push onto the
stack, why does it suddenly matter that we make it static and charge
everyone for its memory instead of just those who really need it?

> and do
> without the NUL assignment; safe_read() won't read beyond 4 bytes anyway.

The NUL assignment isn't about safe_read(), its about making the
block of 4 bytes read a proper C-style string so we can safely pass
it down into the snprintf that is within die().

-- 
Shawn.
