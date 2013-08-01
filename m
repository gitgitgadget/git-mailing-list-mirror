From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close
 packs on fd pressure
Date: Thu, 1 Aug 2013 13:37:31 -0700
Message-ID: <CA+sFfMdJgQaEBx_FsYPz1rC3--jknnb4Zwr+FOaL+9gNe4xwyw@mail.gmail.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<7vsiyts5bb.fsf@alter.siamese.dyndns.org>
	<CA+sFfMdp9j4LL4eocbsJu5DCEfhoE=uEN_wJ3o8VBW+hUVFVLQ@mail.gmail.com>
	<7v4nb9s1az.fsf@alter.siamese.dyndns.org>
	<CA+sFfMer+5bhqxF=_zAQhZ+8sQD6EAYb8HBtYpuhQY_0uj-m9A@mail.gmail.com>
	<7vy58lqiwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 22:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4zcx-0008TI-JH
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 22:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225Ab3HAUhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 16:37:34 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46348 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab3HAUhd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 16:37:33 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so17220wiw.13
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vb6tTyF38eI36WHm06CLdM69zDkBVQMmMHOeYl4ktb4=;
        b=PYXSp8FDF3tFTzk+1ukPfwMlOmuRW0N1Ff/30c89yJr1yvEGWfKgzX99HDdwNvAPXm
         ZDO9h0kZbFF/XESY0he+4eao+cINR+q1dhY3VhXiVuM1hqX9PIH9oa7p1rsD0zmE6sNS
         gyUff+FZqMg6KWXJCNeXUBwEdjj6hgG7Iunc/wmxrZIrvUM7MGb71QFB/ybTYjzyjDbN
         wTHo/N9aY7iXqdP4V063MvE+Q+IP3MV1H2u4wJt/cdOklT+mYoC8oBc21l1O8R/30/og
         nr5UBKf5mP/ObnuBVECw5MBoL8RAVyob7PAhVKk9Mf/imkfrAYgNf9lTyB3SA5UMxnnF
         sgcw==
X-Received: by 10.194.60.5 with SMTP id d5mr2711150wjr.26.1375389451729; Thu,
 01 Aug 2013 13:37:31 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Thu, 1 Aug 2013 13:37:31 -0700 (PDT)
In-Reply-To: <7vy58lqiwd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231504>

On Thu, Aug 1, 2013 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> On Thu, Aug 1, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> That makes me feel somewhat uneasy.  Yes, you can open/mmap/close
>>> and hold onto the contents of a file still mapped in-core, and it
>>> may not count as "open filedescriptor", but do OSes allow infinite
>>> such mmapped regions to us?  We do keep track of number of open
>>> windows, but is there a way for us to learn how close we are to the
>>> limit?
>>
>> Not that I know of, but xmmap() does already try to unmap existing
>> windows when mmap() fails, and then retries the mmap.  It calls
>> release_pack_memory() which calls unuse_one_window().  mmap returns
>> ENOMEM when either there is no available memory or if the limit of
>> mmap mappings has been exceeded.
>
> OK, so if there were such an OS limit, the unuse_one_window() will
> hopefully reduce the number of open windows and as a side effect we
> may go below that limit.
>
> What I was worried about was if there was a limit on the number of
> files we have windows into (i.e. having one window each in N files,
> with fds all closed, somehow costs more than having N window in one
> file with the fd closed).

Ah, yeah, I've never heard of that type of limit and I do not know if
there is one.

If there is such a limit, like you said unuse_one_window() will
_hopefully_ release enough windows to reduce the number of packs we
have windows into, but it is certainly not guaranteed.

> We currently have knobs for total number
> of windows and number of open fds consumed for packs, and the latter
> indirectly controls the number of active packfiles we have windows
> into. Your proposed change will essentially make the number of
> active packfiles unlimited by any of our knobs, and that was where
> my uneasiness was coming from.

Yes and no.  The limit on the number of open fds used for packs only
indirectly controls the number of active packfiles we have windows
into for the packs that are larger than packedGitWindowSize.  For pack
files smaller than packedGitWindowSize, the number was unlimited too
since we close the file descriptor if the whole pack fits within one
window.

-Brandon
