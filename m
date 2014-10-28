From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Tue, 28 Oct 2014 12:56:17 -0700
Message-ID: <xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
	<xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:27:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjDMJ-00069B-5u
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 21:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbaJ1U1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 16:27:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753655AbaJ1U1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 16:27:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19EDB1821F;
	Tue, 28 Oct 2014 16:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MdDdSJYmNCH1t3SZWdBCnbNMCDI=; b=brJW16
	iWUc/bkz70Q/PQp1TQ1RlKhn/+ZAL+oDceKV/5l59too476SjUOeizeMZh+GCjGu
	/ODX51C0ftGbSH3lKmrNuVBTGLfLaGLL4J+Ktptjo65R1DL21Bxxox4LPPXVz+pd
	VRu1BTUl4aHhQbXy67OMzP7jyi73bJVQ1V6WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYlQqp/H63hCwLpnM/GBYE3eszOOSHg9
	Bltif5Fwi6ps7ykLxpX8d56oh/zXly6nVclPsgdtZy1vtn6nt3oMH0ECWAJrzYtb
	uoExAN/L7GIyZnQvs+lvocucM0gwb8LpMtC61dmQGz2eMrNNW7eseRB3R74upP9R
	dmv5W1j6ecA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B2101821E;
	Tue, 28 Oct 2014 16:27:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A30781990A;
	Tue, 28 Oct 2014 15:56:18 -0400 (EDT)
In-Reply-To: <xmqqppdcj9m9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Oct 2014 12:07:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7BA132D0-5EDC-11E4-8FAF-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> commit 0295e9cebc41020ee84da275549b164a8770ffba upstream.
>>
>> Change refs.c to use a single transaction to copy/rename both the refs and
>> its reflog. Since we are no longer using rename() to move the reflog file
>> we no longer need to disallow rename_ref for refs with a symlink for its
>> reflog so we can remove that test from the testsuite.
>
> Do you mean that we used to do a single rename(2) to move the entire
> logfile, but now you copy potentially thousands of reflog entries
> one by one?
>
> Hmmmm,... is that an improvement?

I see some value in "keep the original while creating a new one,
just in case we fail to fully recreate the new one so that we can
roll back with less programming effort".  But still, we should be
able to copy the original to new without parsing and reformatting
each and every entry, no?
