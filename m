From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: fix objectname:short bug
Date: Thu, 26 Aug 2010 18:15:36 -0400
Message-ID: <20100826221536.GA10418@coredump.intra.peff.net>
References: <AANLkTikhcAC6Nf=jWQN40ascodaCte6v6e1JPfv-=To-@mail.gmail.com>
 <1282858469-22116-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 00:16:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ookjm-00050A-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 00:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0HZWPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 18:15:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab0HZWPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 18:15:41 -0400
Received: (qmail 32263 invoked by uid 111); 26 Aug 2010 22:15:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Thu, 26 Aug 2010 22:15:40 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Aug 2010 18:15:36 -0400
Content-Disposition: inline
In-Reply-To: <1282858469-22116-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154567>

On Thu, Aug 26, 2010 at 05:34:29PM -0400, Jay Soffian wrote:

> When objectname:short was introduced, it forgot to copy the result of
> find_unique_abbrev. Because the result of find_unique_abbrev is a
> pointer to static buffer, this resulted in the same value being
> substituted in for each ref.

Yuck. I can't believe neither Michael nor I noticed this on first
review.

> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -228,7 +228,8 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>  			v->s = s;
>  		}
>  		else if (!strcmp(name, "objectname:short")) {
> -			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
> +			v->s = xstrdup(find_unique_abbrev(obj->sha1,
> +							  DEFAULT_ABBREV));

Your fix looks correct. It obviously leaks, but then so does 99% of the
rest of for-each-ref.

-Peff
