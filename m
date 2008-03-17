From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 17:35:31 -0700
Message-ID: <7vlk4ichm4.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
 <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161716470.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 01:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb3LR-0002y6-6l
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 01:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYCQAft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 20:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYCQAfs
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 20:35:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbYCQAfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 20:35:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC9C1287D;
	Sun, 16 Mar 2008 20:35:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 99208287B; Sun, 16 Mar 2008 20:35:42 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803161716470.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 16 Mar 2008 17:28:36 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77406>

Daniel Barkalow <barkalow@iabervon.org> writes:

> We don't currently have any concept of an invalid refspec;

We don't? or just that parse_ref_spec() does not detect one?

> ... we just have 
> things that fall back to not being patterns and not being possible to 
> match (due to one or the other side being invalid as a ref name).

I am afraid that is an invitation for more bugs and confusions.

It probably is not too late to fix this; users would rather want to see
their misconfigurations clearly flagged as such, rather than the code
letting bogosity through silently and doing something that does not
exactly match what they configured.

> diff --git a/remote.c b/remote.c
> index f3f7375..fffde34 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -404,18 +404,17 @@ struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
>  			rs[i].force = 1;
>  			sp++;
>  		}
> -		gp = strchr(sp, '*');
> +		gp = strstr(sp, "/*");
>  		ep = strchr(sp, ':');
>  		if (gp && ep && gp > ep)
>  			gp = NULL;

How would this trigger?  We find * (or /*) but that is the one on the LHS,
which means the spec was like "refs/heads/foobar:refs/remotes/origin/*",
and it makes me wonder if we should mark this as an configuration error.

Did erroring out on "gp && ep && gp > ep" here have issues (i.e. reject a
valid configuration)?

>  		if (ep) {
>  			if (ep[1]) {
> -				const char *glob = strchr(ep + 1, '*');
> +				const char *glob = strstr(ep + 1, "/*");
>  				if (!glob)
>  					gp = NULL;
>  				if (gp)
> -					rs[i].dst = xstrndup(ep + 1,
> -							     glob - ep - 1);
> +					rs[i].dst = xstrndup(ep + 1, glob - ep);

This truncates "refs/heads/*:refs/remotes/origin/*/bar" as if it did not
have "/bar" without any error indication.  The same questions apply.
