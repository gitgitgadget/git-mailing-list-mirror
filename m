From: Junio C Hamano <gitster@pobox.com>
Subject: Re: resume downloads
Date: Sun, 10 May 2015 15:19:34 -0700
Message-ID: <CAPc5daVwxEniz-s-6dcowQkE-bK50wJ4MOCWGkAM=u02BGtN+w@mail.gmail.com>
References: <CACnwZYeW3+LQZYV4D_+vWggeh_yoWa-C3KdssHO21sRbsEKrMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 00:20:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrZZx-0007yL-Uv
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 00:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbbEJWT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 18:19:56 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36465 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbEJWTz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 18:19:55 -0400
Received: by oift201 with SMTP id t201so92096756oif.3
        for <git@vger.kernel.org>; Sun, 10 May 2015 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xLSGSwZPRGFs6dbtYyutXC9w+mDSl0mVEweZe+02GdY=;
        b=B0tjyuyY2+k646zstqA5Q/rFlriKx95iah/AV8WHzI5KGGTb5fTusvpUqBdvR/akkx
         FsiCwjniNUCiH8fUFpEg44ZkiO5Iw+kOIer38ximNpHDGsqzCh2mUfg1J8CrNmHs2mWl
         MIO2U2WxHmWBEzro6wcQvzr5fcN9KK8lEwUFzQ8zHk4rCb0vn2C4cUfVzv52FF49sYoZ
         DJ9Ry1TJzlhPn1LrFsOXh6hLhguO3haeOZgVdg2yzgJOoaRPCsV9KailjxRTbmm9cUlJ
         +khvlaEBxhhTIW7hYmIBrHNaIppghdZy8ioD6h6Q/bq4XMIUN2UndNU96SfMHpJvrmUS
         AORw==
X-Received: by 10.60.137.201 with SMTP id qk9mr6036325oeb.15.1431296394967;
 Sun, 10 May 2015 15:19:54 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Sun, 10 May 2015 15:19:34 -0700 (PDT)
In-Reply-To: <CACnwZYeW3+LQZYV4D_+vWggeh_yoWa-C3KdssHO21sRbsEKrMg@mail.gmail.com>
X-Google-Sender-Auth: mWFSTWwwk3Ec7ZibmQPkA6AdeHI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268751>

The current thinking is to model this after the "repo" tool.
Prepare a reasonably up-to-date bundle file on the server side,
add a protocol capability to advertise the URL to download that
bundle from upload-pack, and have "git clone" to pay attention to it.

Then, a "git clone" could become:

 - If the capability advertises such a prebuilt bundle, spawn "curl"
   or "wget" internally to fetch it. This can be resumed when the
   connection goes down and will grab majority of the data necessary.

 - Extract the bundle into temporary area inside .git/refs/ to help
   the next step.

 - Internally do a "git fetch" to the original server. Thanks to the
   bundle transfer that has already happened, this step will become
   a small incremental update.

 - Then prune away the temporary .git/refs/ refs that were in the
   bundle, as these are not the up-to-date refs that exist on the
   server side.

A few points that need to be considered by whoever is doing this
are:

 - Where to download the bundle, so that after killing "git clone"
   that is still in the bundle-download phase, the next invocation
   of "git clone" can notice and resume the bundle-download;

 - What kind of transfer protocols do we want to support? Is http
   and https from CDN sufficient? In other words, what exactly
   should the new capability say to point at the prebuilt bundle?

These (and probably there are several others) are not something
that "repo" does not have to worry about, but would become
issues when we try to fold this into "git clone".



On Sun, May 10, 2015 at 2:55 PM, Thiago Farina <tfransosi@gmail.com> wrote:
> Hi,
>
> Is there links to discussion on this? I mean, is resume downloads a
> feature that is still being considered?
>
> Being able to download huge repos like WebKit, Linux, LibreOffice in
> small parts seems like a good feature to me.
>
> --
> Thiago Farina
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
