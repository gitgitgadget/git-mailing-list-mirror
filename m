From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Thu, 01 Aug 2013 13:02:26 -0700
Message-ID: <7vy58lqiwd.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<7vsiyts5bb.fsf@alter.siamese.dyndns.org>
	<CA+sFfMdp9j4LL4eocbsJu5DCEfhoE=uEN_wJ3o8VBW+hUVFVLQ@mail.gmail.com>
	<7v4nb9s1az.fsf@alter.siamese.dyndns.org>
	<CA+sFfMer+5bhqxF=_zAQhZ+8sQD6EAYb8HBtYpuhQY_0uj-m9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 22:02:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4z51-0001VP-2A
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 22:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab3HAUCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 16:02:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919Ab3HAUCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 16:02:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2AD335D6B;
	Thu,  1 Aug 2013 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YuUeH+Ut6MPacJHSOi4Kc6ViWCA=; b=KXNhhW
	+SY19udKBQ5v5SsnwBlT3Yh6xVksndq+EjJVgD9/X10QYjaiu7dqilWBkqgf5zFU
	9lYdVkNWtKGiSDGZabsFpwvZsMCVj6Ig7br6d0Mo1Ipw9+xAl+Z70curLCZCYts2
	Y0lutN1nLlgZIWFLAGrkMNI1pd5vwbelw+ROY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqPlXOUT6jxA+80TzaApctHS3FSIbzMh
	T0T2P6lrMjP0z9FElmzsTX+RtXjGlDcOhOYeGyZlUvUFb3DtgL6IiAn45pDUhWSZ
	hbHLe2D3i9QldXUrOfC+xheL1/bieGQYMzzGZrRGACVjNIPZhbg16kp8bo7A173a
	N5xwrRQTW8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71D535D6A;
	Thu,  1 Aug 2013 20:02:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA7F035D61;
	Thu,  1 Aug 2013 20:02:27 +0000 (UTC)
In-Reply-To: <CA+sFfMer+5bhqxF=_zAQhZ+8sQD6EAYb8HBtYpuhQY_0uj-m9A@mail.gmail.com>
	(Brandon Casey's message of "Thu, 1 Aug 2013 12:16:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A82B702-FAE5-11E2-97CD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231502>

Brandon Casey <drafnel@gmail.com> writes:

> On Thu, Aug 1, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> That makes me feel somewhat uneasy.  Yes, you can open/mmap/close
>> and hold onto the contents of a file still mapped in-core, and it
>> may not count as "open filedescriptor", but do OSes allow infinite
>> such mmapped regions to us?  We do keep track of number of open
>> windows, but is there a way for us to learn how close we are to the
>> limit?
>
> Not that I know of, but xmmap() does already try to unmap existing
> windows when mmap() fails, and then retries the mmap.  It calls
> release_pack_memory() which calls unuse_one_window().  mmap returns
> ENOMEM when either there is no available memory or if the limit of
> mmap mappings has been exceeded.

OK, so if there were such an OS limit, the unuse_one_window() will
hopefully reduce the number of open windows and as a side effect we
may go below that limit.

What I was worried about was if there was a limit on the number of
files we have windows into (i.e. having one window each in N files,
with fds all closed, somehow costs more than having N window in one
file with the fd closed).  We currently have knobs for total number
of windows and number of open fds consumed for packs, and the latter
indirectly controls the number of active packfiles we have windows
into.  Your proposed change will essentially make the number of
active packfiles unlimited by any of our knobs, and that was where
my uneasiness was coming from.
