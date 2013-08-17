From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Sat, 17 Aug 2013 07:58:39 +0100
Organization: OPDS
Message-ID: <E5FB18126E7F42D79E085F3924AC9E07@PhilipOakley>
References: <EE5B338564E14F89B349550B37741AFF@PhilipOakley> <1376688157-8374-1-git-send-email-stefanbeller@googlemail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <sunshine@sunshineco.com>, <nico@fluxnic.net>
To: "Stefan Beller" <stefanbeller@googlemail.com>,
	<git@vger.kernel.org>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 09:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAaYX-000840-VF
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 09:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab3HQG6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 02:58:40 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:36204 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721Ab3HQG6j (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Aug 2013 02:58:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AncNAKAdD1JOl3GZ/2dsb2JhbABbgwZgiH62SQQEAYEhF3RoAQGBHwEBFAEEAQEEAQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBxcGARIIAgECAwGFOAcBgiANAwkKsEINiF6NVYEsEg2BMIMidwOIdYYOhQqNf4ctgTeBZjuBLAIHFgE
X-IPAS-Result: AncNAKAdD1JOl3GZ/2dsb2JhbABbgwZgiH62SQQEAYEhF3RoAQGBHwEBFAEEAQEEAQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBxcGARIIAgECAwGFOAcBgiANAwkKsEINiF6NVYEsEg2BMIMidwOIdYYOhQqNf4ctgTeBZjuBLAIHFgE
X-IronPort-AV: E=Sophos;i="4.89,900,1367967600"; 
   d="scan'208";a="585775769"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with SMTP; 17 Aug 2013 07:58:37 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232453>

From: "Stefan Beller" <stefanbeller@googlemail.com>
> The code sequence  ' (1u << i) < hsize && i < 31 ' is a multi step
> process, whose first step requires that 'i' is already less that 31,
> otherwise the result (1u << i)  is undefined (and  'undef_val < hsize'
> can therefore be assumed to be 'false'), and so the later test  i < 31
> can always be optimized away as dead code ('i' is already less than 
> 31,
> or the short circuit 'and' applies).
>
> So we need to get rid of that code. One way would be to exchange the
> order of the conditions, so the expression 'i < 31 && (1u << i) < 
> hsize'
> would remove that optimized unstable code already.
>
> However when checking the previous lines in that function, we can 
> deduce
> that 'hsize' must always be smaller than (1u<<31), since 506049c7df2c6
> (fix >4GiB source delta assertion failure), because 'entries' is
> capped at an upper bound of 0xfffffffeU, so 'hsize' contains a maximum
> value of 0x3fffffff, which is smaller than (1u<<31), so the value of
> 'i' will never be larger than 31 and we can remove that condition
> entirely.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> ---

Acked-by: Philip Oakley philipoakley@iee.org

If there are concens that future upgrades may make the (i < 31) test a 
necessity that it should be added before the &&. If the compiler is able 
to determine it's dead code in that case then that's OK, at least it 
would be future proof. Then again it's probably not likely in the near 
future.

>
> Philip,
> thanks for the wording of your mail. I get quickly derailed from the
> warnings of the STACK tool and write the other commit messages than
> I ought to write. I think the wording of your mail nails it pretty
> good, so I put it in the commit message as well.
>
> Stefan
>
>
> diff-delta.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 93385e1..3797ce6 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -155,7 +155,7 @@ struct delta_index * create_delta_index(const void 
> *buf, unsigned long bufsize)
>  entries = 0xfffffffeU / RABIN_WINDOW;
>  }
>  hsize = entries / 4;
> - for (i = 4; (1u << i) < hsize && i < 31; i++);
> + for (i = 4; (1u << i) < hsize; i++);
>  hsize = 1 << i;
>  hmask = hsize - 1;
>
> -- 
> 1.8.4.rc3.2.g2c2b664
>
>
Philip 
