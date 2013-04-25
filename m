From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Fri, 26 Apr 2013 04:20:26 +0700
Message-ID: <CACsJy8ChXRMR93r2R5NoTL7Ly1HqWCXq=t=Kj4ma5+MyYvESpg@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
 <51781455.9090600@gmail.com> <CACsJy8AuQFGCwOBTXU48T65+7DTmCw31RZc0Z-2YBpkKYcoAoA@mail.gmail.com>
 <CAKXa9=pt2mxwFtepoOLZ-Atw3Ey5_OHh6rzk43kVTs8=vcVuRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:21:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTbF-00041k-L4
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759655Ab3DYVVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:21:00 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:55803 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758873Ab3DYVU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:20:59 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so3279551oag.22
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3kwU/2x+418/Gv3TXTLaAGl6e8NxzhbUpqO0KzMUWfg=;
        b=i/mxJqpqd2l1EXx946DChdQsWymUu05LvRhvrLAzdvdCADwtu3FBc7J5GioNAm2H2C
         oKMhguy4N5hh6YeZ4QE/hGmoxW99couoY4dtt/Pkx4kRHSYGHJBjvF2T9rcjeJUFXW9q
         kz4Eb7mBhMSeVeNNSdO5whlT2edSf61S3+NRwFl1cOzMHGJdf4wsUyyLgqVGQiENJrgz
         rgQh1zCqXAnZcwtxCvncKpFqWfs17h80qeLSPmxeRMU64hyatRgGQCUn1aorIVK2t1+x
         qHcoCxoj3XlR5laWUSA/5bBNGQJGbefgtegsZTeBjXghZZzQuHMqf0xhj1hPcMImYaqE
         11FA==
X-Received: by 10.60.84.102 with SMTP id x6mr3994766oey.73.1366924857901; Thu,
 25 Apr 2013 14:20:57 -0700 (PDT)
Received: by 10.76.142.74 with HTTP; Thu, 25 Apr 2013 14:20:26 -0700 (PDT)
In-Reply-To: <CAKXa9=pt2mxwFtepoOLZ-Atw3Ey5_OHh6rzk43kVTs8=vcVuRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222451>

On Fri, Apr 26, 2013 at 2:44 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
>> Can you just replace lstat/stat with cached_lstat/stat inside
>> git-compat-util.h and not touch all files at once? I think you may
>> need to deal with paths outside working directory. But because you're
>> using lookup table, that should be no problem.
>
> That's a good idea; but there are a few places where you want to call
> the uncached stat because calling the cache leads to recursion or
> you bump into things that haven't been setup yet.  Any ideas how to
> handle that?

On second thought, no my idea was stupid. We only need to optimize
lstat for certain cases and naming cached_lstat is much clearer. I
suspect read-cache.c and maybe dir.c and unpack-trees.c are the only
places that need cached_lstat. Other places should not issue many
lstats and we don't need to touch them.
--
Duy
