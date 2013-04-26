From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Fri, 26 Apr 2013 10:35:43 -0500
Message-ID: <CAKXa9=rjQJMwgcAs9ic3XSqFh40NYrQt217QS_VUw7ifKihqdA@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
	<CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
	<51781455.9090600@gmail.com>
	<CACsJy8AuQFGCwOBTXU48T65+7DTmCw31RZc0Z-2YBpkKYcoAoA@mail.gmail.com>
	<CAKXa9=pt2mxwFtepoOLZ-Atw3Ey5_OHh6rzk43kVTs8=vcVuRw@mail.gmail.com>
	<CACsJy8ChXRMR93r2R5NoTL7Ly1HqWCXq=t=Kj4ma5+MyYvESpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 17:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVkgk-0005Ia-5i
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 17:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab3DZPft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 11:35:49 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46056 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab3DZPfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 11:35:48 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so766608wiv.7
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=y8TAo/VSErfqd21eCzxONk+7l6P6IVxH6CiKoU5uAGE=;
        b=yRDK46rY31ltvcDjGAMVlSK0V1afQFbiJyukqsQ/HwdFxksFs1ET8cB049rUkx7eff
         n6aph+TGJa+G/LT5yKEM67QcRgDjG2gIwjsDC2gXcNGJktjsqL82XHdMYmwuK/YWBJ65
         1cA5vIFdgC/NWEI+3rM5IH7TTTPtNogpdB+Vsmvz3DT6BhcLcMN0lcRjRtORchcFD9dI
         KnoIvvE04i2qlsC9vR9k8CBEv5j53oY0NGBUqQawHNYoCGXH2JsQbDk4NcMm0rg7vHwW
         VncOH8mL3imeMzooftpR4KYoKLV7MsI6xUIEV1z+AC/qwrZ7/kv4is6CiJImV8rGNZyo
         EpjA==
X-Received: by 10.180.189.205 with SMTP id gk13mr4791782wic.25.1366990543861;
 Fri, 26 Apr 2013 08:35:43 -0700 (PDT)
Received: by 10.216.183.134 with HTTP; Fri, 26 Apr 2013 08:35:43 -0700 (PDT)
In-Reply-To: <CACsJy8ChXRMR93r2R5NoTL7Ly1HqWCXq=t=Kj4ma5+MyYvESpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222533>

On Thu, Apr 25, 2013 at 4:20 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Apr 26, 2013 at 2:44 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
>>> Can you just replace lstat/stat with cached_lstat/stat inside
>>> git-compat-util.h and not touch all files at once? I think you may
>>> need to deal with paths outside working directory. But because you're
>>> using lookup table, that should be no problem.
>>
>> That's a good idea; but there are a few places where you want to call
>> the uncached stat because calling the cache leads to recursion or
>> you bump into things that haven't been setup yet.  Any ideas how to
>> handle that?
>
> On second thought, no my idea was stupid. We only need to optimize
> lstat for certain cases and naming cached_lstat is much clearer. I
> suspect read-cache.c and maybe dir.c and unpack-trees.c are the only
> places that need cached_lstat. Other places should not issue many
> lstats and we don't need to touch them.

ok.  The only reason I did it for all of them was the it was a simple search
and replace, and I didn't know how often lstat was called from various
locations.
