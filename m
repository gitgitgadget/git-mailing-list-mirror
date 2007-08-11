From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH resend] git-apply: apply submodule changes
Date: Sat, 11 Aug 2007 08:45:55 +0200
Message-ID: <20070811064555.GC29996@liacs.nl>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org> <20070810135744.GA29243MdfPADPa@greensroom.kotnet.org> <7vd4xupqwh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 08:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJkjl-0003Bt-PE
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 08:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbXHKGqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 02:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbXHKGqJ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 02:46:09 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46910 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbXHKGqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 02:46:08 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l7B6jtuI022538;
	Sat, 11 Aug 2007 08:46:00 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 483133C00C; Sat, 11 Aug 2007 08:45:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4xupqwh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55590>

On Fri, Aug 10, 2007 at 10:43:42PM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> >  	else if (patch->old_name) {
> >  		size = xsize_t(st->st_size);
> >  		alloc = size + 8192;
> >  		buf = xmalloc(alloc);
> > -		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
> > +		if (S_ISGITLINK(patch->old_mode))
> > +			size = snprintf(buf, alloc,
> > +				"Subproject commit %s\n", sha1_to_hex(ce->sha1));
> > +		else if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
> 
> Who guarantees that ce is given to apply_data() in this codepath?

Oops.  I guess it shows that I only tested it through git-rebase.
Would changing

		if (check_index) {

on line 2093 to

		if (check_index || S_ISGITLINK(patch->old_mode)) {

be acceptable?  Adding a conditional call to read_cache(), of course.
We're not going to be able to apply submodule patches without
an index, anyway.
Or should we just refuse to apply submodule patches if --index
has not been specified?

skimo
