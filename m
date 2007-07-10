From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add for_each_remote() function, and extend remote_find_tracking()
Date: Mon, 09 Jul 2007 22:07:00 -0700
Message-ID: <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081336020.4248@racer.site>
	<7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
	<7vhcoexqeh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707091228290.5546@racer.site>
	<7v4pkduw2f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707092203100.5546@racer.site>
	<7vzm25tex6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707100401070.4131@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 07:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I87wK-00083h-MN
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 07:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXGJFHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 01:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXGJFHF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 01:07:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55532 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbXGJFHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 01:07:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070710050700.AJE22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 10 Jul 2007 01:07:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mh701X00N1kojtg0000000; Tue, 10 Jul 2007 01:07:01 -0400
In-Reply-To: <Pine.LNX.4.64.0707100401070.4131@racer.site> (Johannes
	Schindelin's message of "Tue, 10 Jul 2007 04:02:02 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52042>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The function for_each_remote() does exactly what the name suggests.
>
> The function remote_find_tracking() was extended to be able to search
> remote refs for a given local ref.  You have to set the parameter
> "reverse" to true for that behavior.
>
> Both changes are required for the next step: simplification of
> git-branch's --track functionality.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	You're right. I completely missed that functionality. Well, a
> 	few tweaks were needed. If this clashes too seriously with
> 	Daniel's work, I will gladly redo it after his changes are
> 	in "next".

No offence meant to Daniel, but I am inclined to postpone the
current round of changes from him to move the stuff further
to get us closer to built-in git-fetch until 1.5.3 final is
done.  The amount of C code changes otherwise would be a bit too
much for me to be comfortable between -rc0 and -rc1.

> diff --git a/remote.c b/remote.c
> index cf98a44..21adb0d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -279,6 +279,26 @@ struct remote *remote_get(const char *name)
>  	return ret;
>  }
>  
> +int for_each_remote(each_remote_fn fn, void *priv)
> +{
> ...
> +		if ((result = fn(r, priv)))
> +			break;

Just a minor style, but (you know what comes)...

> @@ -289,34 +309,36 @@ int remote_has_uri(struct remote *remote, const char *uri)
>  	return 0;
>  }
>  
> +int remote_find_tracking(struct remote *remote, struct refspec *refspec,
> +		int reverse)
>  {
>  	int i;
>  	for (i = 0; i < remote->fetch_refspec_nr; i++) {
>  		struct refspec *fetch = &remote->fetch[i];
> +		const char *src = reverse ? fetch->dst : fetch->src;
> +		const char *dst = reverse ? fetch->src : fetch->dst;

I have to agree with Daniel here --- variable names src and dst
are quite confusing.  It seems to mean that "we search with
'src' to fill 'dst', but if reverse incoming refspec is given
reversed so matching refspec->src with what in fact is 'dst' in
the configuration file is fine".  Utterly confusing.

Even though this is a good opportunity for you to improve your
comment ratio in ohloh stats, I doubt any amount of explanation
can unconfuse readers of this code.

>  		if (!fetch->dst)
>  			continue;
>
>  		if (fetch->pattern) {
> +			if (!prefixcmp(refspec->src, src)) {
>  				refspec->dst =
> +					xmalloc(strlen(dst) +
>  						strlen(refspec->src) -
> +						strlen(src) + 1);
> +				strcpy(refspec->dst, dst);
> +				strcpy(refspec->dst + strlen(dst),
> +				       refspec->src + strlen(src));
>  				refspec->force = fetch->force;
>  				return 0;
>  			}
>  		} else {
> +			if (!strcmp(refspec->src, src)) {
> +				refspec->dst = xstrdup(dst);
>  				refspec->force = fetch->force;
>  				return 0;
>  			}
>  		}
>  	}
> -	refspec->dst = NULL;
>  	return -1;
>  }

The original remote_find_tracking() took a single remote and a
refspec with src filled, and returned the given refspec after
filling its dst, if an appropriate tracking was configured for
the remote.  What you want to do is from the same remote
information and a refspec with dst filled to find a src branch
that would be stored to that dst.

In either case, incoming refspec would not have both src and dst
filled.  The caller has one side of the information and asking
for the other.  As Daniel suggests, the 'reverse' parameter is
not needed.  If you must have it, please do not call it
'reverse' -- it is more like "find_by_dst".

Following Daniel's suggestion might make the code a bit
lengthier, but I think that would not be as confusing.

> diff --git a/send-pack.c b/send-pack.c
> index fecbda9..9fdd7b4 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -305,8 +305,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
>  		if (remote) {
>  			struct refspec rs;
>  			rs.src = ref->name;
> -			remote_find_tracking(remote, &rs);
> -			if (rs.dst) {
> +			if (!remote_find_tracking(remote, &rs, 0)) {
>  				struct ref_lock *lock;
>  				fprintf(stderr, " Also local %s\n", rs.dst);
>  				if (will_delete_ref) {
