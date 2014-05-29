From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Fri, 30 May 2014 06:24:30 +0700
Message-ID: <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
 <1401311055-480-2-git-send-email-dturner@twitter.com> <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross> <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
 <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 01:25:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq9h7-0004F3-Jt
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 01:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbaE2XZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 19:25:03 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:52326 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbaE2XZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 19:25:02 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so3195968qgd.13
        for <git@vger.kernel.org>; Thu, 29 May 2014 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9pMTV08RxnSgt7Tkg83AmJzipJlSholDVmY/0OAq+OM=;
        b=y9mxEuOG9Kl4/FD9FGR3ckr5zovk3rpmyq1QFTME/jVYKVpwPZ7piEWtzLI/0mw8Y2
         FnIODRLRFwHdGfvmai/W+k3CQ/+NeW3Kr55PC7/+wnRMY9XRYitdG/FxRPqdkAXOWOhn
         Su1kHyuVjQ3mNtu3280rfPoFzNAzLxmLhccx6PrJNy0LajN6gAxfqPc0nPDmZ6Zdj+C/
         FXtyn7IZP09kvNNrO06PJIBSTUpI2lXosywI6xAFObO36Y25k/axD9sJI/jXEIDPA9oq
         R9IOD7p+lTs2gXjahH73EwwUM4mbxIhSPeHOMZEYAbUoOFNaG6wPBbCLDjD/aaigON6l
         dDag==
X-Received: by 10.140.92.200 with SMTP id b66mr14092265qge.41.1401405900942;
 Thu, 29 May 2014 16:25:00 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 16:24:30 -0700 (PDT)
In-Reply-To: <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250418>

On Thu, May 29, 2014 at 11:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, May 29, 2014 at 6:49 AM, David Turner <dturner@twopensource.com> wrote:
>>>> I assume that most of the time spent in check_refname_component() is
>>>> while reading the packed-refs file, right?
>>>
>>> Yes.
>>
>> I wonder if we can get away without SSE code by saving stat info of
>> the packed-refs version that we have verified. When we read pack-refs,
>> if stat info matches, skip check_refname_component(). Assuming that
>> pack-refs does not change often, of course.
>
> Can you elaborate a bit more?

The first time we read packed_refs, check_refname_format() is called
in read_packed_refs()->create_ref_entry() as usual. If we find no
problem, we store packed_refs stat() info in maybe packed_refs.stat.
Next time we read packed_refs, if packed_refs.stat is there and
indicates that packed_refs has not changed, we can make
create_ref_entry() ignore check_refname_format() completely. That's
even cheaper than SSE-enhanced check_refname_component() and easier to
do. If packed_refs is updated, we do the whole check_refname_format
dance again.
-- 
Duy
