From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in pack directory
Date: Wed, 04 Nov 2015 11:35:52 -0800
Message-ID: <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
	<CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:36:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu3ql-0004SY-AG
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254AbbKDTf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:35:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756134AbbKDTfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:35:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB90127484;
	Wed,  4 Nov 2015 14:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qsXHfIMgRsbGfgYFWEaIdQ7af80=; b=EkOcM8
	sSOpL6rP5xROtkXLoUNpc2Te9GjyGjEXpXtVOpvUY/zd6ShnIo7+Ox67S9I6ji87
	V32FK4vaJf0t8wHEZF91KIZBd7DiOf8GkaPgdBVpk8iX9Y+NOVjxbYR8GZR4FN4r
	NAQmwh6+h+jDT3uzIlAxDTElgE6Ukdl4veHPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M6peWKMxaPCnZ4nrVZHcLJDBAyuygmmi
	fJCmeyiOm1xk5MtLCdjjJ44DU//GSebDDkbgWKel70iJ9E6phz7TVGUmQZ1xvloe
	O+RN4HzjBlxxm7ih7I43xCrL0qpmkMwn+IawZ3c9Jfpp9ah/5kEST59TZH0r8VLy
	yfnYHRQEMNI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B357027483;
	Wed,  4 Nov 2015 14:35:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BDD027481;
	Wed,  4 Nov 2015 14:35:54 -0500 (EST)
In-Reply-To: <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
	(Doug Kelly's message of "Tue, 3 Nov 2015 21:12:38 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4360CEB6-832B-11E5-852E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280866>

Doug Kelly <dougk.ff7@gmail.com> writes:

> I think the patches I sent (a bit prematurely) address the
> remaining comments... I did find there was a relevant test in
> t5304 already, so I added a new test in the same section (and
> cleaned up some of the garbage it wasn't removing before).  I'm
> not sure if it's poor form to move tests around like this, but I
> figured it might be best to keep them logically grouped.

OK, will queue as I didn't spot anything glaringly wrong ;-)

I did wonder if we want to say anything about .bitmap files, though.
If there is one without matching .idx and .pack, shouldn't we report
just like we report .idx without .pack (or vice versa)?

Thanks.
