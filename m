From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 07:04:36 +0700
Message-ID: <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:05:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOb5o-00074a-1z
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 01:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbBTAFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 19:05:08 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:56303 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbBTAFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 19:05:07 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so48142457igb.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 16:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AWRoRmf11cd+dgiaG7aYX7XpJyDW1RcCeAjOVf4mdmk=;
        b=avKgLs8nXsjvaoKvaAvBOwuMBDd1scpHaB5MGBXjSAUEeri0kF0c7zD/76VSsGGS1w
         RT9gJNsIViPv7g8fIvVEDtTUVBnUP/yqUfi7n3HUginMm6Af2u0JdwYKb/tzSTGcf974
         dfS0RitvdJksfTu/pkD8DSrW5sKPKxhvq7jN4mkr+6GuU2FvjzeiuJy6Sok1OXeQrU2n
         DsvYB3vwc7C6bXtnPhJbAY0viu4ZxJU0ft8oRnAmyS4s0ysdtO3vnDFhRoK0/vliiehA
         10rQTZ3W2V5x7guPtgcttFeMw2f43nbcpWjCojwhvJ1dKU2JRRod+S52VN4g+zaO+AcO
         Rtsw==
X-Received: by 10.42.83.147 with SMTP id h19mr9106864icl.95.1424390706903;
 Thu, 19 Feb 2015 16:05:06 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Thu, 19 Feb 2015 16:04:36 -0800 (PST)
In-Reply-To: <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264124>

On Fri, Feb 20, 2015 at 6:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Anecdotally I work on a repo at work (where I'm mostly "the Git guy")=
 that's:
>
>  * Around 500k commits
>  * Around 100k tags
>  * Around 5k branches
>  * Around 500 commits/day, almost entirely to the same branch
>  * 1.5 GB .git checkout.
>  * Mostly text source, but some binaries (we're trying to cut down[1]=
 on those)

Would be nice if you could make an anonymized version of this repo
public. Working on a "real" large repo is better than an artificial
one.

> But actually most of "git fetch" is spent in the reachability check
> subsequently done by "git-rev-list" which takes several seconds. I

I wonder if reachability bitmap could help here..

> haven't looked into it but there's got to be room for optimization
> there, surely it only has to do reachability checks for new refs, or
> could run in some "I trust this remote not to send me corrupt data"
> completely mode (which would make sense within a company where you ca=
n
> trust your main Git box).

No, it's not just about trusting the server side, it's about catching
data corruption on the wire as well. We have a trick to avoid
reachability check in clone case, which is much more expensive than a
fetch. Maybe we could do something further to help the fetch case _if_
reachability bitmaps don't help.
--=20
Duy
