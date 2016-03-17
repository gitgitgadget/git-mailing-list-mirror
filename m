From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 00:50:09 -0700
Message-ID: <xmqq4mc535n2.fsf@gitster.mtv.corp.google.com>
References: <1458177584-11378-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr, j6t@kdbg.org,
	johannes.schindelin@gmail.com, Lucien.Kong@ensimag.imag.fr
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:50:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agShG-0006Yk-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 08:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbcCQHuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 03:50:14 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752002AbcCQHuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 03:50:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14A57443FA;
	Thu, 17 Mar 2016 03:50:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MDJ/P9lq0AFzvl47c30ScHI9RGg=; b=GS/IfT
	XPKgI8knt7Bme/lhHejM3VShSIU211DG0RhKo7dmbAQqxT5/dSMrOSv33OCjx+uG
	g2RUJMoJqFARoEdaeZ7pIFkrGGwose5oBYFjBoHX4fK7K/Vj8amVFPJ8VSCb1bdY
	xCa/bNw+VEbii7nRgqXaYfzcquq0MdujJFXRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjxlUNhlEn+mvmQDk/FXLvmmY+cKN3O9
	ZeJbZlP2bQLCf1VUduMZilecli051qRy1SWcdAzYKMKgCvU/4b3nq8JYDuuflWTq
	r2qpQgh9x1jVdAsrEoGZ81f6l2TvxEm97xXlc3Pw6N1wMdCxm61AhD9JUgJM/uOc
	gBsYdToNH6g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CAD6443F9;
	Thu, 17 Mar 2016 03:50:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B685443F7;
	Thu, 17 Mar 2016 03:50:10 -0400 (EDT)
In-Reply-To: <1458177584-11378-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 16 Mar 2016 18:19:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E003B948-EC14-11E5-8C55-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289084>

Stefan Beller <sbeller@google.com> writes:

> In the later steps of preparing a patch series I do not want to edit the
> patches any more, but just make sure the test suite passes after each
> patch. Currently I would run
>
>   EDITOR=true git rebase -i <anchor> -x "make test"

Hmm, I guess that may "work" but it sounds like quite a roundabout
way to "test all commits".  "rebase" is about replaying history to
end up with a set of newly minted commits, and being able to poke at
the state each commit records in the working tree is a side effect.
"rebase -i" may use the same commit object if you didn't actually
make new commit as an optimization, but otherwise, it is like going
through pages of a book, tearing each page to examine it, and
replacing each page with a photocopy of it before going to examine
the next page.  Which makes me feel somewhat dirty X-<.

In other words, that looks like a workaround for not having

    $ git for-each-rev -x "$command" old..new

where you can write "sh -c 'git checkout $1 && make test' -" as
your $command.
