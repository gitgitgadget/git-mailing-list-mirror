From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Submodule Groups
Date: Thu, 21 Jan 2016 14:37:56 -0800
Message-ID: <xmqqpowuwocb.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<56A14AD4.6040608@gmail.com>
	<CAGZ79ka+LZHRjVB8bZ4u+-n-U06mUWsbx9nRVCvd4aPwrb7yHQ@mail.gmail.com>
	<xmqq37tqy3t4.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYVE7a=kXi__+Y3C7cuQUhY78o0unuw7vU4hrO71q1dwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:38:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNrg-0007Ka-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbcAUWiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:38:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751224AbcAUWh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:37:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 612213D8CB;
	Thu, 21 Jan 2016 17:37:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zPZZ40gcHTjWL1Hm30YAqs/wTM0=; b=aBRFq8
	ra7Wx13EmZAPpWOpnC7/aIJ5c8q3CT+lDdDUd6RbLYfaJR1lYdRf7V6K9xNWKzPp
	RPHCVuM1FLiViTJAp9WEE/NOrXUF8BumAhwos7ibw9ANwty66Buf1d/5gZWCD8zB
	aXjYF23sYZw+qzeUpsbjTdcFYjp63GpHBhTNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FBhLRIq/oQR4UkPzI1wt8BL4FbPyjcRC
	gVW45kcewsArExVewSy4aLxsmaQRykubnPA7RE4GUZ5JUKgYkLnC40IbS11hrOgb
	UDW8QggduAIiZG4e++e3D91oPFKzrhttv442C+IMZVQuv9qS+nrmwpQeecVB870g
	SYd2d3iE2gI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 579F63D8CA;
	Thu, 21 Jan 2016 17:37:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD42F3D8C9;
	Thu, 21 Jan 2016 17:37:57 -0500 (EST)
In-Reply-To: <CAGZ79kYVE7a=kXi__+Y3C7cuQUhY78o0unuw7vU4hrO71q1dwA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Jan 2016 14:30:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E9BEB98-C08F-11E5-9E92-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284539>

Stefan Beller <sbeller@google.com> writes:

> I think having both is bad as it may contradict each other?
> What is supposed to happen here:
>
>      [submodule "frotz"]
>          group = default
>
>      [submoduleGroup "default"]
>          member = !:frotz

What is supposed to happen is that you will write code to diagnose
this as an error, and give helpful error message to the user.

> So groups of groups, we discovered recursion today. :)
> Having this discussion makes me realize, the groups handling logic
> will be more complex than I anticipated for the first RFC patch series.

That is why I think we do not have to have a very complex group
logic from day one.

> The two basic questions the logic has to answer is:
>  * Give me all the submodules that fit these specifiers (i.e. the
>     --init-submodules collection from clone)
>  * Given submodule X, does it fit the specifier ( a new uninitialized
>     submodule during a later update)

Yes.
