From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to make "full" copy of a repo
Date: Mon, 30 Mar 2015 10:37:39 -0700
Message-ID: <xmqqbnjaxu70.fsf@gitster.dls.corp.google.com>
References: <1427511397.19633.52.camel@scientia.net>
	<20150328143152.GB9387@vps892.directvps.nl>
	<CACsJy8AN6X3oh2=yLn-szEApEMC+uQMmO6qBYbPrVNK1_d5tEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin D <me@ikke.info>,
	Christoph Anton Mitterer <calestyo@scientia.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdhp-0002mt-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbbC3RmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:42:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753715AbbC3RmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:42:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E6C843E06;
	Mon, 30 Mar 2015 13:42:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cammzgQqDcnKrxaZnhiWW8lM/7c=; b=C6jZmv
	FIls+c3E7jko6FRCurmvo5Z19KbZpKZ/EtwUZBhMgR7whFDXbRx4JPRE45/ndroA
	qtnnvmQzC38LDVoT6tzH3ERAbUckuTSgT9HGE/jcQnu2Dyi1m59SWsVouu5kHFWs
	SWAEFX2CZUfkzcDszEzVhzfPZWxm7MhizgtZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xnoyMrL6yYVeh8aC4ik32xRUh/g0+j+8
	5UEJyNwDxG448Es0bXLb65XKNu1CEhvx0XGt1A9V2f2MXqqE1xd6bQG5lu8sxTgB
	cljNHY5vD739iuZm7/yiVIBXVkYE9w0s80iJVZjTB81Tjfq7PHJhIjCvRl0hU/pe
	waRZsKwvCqI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85D0C43E05;
	Mon, 30 Mar 2015 13:42:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 520A943C2C;
	Mon, 30 Mar 2015 13:37:40 -0400 (EDT)
In-Reply-To: <CACsJy8AN6X3oh2=yLn-szEApEMC+uQMmO6qBYbPrVNK1_d5tEQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 30 Mar 2015 22:22:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76A82E38-D703-11E4-94C4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266465>

Duy Nguyen <pclouds@gmail.com> writes:

> This is true. But I wonder if we should (and can) support
> --super-mirror option (disabled by default), where reflog and stashes
> are kept, for backup purposes. We might keep unreferenced objects as
> well if it's not hard to do.

I doubt that we want to be in the business of filesystem backup.  Is
there a practical use case that is *not* "I am relocating out of
this directory on this machine and will be using the other one I am
making by copying"?

For the "I am relocating" scenario, rsync is the most suitable
option.  The caveat "activity at the original will leave the copied
result incomplete" will apply to whatever transport method you use,
but in the "I am relocating" scenario, you will have a period that
the original is quiet (i.e. you stop using the original at some
point before you start the copied one, and do not expect that the
sequence to take zero down time).

In a sense, "super-mirror" is even worse, if it is doing some "Git
activity" on the source which we may want to log, which means the
original will never be quiet during the copying.  Sure, send-pack
may not currently not do any logging in the original repository, but
depending on the reason why such a copy is being made, the original
may even have a custom hook-based logging data left somewhere in the
repository and for copying such a repository the repository owner
would want to keep the logged data.

And if what super-mirror does is not considered a "Git activity" and
somehow bypasses all the Git rules in the original repository, then
what is the advantage of having it in Git in the first place, over
using something like rsync?
