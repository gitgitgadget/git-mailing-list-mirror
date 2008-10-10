From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v2 4/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Fri, 10 Oct 2008 16:22:50 +0400
Message-ID: <bb6f213e0810100522v653507d6r75cc4c64b57aa459@mail.gmail.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
	 <1222772422-28020-2-git-send-email-angavrilov@gmail.com>
	 <1222772422-28020-3-git-send-email-angavrilov@gmail.com>
	 <1222772422-28020-4-git-send-email-angavrilov@gmail.com>
	 <1222772422-28020-5-git-send-email-angavrilov@gmail.com>
	 <18671.16658.667581.499095@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 14:25:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoH2N-0008ON-82
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 14:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbYJJMWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 08:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbYJJMWy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 08:22:54 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:19859 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYJJMWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 08:22:53 -0400
Received: by ik-out-1112.google.com with SMTP id c30so414024ika.5
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FntPU3EbDdPtWrSHbxm4S9h8Vni8J/dagmjgbJHZaUo=;
        b=NZ2rWOILtG8CiLOm8Bu4p2fl8qYDmV3b3I/xF5th3Uhav36iZukBBD/+lkjEw1RifD
         UVcOljiU8APQ+QheyzDhKu8n6KfULcHVwT4TO/Wgm9rrusalJoRtSNYOwk19EzDKQ0xZ
         YzCL4K4TyZJ/JufUQ8M0yCzfjU4riRFCMP334=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fim4cuMLMnPn2yqXksQeQvEixzUekPBpfGDEp1a8whEdUHwwDR9qdbpi6s5Mi2e7nu
         Q9hcAlrVIej3GhgKDCgwxmuSgcn/IiNZoPTfwPr7479S/y9ne1Jd1ZXva2qiZOBSlUxT
         dVJtIuT8tsYVCz4d6VdQTbqGKFBbMvum1vbDg=
Received: by 10.103.24.11 with SMTP id b11mr980780muj.98.1223641370800;
        Fri, 10 Oct 2008 05:22:50 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Fri, 10 Oct 2008 05:22:50 -0700 (PDT)
In-Reply-To: <18671.16658.667581.499095@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97930>

On Fri, Oct 10, 2008 at 3:48 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> When the diff contains thousands of files, calling git-check-attr
>> once per file is very slow. With this patch gitk does attribute
>> lookup in batches of 30 files while reading the diff file list,
>> which leads to a very noticeable speedup.
>
> Why only 30 at a time?  The logic would be simpler if cache_gitattr
> just did all the paths in one call to git check-attr, and it should be
> able to cope with 1000 paths in one call, I would think, which is the
> most that gettreediffline will give it.

OS-enforced command-line size limit on Windows is 32K. Cramming in
1000 paths would leave only 32 characters for each path.

> Also, I wonder why we now have two levels of caching of the encoding
> attribute.  Your patch 1/4 introduced path_encoding_cache, which was
> fine, but now we have path_attr_cache as well, which seems to me to
> serve exactly the same function since the encoding is the only
> attribute we ever ask about.  Surely we don't need both caches?

If the (git-gui) patch that reimplements the tcl_encoding procedure is
applied, we may drop the path_encoding_cache. Current implementation
is too slow for batch lookup, especially if the encoding is actually
not supported, and without the cache the lookup would be done on every
loading of a diff.

> Even with this batching, I am a bit concerned that adding the encoding
> support might make things noticeably slower for people who don't need
> any encoding support (which would be the majority, I think).  We may
> end up needing an option to turn off the checking of the encoding
> attribute.

I hope that most diffs don't contain thousands of files at once. And
actual huge diffs are likely to be relatively slow to load anyway.

Alexander
