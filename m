From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] attr: more matching optimizations from .gitignore
Date: Fri, 05 Oct 2012 23:59:48 -0700
Message-ID: <7v4nm8rspn.fsf@alter.siamese.dyndns.org>
References: <1349412069-627-1-git-send-email-pclouds@gmail.com>
 <1349412069-627-5-git-send-email-pclouds@gmail.com>
 <7vy5jku549.fsf@alter.siamese.dyndns.org>
 <CACsJy8BWJg0sr-6iG4LwJjkSM46=CBgddDac4dDR2o3HZ8_25g@mail.gmail.com>
 <7vk3v4rwkv.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cn0rAV+u+8tzD2HOm1XkfKBPkFJVrPQAojMBtYe6wxRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 09:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKOMj-0006ZP-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 09:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab2JFG7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 02:59:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab2JFG7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 02:59:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 389B46130;
	Sat,  6 Oct 2012 02:59:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zldpSXJWyoi0ilqFtERBSvTzJ68=; b=j0t85b
	7l40LnRiIlJ7TwsLSK7Qjwoo3s9X4YgJ4NrLl10ISTMPBEys4JHs9r6G6a0JZTGK
	9TqLhjkbuvV6pUHhGthHxsL4LanKuHe0n4kw4EhmwM9/e021YumqYsSJGR2G5ReK
	r1h2fWyhZLRjlEOwHraMSOcAqWYLZHbmIg6lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeM6O8PE8zGN0YMxOBXD5PmcV+e3AGwc
	NhDSc2ouKYnQqwrTBEnDGOC0LxdseftqfUZ3x1GysUcdDkYnUFzV9e7cFFNazeXG
	55fk0sbFnxK6qceQXV4Uyt9kyl4vfFmHPFmOC76MhImEW7JTg3Xis/RhxTd55Mxc
	c818NOqX02w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266F7612F;
	Sat,  6 Oct 2012 02:59:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 979D76129; Sat,  6 Oct 2012
 02:59:49 -0400 (EDT)
In-Reply-To: <CACsJy8Cn0rAV+u+8tzD2HOm1XkfKBPkFJVrPQAojMBtYe6wxRg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 6 Oct 2012 13:43:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BAEC5B8-0F83-11E2-A096-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207134>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Oct 6, 2012 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Or the user might think "path/ attr1" sets attr1 for all files under
>>> "path/" because it does not make sense to attach attributes to a
>>> directory in git.
>>
>>    ...
>>
>>    We may not have a need to assign a real attribute to a directory
>>    right now, because nothing in Git asks for an attribute for a
>>    directory. But that does not necessarily mean we would never need a
>>    way to give an attribute to a directory but not to its contents.
>
> Exactly why we should not make "path/ attr" no-op. If we want to make
> it meaningful some day in future, I don't think we want those no-ops
> lay around and suddenly cause changes in behavior with a new version
> of git.

I do not think you understood.  "path/ attr" is a no-op from the
point of view of the *users* of the current versions of Git.  It is
perfectly fine to accept and apply attr to "path/"; no codepath in
Git should be asking about path/ anyway, so it ends up to be a
no-op.  You shouldn't be erroring out at the syntactic level, i.e.
when these lines are parsed.
