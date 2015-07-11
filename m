From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git Smart HTTP with HTTP/2.0
Date: Sat, 11 Jul 2015 10:23:09 -0700
Message-ID: <CAJo=hJs21m1C6+rdvCid311-TapK=QKLkqrH8aUZmzHH7CpVug@mail.gmail.com>
References: <BLU403-EAS33258611CF3B5B553B1C996A09E0@phx.gbl> <20150711070055.GA4061@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ForceCharlie <fbcharlie@outlook.com>, git <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jul 11 19:23:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDyUy-0004oL-Ru
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 19:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbbGKRXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 13:23:31 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:32868 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbGKRXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 13:23:30 -0400
Received: by wgmn9 with SMTP id n9so16605820wgm.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j56Z40bYXYY3FGbybhCdd9ZG0jz+2/QKsKG8BRUVtZI=;
        b=X3e1wFv1LKFnW5e5qqBQxD36KuRW/WgirAWTwpQiwFhm96UyqWxDnGcD54ML+Val7F
         o1VpjKcokhNJziCB2Fi/poEPuznTGJswm9cJebnJq9gy9aooFnk1mJyk9mFtwNdA/biK
         Dlh6CpLS86U+SB2R/XsDRkcSffRDs7M61WAVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=j56Z40bYXYY3FGbybhCdd9ZG0jz+2/QKsKG8BRUVtZI=;
        b=YRZeD44WXlHtnEMz2MBe6oDqEqNDGBZMvQofAtCtYaTJZdIOUmtZOB+JR8m8RPxHOX
         u4shQq4LBJD55oxc/83ZiECj3lmBvVZ/ghJuwtK+QHQT7CxXkoIhdMUNTjiD+VsqC/xh
         w9zs0v9NTdi2JHM5vQSZJb137EnVvRtOacNqKKN2nIkqblJdK51JyJm2zS1J3oIr03Di
         v/TlN5NVddEN1bnuRw+Ci72kA979kCorjwhxytUqGF/fpTkmgcP41rSKxFQIOPkfTuzt
         EeQRslXrlXWpVobvD6jKCwrpFwuOER3Y9pWec4xH9BpiSXji8wFKpfpVoj8lro08MSWX
         5O2w==
X-Gm-Message-State: ALoCoQlpt7Qndmg8LuDWMSAGaTKq5hlwU49j4bwxIRCoCx1ubVbq9z7OWoViK1ybLP5r49EhrDFJ
X-Received: by 10.180.84.194 with SMTP id b2mr7782083wiz.36.1436635408642;
 Sat, 11 Jul 2015 10:23:28 -0700 (PDT)
Received: by 10.28.228.70 with HTTP; Sat, 11 Jul 2015 10:23:09 -0700 (PDT)
In-Reply-To: <20150711070055.GA4061@LK-Perkele-VII>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273875>

On Sat, Jul 11, 2015 at 12:00 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Sat, Jul 11, 2015 at 11:10:48AM +0800, ForceCharlie wrote:
>> As we known, HTTP/2.0 has been released. All Git-Smart-HTTP are currently
>> implemented using HTTP/1.1.
>
> Nit: It is HTTP/2.
>
>> Frequently used Git developers often feel Git HTTP protocol is not
>> satisfactory, slow and unstable.This is because the HTTP protocol itself
>> decides
>
> Note that there are already two versions of HTTP transport, the old "dumb"
> one and the newer "smart" one.
>
> The smart one is difficult to speed up (due to nature of the negotiations),
> but usually is pretty reliable (the efficiency isn't horrible).

The negotiation in smart-HTTP actually has some bad corner cases. Each
round of negotiation requires a new POST resupplying all previously
agreed upon SHA-1s, and a batch of new SHA-1s. We have observed many
rounds where this POST is MiBs in size because the peers can't quite
agree and have to keep digging through history.

The native protocol on git:// and SSH is not as bad. Negotiation is
still many rounds, but these are pipelined and each round does not
need to repeat the prior round, as the server has a single stream and
is saving state.

> Now, the old "dumb" protocol is pretty unreliable and slow. HTTP/2 probably
> can't do anything with the reliability problems, but probably could improve
> the speed a bit.
>
> Websockets over HTTP/2 (a.k.a. "websockets2") has not been defined yet.
> With Websockets(1), it would probably already be possible to tunnel the
> native git smart transport protocol over it. Probably not worth it.

Another option is to tunnel using gRPC (grpc.io). libcurl probably
can't do this. And linking grpc.io library into git-core is crazy. So
its probably a non-starter. But food for thought.

But, at $DAY_JOB we tunnel the native bidirectional protocol in
grpc.io's predecessor, and it works quite well for us.
