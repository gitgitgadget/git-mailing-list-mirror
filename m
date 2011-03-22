From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 11:38:06 +0100
Message-ID: <AANLkTimH+eVUh6D5qK-PbNJGg46XJwaCii5zMg7xyZ_6@mail.gmail.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
	<20110321215310.GA2122@sigill.intra.peff.net>
	<7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
	<7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1yyd-0007MY-K4
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 11:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab1CVKiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 06:38:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60691 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab1CVKiI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 06:38:08 -0400
Received: by bwz15 with SMTP id 15so5716795bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mrPS9BuKqrnzXe/Ylp/v3Dt69PQZw/c9VKKOObpzntE=;
        b=q2e84URn7QqbOsFopDdq7Y6ALOzwMvhyP7boP8adgiAy409E8N0AIAosLbR0FS7mnO
         Qpyqt6LzGr5/wHkE+p2XDf3DaKLZVXMuh0AiEiZd4ibAitCSWYD7hp3Z1G7KPc7OXmEy
         3RuFsymdxgQ4cS7a/RNPWXvoAEKuSyiMkJn0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jk6hmCZZWorQ35Tdy3mfuBiSwwh/euN0BkWcoVRRPgiTD2uzJI6qr0KID/JObOVizX
         VKJ1byrtWh6SJrRaL8eInXiyQbP27iL5pPz0QXR4izIKlMNc0y9lSUnByk5AzjAFsQ27
         LRKeQZdjeuQSMRj1v6ckPF9tITdndTip2PzPM=
Received: by 10.204.126.147 with SMTP id c19mr4787170bks.60.1300790286651;
 Tue, 22 Mar 2011 03:38:06 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Tue, 22 Mar 2011 03:38:06 -0700 (PDT)
In-Reply-To: <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169719>

On 21 March 2011 23:33, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Oh, I should have been paying a bit more attention. =A0I've been ass=
uming
>> that we were turning "!anything" into { "sh", "-c", "anything", "-" =
}
>> followed by the user supplied arguments.
>
> The attached quick hack gives
>
> =A0$ git config alias.silly
> =A0!echo hello $1; echo $# args, bye!
> =A0$ GIT_TRACE=3D1 ./git silly world funny
> =A0trace: exec: 'git-silly' 'world' 'funny'
> =A0trace: run_command: 'git-silly' 'world' 'funny'
> =A0trace: run_command: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!=
'' '-' 'world' 'funny'
> =A0trace: exec: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!''
> =A0'-' 'world' 'funny'
> =A0hello world
> =A02 args, bye!

That would IMHO be The Right Way to do it. Since the documentation for
aliases promises to to pass my alias to a shell if I prefix it with
"!", I shouldn't have to add the "sh -c ... -" myself...

> but it would penalize a properly written alias that uses "sh -c <it> =
-"
> trick itself by double forking, which is not very nice and I am unhap=
py
> about.

A properly written alias that uses a trick? I guess that sums up the
problem... :-)

Anyway, doesn't the existing way potentially break when passing funky
arguments containing spaces/quotes/something? We currently pass the
arguments to the alias command as a single quoted string. Passing them
as seperate elements on argv seems a lot more robust...

Do we risk breaking any existing "!sh -c ... -" aliases by applying thi=
s?

/Lasse
