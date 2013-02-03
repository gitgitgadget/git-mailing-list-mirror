From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] fix clang -Wtautological-compare with unsigned enum
Date: Sun, 3 Feb 2013 11:38:28 -0800
Message-ID: <20130203193816.GA3221@elie.Belkin>
References: <cover.1359901732.git.john@keeping.me.uk>
 <a9fe675ed9b34d3c15f4678ee13e90cddaa36055.1359901732.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U25P1-0002iP-Ky
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 20:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab3BCTih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 14:38:37 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:64390 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab3BCTig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 14:38:36 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so2073507pbc.25
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 11:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S8BfODhwIvKFl551RXqhU153CBOR3SfTMuKnUy3l4uo=;
        b=mT71qfqE5/pDjMVNdTh25gv3Q0ySid5s5E82xFIuMpc66u0htohjuQy8ozN7jR0eJj
         XdcgGVKqG27pMmqcko+HGNC6NkrigimpVzYtqcleS5Ezj91ACwnn41hJ6kSUHPwK3IQl
         LD0Hv59rXhsGoTCTlErhuZQ/BJZC/Xir3xG/9sQ++170pBVCYdAqxZouCkif9gq/sr2X
         AHAHnnmLUQy/52ia/ItMVhfaJ8M9uxoHa5bZG15VxeIk7ati/uAtm0eLusbRbQ76z+tp
         L9pblDluPB7284Uh+UFdX82KNjVYEfIqvrxXUE0XbyzF/eK+0u2vkDMcJqEMDOViL5sw
         aAZQ==
X-Received: by 10.68.131.35 with SMTP id oj3mr49595216pbb.17.1359920316103;
        Sun, 03 Feb 2013 11:38:36 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ou3sm14503198pbb.46.2013.02.03.11.38.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 11:38:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a9fe675ed9b34d3c15f4678ee13e90cddaa36055.1359901732.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215324>

John Keeping wrote:

> From: Antoine Pelisse <apelisse@gmail.com>
>
> Create a GREP_HEADER_FIELD_MIN so we can check that the field value is
> sane and silent the clang warning.

Thanks.  Looks good to me.

[...]
> --- a/grep.c
> +++ b/grep.c
> @@ -625,7 +625,8 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
>  	for (p = opt->header_list; p; p = p->next) {
>  		if (p->token != GREP_PATTERN_HEAD)
>  			die("bug: a non-header pattern in grep header list.");
> -		if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
> +		if (p->field < GREP_HEADER_FIELD_MIN ||
> +		    GREP_HEADER_FIELD_MAX <= p->field)
>  			die("bug: unknown header field %d", p->field);

I also think it would be fine to drop this test or replace it with an

	assert((unsigned) p->field < ARRAY_SIZE(header_field));

because we know the test never trips.
