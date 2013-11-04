From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use suffixcmp() instead
Date: Mon, 04 Nov 2013 11:19:43 -0800
Message-ID: <xmqqbo20ynxs.fsf@gitster.dls.corp.google.com>
References: <20131103201303.14446.7508.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 04 20:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdPgl-0004tH-6K
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 20:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab3KDTTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 14:19:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab3KDTTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 14:19:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFF74F009;
	Mon,  4 Nov 2013 14:19:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iOk2BIit4sgUFtQ7EDdEdoxCqFs=; b=sWBoZ2
	JhF44HjVrqEB9CwBO5hVHSpQkL9Ij1Lf9JsPGxUSPQXItn2KtUDOQavfHTtxf4nD
	uXhvZ+Kf1uZDaoY4TWGWtVptKOJFlZAcAu52wz+118aaDc6LK+Yy4oe4MNnDm0E9
	J7j3YhvVGFicQTmL8XnW/iqvuz53wJJXtagjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M8lJWXYt4URNzMEne2eakdvnw9b4t2SZ
	LVGLEjG4VnT95ciogZOd2dFYPx6lnKmHXDRleVKdapmCB5Tovc6encpjx1ltXHdf
	K8rTnfpNk2WkuPJ9rfQCZIYlxOhbWWp7QUhbLkY8PVR3E13TsUOWNHLw0jk35MAK
	I+SCSWmVukI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2B514F008;
	Mon,  4 Nov 2013 14:19:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D4424EFFB;
	Mon,  4 Nov 2013 14:19:45 -0500 (EST)
In-Reply-To: <20131103201303.14446.7508.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 03 Nov 2013 21:13:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 104BFFD0-4586-11E3-AB4F-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237298>

Christian Couder <chriscool@tuxfamily.org> writes:

> Commit 8cc5b290 (git merge -X<option>, 25 Nov 2009) introduced
> suffixcmp() with nearly the same implementation as postfixcmp()
> that already existed since commit 211c8968 (Make git-remote a
> builtin, 29 Feb 2008).

This "nearly the same" piqued my curiosity ;-)

The postfixcmp() you are removing will say "f" > ".txt" while
suffixcmp() will say "f" < ".txt".

As postfixcmp() is only used to compare for equality, the
distinction does not matter and does not affect the correctness of
this patch, but I am not sure which answer is more correct.

I do not think anybody sane uses prefixcmp() or suffixcmp() for
anything but checking with zero; in other words, I suspect that all
uses of Xcmp() can be replaced with !!Xcmp(), so as a separate
clean-up patch, we may at least want to make it clear that the
callers should not expect anything but "does str have sfx as its
suffix, yes or no?" by doing something like this:

 int suffixcmp(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
 	if (len < suflen)
 		return -1;
 	else
-		return strcmp(str + len - suflen, suffix);
+		return !!strcmp(str + len - suflen, suffix);
 }

I am not absolutely sure about doing the same to prefixcmp(),
though. It could be used for ordering, even though no existing code
seems to do so.

> As postfixcmp() has always been static in builtin/remote.c
> and is used nowhere else, it makes more sense to remove it
> and use suffixcmp() instead in builtin/remote.c, rather than
> to remove suffixcmp().
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/remote.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 4e14891..9b3a98e 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -80,14 +80,6 @@ static int verbose;
>  static int show_all(void);
>  static int prune_remote(const char *remote, int dry_run);
>  
> -static inline int postfixcmp(const char *string, const char *postfix)
> -{
> -	int len1 = strlen(string), len2 = strlen(postfix);
> -	if (len1 < len2)
> -		return 1;
> -	return strcmp(string + len1 - len2, postfix);
> -}
> -
>  static int fetch_remote(const char *name)
>  {
>  	const char *argv[] = { "fetch", name, NULL, NULL };
> @@ -277,13 +269,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  		enum { REMOTE, MERGE, REBASE } type;
>  
>  		key += 7;
> -		if (!postfixcmp(key, ".remote")) {
> +		if (!suffixcmp(key, ".remote")) {
>  			name = xstrndup(key, strlen(key) - 7);
>  			type = REMOTE;
> -		} else if (!postfixcmp(key, ".merge")) {
> +		} else if (!suffixcmp(key, ".merge")) {
>  			name = xstrndup(key, strlen(key) - 6);
>  			type = MERGE;
> -		} else if (!postfixcmp(key, ".rebase")) {
> +		} else if (!suffixcmp(key, ".rebase")) {
>  			name = xstrndup(key, strlen(key) - 7);
>  			type = REBASE;
>  		} else
