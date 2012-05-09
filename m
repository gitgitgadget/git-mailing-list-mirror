From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Seeing high CPU usage during git-upload-pack
Date: Wed, 9 May 2012 17:37:38 +0700
Message-ID: <CACsJy8DMm0ZNiQYQ1CvOfDJu5ogP42Y06792iA_xyzeHDGLJaw@mail.gmail.com>
References: <CAPeUw3EsFCxki6obAAeVBb0g4MKNWBteL3VueG5djbajkFiv3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Ebbo <david.ebbo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 12:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS4Hg-0007vu-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 12:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab2EIKiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 06:38:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60268 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab2EIKiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 06:38:09 -0400
Received: by wgbdr13 with SMTP id dr13so124845wgb.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QP4YTwU/43NvOijDqU34T60+e+PzlsPfW1HIiKe8N3Y=;
        b=POP1qVo5KCdXW1YhBx3tcBqRTeYeBLdPnDwsM5Po9xPMNff55C/S6P6VX7eC4kV9Pi
         pQhmMkLfh8eXMI6tTSgMkZRswlTMkXwucYyBqk23I73wZhaS6Ia+KZIGQ4LZaQmOyiq5
         gFqzV64/kYrkwsPqJ3Efgwh6KmHyxyfY7yUoe21/JFUASM2jvPYgOTxCy0JR2STiSuMQ
         6lr56vz2J0TaKlP2jcLZ4hAB0GAODndtFa7QD4viqQtkGU0lpL+NjKIsJUhDKz9nAuW0
         iXTUNeIJksl241WDCUL3UN850JFmsOfx2orV3B3Gkb8e7nrgnsDIOrwN5LTEjhY1kPKl
         XI3Q==
Received: by 10.180.82.5 with SMTP id e5mr14211891wiy.0.1336559888333; Wed, 09
 May 2012 03:38:08 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 9 May 2012 03:37:38 -0700 (PDT)
In-Reply-To: <CAPeUw3EsFCxki6obAAeVBb0g4MKNWBteL3VueG5djbajkFiv3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197465>

On Wed, May 9, 2012 at 2:01 PM, David Ebbo <david.ebbo@gmail.com> wrote=
:
> We=E2=80=99re using git-upload-pack in a simple git server. When the =
repo is
> on a slow share, we=E2=80=99re noticing that git-upload-pack is huggi=
ng the
> CPU during the whole pack-objects operation.

What OS is it run on? What git version?

> More details:
>
> - git-upload-pack gets launched (with params git-upload-pack
> --stateless-rpc //path/to/repo)
> - it itself launches a git process (with params pack-objects --revs
> --all --stdout --progress --delta-base-offset). This git process is
> the one that does all the disk I/O, but it's not the one using up the
> CPU time.
> - git-upload-pack appears to be waiting for the git process, and is a=
t
> high CPU during that time, suggesting that it's doing some kind of
> busy wait. To further test that, I stopped the git process in the
> debugger, preventing it from making progress. At that point,
> git-upload-pack pegs the CPU forever.

How about stopping upload-pack and see where it stops? There's a main
loop in upload-pack.c, create_pack_file() that is only active when
data comes. I looked but failed to see how it becomes a busywait loop.
Maybe you can put some debugging there.

Setting env var GIT_TRACE_PACKET and GIT_DEBUG_SEND_PACK before
running upload-pack might also help.

> Would someone familiar with the sources be able to comment on this
> busy wait behavior, and on whether it could conceivably be done in a
> way that doesn=E2=80=99t use up some much CPU?
--=20
Duy
