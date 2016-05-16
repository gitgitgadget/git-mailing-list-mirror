From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr.c: simplify macroexpand_one()
Date: Sun, 15 May 2016 21:41:03 -0700
Message-ID: <CAPc5daVH_qveYBnxybvZYTuVKNBhG7PnJxeY9f8zVXqNxpvzVQ@mail.gmail.com>
References: <xmqqmvnr3p62.fsf@gitster.mtv.corp.google.com> <CAPig+cST7phEvTodEDoYk2UpDOssKg9OVcpddT0sZPy-0aMqsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 06:41:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2ALR-00048g-DF
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 06:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbcEPElY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 00:41:24 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35252 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcEPElY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 00:41:24 -0400
Received: by mail-yw0-f172.google.com with SMTP id g133so151752878ywb.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 21:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AB6zje3gtjH3hqJ6qBYEiiorbO5NiW4+0afv5tWkTiM=;
        b=dGxoZOYgI72KjFkP77zPMxS9JUTY2x0TzBSeI5gqjdqCttjSHuULh3Y1c61sym4040
         9EknvbCJyUzV/fkzcx6fhEA1aW0r3AIfbpz7cGk/OV90WQcNI9RExPW5ZbLrdoPzcWQv
         RX2b8OkosnbztBu9LVK6uhElnPDFc8JdTeLQ/aiqGIZnNNxFjVukW+KgpNNMW/Da47pa
         aYypcThp6GeU0boZA8vQthofQAOFW7YlQIaf9lSdI7TAacpt0MICiq389Mx+7pVkV656
         XRrxcA4F4Dxf3CgGJYMdYpgzlZDcg03vjav9g7jE9vcvVKgmtIDfCIVGBddHKvoBFJpi
         90rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AB6zje3gtjH3hqJ6qBYEiiorbO5NiW4+0afv5tWkTiM=;
        b=CTr2YC7SXexhLjxBDB7cPAHqkmj2Kyd+QWOaUYiHwK50s7Pm/HhbcYUrU7tWoDoQK/
         qaJ+rbdKbu7sRjTz6txEf5UR5kqHMiP8t6bMXgcz8wfd+qtoApx4piJJItheIIZXtdrC
         ZvwYey5qTpEV36kOV/+odfXhVtAE/ayuB/SXaH6L0lyX9kVmG8jO4qC496ZuWUym3Zst
         BwAgEBOwANCuikP0F+dV1DecPigfGKPZp8RsqrtBHbIdM++NxszosqJm2Dz3Q/4a86bb
         3wfBXaUBPAHNR+F97bRHDVpTaEYVVM617FPGuaI0s+wacvRMAhDF0W6hX7d6z/CNwtqx
         dozg==
X-Gm-Message-State: AOPr4FVRNFnnRiwyVRGgZ4n/Q0AU8HPjuyHLe/Lj81xEhtYw9ET3j43Tuql7TSAQisVLK1xX5kS2HmkypBVPHA==
X-Received: by 10.13.219.75 with SMTP id d72mr13315253ywe.293.1463373683370;
 Sun, 15 May 2016 21:41:23 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Sun, 15 May 2016 21:41:03 -0700 (PDT)
In-Reply-To: <CAPig+cST7phEvTodEDoYk2UpDOssKg9OVcpddT0sZPy-0aMqsg@mail.gmail.com>
X-Google-Sender-Auth: 4CdSedrQaHD8D_bP2WIj23sKHDs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294722>

On Sun, May 15, 2016 at 8:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 15, 2016 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The double-loop wants to do an early return immediately when one
>> matching macro is found.  Eliminate the extra variable 'a' used for
>> that purpose and rewrite the "assign found itme to 'a' to make it
>
> What's "itme"?

item.
