From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC 03/11] Allow programs to not depend on remotes having
 urls
Date: Mon, 27 Jul 2009 15:33:32 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907271501300.2147@iabervon.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <1248656659-21415-4-git-send-email-johan@herland.net> <7v1vo2j6qo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 21:34:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVVxW-0003O7-CM
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 21:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbZG0Tde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbZG0Tdd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 15:33:33 -0400
Received: from iabervon.org ([66.92.72.58]:59610 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbZG0Tdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 15:33:33 -0400
Received: (qmail 18400 invoked by uid 1000); 27 Jul 2009 19:33:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jul 2009 19:33:32 -0000
In-Reply-To: <7v1vo2j6qo.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124188>

On Mon, 27 Jul 2009, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
> > index 78a88f7..4c6fc58 100644
> > --- a/builtin-ls-remote.c
> > +++ b/builtin-ls-remote.c
> > @@ -87,9 +87,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> >  		}
> >  	}
> >  	remote = nongit ? NULL : remote_get(dest);
> > -	if (remote && !remote->url_nr)
> > +	if (!nongit && !remote)
> >  		die("remote %s has no configured URL", dest);
> 
> It appears to me that remote_get() calls make_remote() that never returns
> NULL, thus this check will never trigger.  At least, the die() message
> needs to be updated, since remote_get() may return NULL for some reason
> other than "no configured URL", but the condition the message says is not
> what this code checks.

The previous patch in the series causes remote_get() to return NULL if 
the remote configuration is invalid. You're right, however, that the 
message should be something more directly accurate.

> It is Ok if the new world order is that the URL does not have to be known
> before transport_get() is called, but if that is the case, it should be
> made clear by removing this check from here (and possibly having a new
> check elsewhere where it really matters, e.g. somewhere in transport
> code).

This spot is trying to make sure that the remote was valid, according to 
remote.c

> > -	transport = transport_get(remote, remote ? remote->url[0] : dest);
> > +	transport = transport_get(remote, remote ? NULL : dest);
> >  	if (uploadpack != NULL)
> >  		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
