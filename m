From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Mon, 23 Feb 2015 22:15:09 -0800
Message-ID: <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com> <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:15:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ8mP-0007lC-0I
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 07:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbbBXGPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 01:15:32 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:46098 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbBXGPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 01:15:31 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so41496039obc.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 22:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=u+gttiz3EQf0VYaLoZlH8QGX3hKpjA/vxp4uTjW0+5w=;
        b=n5mCaxuqQOKexjqCpKPicGzCQR6JKkr3jmYIUNO10eM2+91v5CFzDSjajsRAXr5Isk
         71homV4bVyqC64ZEytPTOHp/+AGVzBUnMNAIrK4bpDH7EYTVSq4OWx1AG/xduUfXfkXE
         S2rJw+Fk4QlKbvz0Jn8/3JxZt4RCwAyXRSWUZveSct1h5qtDxhlK0RWT+Yc9Vfp/jYY6
         2CEdX9X8KIs03tnl5TzvDT+8nIQpAePlg+yWH9V3rF3njPtQeC045B0GqLRmfJm7ErPa
         1EmBx9kBeMTVUtuMl6lXMCS/9+wdKSyl4ZLlJCZ9re3FfWjOy/8vB7jrAxVpwpilQb8I
         7mlQ==
X-Received: by 10.60.51.102 with SMTP id j6mr10037120oeo.34.1424758531240;
 Mon, 23 Feb 2015 22:15:31 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Mon, 23 Feb 2015 22:15:09 -0800 (PST)
In-Reply-To: <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
X-Google-Sender-Auth: -WuxVZTXmOtQ8fOkNfAQ8GL4DYA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264311>

On Mon, Feb 23, 2015 at 8:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> It's very hard to keep backward compatibility if you want to stop the
> initial ref adverstisement, costly when there are lots of refs. But we
> can let both protocols run in parallel, with the old one advertise the
> presence of the new one. Then the client could switch to new protocol
> gradually. This way new protocol could forget about backward
> compatibility. See
>
> http://thread.gmane.org/gmane.comp.version-control.git/215054/focus=244325

Yes, the whole thread is worth a read, but the approach suggested by
that article $gmane/244325 is very good for its simplicity. The server
end programs, upload-pack and receive-pack, need to only learn to
advertise the availability of upload-pack-v2 and receive-pack-v2
services and the client side programs, fetch-pack and push-pack,
need to only notice the advertisement and record the availability of
v2 counterparts for the current remote *and* continue the exchange
in v1 protocol. That way, there is very little risk for breaking anything.

And the programs for new protocol exchange do not have to worry
about having to talk with older counterparts and downgrading the
protocol inline at all. As long as we learn from our past mistakes
and make sure that the very initial exchange will be kept short (one
of the items in the list of limitations, $gmane/264000), future servers
and clients can upgrade the protocol they talk inline by probing
capabilities, just like the current protocol allows them to choose
extensions. The biggest issue in the current protocol is not "who
speaks first" (that is merely one aspect) but "what is spoken first",
iow, "one side blinly gives a large message as the first thing", which
cannot be squelched by capability exchange.

So if we are going to discuss a new protocol, I'd prefer to see the
discussion without worrying too much about how to inter-operate
with the current vintage of Git. It is no longer an interesting problem,
as we know how to solve it with minimum risk. Instead, I'd like to
see us design the new protocol in such a way that it is in-line
upgradable without repeating our past mistakes.

I am *not* convinced that we want multiple suite of protocols that
must be chosen from to suit the use pattern, as mentioned somewhere
upthread, by the way.

Thanks.
