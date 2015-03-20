From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] refs.c: drop curate_packed_refs
Date: Thu, 19 Mar 2015 21:27:02 -0400
Message-ID: <CAPig+cSBnLbZVikuZDy4cN5hV1rMs4cmLVqd-k+9Qi9e-9t+kQ@mail.gmail.com>
References: <20150317072750.GA22155@peff.net>
	<20150317073157.GE25191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 02:27:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYliR-00046Q-EY
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 02:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbbCTB1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 21:27:05 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:36559 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbCTB1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 21:27:03 -0400
Received: by yhjf44 with SMTP id f44so33431701yhj.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RiIIbClkYn6PqYCqRV6HyHkv10D6R9yQ04L7ZBae7Mo=;
        b=kC3DeB4N2al80kMEDcJzT2bWrm/ul15/yJYX57ySaRTB1ATm9NqFGJ2/AYzXBp3DIW
         2L4HgwmcGSYw+xUfQwpC8oUYxXqplyJg6NStw4OSaTzyl+zkXLui7i6+l9nELKQdMPD8
         WwW02waM2eDRhcavS9ITMeqkbsfue75lSoe1YfFdW+0vtr/3VQHpUbu2Ik2nXD1BGpuS
         Wb+/JkIpAtdmAw43A1uTza9owROU5sgWc0lviGLPY28uTDpk8q+9i/Ea4vKs6XMVtZ6R
         AWFYW58NA84COGKV13ze8GofiJmhOuMgb1SHVIp9Lozf4bvi5ZD26nt7Yqvi/8LdwZLs
         Py6g==
X-Received: by 10.236.105.210 with SMTP id k58mr79973746yhg.52.1426814822202;
 Thu, 19 Mar 2015 18:27:02 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Thu, 19 Mar 2015 18:27:02 -0700 (PDT)
In-Reply-To: <20150317073157.GE25191@peff.net>
X-Google-Sender-Auth: vPLp8XQjd021QegSsdDkUQD7Bvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265856>

On Tue, Mar 17, 2015 at 3:31 AM, Jeff King <peff@peff.net> wrote:
> When we delete a ref, we have to rewrite the entire
> packed-refs file. We take this opportunity to "curate" the
> packed-refs file and drop any entries that are crufty or
> broken.
>
> Dropping broken entries (e.g., with bogus names, or ones
> that point to missing objects) is actively a bad idea, as it
> means that we lose any notion that the data was there in the
> first place. Aside from the general hackiness that we might
> lose any information about ref "foo" while deleting an
> unrelated ref "bar", this may seriously hamper any attempts
> by the user at recovering from the corruption in "foo".
>
> They will lose the sha1 and name of "foo"; the exact pointer
> may still be useful even if they recover missing objects
> from a different copy of the repository. But worse, once the
> ref is gone, there is no trace of the corruption. A
> follow-up "git prune" may delete objects, even though it
> would otherwise bail when seeing corruption.
>
> We could just drop the "broken" bits from
> curate_packed_refs, and continue to drop the "crufty" bits:
> refs whose loose counterpart exists in the filesystem. This
> is not wrong to do, and it does have the advantage that we
> may write out a slightly smaller packed-refs file. But it
> has two disadvantages:
>
>   1. It is a potential source of races or mistakes with
>      respect to these refs that are otherwise unrelated to
>      the operation. To my knowledge, there aren't any active
>      problems in this area, but it seems like an unnecessary
>      risk.
>
>   2. We have to spend time looking up the matching loose
>      refs for every item in the packed-refs file. If you
>      have a large number of packed refs that do not change,
>      that outweights the benefit from writing out a smaller

s/outweights/outweighs/

>      packed-refs file (it doesn't get smaller, and you do a
>      bunch of directory traversal to find that out).
>
> Signed-off-by: Jeff King <peff@peff.net>
