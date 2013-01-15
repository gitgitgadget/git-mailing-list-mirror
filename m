From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Tue, 15 Jan 2013 07:50:43 -0800
Message-ID: <20130115155043.GA21815@sigill.intra.peff.net>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 16:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv8nJ-0002kA-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 16:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab3AOPus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 10:50:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34086 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141Ab3AOPuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 10:50:46 -0500
Received: (qmail 30243 invoked by uid 107); 15 Jan 2013 15:52:03 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Jan 2013 10:52:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2013 07:50:43 -0800
Content-Disposition: inline
In-Reply-To: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213639>

On Mon, Jan 14, 2013 at 03:36:21PM -0800, Junio C Hamano wrote:

> It appears that memcmp() uses the usual "one word at a time"
> comparison and triggers valgrind in a callback of bsearch() used in
> the refname search.  I can easily trigger problems in any script
> with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
> without this suppression.

Out of curiosity, what platform do you see this on? I can't reproduce on
glibc.

> diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
> index 0a6724f..032332f 100644
> --- a/t/valgrind/default.supp
> +++ b/t/valgrind/default.supp
> @@ -49,3 +49,11 @@
>  	Memcheck:Addr4
>  	fun:copy_ref
>  }
> +
> +{
> +	ignore-memcmp-reading-too-much-in-bsearch-callback
> +	Memcheck:Addr4
> +	fun:ref_entry_cmp_sslice
> +	fun:bsearch
> +	fun:search_ref_dir
> +}

Given that it is valgrind-clean on my platform, and reading the code I
don't see any problems, I think it probably is a false positive, and
this suppression makes sense.

-Peff
