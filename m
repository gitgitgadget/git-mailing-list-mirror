From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 4 Sep 2014 19:41:48 -0700
Message-ID: <CAJo=hJscZVJpF024O7rWXA_1LJEmkCF1HpoGBT2fcAf=ET7gEA@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-19-git-send-email-gitster@pobox.com> <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
 <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com> <xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
 <CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com> <xmqqha0nq6pt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 04:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPjTa-000296-7w
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 04:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbaIECmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 22:42:10 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54184 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaIECmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 22:42:09 -0400
Received: by mail-ie0-f170.google.com with SMTP id rl12so13047107iec.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tNIPhc3L0x/T1TA9ggmsvgysIBGIs7PvMT98FGXIpTA=;
        b=NTs4aG1M0pBby1Rt/MIF22kX3kaX0qPZotML5tkERDz5Va7pNOx52Qc1j/k+rPOxym
         0VPzkN04QBu8NJm7rYbdKL8qL8tflYJEc8yGY6Z0NkW8JWaV/h4Ez4OJSt+1JT8DeTzL
         l2ovzn8iVLk16OZH0Nuze43PEUgYwM8F1erQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tNIPhc3L0x/T1TA9ggmsvgysIBGIs7PvMT98FGXIpTA=;
        b=dxzprlb2TXAmsDnmVoJZa5VfCAIPFQYlnbrdE0qacF2OOgutP/lLXEsmeycWh7GA4n
         DE8+4241HATeRciUwerGc/KL0+GUg3mNVSeDvG/qoCuA3ADDlC7ehEBnAP1hGKQDlVGF
         ktOm7sDJheufJrr2nEwNbCV5ekrO6JPrDb3nVCZKYFk+VnR2BgSTA5GlWwDXezx4e7IP
         fsLQQyZhJOY89XgK0jBN64NGbS3JDIKhKOloHNlmgtN4E621Gw+QquIMroZbptTR/XIl
         vcBYcf+kTQdhfZflJqw0MFZHzaQaNb4QN5Z2cHrwYBtXDNb3nz+bRiJstvvBS2Ga9rOK
         Fdyw==
X-Gm-Message-State: ALoCoQlyd13LDQ5hiRI+TCdT098i8cTFhT8wF9aAuajyvVwiU/QQH8hXeyWgKJYs9wFnrmvOvFFQ
X-Received: by 10.51.17.66 with SMTP id gc2mr249194igd.40.1409884928209; Thu,
 04 Sep 2014 19:42:08 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Thu, 4 Sep 2014 19:41:48 -0700 (PDT)
In-Reply-To: <xmqqha0nq6pt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256497>

On Thu, Sep 4, 2014 at 4:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> As you know, the stateless HTTP thing doesn't allow the nonce on the
>> server to be carried from the initial ref advertisement into the final
>> receive-pack. We would either need to write the nonce to disk and load
>> it back up later (ick), or use some sort of stateless nonce.
>>
>> A stateless nonce could look like:
>>
>>   nonce = HMAC_SHA1( SHA1(site+path) + '.' + now, site_key )
>>
>> where site_key is a private key known to the server. It doesn't have
>> to be per-repo.
>
> Doing the above naively will force you to check 600 HMAC if your
> slack is for 10 minutes.  You could just instead use
>
>         nonce = now '-' HMAC_SHA1(path + '.' + now, site_key)
>
> and the validation side can make sure the same site_key was used,
> and also "now" readable from the plaintext part is fresh enough,
> with a single HMAC.

Argh. Yes, thank you. This is what I meant but did not write. :(

> I may be missing something, but with this, we can always validate
> that "nonce" is what the repository issued (whether "stateless" is
> used or not).  The hook script can decide if "now" is recent enough
> or not without bothering receive-pack at all.

Correct.
