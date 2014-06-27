From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to populate index/worktree when recursive merge merges
 multiple common ancestors?
Date: Fri, 27 Jun 2014 08:31:56 -0700
Message-ID: <CAJo=hJtLzMqrBf5Y1dzUxi_0nGmY72xURRmcvmjoFD+=j0FCwQ@mail.gmail.com>
References: <CAENte7jg7RnpEFmZ0QWGw=a-AvAN6AF=cknHXWyTEuo9zq7ERg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 17:32:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Y8U-00060J-GW
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 17:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbaF0PcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 11:32:18 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50553 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbaF0PcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 11:32:17 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so4537035iec.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NhN/Jq9fj24ryYOEIgRzjzjgXAiw49kM0Mjnufpb0/E=;
        b=GiLhPzVtyUh7td5c6+Ctztp1RYiAAynY6cs/7n9q1c6Pmps+3Hd/FmRepQfv2NAEW9
         PdQcln0sRrT0p+5CMzknZMjRRuXptzTyqmVJAaTfiBckC3qwUOc5++kgvuCcQYz/9B+g
         0QdDIGFWi6c23Sz7LtI41bQaYCvmzesccFWNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NhN/Jq9fj24ryYOEIgRzjzjgXAiw49kM0Mjnufpb0/E=;
        b=T01GkRHpFIOjqbq0eIsM7C7001O2WVPwiBhksZSbDu1hoBuo3PVP2ueW/InTd3dxJD
         6JDDGegCuE07J0fNTKdCQHSOHwFGhHFsduAWOctXzUj/6uo3jegTLostslmHcSIq4WyD
         iwhbE77Y2KZYQATvDwd+6fiymj3bTw46GiWmL+daCX2kf9CCazUKhja6NfAzazFZVyMJ
         /jpPu4CkEAEw4mj8k6RNivV9Yh9Z5ItMIcreREoBOvbixoaA8cDQT0fITn/hDMprwEyp
         d4AR2WymABh+jWs0Xsyg3P0+mtZw+ycdtf80A/H3Hv1IUVZdTZrjsTjZpfxGJHMEn0V/
         NtEA==
X-Gm-Message-State: ALoCoQmirqwGjJSG0PmzmRefm1Iay5eyMkbbgnpcplnJxnKzCp44izBDHGHYiy7S/41MOou/qeIW
X-Received: by 10.42.122.208 with SMTP id o16mr20946699icr.39.1403883136264;
 Fri, 27 Jun 2014 08:32:16 -0700 (PDT)
Received: by 10.64.208.12 with HTTP; Fri, 27 Jun 2014 08:31:56 -0700 (PDT)
In-Reply-To: <CAENte7jg7RnpEFmZ0QWGw=a-AvAN6AF=cknHXWyTEuo9zq7ERg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252557>

On Thu, Jun 26, 2014 at 10:50 PM, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> Imagine git does a recursive merge between A and B and finds multiple
> common ancestors X1,X2 for these commits.
> - Does git try to create an implicit/temporary common ancestor X3 by
> merging X1 and X2?

Yes this is the point of the recursive merge algorithm. When >1 common
ancestor is found they are merged. If those again have >1 common
ancestor, it proceeds recursively. :)

> - How should workingtree, index (stage1,2,3) look like if during that
> merge of common ancestors a conflict occurs? Will I see in stage2 and
> stage3 really see content of X1 and X2?

Its done entirely in memory and never touches the working tree or
index. When a conflict exists in the X1-X2 merge the conflict is
preserved into the new virtual base.

> - How is the end user supposed to fix this? Imaging merging X1 and X2
> leads to conflicts solved by the end user leading to a implicit common
> ancestor X3. Then merging A and B with X3 as common base again
> conflicts occur.

They don't. The conflicts are preserved into the virtual ancestor. The
user only sees the final conflicts during merging of A and B with
virtual X3 as the common ancestor.

>
> Ciao
>   Chris
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
