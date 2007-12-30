From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sat, 29 Dec 2007 16:44:30 -0800
Message-ID: <7vir2h9fkh.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	<Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 01:45:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8mIj-0006bq-TE
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 01:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbXL3Aop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 19:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXL3Aop
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 19:44:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbXL3Aoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 19:44:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EA2E458EC;
	Sat, 29 Dec 2007 19:44:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DE1558EB;
	Sat, 29 Dec 2007 19:44:37 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 29 Dec 2007 20:22:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69340>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Certain codepaths (notably "git log --pretty=format...") use
> prefixcmp() extensively, with very short prefixes.  In those cases,
> calling strlen() is a wasteful operation, so avoid it.
>
> Initial patch by Marco Costalba.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	On Sat, 29 Dec 2007, Marco Costalba wrote:
>
> 	> In case the prefix string is a single char avoid a costly call 
> 	> to strlen() + strncmp()
>
> 	Could you test this patch, please?
>
> 	Not only does it avoid the strlen() call also for longer prefixes; 
> 	it also avoids a C++ comment.
>
>  git-compat-util.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 79eb10e..7059cbd 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -398,7 +398,11 @@ static inline int sane_case(int x, int high)
>  
>  static inline int prefixcmp(const char *str, const char *prefix)
>  {
> -	return strncmp(str, prefix, strlen(prefix));
> +	for (; ; str++, prefix++)
> +		if (!*prefix)
> +			return 0;
> +		else if (*str != *prefix)
> +			return (unsigned char)*prefix - (unsigned char)*str;
>  }

Losing the unnecessary check for !str || !prefix is a good
change.

While I think, for the readability's sake, Marco's original
without the unnecessary check would be the way to go, a profile
from your totally inlined version would also be interesting, as
it may or may not beat the underlying strncmp(), which could be
highly optimized.
