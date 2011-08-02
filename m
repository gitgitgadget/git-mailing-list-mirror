From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/ PATCH] revert: Allow arbitrary sequencer instructions
Date: Tue, 2 Aug 2011 22:53:53 +0200
Message-ID: <20110802205353.GF2743@elie>
References: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
 <1312260884-5087-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 22:54:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoLyd-00071y-Q8
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 22:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab1HBUyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 16:54:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54376 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322Ab1HBUyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 16:54:05 -0400
Received: by wwe5 with SMTP id 5so159158wwe.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XED0+7ru4Sm1B4TK/n2Rh8SmPdtES0tFKXq9rBF3gZQ=;
        b=DnbsMHEOveXS7J3uMAxduleNOcKR+8Zx0XHrKg21O0p4uiMrRwahfk64WDAL+J9gL1
         r0uYKehaikP8qBH0/KJh/rPcMalQ8HX513AjDCSXp8elYw3aT/IiM46+B35GAuXhvBfK
         fxBCv9GMAwiLMNlyufuHDDZjl+6RwMEKwk8xA=
Received: by 10.216.14.19 with SMTP id c19mr2118289wec.88.1312318443279;
        Tue, 02 Aug 2011 13:54:03 -0700 (PDT)
Received: from elie ([109.144.213.170])
        by mx.google.com with ESMTPS id m46sm100093weq.5.2011.08.02.13.53.56
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 13:54:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312260884-5087-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178507>

Ramkumar Ramachandra wrote:

> Allow arbitrary sequencer instructions in the instruction sheet.

"So now I can ..." wait, what does this allow me to do?  Your audience
hasn't read the patch yet.

> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -32,6 +32,16 @@ struct replay_opts {
>  	size_t xopts_nr, xopts_alloc;
>  };
>  
> +struct replay_insn {
> +	struct commit *commit;
> +	enum replay_action action;
> +};
> +
> +struct replay_insn_list {
> +	struct replay_insn *item;
> +	struct replay_insn_list *next;
> +};

Ah, so this allows sequences like

	revert A
	pick B
	pick C
	revert D

Nit: why isn't the list-item struct something like

	struct replay_insn item;
	struct replay_insn_list *next;

which would save a little memory management and memory access
overhead (or even

	enum replay_action action;
	struct commit *operand;
	struct replay_insn_list *next;

since every "struct replay_insn" exists in the context of an
insn list afaict)?

Anyway, the general idea seems good.
