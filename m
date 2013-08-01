From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Thu, 01 Aug 2013 11:39:32 -0700
Message-ID: <7v4nb9s1az.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<7vsiyts5bb.fsf@alter.siamese.dyndns.org>
	<CA+sFfMdp9j4LL4eocbsJu5DCEfhoE=uEN_wJ3o8VBW+hUVFVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 20:39:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4xmy-00060y-Ng
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 20:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab3HASjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 14:39:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab3HASjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 14:39:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D66335C15;
	Thu,  1 Aug 2013 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dUWPkcCB+Qgou5y4zv7WMzwmQ3A=; b=ZzJv98
	ZOafX59HjTyTKinX8h/RjtKt9VFLA0Z6+UCDfh5xy1Va3rJZ6KjnybfjBbVatAO7
	tZdyhgBb7CqflH7bJAnOk0FwXwo5gMkgmv5Du72IKEEaTRJhaIaepIOhLGOuCkHa
	RZu7IzLMSwpxNCwKD9THGHCSL1x3sf4wrrks0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsUq47BjApkDLPgqdyBHvCDdCcALIbCF
	IGjDrwR9NIn1C0aSRnZOomUOATZejz6OM31lu7V6RuVg8eeZrc3n6JaMPwTOIzoh
	9UDFardcq6rbaNGbXr/d5/hzGDJL11lxqtSbyUNbXE+A2QJa4i4uTTjzQZfzUtNj
	CxHGL8023eM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E6835C14;
	Thu,  1 Aug 2013 18:39:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 672C535BF7;
	Thu,  1 Aug 2013 18:39:34 +0000 (UTC)
In-Reply-To: <CA+sFfMdp9j4LL4eocbsJu5DCEfhoE=uEN_wJ3o8VBW+hUVFVLQ@mail.gmail.com>
	(Brandon Casey's message of "Thu, 1 Aug 2013 11:01:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6228A0C-FAD9-11E2-BD9F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231498>

Brandon Casey <drafnel@gmail.com> writes:

> I've been looking closer at uses of p->windows everywhere, and it
> seems that we always open_packed_git() before we try to create new
> windows.  There doesn't seem to be any reason that we can't continue
> to use the existing open windows even after closing the pack file.
> ...
> If we don't need to close_pack_windows(), find_lru_pack() doesn't
> strictly need to reject packs that have windows in use.

That makes me feel somewhat uneasy.  Yes, you can open/mmap/close
and hold onto the contents of a file still mapped in-core, and it
may not count as "open filedescriptor", but do OSes allow infinite
such mmapped regions to us?  We do keep track of number of open
windows, but is there a way for us to learn how close we are to the
limit?
