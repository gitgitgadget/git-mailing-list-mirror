From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Thu, 15 Aug 2013 23:14:23 +0100
Organization: OPDS
Message-ID: <0F8B752CC3F241A9874E8A268A25D162@PhilipOakley>
References: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com> <1376602462-32339-1-git-send-email-stefanbeller@googlemail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Stefan Beller" <stefanbeller@googlemail.com>,
	<sunshine@sunshineco.com>, <git@vger.kernel.org>,
	<gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:14:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA5oF-0005zT-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab3HOWOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:14:14 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:12827 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901Ab3HOWON (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Aug 2013 18:14:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmcMAEVSDVJOl3GZ/2dsb2JhbABbgwY1iSe2NQQEgSMXdGgBAYEfAQEUAQQBAQQBCAEBLh4BASwCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBhTgHAYIgDQMJCrE7DYhejVWBLIRxdwOIdYYOkweCCIUkgTeBZTuBLA
X-IPAS-Result: AmcMAEVSDVJOl3GZ/2dsb2JhbABbgwY1iSe2NQQEgSMXdGgBAYEfAQEUAQQBAQQBCAEBLh4BASwCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBhTgHAYIgDQMJCrE7DYhejVWBLIRxdwOIdYYOkweCCIUkgTeBZTuBLA
X-IronPort-AV: E=Sophos;i="4.89,889,1367967600"; 
   d="scan'208";a="420041501"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 15 Aug 2013 23:14:12 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232378>

From: "Stefan Beller" <stefanbeller@googlemail.com>
> When checking the previous lines in that function, we can deduce that
> hsize must always be smaller than (1u<<31), since 506049c7df2c6
> (fix >4GiB source delta assertion failure), because entries is
> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> value of 0x3fffffff, which is smaller than (1u<<31), so the value of
> 'i' will never be larger than 31.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>
> Eric, thanks for reviewing my patch.
>
> I applied the first 2 proposals (deduce, entries), but I disagree on
> the third, so I reformulated the sentence, as I really meant the 
> variable
> i and not it as a pronoun.
>
> Do I understand right, you're suggesting to remove the
> source code comment? I did this now, but I have a bad feeling with it.
>
> The change of this patch surely removes dead code as of now and makes 
> it
> more readable. But also it could become alive again, once somebody
> changes things nearby and forgets about the assumption, hsize not
> exceeding a certain size. That's why I put a comment in there, so
> the future changes nearby may be more careful.

Should the comment also include a note about potential undefined 
behaviour of a large shift, with the possible consequential bad compiler 
optimization, such as simply deleting the code. I understand the initial 
spot was part of the STACK tool check of such latent optimisation bugs.

http://css.csail.mit.edu/stack/

>
> Thanks,
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
> 1.8.4.rc3.1.gc1ebd90
>
