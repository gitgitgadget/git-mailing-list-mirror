From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Tue, 24 Feb 2015 14:42:42 -0800
Message-ID: <xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
References: <20150224214311.GA8622@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:42:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQOBr-0006cf-F8
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 23:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbbBXWmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 17:42:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751627AbbBXWmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 17:42:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6BD63B0E8;
	Tue, 24 Feb 2015 17:42:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5aR5lRhuLSFCtUlHNNjb/xVXKrM=; b=dJYTC+
	S+7SFhLk+61fFxSDZkkyPesF9mc3LHtpbDyixenxYA+5DNrgRCl9Aw4C3oGpXwwC
	QbkZVGNFxDQ82auX5uA9QSQHaMlkcVRtX6tMR6IOpDN3JZC+Dz1ph7RbCmhNWmI/
	ovHD2Dn02TqzfbUyW9hBidZV7LXsMwxJKoDkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xrqchfvZtxs+DnPHY9DK8lf4ih+3ZDn0
	BCEbPyG75gDhCzj7ftgftMxB5mOJmCmd7hiN1clcW8Z80a9Swc4yIMT4e0jzU9Ng
	J7T9ZTFMt44LNKyBRHPthvOj9NvL1ba0IvQXQ79x/9Yy+GQ1F7NBrgzyqM0PpgEj
	Rs0FbCcfnSY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD75C3B0E7;
	Tue, 24 Feb 2015 17:42:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93EFE3B0DD;
	Tue, 24 Feb 2015 17:42:43 -0500 (EST)
In-Reply-To: <20150224214311.GA8622@peff.net> (Jeff King's message of "Tue, 24
	Feb 2015 16:43:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72343812-BC76-11E4-A0BC-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264357>

Jeff King <peff@peff.net> writes:

> I ran across a real-world case where git segfaults on some trees that
> have duplicate entries. Those trees are obviously broken, and I'm fine
> with us producing whatever output we like on them. But probably we
> shouldn't segfault.

Thanks.

> ...
> That does fix this problem, and it doesn't break any other tests. But
> frankly, I don't know what I'm doing and this feels like a giant hack.
>
> Given that this is tangentially related to the "-B -M" stuff you've been
> looking at (and it's your code in the first place :) ), I thought you
> might have some insight.

Indeed.

Honestly, I'd rather see us diagnose duplicate filepairs as an error
and drop them on the floor upon entry to the diffcore_std(), even
before we go into the rename codepath.
