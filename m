From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: resume downloads
Date: Tue, 12 May 2015 15:24:08 +0530
Message-ID: <5551CDC0.10101@gmail.com>
References: <CACnwZYeW3+LQZYV4D_+vWggeh_yoWa-C3KdssHO21sRbsEKrMg@mail.gmail.com> <CAPc5daVwxEniz-s-6dcowQkE-bK50wJ4MOCWGkAM=u02BGtN+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 11:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys6tO-0004n0-95
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 11:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbbELJyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 05:54:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35415 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbELJyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 05:54:19 -0400
Received: by pabtp1 with SMTP id tp1so3226638pab.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OmvPb03zlY3z3UVVEHPtYwpOr3oFQSwTbpoLTY6jStA=;
        b=INcXmPIiYc/BkiX1SBVWf1CgQf78FDT28kps+/NvQFaDge5tpv3myi3ONNyF0CBqR5
         7RSkcCih/8OgERJjA+Qyfzlu+vfHj02cv0NuHZurw59cKmrFBDpY+wKcspkvrMbgFUC4
         feVYTRpPsNolVYoPT1TaVBOlkcVBsLsn3PAkbahmMvgYtHuUhesAmM/rJGx97TOHtBGo
         OsZ+tEN5VEclWsHmkvdSyHS2U4hnZl58xsPXKVDkWCe9RG02bWU5KBTtn9Bll6M15Rix
         SD6I54NREDiPvuWZtSxu9MBLyjyfUpezbAxDpzhHJs8W6loNAeWK288k2IG2UvosZvUN
         /nTA==
X-Received: by 10.70.126.225 with SMTP id nb1mr26936619pdb.71.1431424458722;
        Tue, 12 May 2015 02:54:18 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id bx6sm15672787pdb.39.2015.05.12.02.54.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 02:54:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPc5daVwxEniz-s-6dcowQkE-bK50wJ4MOCWGkAM=u02BGtN+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268851>

On 05/11/2015 03:49 AM, Junio C Hamano wrote:
> The current thinking is to model this after the "repo" tool.
> Prepare a reasonably up-to-date bundle file on the server side,

<shameless plug (but not "commercial")>

For people using gitolite, the server side issues of generating a
reasonably up-to-date bundle *and* enabling it for resumable download
using rsync (with the same ssh key used to gain gitolite access), can
all be handled by gitolite.

</shameless plug>

Of course the client side issues still remain; gitolite can't help
there.

> add a protocol capability to advertise the URL to download that
> bundle from upload-pack, and have "git clone" to pay attention to it.
> 
> Then, a "git clone" could become:
> 
>  - If the capability advertises such a prebuilt bundle, spawn "curl"
>    or "wget" internally to fetch it. This can be resumed when the
>    connection goes down and will grab majority of the data necessary.
> 
>  - Extract the bundle into temporary area inside .git/refs/ to help
>    the next step.
> 
>  - Internally do a "git fetch" to the original server. Thanks to the
>    bundle transfer that has already happened, this step will become
>    a small incremental update.
> 
>  - Then prune away the temporary .git/refs/ refs that were in the
>    bundle, as these are not the up-to-date refs that exist on the
>    server side.
> 
> A few points that need to be considered by whoever is doing this
> are:
> 
>  - Where to download the bundle, so that after killing "git clone"
>    that is still in the bundle-download phase, the next invocation
>    of "git clone" can notice and resume the bundle-download;
> 
>  - What kind of transfer protocols do we want to support? Is http
>    and https from CDN sufficient? In other words, what exactly
>    should the new capability say to point at the prebuilt bundle?
> 
> These (and probably there are several others) are not something
> that "repo" does not have to worry about, but would become
> issues when we try to fold this into "git clone".
> 
> 
> 
> On Sun, May 10, 2015 at 2:55 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>> Hi,
>>
>> Is there links to discussion on this? I mean, is resume downloads a
>> feature that is still being considered?
>>
>> Being able to download huge repos like WebKit, Linux, LibreOffice in
>> small parts seems like a good feature to me.
>>
>> --
>> Thiago Farina
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
