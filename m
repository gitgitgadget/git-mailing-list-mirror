From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Tue, 21 Apr 2015 10:19:43 -0700
Message-ID: <xmqqa8y1iekw.fsf@gitster.dls.corp.google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
	<xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:20:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykbq2-0004Nd-S5
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbbDURTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:19:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932702AbbDURTq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:19:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E6BD4A410;
	Tue, 21 Apr 2015 13:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+roYU8u/Eeqsxy2CGZ+erShU7PE=; b=k51q1W
	3HGHjdva0B7ziL9iouFXlwGt7yoHPbeLpTzeMStl2k2nhZHPVvBCtnZp5uJgGSlR
	aRNDbvLYkWhKJf7eTyrR+IIigDDBemUNOylC3NGU2pdmEDSHW6G0ppwa+MKgO2cj
	DMmb5G+j3jXooacRacV3MsfXLL2biCFgMeA24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yj1ujbVguq4m6aZWbxh2cLpS30vSZbXW
	k+Q1Yc1lOuSWRCPRwGceRqzBsSJGC79ytMeNA5KpmpIexN8D4tLIMAdgitH6+udy
	0A+hgcEcxP3WifRU4FPo+SUh+r3X1sE2c6RT1u6rdQyEqbCp6IHUan4n0t+6OjKJ
	jMl1VzWwMzQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 673284A40D;
	Tue, 21 Apr 2015 13:19:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 681624A404;
	Tue, 21 Apr 2015 13:19:44 -0400 (EDT)
In-Reply-To: <CAGZ79kYk_3E1RMdNvA_OrCj6EdaJ2Xdps9pUxEkWwvDNazb6Gg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 20 Apr 2015 16:07:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A72D2A2-E84A-11E4-A4D5-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267536>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Apr 20, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> On the core management side, xmalloc() and friends retry upon
>> failure, after attempting to free the resource.  I wonder if your
>> codepath can do something similar to that, perhaps?
>
> But then we'd need to think about which fds can be 'garbage collected'.
> The lock files certainly can be closed and reopened.

... and that is the natural thing to garbage collect, no?  After
all, this approach allows lock-file subsystem to keep fds open even
when they do not absolutely have to, so they are the best candidates
to be shot down first when things gets tight.

A good thing is that you have a list of all them already for use by
the atexit handler ;-)
