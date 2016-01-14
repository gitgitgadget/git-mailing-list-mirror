From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [issue?]'git branch -D' case sensitive issue
Date: Thu, 14 Jan 2016 09:21:46 -0800
Message-ID: <xmqq4megkrf9.fsf@gitster.mtv.corp.google.com>
References: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
	<56978BA9.2010005@web.de>
	<CAB4fgE-UbTD6AkTaxyknJ+3ggtzRdYN43wgsamTXOYmGqDQ3_A@mail.gmail.com>
	<5697CFEB.4090308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?6YOt6IW+6aOe?= <tfguo369@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 18:21:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJlas-00038t-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 18:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbcANRVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 12:21:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755728AbcANRVt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2016 12:21:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 999B83AC8E;
	Thu, 14 Jan 2016 12:21:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b1tJpdkcZ365
	LFctvDbJ4pNLfP4=; b=VSm4nNzaeT/9efi/yeX+D9cx6jdB55lwmnAIpyEkZ6p4
	lODgS5CC7pU17yQaXfPwbNJFlOPzPOZxAoDMWT1nbiF35KyiIHOyiK/ESrzi94kU
	bvTVQQN8BwReqvs54YOmMlftb4jt4FyQe5bf3nC8AHD9cIk4xd1uy1UIN9xNBHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BAfzKW
	dyEZnZJ1oCyGmC57XeOAsuU54Z6KX26TZZ4ohIvDVVPsCNLAQbgqDjg+6G2nHZKm
	RJIDdAykaQ3ikTB/puQqZw13JbgeO5zZkoGrtYRNQkmWVybmj8z9NWqXooLJvCBO
	WFJzgJPA3g5yZn6aHYEG2pozq4wP5ZsfJUpDI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F5A03AC8D;
	Thu, 14 Jan 2016 12:21:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 110FC3AC89;
	Thu, 14 Jan 2016 12:21:47 -0500 (EST)
In-Reply-To: <5697CFEB.4090308@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 14 Jan 2016 17:42:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4ADAC904-BAE3-11E5-8D3F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284071>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> No, this is typically what we observe on a case insensitive FS.

There is an interesting bit in delete_branches::builtin/branch.c

	if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
		error(_("Cannot delete the branch '%s' "
		      "which you are currently on."), bname.buf);
		ret =3D 1;
		continue;
	}

The strcmp() does not protect you from attempting to remove "FrOtZ"
branch when you are on (and more importantly, Git thinks you are on)
"frotz" branch.  A case-insensitive system then can tell Git that
the request to remove "refs/heads/FrOtZ" succeeded, even though in
reality it didn't have such file, and silently "refs/heads/frotz"
gets removed instead.  You can end up removing your current branch
that way.
