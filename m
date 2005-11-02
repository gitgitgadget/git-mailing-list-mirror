From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Warn when calling deref_tag() on broken tags
Date: Thu, 3 Nov 2005 00:42:32 +0100
Message-ID: <20051102234232.GG1431@pasky.or.cz>
References: <20051102200751.26904.5780.stgit@machine.or.cz> <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de> <20051102204101.GE1431@pasky.or.cz> <7vhdauocv6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 00:43:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXSFb-0002dx-5i
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 00:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVKBXmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVKBXmf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 18:42:35 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21125 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030208AbVKBXme (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 18:42:34 -0500
Received: (qmail 10319 invoked by uid 2001); 3 Nov 2005 00:42:32 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdauocv6.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11059>

Dear diary, on Thu, Nov 03, 2005 at 12:21:01AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Good idea. Not that I would be excited by the awing elegancy of the
> > patch...
> 
> It turns out to be not so good idea.  Some places call deref_tag
> just to see if we can unwrap it but not having the referenced
> object but having the tag object does not necessarily mean a
> corrupt repository.

Aha, that didn't occur to me initially. Yes, what you did is fine by me
(not that I would be overly proficient in this part of code).

> diff --git a/tag.c b/tag.c
> index b1ab75f..e574c4b 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -3,10 +3,15 @@
>  
>  const char *tag_type = "tag";
>  
> -struct object *deref_tag(struct object *o)
> +struct object *deref_tag(struct object *o, const char *warn, int warnlen)
>  {
>  	while (o && o->type == tag_type)
>  		o = parse_object(((struct tag *)o)->tagged->sha1);
> +	if (!o && warn) {
> +		if (!warnlen)
> +			warnlen = strlen(warn);
> +		error("missing object referenced by '%.*s'", warnlen, warn);
> +	}
>  	return o;
>  }
>  

It should still be a warning, not an error, though. I'd also mention the
"tag" keyword in the message.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
