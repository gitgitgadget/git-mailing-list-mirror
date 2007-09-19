From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Rework unquote_c_style to work on a strbuf.
Date: Wed, 19 Sep 2007 01:09:19 -0700
Message-ID: <7v4phrqdow.fsf@gitster.siamese.dyndns.org>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224121.24C3B344AB3@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXucl-0005PJ-6R
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbXISIJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbXISIJZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:09:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbXISIJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:09:24 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E96DB137DC4;
	Wed, 19 Sep 2007 04:09:42 -0400 (EDT)
In-Reply-To: <20070918224121.24C3B344AB3@madism.org> (Pierre Habouzit's
	message of "Tue, 18 Sep 2007 23:22:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58689>

Pierre Habouzit <madcoder@debian.org> writes:

> If the gain is not obvious in the diffstat, the resulting code is more
> readable, _and_ in checkout-index/update-index we now reuse the same buffer
> to unquote strings instead of always freeing/mallocing.
>
> This also is more coherent with the next patch that reworks quoting
> functions.
>
> The quoting function is also made more efficient scanning for backslashes
> and treating portions of strings without a backslash at once.
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-apply.c          |  125 +++++++++++++++++++++++-----------------------
>  builtin-checkout-index.c |   27 +++++-----
>  builtin-update-index.c   |   51 ++++++++++---------
>  fast-import.c            |   47 ++++++++---------
>  mktree.c                 |   25 +++++----
>  quote.c                  |   92 ++++++++++++++++------------------
>  quote.h                  |    2 +-
>  7 files changed, 184 insertions(+), 185 deletions(-)
> ...
> diff --git a/quote.c b/quote.c
> index 4df3262..67c6527 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -201,68 +201,62 @@ int quote_c_style(const char *name, char *outbuf, FILE *outfp, int no_dq)
>   * should free when done.  Updates endp pointer to point at
>   * one past the ending double quote if given.
>   */

You need to update the comment above which talks about the input
and return values.  You no longer return an allocated memory
which the caller should free.  You return something else.
