From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] alias.c: use git_config_string() to get alias_val
Date: Sat, 5 Apr 2008 19:39:56 +0200
Message-ID: <20080405173956.GD14565@leksak.fem-net>
References: <20080405121834.GB14565@leksak.fem-net> <200804051819.46904.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 19:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiCNr-0002JR-Ay
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 19:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYDERkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 13:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbYDERkM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 13:40:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:58232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752675AbYDERkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 13:40:11 -0400
Received: (qmail invoked by alias); 05 Apr 2008 17:40:09 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp021) with SMTP; 05 Apr 2008 19:40:09 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX190bTo5bCZ0hVeQL+88SIQM2Jrurti4x7cRuU6jwG
	J/65SSeQMvpxOf
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1JiCMu-0007hN-Rk; Sat, 05 Apr 2008 19:39:56 +0200
Mail-Followup-To: Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200804051819.46904.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78856>

Hi,

> Did you see:
> 
> "(And no, casting the "char **" into a "const char **" is not a good 
> solution either.)"
> 
> in the above page ?

Yes.

> > +	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key))
> > +		return git_config_string((const char**)&alias_val, k, v);
> 
> Are you sure this ugly cast to "const char**" is needed ?
> Isn't there a better way to do it ?

Well, because alias_val is not a constant[1], changing
	static char *alias_val;
to
	static const char *alias_val;
is not an option.

The only other way I see[2] atm is a brain-damaged:
--
static int alias_lookup_cb(const char *k, const char *v)
{
	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
		const char *tmp;
		int ret = git_config_string(&tmp, k, v);
		alias_val = xstrdup(tmp);
		/* actually, tmp should be free()'d. */
		return ret;
	}
	return 0;
}
--
But instead of doing that, the original should be kept, because it is
better in code beauty, performance and memory usage. ;-)

So I thought the casting is ugly, but it does no harm. I hope ;)
(Yes, a cast from const char ** to char ** is, indeed, dangerous.)

But if I miss an obvious point, please tell me :)

Regards,
 Stephan

Footnotes:
 [1] It is no constant because it is returned by alias_lookup(),
     and thus could be changed by further instructions.
 [2] ...between the many ways that result in compiler warnings ;-)

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
