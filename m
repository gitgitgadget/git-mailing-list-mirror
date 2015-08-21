From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 12:48:23 -0700
Message-ID: <CAGZ79kYM6m-Me=okbxMAY_NKDm40JwfgRutwTzYfT5=ez42=jg@mail.gmail.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<20150821194454.GB26466@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:48:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsIe-0008BO-Sn
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbbHUTsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:48:24 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33494 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbbHUTsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:48:24 -0400
Received: by ykll84 with SMTP id l84so80995585ykl.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SaPP0yKh6AyEsQBQ0NOBGpoTBohaVGhEWfvFzrXpja8=;
        b=TLk6hCdQBH07oud8QwSEPhHLZ2tvnB8iDSjNtOKOEC0CcnbE/4ipKiSud9ZH9uwBBi
         v0iSvOQQvDEw7Ji9cDgWld9/txZsopYWPAzi2bsfUR4TXBthR8raH9ons2QgDP6M4x5R
         MZmEXgzhtTIRFr6z7QQcx5BMQTAa8W68gtfrI1TNqW7aAurtQpxWXHGu6hk/mwtSHNFx
         yffbQp4f8DTLujORv2mxSZKzkUcWu5w5dHL4WQX2o68xdVvMXMBioE+v1lg6LH5+Nex2
         I4SGgpbqq6sWQcRM45w8XfMScaglBa1fq9MtlW/k/STShQgTfIyeafzxWe6vNGWeS/SE
         0y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SaPP0yKh6AyEsQBQ0NOBGpoTBohaVGhEWfvFzrXpja8=;
        b=gldWIrZqHnv5MT0Fb5lO4j0W1opYx8v1VAQ7C4zNKxz8fJqda7MsjU4XAOrsQLDoFU
         iqkvs2ERG0VKE5WkM8zw1CdDiGOPCyRvT71413ToE80gxHFiWkcZZ/RjcKzkfya5ELgK
         YmLUHak3w7IL3rtYr9baNUTrhoPXeVblJwk5UTKeOgjmHuAbnFzahlPpBgiyjxbBBnvk
         DYOSS0vNgiAMRs5+nLVMzwKL3G829wIjwX3e7k377aQIDBbwb9j8QfQQKpyz+6AF9XkK
         X+fzLy1tA0nO//yRLoEgGhiqXaCVRyOrZ9rPF4vTPaxVGpnXnv29YSI9WvNgWhzF1PYH
         +naA==
X-Gm-Message-State: ALoCoQnIcvK6LcL81SM8D89s+mRsiUWjF1SsMPMVFEwf9+sm2GG4gT1bkto5Xu4hfej/nwSA7NHV
X-Received: by 10.170.205.151 with SMTP id w145mr14147984yke.56.1440186503458;
 Fri, 21 Aug 2015 12:48:23 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 12:48:23 -0700 (PDT)
In-Reply-To: <20150821194454.GB26466@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276325>

On Fri, Aug 21, 2015 at 12:44 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 21, 2015 at 12:05:13PM -0700, Junio C Hamano wrote:
>
>> The primary reason I suspect is because you sent to a wrong set of
>> people.  Submodule folks have largely been working in the scripted
>> ones, and may not necessarily be the ones who are most familiar with
>> the run-command infrastructure.
>>
>> "shortlog --no-merges" tells me that the obvious suspects are j6t
>> and peff.
>
> No good deed goes unpunished. ;)
>
> Before even looking at the implementation, my first question would be
> whether this pattern is applicable in several places in git (i.e., is it
> worth the extra complexity of abstracting out in the first place). I
> think there are a few task-queue patterns already in git; for example
> the delta search in pack-objects. Is the interface given here sufficient
> to convert pack-objects? Is the result nicer to read? Is it as
> efficient?
>
> We do not need to convert all possible call-sites to the new abstracted
> code at once. But I find that converting at least _one_ is a good litmus
> test to confirm that a new interface is generally useful.

Ok, I'll head off to convert one place.

>
> -Peff
