From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multi-threaded 'git clone'
Date: Tue, 17 Feb 2015 19:14:05 -0800
Message-ID: <CAPc5daWK-GbjL=YEyW55bcBELoq05dy4umh11upG=YxKQuFMpQ@mail.gmail.com>
References: <20150217052007.CC8B713FECF@smtp.codeaurora.org> <xmqqegpoxgf3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	David Lang <david@lang.hm>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 04:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNv5r-00018B-A8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 04:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbbBRDO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 22:14:26 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:53626 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbBRDOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 22:14:25 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so60901599obc.10
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 19:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Zm/ewrvgC7H3tc5eoFuozr3DPIvGLDGUrrzA1DxGYHo=;
        b=kCTqSW68XZUzdxF/cJVRMFUX1+FC9f43xVlWixjhIu+/Ob9jzSrOQbBU0xcG45Ft/H
         69rEfwwmwHNNNcNN5O5fvRys33doCukGYRre+zBao6YKrvLxyyZMc1/pd7abQQwHAEuu
         hdxtizgdzlKIpUndyhULsbHK6X5/NI2ZJWe02c3iA49xywKhzIscDgKbZtbk/iXeEyn7
         uZgnIL7Qn5BzL8FRAFYKKaoIVs/mCwDICIVx/vAbFG2HoFqwxExFaM2v15P0AeCQsIyH
         go9vHxzDhncWvNSD0lAObhmjbt/e2jqL7+2FFLBMke+ydQ2p45rC818DLuB3DAO3PlVn
         /xCg==
X-Received: by 10.182.43.129 with SMTP id w1mr20805516obl.86.1424229265317;
 Tue, 17 Feb 2015 19:14:25 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Tue, 17 Feb 2015 19:14:05 -0800 (PST)
In-Reply-To: <xmqqegpoxgf3.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: J0DRPljmFOi5vk6d4OvUtahHVmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264003>

On Tue, Feb 17, 2015 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:

A few typofixes and clarifications.

> *4* The scheme in *3* can be extended to bring the fetcher
>     step-wise.  If the server's state was X when the fetcher last

"bring the fetcher up-to-date step-wise", or "update the fetcher step-wise".

>     contacted it, and since then the server received multiple pushes
>     and has two snapshots of states, Y and Z, then the exchange may
>     go like this:
>
>     fetcher: I am interested in refs/heads/* and refs/tags/* and I
>              have your state X.
>
>     server:  Here is the incremental difference to the refs and the
>              end result should hash to Y.  Here comes the pack data
>              to bring you up to date.
>
>     fetcher: (after receiving, unpacking and updating the
>              remote-tracking refs) Thanks.  Do you have more?
>
>     server:  Yes, here is the incremental difference to the refs and the
>              end result should hash to Z.  Here comes the pack data
>              to bring you up to date.
>
>     fetcher: (after receiving, unpacking and updating the
>              remote-tracking refs) Thanks.  Do you have more?
>
>     server:  No, you are now fully up to date with me.  Bye.

The initial part of this exchange may go like this, if the state the
fetcher grabbed the last time from this server is even older than X:

  fetcher: I am interested in refs/heads/* and refs/tags/* and I have
        your state W (or "I know I am too old that I do not know what
        you call that state").

  server: Sorry, I do not know what W is. Please be more specific.

  fetcher: Here are the refs and their objects: refs/heads/master points
        at commit A, refs/heads/maint points at commit B, ...

  server: (goes and checks and finds out that fetcher is behind X).
        OK, I'll compute a custom pack to bring you up to date with
        one of my states. Here is the incremental difference to the refs,
        and the end result should hash to X. Here comes the pack data.

  fetcher: (after receiving, unpacking and updating the
        remote-tracking refs) Thanks. Do you have more?

After that, the server would update this client to state Y and then
state Z as above.

Needless to say, this would naturally extend to a case where you
follow only a single branch (you would say "I am interested in your
refs/heads/dev" with a wildcard that matches exactly that branch).
Of course, depending on the access pattern by common project
participants, the server side may choose what set of refs to prepare
such snapshots and uncommon requests may always be served by
the traditional object enumeration codepath.
