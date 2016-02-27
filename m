From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 17:28:55 -0300
Message-ID: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
 <xmqqd1riggd7.fsf@gitster.mtv.corp.google.com> <20160227190712.GC12822@sigill.intra.peff.net>
 <20160227191943.GD12822@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 21:29:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZlUO-00087g-8v
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 21:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992534AbcB0U3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 15:29:16 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34227 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992522AbcB0U3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 15:29:15 -0500
Received: by mail-io0-f174.google.com with SMTP id 9so148741965iom.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 12:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OlXnRtjoZciqYnciJcmuMX94XqMfr5hJwUehbL0L4rY=;
        b=tBlapJbeps/QMGTAuWEyb08ByW0xAdNOlkj5qxCnnst8Zud2p9NmZ8+pryf9F6NIhW
         8vrf4B70jtEai+MDmDjD66ohT32rW93Lr7zVyjKmz8gfVLLqheijR0JcWIbVFfMHxZX2
         qKnp+Vu6h7aNXj8UB8k28H+v179qywv/gPeCnetynaYuEnbYeolYmUo1rxinOvKIQesS
         AcJtrRnbgYmsoeD4fHDFQzPLvmcUAukTfK1foJyeDuAxKNPn6HV9L2b2AQ+syP6RxtzP
         DTOTeFA0AUPAJC9Ys8x3nxZsXmrA/ZFHXgbGWb5MF/Q55NMb95xvr5h1x7DD+lYQvvH7
         UU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OlXnRtjoZciqYnciJcmuMX94XqMfr5hJwUehbL0L4rY=;
        b=VOc1gE9hEJ5yC/kVq4xfxzGrl3WfnXNI8V7j0U/gBX/AGPGSIpzCj0RFW3DDyhUFta
         /8EGrgSGyMmdusVDAIlhYGrnE0bwQpugF2bsX7iewO+ZW/yDWnEp53rpIoSVCQyNxGA7
         e5YmQrAaaTrA+pUWsTlMTXEKjw6Um0A+x3hh7sUzbye8w0qzUoCAMZK1fRgDmXHx1AXI
         Qsikt3mJiS1LcJFr21wdoHd+vQKEGvx84wozgj76fRWfOqWrRQUxnpyBZo94Oy8yMkgC
         EvBZtZiLtFC+prJfc8zAXwVytNFq3KjyMfwEzg42DkEvSYhtNdujpJUwIbFbstvmeKsm
         0rAg==
X-Gm-Message-State: AG10YOQs+2fRGruCkn+jzpIXgU3JalcBfBEjf+O/kd/i1hrhCD7+nC3E87YnhY6wGNg0ZFH93V9pGnTU9IVRfA==
X-Received: by 10.107.135.156 with SMTP id r28mr13892649ioi.40.1456604954629;
 Sat, 27 Feb 2016 12:29:14 -0800 (PST)
Received: by 10.50.59.2 with HTTP; Sat, 27 Feb 2016 12:28:55 -0800 (PST)
In-Reply-To: <20160227191943.GD12822@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287729>

On Sat, Feb 27, 2016 at 4:19 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 27, 2016 at 02:07:12PM -0500, Jeff King wrote:
>
>> We expect whoever creates the "sought" list to fill in the name and sha1
>> as appropriate. If that is not happening in some code path, then yeah,
>> filter_refs() will not work as intended. But I think the solution there
>> would be to fix the caller to set up the "struct ref" more completely.
>>
>> Gabriel, did this come from a bug you noticed in practice, or was it
>> just an intended cleanup?

I was experimenting with uploadpack.hiderefs and uploadpack.allowTipSHA1InWant
and couldn't get

        git fetch-pack $remote <sha1>

to work, and I traced the failure until that check. Reading more, I now see
that currently it requires

       git fetch-pack $remote "<sha1> <sha1>"

to do what I want.

>
> I double-checked that the code for git-fetch does so. It's in
> get_fetch_map()
>
>     if (refspec->exact_sha1) {
>             ref_map = alloc_ref(name);
>             get_oid_hex(name, &ref_map->old_oid);
>     } else ...
>
> So we should always have old_oid filled in already, and there is no need
> to do so in filter_refs() (and in fact it is wrong, for the degenerate
> example I gave earlier).

git fetch-pack doesn't use these code paths. I'll send a new patch
shortly to allow
bare sha1's in fetch-pack.

>
> -Peff
