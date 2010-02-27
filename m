From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prune: honor --expire=never
Date: Fri, 26 Feb 2010 16:07:45 -0800
Message-ID: <7v4ol3ilri.fsf@alter.siamese.dyndns.org>
References: <20100226215916.GF5116@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Adam Simpkins <simpkins@facebook.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 01:08:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlAE0-0007pm-Dt
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 01:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966672Ab0B0AH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 19:07:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966660Ab0B0AHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 19:07:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1879D1AF;
	Fri, 26 Feb 2010 19:07:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9l3nNPA+smeiM18lRapnLSkd/Lc=; b=Lixe5y
	AmjAFXpyOTgo/CE7lsOjZs9SIvekqe5r7Hj4tKuPltNknXhUWnLUxQmIqdxXjhyf
	GijaHzFD9TDmipuGekfK2EntlsPDJjzLka4T2W6ok8wO+iipWkHcS+TBZnll3ViC
	K5e2F+KzNgrwSJCJL3DU5qCdt8FIcIzxPEGXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UYWei3Onv1e8AVqHbJSN1OOyJAy1sRRp
	+GR/8sHcuAUrrzeQqEbxR53Ym4SWacSXO7ViFY9e+2iWnmDgtTWYaIIEnDbkO90H
	hoMIFHtn8kKRbM0vz2xR8f84JQjo7zIzVLuGKplETXYJ+598Dyh+1DchZGCqhS9V
	Kp3JUn4okh4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0209D1AE;
	Fri, 26 Feb 2010 19:07:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 453A39D1AD; Fri, 26 Feb
 2010 19:07:47 -0500 (EST)
In-Reply-To: <20100226215916.GF5116@facebook.com> (Adam Simpkins's message of
 "Fri\, 26 Feb 2010 13\:59\:16 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 244CC4EC-2334-11DF-9188-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141162>

Adam Simpkins <simpkins@facebook.com> writes:

> diff --git a/builtin-prune.c b/builtin-prune.c
> index 4675f60..ce43271 100644
> --- a/builtin-prune.c
> +++ b/builtin-prune.c
> @@ -7,6 +7,8 @@
>  #include "parse-options.h"
>  #include "dir.h"
>  
> +#define ALWAYS_EXPIRE ((unsigned int)-1)
> ...
> @@ -34,7 +36,7 @@ static int prune_tmp_object(const char *path, const char *filename)
>  static int prune_object(char *path, const char *filename, const unsigned char *sha1)
>  {
>  	const char *fullpath = mkpath("%s/%s", path, filename);
> -	if (expire) {
> +	if (expire != ALWAYS_EXPIRE) {

Wouldn't it be a lot simpler to initialize expire to "now" for the default
case, and remove all these "if (expire)"?  I think that is how the logic
to expire reflog entries work, which I think is saner.

While you are at it, you might want to think about a way to unify what
parse_opt_approxidate_cb() and parse_expire_cfg_value() do.  The latter
knows about "expire = false" but the former doesn't, which is a slight
inconsistency.
