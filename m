From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Wed, 20 Jun 2012 12:21:12 -0700
Message-ID: <7vipelvlg7.fsf@alter.siamese.dyndns.org>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
 <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
 <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
 <20120619135814.GA3210@sigill.intra.peff.net>
 <CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
 <CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
 <20120620160607.GA12856@sigill.intra.peff.net>
 <7vpq8tvn5i.fsf@alter.siamese.dyndns.org>
 <20120620185237.GA31520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:21:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQSt-0007N0-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873Ab2FTTVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:21:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab2FTTVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:21:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364A497D4;
	Wed, 20 Jun 2012 15:21:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j09dmt2Kc3dy7BKmeZ+6M7oW6Ok=; b=QJU288
	rx1fNkLD6I9HgmsTmoPWWZdK13NPCm6HQGOHeK5EYMfy+KaV3bgDFehBoVEti8qr
	TwdpHK+/FgAQsxPvbEfc7roLPgQwwF2zgFuoYVZZW31xxEha7JeoVX2D44qUgbcC
	+JC5Iy0cNop5N4K03W50RmcPvDROUEVJJqYxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a99RBt6LAVCHeY6NF5cbZZGy0kAkZOoo
	cZfv71ngLaMjbqyRXVDZQnr9zP6I8dTGviNJlBlPZsQ1tl2BCaUIp6JgP+j/316s
	om5EhCd9KBV35afp2+Jv8bSmVpljwimAjhArAEpZ+FMFeBkO71B/AmxXLRywIB4v
	ZTndniVjrrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28A1E97D3;
	Wed, 20 Jun 2012 15:21:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEFF097D2; Wed, 20 Jun 2012
 15:21:13 -0400 (EDT)
In-Reply-To: <20120620185237.GA31520@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 14:52:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19A8874C-BB0D-11E1-B684-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200333>

Jeff King <peff@peff.net> writes:

> I thought this bug would be enough to show that diffopt.found_changes is
> not clear enough. It is the source of the original bug (the code should
> have been using HAS_CHANGES instead of found_changes), and it gave at
> least one of the bug investigators (i.e., me) quite a bit of confusion
> to understand why found_changes was not being set when diff_flush found
> changes.

I think when found_changes was introduced so that diff can indicate
more than what HAS_CHANGES (i.e. there is a blob-level difference
exists) can represent, the patch forgot to update the no-index
codepath.

> IOW, as a naive reader of the "struct diff_options", how do I understand
> the difference between HAS_CHANGES and found_changes?

HAS_CHANGES and found_changes should be implementation detail of
diff_result_code() and as long as we do not add outside users of it,
the names should not matter too much.  If we were to rename them,
HAS_CHANGES should also be made more descriptive to hint what it
means ("object level difference exists"), I would think.  Given the
recent discussion on "diff/log -L <bottom>,<top>", found_changes
would mean "content level change that the caller cares about
exists".
