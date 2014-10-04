From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/16] make prune mtime-checking more careful
Date: Sat, 04 Oct 2014 15:22:10 -0700
Message-ID: <xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 05 00:22:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaXij-0003jh-8x
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 00:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbaJDWWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 18:22:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52250 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751033AbaJDWWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 18:22:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B40B1115D9;
	Sat,  4 Oct 2014 18:22:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HUFm9qbwRjPnoWlST+OFNZIbTCI=; b=FLPOxc
	4jhsDB6YxQn4p/QQlRHmA6XAfLggSIMYtSK/S76cZrs9Uik9PCObpEOkFOeyK910
	TEHaWZZKlK4ClDV6HpnxIG7fXkvQaOu5zMTCkvjC3bOi1+jpBzeS1EP9pH5TdHiT
	IdJxuGgwFjpr6964t6evD1jcbcmrdLDRhOWoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uqOLKuoJm5xw9pZMBcCbkWWhun3hDTx4
	xyFFvKpo9EAVB0pitYkzIi3kx+rk7fwTdfsvVjd0H8sqSDBCkw62lRvix4BH3dD/
	fUbIs4r14RfZ/JBeJH2lLWyeZCywWa7zyRT9W6DFPN7IixHuXyQvTBCD4VGkXJS4
	jiX3tZOCbjk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB30F115D8;
	Sat,  4 Oct 2014 18:22:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 264F9115D7;
	Sat,  4 Oct 2014 18:22:12 -0400 (EDT)
In-Reply-To: <20141003202045.GA15205@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 16:20:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3220F04-4C14-11E4-A49D-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257893>

Jeff King <peff@peff.net> writes:

> There's quite a lot of patches here, but most of them are preparatory
> cleanups. The meat is in patches 13, 15, and 16.
>
>   [01/16]: foreach_alt_odb: propagate return value from callback
>   [02/16]: isxdigit: cast input to unsigned char
>   [03/16]: object_array: factor out slopbuf-freeing logic
>   [04/16]: object_array: add a "clear" function
>   [05/16]: clean up name allocation in prepare_revision_walk
>   [06/16]: reachable: clear pending array after walking it
>   [07/16]: t5304: use test_path_is_* instead of "test -f"
>   [08/16]: t5304: use helper to report failure of "test foo = bar"
>   [09/16]: prune: factor out loose-object directory traversal
>   [10/16]: count-objects: do not use xsize_t when counting object size
>   [11/16]: count-objects: use for_each_loose_file_in_objdir
>   [12/16]: sha1_file: add for_each iterators for loose and packed objects
>   [13/16]: prune: keep objects reachable from recent objects
>   [14/16]: pack-objects: refactor unpack-unreachable expiration check
>   [15/16]: pack-objects: match prune logic for discarding objects
>   [16/16]: write_sha1_file: freshen existing objects

Somebody please help me out here.

This applied on top of 'maint' (which does have c40fdd01) makes the
test #9 (prune: do not prune detached HEAD with no reflog) fail.

If we merge 'dt/cache-tree-repair' (which in turn needs
'jc/reopen-lock-file') to 'maint' and then apply these on top, the
said test passes.  But I do not see an apparent reason why X-<.
