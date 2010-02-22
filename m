From: Don Zickus <dzickus@redhat.com>
Subject: Re: 'git mailinfo' whitespace bug
Date: Mon, 22 Feb 2010 10:13:44 -0500
Message-ID: <20100222151344.GK3062@redhat.com>
References: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
 <7vzl343160.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 16:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nja5A-0002cR-Ua
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 16:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab0BVPUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 10:20:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab0BVPUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 10:20:17 -0500
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1MFDk53001748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 22 Feb 2010 10:13:46 -0500
Received: from redhat.com (dhcp-100-18-242.bos.redhat.com [10.16.18.242])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id o1MFDiHj003494;
	Mon, 22 Feb 2010 10:13:45 -0500
Content-Disposition: inline
In-Reply-To: <7vzl343160.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140689>

On Fri, Feb 19, 2010 at 09:51:19PM -0800, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > I bisected it, and this bug was introduced almost two years ago. In commit 
> > 3b6121f69b2 ("git-mailinfo: use strbuf's instead of fixed buffers"), to be 
> > exact. I'm pretty sure the bug is that handle_commit_msg() was changed to 
> > use 'strbuf_ltrim()' for the 'still_looking' case.
> >
> > Before commit 3b6121f69b2, it would create a new variable that had the 
> > trimmed results ("char *cp = line;"), after that commit it would just trim 
> > the line itself. Which is correct for the case of it being a header, but 
> > if it's the first non-header line, it's wrong.
> 
> True; trimming the body is obviously wrong.
> 
> But when is it correct to ltrim a header line?  It means we are going to
> accept a header (or header-looking line in body) that is indented.  I
> don't know why 87ab799 (builtin-mailinfo.c 2007-03-12) was coded that way.

In regards to 87ab799, I just deleted and pasted it from the function
handle_inbody_header (which you can see from that commit).  The original
code for those lines came from ae448e3854d8b6e7e37aa88fa3917f5dd97f3210.
Perhaps I misused it when I moved it.

Your patch belows seems to make sense for what its worth.

Cheers,
Don

> 
> 
>  builtin-mailinfo.c |    3 +--
>  t/t5100/msg0015    |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index a50ac22..ce2ef6b 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -779,8 +779,7 @@ static int handle_commit_msg(struct strbuf *line)
>  		return 0;
>  
>  	if (still_looking) {
> -		strbuf_ltrim(line);
> -		if (!line->len)
> +		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
>  			return 0;
>  	}
>  
> diff --git a/t/t5100/msg0015 b/t/t5100/msg0015
> index 9577238..4abb3d5 100644
> --- a/t/t5100/msg0015
> +++ b/t/t5100/msg0015
> @@ -1,2 +1,2 @@
> -- a list
> +  - a list
>    - of stuff
