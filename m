From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates corruption issue
Date: Tue, 31 Jan 2012 12:25:45 -0800
Message-ID: <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
References: <1328018729.13744.26.camel@ted>
 <20120131193922.GA31551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart\, Darren" <darren.hart@intel.com>,
	"Ashfield\, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:26:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsKH3-00023U-RH
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 21:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab2AaUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 15:25:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab2AaUZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 15:25:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71CD86024;
	Tue, 31 Jan 2012 15:25:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xDSt1gSXe08aOXVCrs5hYms7FsY=; b=csHZmh
	rWB+GQOpblKC2XrQXd677hpM8f3sjeJ/T69Rqbjj0C7dKB2FuOMP3mcrxoOMn09t
	yxC9pf10dZU5xHyJe5/OMoUNq+UdOB0VRxcBz6UzMYzJxniUrg1H1uXEof22ba/h
	EZdYSvUki9b3PgCn91HIY0bOXmkyJy3Qqg68s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fnSuyq0GHNCb/THuwV1nztPZQr4u5rKD
	v5iKvTlrA3y2FxkibU56Dk411WhnmH+kMkj1vsNMDrhdWYoWUwze2nO0pudoV9Ui
	62PZXxAqctC2hT8xyYKFZlCqlVKYH7l3tRTg7JeY5FWvcTFx4ieqjeKnux3ak7T7
	USXS45tKtpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E9336023;
	Tue, 31 Jan 2012 15:25:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 915706022; Tue, 31 Jan 2012
 15:25:46 -0500 (EST)
In-Reply-To: <20120131193922.GA31551@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 Jan 2012 14:39:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1D456B8-4C49-11E1-87E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189470>

Jeff King <peff@peff.net> writes:

> I believe that would work in your case, but it seems like the most
> correct thing would actually be:
>
>   { "", "/.git", ".git" }
>
> That is:
>
>   1. Try the literal path the user gave as a repo
>
>   2. Otherwise, try it as the root of a working tree (containing .git)
>
>   3. Otherwise, assume they were too lazy to type ".git" and include it

That sounds sensible, together with this, to which I agree with:

> One way of dealing with that would be to make get_repo_path a little
> more robust by only selecting paths which actually look like git
> directories.

... but ...

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9084feb..0fbbae9 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -108,7 +108,7 @@ static const char *argv_submodule[] = {
>  
>  static char *get_repo_path(const char *repo, int *is_bundle)
>  {
> -	static char *suffix[] = { "/.git", ".git", "" };
> +	static char *suffix[] = { "/.git", "", ".git" };

... this does not match that simple and clear guideline.

Shouldn't this simply be { "", "/.git", ".git" }?

> diff --git a/path.c b/path.c
> index b6f71d1..1ca6567 100644
> --- a/path.c
> +++ b/path.c
> @@ -293,7 +293,7 @@ const char *enter_repo(const char *path, int strict)
>  
>  	if (!strict) {
>  		static const char *suffix[] = {
> -			".git/.git", "/.git", ".git", "", NULL,
> +			"/.git", "", ".git/.git", ".git", NULL,
>  		};

Neither does this.

Shouldn't this be { "", "/.git", ".git", ".git/.git", NULL }?

I must be missing something from your description...
