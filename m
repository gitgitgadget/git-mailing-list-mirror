From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] color: delay auto-color decision until point of
 use
Date: Thu, 18 Aug 2011 14:59:37 -0700
Message-ID: <7vvctu7402.fsf@alter.siamese.dyndns.org>
References: <20110818045821.GA17377@sigill.intra.peff.net>
 <20110818050421.GG2889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:24:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuB0U-0003Jb-Ou
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab1HRWYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:24:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42042 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737Ab1HRWX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:23:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDB1F435D;
	Thu, 18 Aug 2011 18:23:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=335ZYbHljYQ5KC7bk1vh1xcOXi8=; b=LTG3Ra+k1lZiltvBYOhy
	bej+s6dq/TxON8a4PkgVdnQO+e3jCHUEHvG7D8h4CXz1ehezmZqKaXakFat5hr0C
	peNmvMsxG0g7FSdcilzE6FO5O2O948ntJhsVD+k5FVMRKkuPKPDE4j6RNhIamHXV
	5iPBFZ1pRbDgm2kqDlt9lEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Qv8s5J2l25laBMys0cnetdQCkwuF1l+8qHOamSYGqN5wc7
	SbaQLDGXr1gUfzi8PxiKUjCjaaPnlJiefqj9dMThH1ZeWx0GczAKWHrwLsAr+ss9
	Aopz/Fum93z7KZvUyXGdll2w8j2vVQu0RQn8PrMYZcqoSNvoF5c2mIlfg62/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C42BE435C;
	Thu, 18 Aug 2011 18:23:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57C8C435A; Thu, 18 Aug 2011
 18:23:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4470208-C9E8-11E0-B87E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179643>

Jeff King <peff@peff.net> writes:

> diff --git a/color.h b/color.h
> index a190a25..d715fd5 100644
> --- a/color.h
> +++ b/color.h
> @@ -49,6 +49,16 @@ struct strbuf;
>  #define GIT_COLOR_NIL "NIL"
>  
>  /*
> + * The first three are chosen to match common usage in the code, and what is
> + * returned from git_config_colorbool. The "auto" value can be returned from
> + * config_colorbool, and will be converted by want_color() into either 0 or 1.
> + */
> +#define GIT_COLOR_UNKNOWN -1
> +#define GIT_COLOR_ALWAYS 0
> +#define GIT_COLOR_NEVER  1
> +#define GIT_COLOR_AUTO   2

The ALWAYS/NEVER somehow go against my intuition. Let me trace one
codepath starting from git_branch_config().

    branch_use_color is set from git_config_colorbool("color.branch");
    -> given "never", git_config_colorbool() returns 0;
    branch_get_color() asks want_color(branch_use_color);
    -> want_color() returns if the given value is positive.

Because git_config_colorbool() does not use the above symbolic constants,
everything goes well, but aren't these two swapped?
