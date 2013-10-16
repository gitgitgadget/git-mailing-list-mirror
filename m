From: Martin Fick <mfick@codeaurora.org>
Subject: Re: pack corruption post-mortem
Date: Wed, 16 Oct 2013 09:41:16 -0600
Organization: CAF
Message-ID: <201310160941.16904.mfick@codeaurora.org>
References: <20131016083400.GA31266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 17:41:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWTDz-0003Iz-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 17:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab3JPPlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 11:41:22 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:46602 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab3JPPlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 11:41:19 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3DA7013EF8C;
	Wed, 16 Oct 2013 15:41:18 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 2F77513F283; Wed, 16 Oct 2013 15:41:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id C7F0313EF8C;
	Wed, 16 Oct 2013 15:41:17 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20131016083400.GA31266@sigill.intra.peff.net>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236248>

On Wednesday, October 16, 2013 02:34:01 am Jeff King wrote:
> I was recently presented with a repository with a
> corrupted packfile, and was asked if the data was
> recoverable. This post-mortem describes the steps I took
> to investigate and fix the problem. I thought others
> might find the process interesting, and it might help
> somebody in the same situation.

This is awesome Peff, thanks for the great writeup!

I have nightmares about this sort of thing every now and 
then, and we even experience some corruption here and there 
that needs to be fixed (mainly missing objects when we toy 
with different git repack arguments).  I cannot help but 
wonder, how we can improve git further to either help 
diagnose or even fix some of these problems?  More inline 
below...


> The first thing I did was pull the broken data out of the
> packfile. I needed to know how big the object was, which
> I found out with:
> 
>   $ git show-index <$idx | cut -d' ' -f1 | sort -n | grep
> -A1 51653873 51653873
>   51664736
> 
> Show-index gives us the list of objects and their
> offsets. We throw away everything but the offsets, and
> then sort them so that our interesting offset (which we
> got from the fsck output above) is followed immediately
> by the offset of the next object. Now we know that the
> object data is 10863 bytes long, and we can grab it
> with:
> 
>   dd if=$pack of=object bs=1 skip=51653873 count=10863

Is there a current plumbing command that should be enhanced 
to be able to do the 2 steps above directly for people 
debugging (maybe with some new switch)?  If not, should we 
create one, git show --zlib, or git cat-file --zlib?


> Note that the "object" file isn't fit for feeding
> straight to zlib; it has the git packed object header,
> which is variable-length. We want to strip that off so
> we can start playing with the zlib data directly. You
> can either work your way through it manually (the format
> is described in
> Documentation/technical/pack-format.txt), or you can
> walk through it in a debugger. I did the latter,
> creating a valid pack like:
> 
>   # pack magic and version
>   printf 'PACK\0\0\0\2' >tmp.pack
>   # pack has one object
>   printf '\0\0\0\1' >>tmp.pack
>   # now add our object data
>   cat object >>tmp.pack
>   # and then append the pack trailer
>   /path/to/git.git/test-sha1 -b <tmp.pack >trailer
>   cat trailer >>tmp.pack
> 
> and then running "git index-pack tmp.pack" in the
> debugger (stop at unpack_raw_entry). Doing this, I found
> that there were 3 bytes of header (and the header itself
> had a sane type and size). So I stripped those off with:
> 
>   dd if=object of=zlib bs=1 skip=3

This too feels like something we should be able to do with a 
plumbing command eventually?

git zlib-extract

> So I took a different approach. Working under the guess
> that the corruption was limited to a single byte, I
> wrote a program to munge each byte individually, and try
> inflating the result. Since the object was only 10K
> compressed, that worked out to about 2.5M attempts,
> which took a few minutes.

Awesome!  Would this make a good new plumbing command, git 
zlib-fix?


> I fixed the packfile itself with:
> 
>   chmod +w $pack
>   printf '\xc7' | dd of=$pack bs=1 seek=51659518
> conv=notrunc chmod -w $pack
> 
> The '\xc7' comes from the replacement byte our "munge"
> program found. The offset 51659518 is derived by taking
> the original object offset (51653873), adding the
> replacement offset found by "munge" (5642), and then
> adding back in the 3 bytes of git header we stripped.

Another plumbing command needed?  git pack-put --zlib?

I am not saying my command suggestions are good, but maybe 
they will inspire the right answer?

-Martin
