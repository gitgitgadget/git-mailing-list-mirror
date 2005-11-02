From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Warn when calling deref_tag() on broken tags
Date: Wed, 02 Nov 2005 13:18:43 -0800
Message-ID: <7vbr12px3g.fsf@assigned-by-dhcp.cox.net>
References: <20051102200751.26904.5780.stgit@machine.or.cz>
	<Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051102204101.GE1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 22:21:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXQ0f-0004FL-0o
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 22:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVKBVSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 16:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbVKBVSp
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 16:18:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:3995 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965247AbVKBVSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 16:18:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102211752.YISE2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 16:17:52 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051102204101.GE1431@pasky.or.cz> (Petr Baudis's message of
	"Wed, 2 Nov 2005 21:41:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11043>

Petr Baudis <pasky@suse.cz> writes:

> +struct object *deref_tag(struct object *o, const char *refname)
>  {
> +	struct object *o2 = o;
>  	while (o && o->type == tag_type)
> -		o = parse_object(((struct tag *)o)->tagged->sha1);
> +		o = parse_object(((struct tag *)(o2 = o))->tagged->sha1);
> +	if (!o)
> +		fprintf(stderr, "warning: invalid tag %s\n",
> +		        refname ? refname
> +		        : (o2 ? sha1_to_hex(o2->sha1)
> +		           : "<unknown> (this is probably internal GIT error)"));
>  	return o;
>  }

I wonder if it would make more sense to keep the root of the
traversal for this function (i.e. the original value of o) for
error reporting purposes, like this:

        struct object *deref_tag(struct object *o, const char *refname)
        {
                struct object *o2 = o;
                while (o && o->type == tag_type)
                        o = parse_object(((struct tag *)o)->tagged->sha1);
                if (!o)
                        fprintf(stderr, "warning: invalid tag %s\n",
                                refname ? refname
                                : (o2 ? sha1_to_hex(o2->sha1)
                                   : "<unknown> (this is probably internal GIT error)"));
                return o;
        }

What do you think?

Other than that, the patch is OK by me.  Thanks.
