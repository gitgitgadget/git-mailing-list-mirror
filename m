From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Make 'git request-pull' more strict about matching
 local/remote branches
Date: Wed, 22 Jan 2014 14:20:34 -0800
Message-ID: <CA+55aFxdNv+Y+OzSazY=yaEGkG57+HsiDCi93tBhvNHarSFyjA@mail.gmail.com>
References: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
	<xmqqwqhrwtoy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 23:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66A3-0003c5-UL
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbaAVWUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:20:36 -0500
Received: from mail-ve0-f172.google.com ([209.85.128.172]:62624 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbaAVWUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:20:35 -0500
Received: by mail-ve0-f172.google.com with SMTP id c14so639996vea.31
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VnORb3uVMmfRKC5nWOyEQGYiKP6uFkxgpNjHdaw8KUA=;
        b=b1yRCyNPx3FLyO+Jjo2L5i7bPi09u0DgYaU3mxsco5BoQuMn8uQA2pMrkcFAahhLVm
         exQmb0q0sqPM391B0XhQmqFM7OzaLFUzDywoObMkBh9WRQ8vGHARI0/BWhshZq+TcpVe
         taLeJEOoUnaOXCMdQrT03/2XOFzQlDFSV6o9bEhRkbUypY7Ju6p3I5Ey4SAfBJuCX4zN
         auENNvgkoBuA2j2Sau9tMbllf/FV1hzU3CmkM5VLPz5HOY6Ev8xV3XnNwDYtl+qbJHni
         dSPtzFgG3tR30pZsaLfCcxDy5LMHAzA1KiC9fFgnKLpNwuJd5JECA6+e6lIhlUBWOwA5
         sLMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VnORb3uVMmfRKC5nWOyEQGYiKP6uFkxgpNjHdaw8KUA=;
        b=EFSp22mG4wVU1ANXBAhaVuAy8/Scylt/kUgDmxzN0IzAHmAM5a32e7rvA00ocePb+K
         9jIRltGnzpXUxIhf0mVGfDTvRouIMGP9D+yESCzC2TX+QyaUWGO/ycqGYxzZ+Rq1t9cU
         yVr4AqUeZOQrs+5b1dv4ibxvvldEvv/1KUaMY=
X-Received: by 10.58.37.67 with SMTP id w3mr2631450vej.22.1390429234394; Wed,
 22 Jan 2014 14:20:34 -0800 (PST)
Received: by 10.221.8.73 with HTTP; Wed, 22 Jan 2014 14:20:34 -0800 (PST)
In-Reply-To: <xmqqwqhrwtoy.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: Gl3I7bY01RbYUTi4_N-DEmkTZRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240868>

On Wed, Jan 22, 2014 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I looked at 5150.4 and found that what it attempts to do is halfway
> sensible.

I agree that it is "half-way sensible". The important bit being the HALF part.

The half part is why we have the semantics we have. There's no
question about that.

The problem is, the *other* half is pure and utter crap. The "half-way
sensible" solution then generates pure and utter garbage in the
"totally sensible" case.

And that's why I think it needs to be fixed. Not because the existing
behavior can never make sense in some circumstances, but because the
existing behavior can screw up really really badly in other (arguably
more common, and definitely real) circumstances.

For the kernel, the broken "missing branch name" situation has come up
pretty regularly. This is definitely not a one-time event, it's more
like "almost every merge window somebody gets screwed by this and I
have to guess what the branch name should have been".

I think that we could potentially do a "local:remote" syntax for that
half-way sensible case, so that if you do

   git push .. master:for-linus

then you have to do

   git request-pull .. master:for-linus

to match the fact that you renamed your local branch on the remote.

              Linus
