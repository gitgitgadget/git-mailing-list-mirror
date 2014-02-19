From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/6] inotify support
Date: Wed, 19 Feb 2014 12:35:28 -0800
Message-ID: <CAJo=hJuu8-F_=XyhPVqqK4JPQabK2iZJS=K+=mQ9dnu4Vm1uaQ@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDs3-0002tR-Ek
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbaBSUfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:35:51 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:52287 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaBSUfu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:35:50 -0500
Received: by mail-wg0-f43.google.com with SMTP id a1so780890wgh.10
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+jeKg0u4NCf0Yw/E8WZzIRbtuxwPTyQvobu0K213kOw=;
        b=RXsJXmHLBTrmenbgCILRrAFCE9UBytVuTa6kAg1QX9PpaPl/snN5CejhBRQl3EyCZG
         Gpz7pTrO+/eah5MqZsLTJBBl7FYlRud1QfOQJ9ooQMbQZw3l/QJ6/71bl9zc83xQQEXH
         MdhORKi6SlSJCKqILixI47goH1yrbIxkESJ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=+jeKg0u4NCf0Yw/E8WZzIRbtuxwPTyQvobu0K213kOw=;
        b=C3DLSgLoHwHcc/jjfW/2s0UJhiwCupWIIuvffuziZAGp34tuYD+paEUAcPD4zMLREX
         onglkoTiUpfg8G4JfKJMzQJJ1F2nKgGlNCi7JKnVtIE1KItvrrrZ0LbldUB88sOOwDYW
         CUyKJgGBrQU+1AZXKMgt30EUwD5Gc5qy/5SGB8oyL3TZ7sjgStTVIRnsehLSZBx47IWI
         HZjcG8Bo0aoDdR91Ewexpd+KcepgGCV3C+rZ5M7/zCWKwT8hoMbamgZCgnXtzDpvVYFr
         woSN5UixXDjkP9LOWdlG4OM84J2zw0vq/7Y0dYQCClTQHmGVqUuhhl78sDyU5HvWlHxG
         gWCg==
X-Gm-Message-State: ALoCoQnA/lrbjro6JaZUDmPEdDwnzxmUpqoBeU6yhvy6vTdm4n8mmKoetToEYkNK7+wXv6V2AUvU
X-Received: by 10.180.101.166 with SMTP id fh6mr3540419wib.2.1392842149038;
 Wed, 19 Feb 2014 12:35:49 -0800 (PST)
Received: by 10.227.7.132 with HTTP; Wed, 19 Feb 2014 12:35:28 -0800 (PST)
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242409>

On Sun, Jan 12, 2014 at 3:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> It's been 37 weeks since Robert Zeh's attempt to bring inotify suppor=
t
> to Git [1] and unless I missed some mails, no updates since. So here'=
s
> another attempt with my preferred approach (can't help it, playing
> with your own ideas is more fun than improving other people's code)
>
> To compare to Robert's approach:
>
> - This one uses UNIX datagram socket. If I read its man page right,
>   unix socket respects the containing directory's permission. Which
>   means on normal repos, only the user process can access. On shared
>   repos, multiple users can access it. This should work on Mac.
>   Windows will need a different transport.
>
> - The daemon is dumb. It passes the paths around and that's it.
>   lstat() is done by git. If I design it right, there's should not be
>   any race conditions that make git miss file updates.
>
> - CE_VALID is reused to avoid mass changes (granted there's other
>   neat ways as well). I quite like the idea of machine-controlled
>   CE_VALID.
>
> inotify support has the potential of reducing syscalls in
> read_directory() as well. I wrote about using lstat() to reduce
> readdir() a while back, if that's implemented then inotify will fit i=
n
> nicely.
>
> This is just a proof of concept. I'm sure I haven't handled all error
> cases very well. The first five patches show the protocol and git
> side's changes. The last one fills inotify in.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/215820/foc=
us=3D222278

Why a new daemon? Why don't we reuse the stable
https://github.com/facebook/watchman project Facebook built to make
Hg's status system fast?
