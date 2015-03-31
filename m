From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/6] line-log.c: fix a memleak
Date: Tue, 31 Mar 2015 12:03:12 -0700
Message-ID: <xmqqr3s5q9an.fsf@gitster.dls.corp.google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
	<1427764931-27745-4-git-send-email-sbeller@google.com>
	<xmqqsiclsqlz.fsf@gitster.dls.corp.google.com>
	<551A323F.9030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	sunshine@sunshineco.com, tr@thomasrast.ch
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:03:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd1Ra-0006ab-2r
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 21:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbbCaTDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 15:03:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751898AbbCaTDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 15:03:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7F1A439BD;
	Tue, 31 Mar 2015 15:03:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e7K4aoIgfaPdzUFmPmeEZ5mBBDo=; b=UMye55
	wMfyXlKqYBeOVkA9ITO4pDr9wkL6Rxy+N+S3PrqsF45tFyTv7Kk0hbt8ogxkCwKH
	p8wF2nLroiZVussKQdCUPgAKbCf5RenIzt7c8aX98kDgsCfzGJq3u3/COPmliFsk
	y9bLrmkIzMUCGFkSvGFvXeqMptbi9195wLaTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cyvhZTz45FRB0g3XpkhREBquN5oDfkjS
	EKsjucG31mbt1TPC8rBnMUL7A9G4Hb/5AnVVr5LHg+rPycd517/dO8udi8J/OHa1
	fYSkbKzOdHjQ1mU1xe6oHe9tL+WA4OvcdgMFcRSQ2icBlTPwM9XP8m5jQlnoIyQ6
	/oR/iMJc2Ws=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97FA5439BC;
	Tue, 31 Mar 2015 15:03:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15FC1439BA;
	Tue, 31 Mar 2015 15:03:14 -0400 (EDT)
In-Reply-To: <551A323F.9030305@gmail.com> (Stefan Beller's message of "Mon, 30
	Mar 2015 22:35:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 950FF3F8-D7D8-11E4-A473-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266547>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 30.03.2015 22:06, Junio C Hamano wrote:
>> If add-line-range does not take ownership of
>> parent_range from us, shouldn't we be freeing it whether we called
>> it or not???
>
> In my understanding it does take ownership of it. (According to my code
> review on friday)

Hmmm.

add_line_range() is given the "parent_range" as its third parameter,
i.e. "range".

If there is nothing for the commit yet, it calls line_log_data_copy()
on it to make a deep copy and stores that in new, which is then used
as the decoration for the commit---the copy is what is retained.

I am not quite sure what the lifetime rule is for the original of
this deep copy, i.e. "range", aka "parent_range" of the caller.
Who holds pointers into it after this function is done?
