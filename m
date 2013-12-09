From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5541: Improve push test
Date: Mon, 09 Dec 2013 14:10:56 -0800
Message-ID: <xmqq61qxwu8f.fsf@gitster.dls.corp.google.com>
References: <201312092103.29047.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 09 23:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq92s-0000YC-PX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 23:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab3LIWLE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Dec 2013 17:11:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab3LIWLC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Dec 2013 17:11:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACDF65995A;
	Mon,  9 Dec 2013 17:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GwSUmrYOCVo0
	ELnaO4ty87+2aww=; b=IXPGPBYjIUhtou1NnRXu3WZYg1wh+uoGP9A5z+AJh+qz
	IjZVXuLd866v9W/kTNR9fjpKfW4pUZ6EbnsqRgM1K875g+ptUGt1iCmBLkI/RSVn
	bozBvLaGoTrUGKqddU4QsrAmfct+iFSadnrr6Owxps5NeqDdQeJxEYxdjTkhsgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QKZ0Rp
	vBa8P6dW4zMH+ALGgToZ4yczaM+ek5tZEBuCrKJBYpJujt/d8swTM2DgJ/MxLyQG
	3ELYRRR53odwfWXGGYp3Uzf3JjUIJyIjXH7LzJEVvwKFiAQlsdKOB3vSeslbytxa
	Qt2KZMHo97eG2tRXUzOcLI9kZRYESugZxBotw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9813759959;
	Mon,  9 Dec 2013 17:11:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D69E559958;
	Mon,  9 Dec 2013 17:10:59 -0500 (EST)
In-Reply-To: <201312092103.29047.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Mon, 9 Dec 2013 21:03:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C8E90D54-611E-11E3-B613-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239112>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The old log-line looked like this:
>  + 9d498b0...8598732 master -> master (forced update)
> And the new one like this:
>    9d498b0..8598732  master -> master
>
> - Loosen the grep pattern by not demanding "(forced update)"

Hmm, what is the reason for the change the output?  The output this
piece is testing is the result of this:

	git push origin master:retsam

	echo "change changed" > path2 &&
	git commit -a -m path2 --amend &&

	# push master too; this ensures there is at least one '"'push'"' comma=
nd to
	# the remote helper and triggers interaction with the helper.
	test_must_fail git push -v origin +master master:retsam >output 2>&1'

This is run inside test_repo_clone, which has /smart/test_repo.git
as its origin, which in turn has 'master' branch (and nothing else).

It

 - pushes master to another branch retsam;

 - amends its 'master';

 - attempts to push the updated master to force-update master, and
   also retsam without forcing.  The latter needs to be forced to
   succeed, and that is why we expect it to fail.

If the output from the push process says

  + 9d498b0...8598732 master -> master (forced update)
  ! [rejected]        master -> retsam (non-fast-forward)
  error: failed to push some refs to '../test_repo_copy/'

I think that is a good thing to do, no?  After all, that is what we
show with Git native transports.

Is this patch merely matching a test to a broken behaviour of some
sort?  Puzzled...
