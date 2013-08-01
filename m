From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close
 packs on fd pressure
Date: Thu, 1 Aug 2013 12:16:57 -0700
Message-ID: <CA+sFfMer+5bhqxF=_zAQhZ+8sQD6EAYb8HBtYpuhQY_0uj-m9A@mail.gmail.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<7vsiyts5bb.fsf@alter.siamese.dyndns.org>
	<CA+sFfMdp9j4LL4eocbsJu5DCEfhoE=uEN_wJ3o8VBW+hUVFVLQ@mail.gmail.com>
	<7v4nb9s1az.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 21:17:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4yMx-00016z-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 21:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab3HATQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 15:16:59 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37254 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab3HATQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 15:16:58 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so5460015wib.10
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xZmzPXAX6nB7Y31xEHdZMfBt7x4y9DuFhodnflaJH0M=;
        b=qpj7YuRi+0JtsBghfVxyidUSA46dFhUb0RmCn0p+olvA13PBcyNROPrVy2JJUuCyk4
         qfMbIkj9PkHIDGRhjcqndEP10DLG+p9ATY1+Di87xJt/z0cdbE38FyNBmTkRWNJTf5TF
         opsZM1U+mDU3i3u1mn8+JVC6i7GSqwtKjZlJaSsMtfeIelNGxq+YHBCj+TVeTJU3icVH
         yCNAQT8rcTyGWVI31zC7E70T1jrIkwcbH4JrfHWOKtZJ/8Pboqc3EjhYMhTP9T++xDf5
         z+/e9x5A92l7Pgopd2h/S0828SR1GLGOyp7zU+MJzEzb1FMLCeiYRopT4abvMG4WeSxP
         +ZMQ==
X-Received: by 10.194.60.5 with SMTP id d5mr2485543wjr.26.1375384617285; Thu,
 01 Aug 2013 12:16:57 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Thu, 1 Aug 2013 12:16:57 -0700 (PDT)
In-Reply-To: <7v4nb9s1az.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231500>

On Thu, Aug 1, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> I've been looking closer at uses of p->windows everywhere, and it
>> seems that we always open_packed_git() before we try to create new
>> windows.  There doesn't seem to be any reason that we can't continue
>> to use the existing open windows even after closing the pack file.
>> ...
>> If we don't need to close_pack_windows(), find_lru_pack() doesn't
>> strictly need to reject packs that have windows in use.
>
> That makes me feel somewhat uneasy.  Yes, you can open/mmap/close
> and hold onto the contents of a file still mapped in-core, and it
> may not count as "open filedescriptor", but do OSes allow infinite
> such mmapped regions to us?  We do keep track of number of open
> windows, but is there a way for us to learn how close we are to the
> limit?

Not that I know of, but xmmap() does already try to unmap existing
windows when mmap() fails, and then retries the mmap.  It calls
release_pack_memory() which calls unuse_one_window().  mmap returns
ENOMEM when either there is no available memory or if the limit of
mmap mappings has been exceeded.

So, I think we'll be ok.  It's the same situation we'd be in if there
were many large packs (but fewer than pack_max_fds) and a small
packedGitWindowSize, requiring many mmap windows.  We'd try to map an
additional segment, fail, release some unused segments, and retry.

The memory usage of all mmap segments would still be bounded by
packedGitLimit.  It's just that now, when we're only under file
descriptor pressure, we won't close the mmap windows unnecessarily
when they may be needed again.

-Brandon
