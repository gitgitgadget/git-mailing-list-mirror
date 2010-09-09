From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] diff.c: call regfree to free memory allocated by
 regcomp when necessary
Date: Thu, 9 Sep 2010 15:15:57 -0400
Message-ID: <20100909191557.GB32508@sigill.intra.peff.net>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:15:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otmb8-0000WW-Jo
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab0IITPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:15:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52495 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab0IITPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:15:45 -0400
Received: (qmail 20955 invoked by uid 111); 9 Sep 2010 19:15:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:15:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:15:57 -0400
Content-Disposition: inline
In-Reply-To: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155885>

On Thu, Sep 09, 2010 at 02:02:45PM -0500, Brandon Casey wrote:

> @@ -919,7 +919,10 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
>  		free (ecbdata->diff_words->minus.orig);
>  		free (ecbdata->diff_words->plus.text.ptr);
>  		free (ecbdata->diff_words->plus.orig);
> -		free(ecbdata->diff_words->word_regex);
> +		if (ecbdata->diff_words->word_regex) {
> +			regfree(ecbdata->diff_words->word_regex);
> +			free(ecbdata->diff_words->word_regex);
> +		}

Makes sense, and closes a leak. But I wonder why word_regex is a pointer
to malloc'd memory at all? Couldn't it just be an actual regex_t inside
the diff_words struct, and we regcomp and regfree it?

I guess maybe having it be NULL is useful. You could check
diff_words->o->word_regex, but I suppose that would mean carrying an
extra variable around through the callchain.

-Peff
