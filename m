From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] t4200: use cut instead of sed
Date: Fri, 14 Mar 2008 17:40:00 -0400
Message-ID: <20080314214000.GA15093@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213756.GI26286@coredump.intra.peff.net> <7vejaf1b0d.fsf@gitster.siamese.dyndns.org> <20080313125920.GF19485@coredump.intra.peff.net> <7vtzjay05k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHdv-00050c-8I
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759129AbYCNVkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbYCNVkF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:40:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2459 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759075AbYCNVkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:40:03 -0400
Received: (qmail 470 invoked by uid 111); 14 Mar 2008 21:40:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 17:40:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 17:40:00 -0400
Content-Disposition: inline
In-Reply-To: <7vtzjay05k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77288>

On Thu, Mar 13, 2008 at 11:00:23AM -0700, Junio C Hamano wrote:

> > index c607aad..e4a1dc1 100644
> > --- a/builtin-rerere.c
> > +++ b/builtin-rerere.c
> > @@ -58,7 +58,8 @@ static int write_rr(struct path_list *rr, int out_fd)
> >  		int length = strlen(path) + 1;
> >  		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
> >  		    write_in_full(out_fd, "\t", 1) != 1 ||
> > -		    write_in_full(out_fd, path, length) != length)
> > +		    write_in_full(out_fd, path, length) != length ||
> > +		    write_in_full(out_fd, "\n", 1) != 1)
> >  			die("unable to write rerere record");
> >  	}
> >  	if (commit_lock_file(&write_lock) != 0)
> 
> No, check 3f43d72392b6c0477debd7edbd49bae9b7f41e60^:git-rerere.perl; the
> records in this file are supposed to be NUL terminated (the paths are
> allowed to have LF in them).

Ah, OK. And it actually does do that correctly ("length = strlen(path) +
1"). So I think there isn't a bug there in rerere.

But if it's NUL-terminated, then using sed _definitely_ isn't portable
here. cut does work on Solaris in this case, but that might or might not
be portable to other systems with similar NUL problems. I'm not sure
what is the best route. We really just want to grab the sha1 from the
beginning of the first line. dd count=40? :)

-Peff
