From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 14:41:04 +0200
Message-ID: <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se>
	<1315511619144-6773496.post@n2.nabble.com>
	<1315529522448-6774328.post@n2.nabble.com>
	<201109251443.28243.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 14:41:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8AUi-000691-7f
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 14:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745Ab1IZMlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 08:41:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45826 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab1IZMlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 08:41:05 -0400
Received: by wwf22 with SMTP id 22so6720197wwf.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dVetD6lCfwYqf2VkJMHBUOSp3Ibxup5lI30YUsX6MjA=;
        b=gNSD6HnNqDOhk8J3qdxk8qLQ9821GVjK3AUWaPN/uHZgi5kh5vnl2Vqv7PKAijTxJO
         RsiX5xrjfjyPUVEKBdgRZ8dmCndWGR/+9Q8pJMmmkAH0dIbEIwXs/YX/tmtL3xV2JkxH
         dC8fwhO0b8MXid0ks5ADD0GJQYq0b/khDagOw=
Received: by 10.227.199.137 with SMTP id es9mr34771wbb.31.1317040864291; Mon,
 26 Sep 2011 05:41:04 -0700 (PDT)
Received: by 10.180.83.168 with HTTP; Mon, 26 Sep 2011 05:41:04 -0700 (PDT)
In-Reply-To: <201109251443.28243.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182105>

On Sun, Sep 25, 2011 at 10:43 PM, Martin Fick <mfick@codeaurora.org> wr=
ote:
> A coworker of mine pointed out to me that a simple
>
> =A0git checkout
>
> can also take rather long periods of time > 3 mins when run
> on a repo with ~100K refs.

Are all these refs packed?

> While this is not massive like the other problem I reported,
> it still seems like it is more than one would expect. =A0So, I
> tried an older version of git, and to my surprise/delight,
> it was much faster (.2s). =A0So, I bisected this issue also,
> and it seems that the "offending" commit is
> 680955702990c1d4bfb3c6feed6ae9c6cb5c3c07:
>
> commit 680955702990c1d4bfb3c6feed6ae9c6cb5c3c07
> Author: Christian Couder <chriscool@tuxfamily.org>
> Date: =A0 Fri Jan 23 10:06:53 2009 +0100
>
> =A0 =A0replace_object: add mechanism to replace objects found
> in "refs/replace/"

[...]

> Now, I suspect this commit is desirable, but I was hoping
> that perhaps a look at it might inspire someone to find an
> obvious problem with it.

I don't think there is an obvious problem with it, but it would be
nice if you could dig a bit deeper.

The first thing that could take a lot of time is the call to
for_each_replace_ref() in this function:

+static void prepare_replace_object(void)
+{
+       static int replace_object_prepared;
+
+       if (replace_object_prepared)
+               return;
+
+       for_each_replace_ref(register_replace_ref, NULL);
+       replace_object_prepared =3D 1;
+}

Another thing is calling replace_object_pos() repeatedly in
lookup_replace_object().

Thanks,
Christian.
