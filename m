From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Mon, 24 Nov 2014 12:50:07 -0800
Message-ID: <xmqqbnnwwcg0.fsf@gitster.dls.corp.google.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alex Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 21:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt0aQ-0004If-IA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 21:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbaKXUuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 15:50:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750757AbaKXUuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 15:50:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0734219F7;
	Mon, 24 Nov 2014 15:50:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJ7fDOthoslDasSryDfcakkqCHg=; b=qpydAw
	Cs7U1p5uhC1ZXYngv+RJjopCtP0WBBjVk6K1w9i0VvR9oMSasfUpXZWpbyDXXRN9
	HzeAcpKo86xI+N1cy8CrJ59aIJIWOG9S6k9KUfRibJU/3xWZcTS+PlobU4aO0wEu
	tpZWJcRiJ2dnO+qvkqeAd8En99M8EMx0iiMKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uP93lBgIgtSEsfsnLa8gFvzEi9ZaitRN
	QaSnrdSoZvcNZXPDuFS7/JQutcoUQxYm89SjMRBbTNb3/5MnCiv5hT1ejeCzIffj
	yYr08eWu9VEsxnjinB0JPU0/wfN2PQ1j166VxyVVWCdXdvdHjmDZ5wpNHPOz7Jf0
	LwwMM+zdYRQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7D42219F6;
	Mon, 24 Nov 2014 15:50:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5813219F5;
	Mon, 24 Nov 2014 15:50:08 -0500 (EST)
In-Reply-To: <87ppcc4b2g.fsf@gmail.com> (Alex Kuleshov's message of "Tue, 25
	Nov 2014 01:53:35 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A1B1350-741B-11E4-99BD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260145>

Alex Kuleshov <kuleshovmail@gmail.com> writes:

>> One thing to note is that this illustration does not consider memory
>> pointed at by the "system_wide" variable here (from attr.c)
>>
>>         static const char *git_etc_gitattributes(void)
>>         {
>>                 static const char *system_wide;
>>                 if (!system_wide)
>>                         system_wide = system_path(ETC_GITATTRIBUTES);
>>                 return system_wide;
>>         }
>>
>> at the point of process exit as a "leak".
>
> But why? We allocated memory to "system_wide" with system_path, next git
> will exit somewhere with die, but system_wide didn't free... Or i'm
> wrong here too?

It is in the same league as "static const char *git_dir" and friends
that appear in the file-scope-static of environment.c.  Keeping small
things around to be cleaned up by exit() is not a crime.
