From: Junio C Hamano <gitster@pobox.com>
Subject: Re: proposal for extending smudge/clean filters with raw file access
Date: Thu, 12 May 2016 12:01:15 -0700
Message-ID: <xmqqvb2jf6dg.fsf@gitster.mtv.corp.google.com>
References: <20160512182432.GA27427@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Thu May 12 21:01:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0vrP-00016T-17
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbcELTBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:01:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752303AbcELTBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:01:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 192B21B9F7;
	Thu, 12 May 2016 15:01:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XpZ5Pfw1b26On5q3iwoDbcWVWm4=; b=ILeLOg
	mQOhoZmdGiQc4xZu/oixKQYCt1O5ARpC4T0A8ELH9jAsN1alqMz01x7ZaHcRBgtA
	DpML3xJFa9C6nqCn2vmoeOiwJQ1vNqLnLFCT+g4MQYZCcpBj7iT5XoCy7ah/W50Y
	5Bt/lkziY9f/OzKP4/ZW5yBAhobNLEtYVksdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wcMxQWZH7DL1K7lIhbfBq5PBsipOBaqY
	ZeE70KejpvZTHHhJJHp6lFe47GepLR02ycL5/tZ1OcC/p3ncCVg1SuNMFLn9JGiW
	twRIYEBcDPyfwBGNxTcexDpspgP3J4vYSiqUUL4/5T2KvgOHKCM6wM3oGoXQ/OvX
	Qigcya4cZxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F93A1B9F6;
	Thu, 12 May 2016 15:01:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 833351B9F3;
	Thu, 12 May 2016 15:01:17 -0400 (EDT)
In-Reply-To: <20160512182432.GA27427@kitenet.net> (Joey Hess's message of
	"Thu, 12 May 2016 14:24:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8174556-1873-11E6-AAD3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294426>

Joey Hess <id@joeyh.name> writes:

> I'm using smudge/clean filters in git-annex now, and it's not been an
> entirely smooth fit between the interface and what git-annex wants
> to do.
>
> The clean filter has to consume the whole file content on stdin;
> not reading it all will make git think the clean filter failed.
> But, git-annex often doesn't need to read the whole content of a
> work-tree file in order to clean it.
>
> The smudge filter has to output the whole file content to stdout. But
> git-annex often has the file's content on disk already, and could just
> move it into place in the working tree. This would save CPU and IO and
> often disk space too. But the smudge interface doesn't let git-annex use
> the efficient approach.

The smudge happens to be the last to run, so it is quite true that
it can say "Hey Git, I've written it out already".

I didn't check all codepaths to ensure that we won't need the
smudged result in core at all, but I am guessing you did so before
making this proposal, so in that case I would say this sounds fine.
