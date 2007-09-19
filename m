From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] sq_quote_argv and add_to_string rework with strbuf's.
Date: Wed, 19 Sep 2007 01:09:55 -0700
Message-ID: <7v3axbqdnw.fsf@gitster.siamese.dyndns.org>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224120.1DC44344AB3@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXudK-0005Y6-2Q
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbXISIKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbXISIKA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:10:00 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbXISIKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:10:00 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 32E9D137D88;
	Wed, 19 Sep 2007 04:10:19 -0400 (EDT)
In-Reply-To: <20070918224120.1DC44344AB3@madism.org> (Pierre Habouzit's
	message of "Tue, 18 Sep 2007 22:15:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58690>

Pierre Habouzit <madcoder@debian.org> writes:

> * sq_quote_buf is made public, and works on a strbuf.
> * sq_quote_argv also works on a strbuf.
> * make sq_quote_argv take a "maxlen" argument to check the buffer won't grow
>   too big.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  connect.c |   21 ++++++--------
>  git.c     |   16 +++-------
>  quote.c   |   91 ++++++++++++++++---------------------------------------------
>  quote.h   |    9 ++----
>  rsh.c     |   33 ++++++----------------
>  trace.c   |   35 +++++++-----------------
>  6 files changed, 60 insertions(+), 145 deletions(-)
> ...
> diff --git a/quote.c b/quote.c
> index d88bf75..4df3262 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -20,29 +20,26 @@ static inline int need_bs_quote(char c)
>  	return (c == '\'' || c == '!');
>  }
>  
> -static size_t sq_quote_buf(char *dst, size_t n, const char *src)
> +void sq_quote_buf(struct strbuf *dst, const char *src)
>  {

You got rid of use of EMIT() macro which is local to this
function, so you need to remove the #undef/#define in front of
the function as well.
