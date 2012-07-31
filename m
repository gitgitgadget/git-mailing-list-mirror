From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 13:16:14 -0700
Message-ID: <7vk3xjit4h.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
 <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
 <CA+55aFwE93YeVjZp9VLhRvbxFJNonafmUE6rHzPer5hv-hON5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 22:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIrh-0004eP-9I
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 22:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487Ab2GaUQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 16:16:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756452Ab2GaUQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 16:16:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF129801;
	Tue, 31 Jul 2012 16:16:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mjb+t+KZzZ9rN8vAC4NXXkm3YU8=; b=yS1sUu
	R9BQZwXjF/+k7GrkksS94693YVx4/pp8r4V+ZRiUwhf2M84uBukrKH/mcf/mttAK
	Dg5ZffWT1ymcxcqSp4KhWmX8Q4wmU3w/Ci7y5poDWhv/cbpwoJ3W85s5j/dbEXXR
	YGIG7rcM44vwMkz1aE3I0odBgPpO0hlVeaSS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNHZNfws+N6wjeWQAaWxk8Hmhc7na5Sb
	eJFY0650Ryq//VYGebTF1dEo6nRA3+PBawG1oDk9kSJIoT9cj9AZ4JgKyM5x6e30
	z+lwsJaNgAziDMwGRi/3b6DE12GkF+2k9Sml4t/4sBr6P1K/CvzBkEX9Nr/m9CSf
	GniZyJJ6GsI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AD259800;
	Tue, 31 Jul 2012 16:16:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A66EA97FF; Tue, 31 Jul 2012
 16:16:15 -0400 (EDT)
In-Reply-To: <CA+55aFwE93YeVjZp9VLhRvbxFJNonafmUE6rHzPer5hv-hON5Q@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 31 Jul 2012 12:51:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B7D17C-DB4C-11E1-AB7F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202680>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jul 31, 2012 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  * This is not even compile tested, so it needs testing and
>>    benchmarking, as I do not even know how costly the calls to
>>    open/close are when we do not have to call iconv() itself.
>
> Ok, so it's easily compile-tested: just add
>
> +       COMPAT_OBJS += compat/precompose_utf8.o
> +       BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
>
> to the makefile for Linux too.
>
> Actually testing how well it *works* is hard, since I don't really
> have a mac (well, I do, but it no longer has OS X on it ;), and the
> whole "utf-8-mac" thing does not make sense.

Also the motivation for this change (not the original utf-8-mac one,
which is not my code) is about not paying unnecessary iconv_open()
overhead when we do not have to, so the measurement has to happen on
Mac, not on Linux.

> HOWEVER. I actually tested it with the conversion being from Latin1 to
> UTF-8 instead, and it does interesting things, and kind of works. I
> say "kind of", because for the case of the filesystem being in Latin1,
> we actually have to convert things back to the filesystem character
> set ...

Eek.

Not just write_entry() codepath that creates the final paths on the
filesystem, you would need to touch lstat() calls that check the
existence and freshness of the path, once you go that route.  I am
sure such a change can be made to work, but I am not sure how much
we would gain from one.
