From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 00:05:56 -0700
Message-ID: <CAGZ79kaJxgMCUSp3dVJt4=nPVi=p_HFY+OATh1wXthdKKGpmjA@mail.gmail.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<1461013950-12503-3-git-send-email-sbeller@google.com>
	<20160419050342.GA19439@sigill.intra.peff.net>
	<CAGZ79kaD3kyWdbT-PhR9XPV_qmYpQipZwvfYYcVvwk62+x5qnw@mail.gmail.com>
	<20160419070001.GA21875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asPjW-00084E-4c
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 09:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbcDSHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 03:05:58 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35024 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbcDSHF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 03:05:57 -0400
Received: by mail-io0-f182.google.com with SMTP id g185so9400186ioa.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kmCQW1Qno8f7vnEd1UuaosOKCIFiWjCCbiFrMDzcIJg=;
        b=pWHIpFus0R9TMDuSNC1tk4sejYiG1dNwlpjQTKb3OcEx20okDi2+iha5u+ykj9LlDH
         JWo0m0S0HOK68IvSaNdmAai88nQ/kEUMFC+/+80T5vps7CSvlnyhb8EvPA+HnUAfICBb
         KjLo9TsxrjLeWnRjJ/07LaTeuzZ3eOUjycbg4hOhVtEdpUO6eJ+/KnsDNN43NWFwMrsZ
         tTsZdJveGzRuGqy6EyNDChyBHO5f9/i3F/g5CX+kt5dsh8BU++VafpIyAEnJ9hQmNRoQ
         pc9dgyvdzQB74sQ2IZJe4CDOpA8SHO7V80ou8Srl5/rx+GqLJX95OwTs3YKdHc/sOy8t
         tUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kmCQW1Qno8f7vnEd1UuaosOKCIFiWjCCbiFrMDzcIJg=;
        b=D6BvPr7bbxNfXXUTB9H0erjnIlYWR0tN44jsIhoGotThdo4FYq9vS7wZymAJNbfSoW
         Ix6EqB1n5M9Vl48QBH+KsLrV+nnNRltCV4cg5zXouRhaQaRl/jkK6sz7/wzBq8tHBPSX
         6ZRyZjAfLOJ6C3uNiFjforKkIItlFsO/P69z8caWQpGLi2tXFMiBUlxzfR5ggIhzMtq6
         RAM/w/27TJsc3oYQaDB21SBd9tDZB+ekvml13s+MezFIu3+MQmp1J0aUrs8IPIG4jB7G
         wEHrQh7uzAGT8A4p2AesO/TwylpEzPexIrXmI6CWzptuTEKyyoTIKmsOj1fM/2GaQNgx
         HFgQ==
X-Gm-Message-State: AOPr4FVnbmOJgL0COxs4WBaUEZEFfx8BamrtJXLDPCemdaWpnFbPcrsWHsTuyZTByvflsDP419Gq641Ejv3C3HE3
X-Received: by 10.107.18.227 with SMTP id 96mr1828025ios.174.1461049556896;
 Tue, 19 Apr 2016 00:05:56 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 19 Apr 2016 00:05:56 -0700 (PDT)
In-Reply-To: <20160419070001.GA21875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291847>

On Tue, Apr 19, 2016 at 12:00 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 18, 2016 at 11:47:52PM -0700, Stefan Beller wrote:
>
>> I am convinced the better way to do it is like this:
>>
>>     Calculate the entropy for each line and take the last line with the
>>     lowest entropy as the last line of the hunk.
>
> I'll be curious to see the results, but I think sometimes predictable
> and stupid may be the best route with these sorts of things. In
> particular, I'd worry that a content-independent measure of entropy
> might miss some subtleties of a particular language (e.g., that "*" is
> more or less meaningful than some other character). But we'll see. :)

I would assume that the "*" would have little entropy when there are lots
of comments, i.e. it just "feels" like an empty line.
If there are no "*", then the entropy is high as it is unusual. And
unusual things
should not be at the border of a hunk I would assume.
So m prediction is that the  'subtleties of a particular language' correlate
highly with the actual use of characters.

Anyway, the experiment can be carried out later. :)

Thanks,
Stefan

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
