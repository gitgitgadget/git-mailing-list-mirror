From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/6] submodule update --init: correct path handling in
 recursive submodules
Date: Tue, 29 Mar 2016 18:00:11 -0700
Message-ID: <CAGZ79ka3ZL8Avs4gt5ODtQQh7o2TFQAj2RQEJz3SdYV7_Z1Oqw@mail.gmail.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
	<1459292558-5840-3-git-send-email-sbeller@google.com>
	<xmqqoa9wvo0w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4Uk-000302-4a
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbcC3BAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:00:19 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:36860 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbcC3BAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:00:17 -0400
Received: by mail-io0-f181.google.com with SMTP id q128so46445241iof.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HKoiByKChB4KtFbjDYH8xLrSDAY4gWiIepBr8qcl9oc=;
        b=SgdOyLSPP+pfqCS6rjygUWmSF93+wCr6w5lCa+oyN4sHBC3XHeoNoJpCPhOQwUO4OE
         bJjqo7ZQH2/9orbzUr6RvV/TFU3ugqKKCOQZiwp3DAXyY04Zoe6ngQ4jiLrPEvxuxe55
         RUFSa/M7l0kxxB1em4sni7lut7aLSQGXI31I0d1mrd5DxQJ14j8d1Gc6+nnz0fP+WLJJ
         /uE8FpAvX61nW1ISeDLwqkPAWXZQR3c42RIPzUoO9x/8OZbPB3Wgvpqjw9z+IH/kfoXd
         +W/kNUtC8jtfpFg1xptvoNcznI/jTFPKPQ3qgJ3AwJt9ncRppTdg9WuLHl154934tOdd
         XLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HKoiByKChB4KtFbjDYH8xLrSDAY4gWiIepBr8qcl9oc=;
        b=bPMa7JmwxYcCklukhv/izAdvN6xjllaQrK2xEJj9VFm4w0Af0rm6ueMIJ34Nhnf1Ax
         4skpr5E9pxRB/TnOVGDD5r1o2IL9G1hOWCAmm68dp0tVfNb8Cp3OcurP/F70RaALnybA
         1vbK2kbDkmPe4N9Gneh3/CeYE0mQ8kQ8nwGOKQb4azG1uFMd09e1FgWSTdImync/Trj2
         vXpkGfgOjCdByIX4jg52ayD1NjJxR9HJi6TtuFvrTbD8om5wKNDLABuc3n2nqhb3hB/8
         VS8SinekftZslDPboVqApSdokTiGycHhXrnAJ9qtduZ35mRw2lVPJbR0UuushxdqCDdx
         kKyg==
X-Gm-Message-State: AD7BkJI4yHCO2wULp30Pp6J2BkEL6PnR/O8slz0b/s/mPInEQSLZglSoGrN2pust6sz/m/9K6UDgR5oFNvb6cGqF
X-Received: by 10.107.161.68 with SMTP id k65mr7142692ioe.110.1459299611712;
 Tue, 29 Mar 2016 18:00:11 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 29 Mar 2016 18:00:11 -0700 (PDT)
In-Reply-To: <xmqqoa9wvo0w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290242>

On Tue, Mar 29, 2016 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The new test demonstrates a failure in the code prior to this patch.
>> Instead of getting the expected
>>     Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
>> the `super` directory is omitted and you get
>>     Submodule 'submodule' (${pwd}/submodule) registered for path '../submodule'
>> instead.
>
> Same "is this about test?" comment applies here.
>
>> That happens because the prefix is ignored in `git submodule add`, probably
>> because that function itself cannot recurse;
>
> "probably"???

I am speculating there. I have no idea why it originally was written that way
but I would assume this is the most likeliest explanation.
I'll reword the whole commit message.

>
>>
>> +supersha1=$(cd super && git rev-parse HEAD)
>
> Perhaps "git -C super rev-parse HEAD"?

done
