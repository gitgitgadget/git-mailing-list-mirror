From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 16:02:51 -0500
Message-ID: <20111014210251.GD16371@elie.hsd1.il.comcast.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:03:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REouK-0002aO-8X
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1JNVDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:03:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36315 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab1JNVDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:03:02 -0400
Received: by gyb13 with SMTP id 13so1527567gyb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XdLIPBqmlszIGS6AtaPBnbV9vP59s6rIRRw/u7OoM8U=;
        b=emWELlAjDNik9GV8GAYsahBekqV6S5Hw1ijlMS63WlggmHZ5x9w9AOp+PRQYsbH5Xb
         D7LqSZxYlVc0dPWw4n47En3G/ODIu4J5bEwVTTN/rBjFXg5pPpo/p9XXIhWM3cFCaivY
         /RvRww8IJ4csD6DDZw02M6OgPppsBnf6pjQG4=
Received: by 10.236.145.74 with SMTP id o50mr14688094yhj.36.1318626181601;
        Fri, 14 Oct 2011 14:03:01 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 8sm12725384anv.9.2011.10.14.14.02.59
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 14:03:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111014192326.GA7713@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183610>

Jeff King wrote:

> When the git-daemon is asked about an inaccessible
> repository, it simply hangs up the connection without saying
> anything further. This makes it hard to distinguish between
> a repository we cannot access (e.g., due to typo), and a
> service or network outage.

*nod*

> Instead, let's print an "ERR" line, which git clients
> understand since v1.6.1 (2008-12-24).

Just to be clear, "git archive --remote" does not understand ERR lines
in the 'master' branch (though 908aaceb makes it understand them in
'next').  But I consider even distinguishing

 a. fatal: git archive: protocol error
 b. fatal: git archive: expected ACK/NAK, got EOF

[(a) is how an ERR response is reported, and (b) a remote hangup] to
be progress, so it's not so important. :)

> Because there is a risk of leaking information about
> non-exported repositories, by default all errors simply say
> "access denied". Open sites can pass a flag to turn on more
> specific messages.

I'm not sure what an "open site" is. :)  But having this flag for
sites to declare whether they consider whether a repository exists to
be privileged information seems reasonable to me.

Note that this really would be privileged information in some
not-too-weird cases.  For example, if many users have a repository at
~/.git, ~/.config/.git, or ~/src/linux/.git, then someone might try to
access

	/home/alice/.git
	/home/alice/.config/.git
	/home/alice/src/linux/.git
	/home/bob/.git
	...

in turn to find a valid username, as reconnaisance for a later
attack not involving git.

Luckily, this can be avoided with

	git daemon --user-path=public_git --base-path=/pub/git

which only allows access to subdirectories of /pub/git and
public_git in home directories.  With

	git daemon --base-path=/pub/git

there is still no problem, since access to home directories is not
allowed at all in that case.  I suppose the documentation should
mention that --informative-errors is best not used unless --base-path
is also in use.  (Almost everyone is already using --base-path, so
this isn't a very serious problem.)

> --- a/daemon.c
> +++ b/daemon.c
> @@ -20,6 +20,7 @@
[...]
> @@ -1167,6 +1176,14 @@ int main(int argc, char **argv)
>  			make_service_overridable(arg + 18, 0);
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--informative-errors")) {
> +			informative_errors = 1;
> +			continue;
> +		}
> +		else if (!prefixcmp(arg, "--no-informative-errors")) {
> +			informative_errors = 0;
> +			continue;
> +		}
>  		if (!strcmp(arg, "--")) {

Micronit: uncuddled "else".  The style of the surrounding code is to
just not include the "else" at all and rely on "continue" to
short-circuit things.

Anyway, except for the documentation nits mentioned above (and Junio's
nit, too),

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks a lot for this.
