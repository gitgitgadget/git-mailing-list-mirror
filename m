From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/5] xdiff: introduce XDF_IGNORE_CASE
Date: Wed, 22 Feb 2012 10:07:56 -0800 (PST)
Message-ID: <m3ehtmeo7c.fsf@localhost.localdomain>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
	<1329704188-9955-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 19:08:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Gbl-0005aE-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 19:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2BVSH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 13:07:59 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53540 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab2BVSH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 13:07:58 -0500
Received: by eekc14 with SMTP id c14so125099eek.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 10:07:57 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.119.202 as permitted sender) client-ip=10.14.119.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.119.202 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.119.202])
        by 10.14.119.202 with SMTP id n50mr16206946eeh.120.1329934077751 (num_hops = 1);
        Wed, 22 Feb 2012 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xROYE1aqSB34Fh0O137c2t5JxhOzclVtX835aDHm+yw=;
        b=BVoB3L3BZTPodnlIeD/rM5276BqyEk+syHH0AVhm0tzd4MzIqJCi15hFF94TuxlFKV
         gvxa3r/evHyLwqxo+dhHGLOQOTdAq1+0wV7vwRwSufHZnUD6OeLwcNk5KztzdB24OP9Y
         P3tIB4AGW9yGFEDJ7wso17eMcPetI2AhAfhqg=
Received: by 10.14.119.202 with SMTP id n50mr12984392eeh.120.1329934077572;
        Wed, 22 Feb 2012 10:07:57 -0800 (PST)
Received: from localhost.localdomain (abvp35.neoplus.adsl.tpnet.pl. [83.8.213.35])
        by mx.google.com with ESMTPS id c16sm105152663eei.1.2012.02.22.10.07.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 10:07:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1MI7rbP020537;
	Wed, 22 Feb 2012 19:07:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1MI7q9a020533;
	Wed, 22 Feb 2012 19:07:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1329704188-9955-5-git-send-email-gitster@pobox.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191266>

Junio C Hamano <gitster@pobox.com> writes:

> Teach the hash function and per-line comparison logic to compare lines
> while ignoring the differences in case.  It is not an ignore-whitespace
> option but still needs to trigger the inexact match logic, and that is
> why the previous step introduced XDF_INEXACT_MATCH mask.

Nb. how it compares with ignore case in filesystem paths?
 
> Assign the 7th bit for this option, and move the bits to select diff
> algorithms out of the way in order to leave room for a few bits to add
> more variants of ignore-whitespace, such as --ignore-tab-expansion, if
> somebody else is inclined to do so later.

Or do a proper Unicode sorting / collation algorithm, with different
levels 

  (4.3 Form a sort key for each string, UTS #10.):

     Level 1: alphabetic ordering
     Level 2: diacritic ordering
     Level 3: case ordering
     Level 4: tie-breaking (e.g. in the case when variable is 'shifted')

> We would still need to teach the front-end to flip this bit, for this
> change to be any useful.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

> +static inline int match_a_byte(char ch1, char ch2, long flags)
> +{
> +	if (ch1 == ch2)
> +		return 1;
> +	if (!(flags & XDF_IGNORE_CASE) || ((ch1 | ch2) & 0x80))
> +		return 0;
> +	if (isupper(ch1))
> +		ch1 = tolower(ch1);
> +	if (isupper(ch2))
> +		ch2 = tolower(ch2);
> +	return (ch1 == ch2);
> +}

<del>
Wouldn't a better solution be a collate algorithm rather than changing
a sorting function?  Or is it a performance hack on typical body of
text under version control (mainly lowercase)?
</del>

"(libc.info)Collation Fuctions" says:

     The functions `strcoll' and `wcscoll' perform this translation
  implicitly, in order to do one comparison.  By contrast, `strxfrm' and
  `wcsxfrm' perform the mapping explicitly.  If you are making multiple
  comparisons using the same string or set of strings, it is likely to be
  more efficient to use `strxfrm' or `wcsxfrm' to transform all the
  strings just once, and subsequently compare the transformed strings
  with `strcmp' or `wcscmp'.

The function match_a_byte (memcoll?) defined here is similar to strcoll;
do we compare single line with more than one other line?

> +static inline unsigned long hash_a_byte(const char ch_, long flags)
> +{
> +	unsigned long ch = ch_ & 0xFF;
> +	if ((flags & XDF_IGNORE_CASE) && !(ch & 0x80) && isupper(ch))
> +		ch = tolower(ch);
> +	return ch;
> +}
> +

Hmmm... hash_a_byte (memxfrm?) is similar to strxfrm, so you do use
one or the other...

-- 
Jakub Narebski
