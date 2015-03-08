From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git very slow ?
Date: Sun, 8 Mar 2015 12:39:10 -0700
Message-ID: <CA+55aFwn9vOWAL_9eHQt+kQN16j3+nQLeibWos86g5T_RZEizg@mail.gmail.com>
References: <20150307013007.GA13250@milliways>
	<20150308155136.GA6273@vps892.directvps.nl>
	<20150308190244.GA32504@milliways>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin D <me@ikke.info>, Git Mailing List <git@vger.kernel.org>
To: Ken Moffat <zarniwhoop@ntlworld.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUh2n-0000uD-T3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbbCHTjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 15:39:13 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34696 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbCHTjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 15:39:11 -0400
Received: by iecvy18 with SMTP id vy18so33724052iec.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pq0QdJ9YYSKmn65Hiy3U/ZNt4P7fm7Uv8emvO6BHwMc=;
        b=ry4O/7mmdZo4q1fLTYUwN/IWPrTENRlL7qaSvLU9S4N8QKSdJzeqy0wTLsfXKIX+Et
         IlDYyak31j1AhNoeY/bAzLA5UEcMQAi2UMwFF3x7pgFFEjOvYCnPeBNDqNHVA3Rs9mGX
         80tYcc8djngNRgULE7Hb2dxOrdc+1c73u3tlO/c11bjk1Qng1T22q/E2mKy0ugZKZqlF
         n2v2dgiehMQOaMftMt2aZBIEzmVv2PRBjzmfgzeZ11W/b9wrXUJLG098WtrKcYLkRlff
         KNAwSXn4JXwtAiiicdOhLMK8fpx+u1AFu3fg5a2KAykUgH/zh0TWUaxGXV0nO0Zn3oQK
         g6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pq0QdJ9YYSKmn65Hiy3U/ZNt4P7fm7Uv8emvO6BHwMc=;
        b=I6kMpDFXmud/4jk97mJupq8/J9gR8mRoH8GtYJOd4is+sPkeFRqM8BfG0F4X/IF211
         OKAYAgA/8iPTJwYIV0tPiXxovjrS0diiurf6qyMa5nhTsFT6jEr+IK4kR7seWzT2qkUv
         QVhCrDhz5q35S623FPGFBPMqz/9l9b4z/dyMU=
X-Received: by 10.107.157.195 with SMTP id g186mr42718370ioe.72.1425843550684;
 Sun, 08 Mar 2015 12:39:10 -0700 (PDT)
Received: by 10.36.60.9 with HTTP; Sun, 8 Mar 2015 12:39:10 -0700 (PDT)
In-Reply-To: <20150308190244.GA32504@milliways>
X-Google-Sender-Auth: 1EdAfyY1HAk7HP2i8afhloih9iA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265105>

On Sun, Mar 8, 2015 at 12:02 PM, Ken Moffat <zarniwhoop@ntlworld.com> wrote:
>
> The comments on git bisect were for linus'skernel tree, on a local
> disk.  2.3GB of repo, just under 57000 files.

Ugh. I hope you are talking about checked-out size.

    [torvalds@i7 linux]$ du -sh .git
   850M .git

because otherwise it sounds like that repo hasn't been repacked in forever.

To really pack things (which can slow things down for old history as
people said, but on the whole it tends to be a big win due to less
IO), do

   git repack -adf --window=200 --depth=200

and go away for a while. Oh, and make sure your machine has enough
memory and CPU to make that "for a while" not be *too* long.

You should have a few hundred files (just a few tens of files directly
after the repack) and that roughly 850MB of space for the repository
information itself.

But yeah, fully checked out and built with all the modules etc, you
would have much more.

That said, if you have something fairly that is consistently really
slow (like the "git commit" you mentioned), *before* doing the repack,
do

   strace -o ../trace-file -Ttt git commit

and we can get a much better guess about why it's so slow. Send it to
me in private email if you don't want to make it public, and I can
take a look.

> ping between them gives times of 0.25 to 0.3 seconds

.. and I *really* hope that was not seconds, but ms. Otherwise your
nfsv3 setup is going to be really really painful.

                          Linus
