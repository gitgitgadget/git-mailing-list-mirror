From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not ignore merge options in interactive rebase
Date: Mon, 24 Jun 2013 07:16:25 -0700
Message-ID: <7vd2rbd26e.fsf@alter.siamese.dyndns.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
	<87bo6wyn0z.fsf@duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Arnaud Fontaine <arnau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 16:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7ZJ-0004zd-5v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 16:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990Ab3FXOQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 10:16:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab3FXOQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:16:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB4F42A016;
	Mon, 24 Jun 2013 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZD9ufOhWbtOHrgMCXQITidcNGoA=; b=l26Xja
	h91s1QEhkY5JjgfwAWqejw0df5uFdI+0aZExBOBUp+UtYv8xwU/0TbAUOH/NivOZ
	O1yTjZY1kCSuqPWvY4rwKe8i6VQYVnatLYV9ITUr9LMRM476EFTsMesdefQ7MvKk
	lSA6auHOqwmtOVQenZgEh59qGuZnkBRdpVZ28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPEEEWuni4prw5qYcaHxLLuiBTp+Xovi
	PdgKNKxOv5WmliDA7x4r6JSZB6aOI4aufFcqJLAAyCmpAvX9K9xHk69hA6YbAYrV
	t2RSu9+ndFQyzoKwGnJjiJgvzwQqVdFcDNDCPs89/GGN7FP9wpEVQMM4a2zbWNMr
	/ibgElWDHtg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF54A2A015;
	Mon, 24 Jun 2013 14:16:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 537A12A014;
	Mon, 24 Jun 2013 14:16:27 +0000 (UTC)
In-Reply-To: <87bo6wyn0z.fsf@duckcorp.org> (Arnaud Fontaine's message of "Mon,
	24 Jun 2013 16:40:28 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A88EE6C0-DCD8-11E2-B29B-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228815>

Arnaud Fontaine <arnau@debian.org> writes:

>>> +			$(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g") \
>>
>> Is it guaranteed $startegy_opts do not have a space in it?
>
> strategy_opts may be something like (git-rebase.sh): "'--foo' '--bar'",
> but I'm not sure what is wrong if there is a space in it though.

I was primarily worried  about "'--frotz=nitfol xyzzy'", where you
need to pass -X='frotz=nitfol xyzzy' so that 'xyzzy' part does not
become a separate argument directly given to 'git merge' and friends.

And adding '' around \1 is not sufficient, because the value given
to the "--frotz" may have to be "nitfol 'n xyzzy".

A comment next to that sed script that says "Currently there is no
strategy option that needs quoting" (if it is the case; I didn't
check), together with a guard to protect us against unexpected
strategy-opts, might be a workable band-aid, though.
	
