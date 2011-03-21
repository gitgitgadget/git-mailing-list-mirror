From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status reads too many files
Date: Mon, 21 Mar 2011 09:41:18 -0700
Message-ID: <7vipvcs9xt.fsf@alter.siamese.dyndns.org>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:41:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1iB2-0006GH-5O
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab1CUQla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:41:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab1CUQl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:41:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82EF3481C;
	Mon, 21 Mar 2011 12:43:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J315iY29rubGfZQanozh8yvrQPw=; b=Qn9sEa
	yCZwBC6/WtJXCC9oydZuaon18Axfxe5RU42W6Vax4rwclco6zJfyCEGKGXlyWf77
	h77nRL75A8tcWSYRXPv/3dHK/WrP6t04v1xIMSUrheraSUhXfaK0nLA4mGBKcjvs
	O4Se7G6ZNlo3pCqAztYblBXWR0YSfrBtHRll0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D1jnv4ySpTicQbl8OU4CkjVcnXvicru6
	KgsJDIwIqh/r/m7xhLl8ayvEl6JFXvfyjCK7/J+mibCiIThkZv0nHl81Z2aYtgii
	B4fAXlD/B5XC912L6zNs7I7jNTS8IY+sp2x8tPMwYjdGG75Js0wc4rWToZ07isxr
	C2N/Ier2OCY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FCFF481B;
	Mon, 21 Mar 2011 12:43:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 712A04814; Mon, 21 Mar 2011
 12:42:58 -0400 (EDT)
In-Reply-To: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
 (Lasse Makholm's message of "Mon, 21 Mar 2011 13:40:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48F1826A-53DA-11E0-B346-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169611>

Lasse Makholm <lasse.makholm@gmail.com> writes:

> This persistent across multiple runs of git status:
>
> $ strace -o /tmp/trace2 git status
> # On branch there
> nothing to commit (working directory clean)
> $ grep ^open /tmp/trace2 | wc -l
> 414
> $
>
> ...until the index is touched:
>
> $ touch .git/index

Don't do this; you are breaking the racy-git protection.

I think we opportunistically update the .git/index file in "git status" to
refresh the stat bits (but we don't error out when we cannot write a new
index, as you may be only browsing somebody else's repository with only a
read access to it).  It probably should be just the matter of adding a bit
of logic to notice that your index is racily clean.

Let me cook something real quick.
