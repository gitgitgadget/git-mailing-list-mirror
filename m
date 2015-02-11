From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not their referent
Date: Wed, 11 Feb 2015 14:49:46 -0800
Message-ID: <xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLg6U-0000UA-7Q
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 23:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbbBKWtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 17:49:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752282AbbBKWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 17:49:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9739338689;
	Wed, 11 Feb 2015 17:49:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WZbthureHGI4zdr8xel0QVPA7Aw=; b=F7N+0j
	qv+n9ETeOE7JNrG36B/f0s7rDALugCt5XrEG28OUIO43OzElgGxW4mbzGCS1LkCC
	aocTnWBlkvIM22WbaodF+dtN7vDuGQlVKSJg2qYsSvdAEOdcK0hu4oeTFqTxkEnc
	F+3M1s8pJMM1pVkVFAJDeDwmzZ54uC0fnPzwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iFxBP7/dr/XHAKklcae87PL+kr6PDzpy
	xMhK2dw5ml7HbmGkDXh8Ftqsu3Ti7bMc9aylRwrkXW4m/qsJMHCOk0OtCffJMDdq
	TQsGbl8x5JCYuEcEfiVaS+4gjJOmeU+TpWndUStxSkd3uNYlyHw8rLDNj1eXUrSu
	Ib3PaEBoK/0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B35F38688;
	Wed, 11 Feb 2015 17:49:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3DAA38686;
	Wed, 11 Feb 2015 17:49:47 -0500 (EST)
In-Reply-To: <CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 10 Feb 2015 16:49:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47D576D4-B240-11E4-80A9-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263698>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> When processing the reflog of a symbolic ref, hold the lock on the
>> symbolic reference itself, not on the reference that it points to.
>
> I am not sure if that makes sense.
> So when expiring HEAD, you want to have a .git/HEAD.lock file
> instead of a .git/refs/heads/master.lock file?
>
> What would happen if there is a concurrent modification
> to the master branch?

The HEAD may be pointing at 'master' and the other party that is
trying to modify it would fail when it tries to update the reflog
for HEAD thanks to HEAD.lock being held by us.  The HEAD may be
pointing at 'next' and the other part that updates 'master' would
not try to modify HEAD reflog and we do not conflict.

At least, I think that is the rationale behind this change.
