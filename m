From: Jeff King <peff@github.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Wed, 15 Jun 2011 20:38:00 -0400
Message-ID: <20110616003800.GC20355@sigill.intra.peff.net>
References: <7v7h8mir5u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 02:38:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX0b3-00014d-Dt
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 02:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab1FPAiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 20:38:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47977
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab1FPAiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 20:38:03 -0400
Received: (qmail 8861 invoked by uid 107); 16 Jun 2011 00:38:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 20:38:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 20:38:00 -0400
Content-Disposition: inline
In-Reply-To: <7v7h8mir5u.fsf@alter.siamese.dyndns.org>
 <7vboxyir8y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175877>

On Wed, Jun 15, 2011 at 04:55:57PM -0700, Junio C Hamano wrote:

> > +test_expect_success 'infer tgz from .tgz filename' '
> > +	git archive --output=j1.tgz HEAD &&
> > +	test_cmp j.tgz j1.tgz
> > +'
> 
> I suspect this would get intermittent failures for the same reason as
> 0c8c385 (gitweb: supply '-n' to gzip for identical output, 2011-04-26)

Ick, yeah. I pulled these tests from my original internal
implementation, which I suspect may have been more stable.

The filename will always be stdin, which is OK, but the timestamp will
probably get us.

> diff --git a/archive-tar-filter.c b/archive-tar-filter.c
> index de8719a..d6e4e32 100644
> --- a/archive-tar-filter.c
> +++ b/archive-tar-filter.c
> @@ -131,7 +131,7 @@ static void load_builtin_filters(void)
>  	struct tar_filter *tf;
>  
>  	tf = tar_filter_new("tgz", strlen("tgz"));
> -	tf->command = xstrdup("gzip");
> +	tf->command = xstrdup("gzip -n");
>  	string_list_append(&tf->extensions, "tgz");
>  	string_list_append(&tf->extensions, "tar.gz");
>  	tf->use_compression = 1;

This feels a little wrong, as we are changing what the tool outputs all
the time just to appease a poorly-written test. Maybe nobody cares about
the timestamp field (I certainly don't), but it seems like it might
surprise some users.

-Peff
