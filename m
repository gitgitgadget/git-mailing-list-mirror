From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: do not trust stat info if lstat() fails
Date: Thu, 03 Apr 2014 09:30:12 -0700
Message-ID: <xmqqvbuqqstn.fsf@gitster.dls.corp.google.com>
References: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
	<1396012689-22480-1-git-send-email-pclouds@gmail.com>
	<xmqq38hvvbr7.fsf@gitster.dls.corp.google.com>
	<CACsJy8DBixHTeqitcAcQRAqY3b4prkwQGgJGuw7hbT7BQAZt9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 18:30:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVkX1-0001rw-4X
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 18:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbaDCQaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 12:30:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbaDCQaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 12:30:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EBAA7A263;
	Thu,  3 Apr 2014 12:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fooLpPh6DzJaKd0fCUkz+zISdho=; b=lBeHu5
	08xF+uHvqTl3G2jSfLg2IulvrgsY1Gw2MFGSMefqPTbRkRdAHtpZLvX7SFAOd2Fs
	icXg8oykslV3FmPxfyd0FQJFTakUpuAkIC6Ihy9Ifyc90eTHoHZ8M0VWKxgshmrz
	VuhVDhfsZBQoNvcJgn9w9mbkmxP3ts01svnM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aSWkVCLsxcC9KyQGEFgwoc8hip7lHVo8
	OEsc07owOqzwWZZbn1caqnnIA7hC6ukWSkXxyVfE+XaDW3KYzDcLDIseuiA8VXjw
	4IAtDhvifjFRbJZvyYx9y+WAM4rX6G6LusGFlHpjWwH2PpGW3AQgqOa7+Cl1VOT2
	9qCCaK28+58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B6BC7A262;
	Thu,  3 Apr 2014 12:30:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6AED7A25F;
	Thu,  3 Apr 2014 12:30:14 -0400 (EDT)
In-Reply-To: <CACsJy8DBixHTeqitcAcQRAqY3b4prkwQGgJGuw7hbT7BQAZt9w@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 3 Apr 2014 19:40:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3C2176A2-BB4D-11E3-8A9B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245742>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Apr 3, 2014 at 1:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I am guessing that, even though this was discovered during the
>> development of list-files, is a fix applicable outside the context
>> of that series.
>>
>> I do think the patched result is an improvement than the status quo,
>> but at the same time, I find it insufficient in the context of the
>> whole codepath.  What if errno were other than ENOENT and we were
>> told to show_deleted (with or without show_modified)?  We would end
>> up saying the path was deleted and modified at the same time, when
>> we do not know either is or is not true at all, because of the
>> failure to lstat() the path.
>>
>> Wouldn't it be saner to add tag_unknown and do something like this
>> instead, I wonder?
>
> Or even better to show an error message when the error code is
> unexpected? The unkown tag '!' says "there are problems" but if it
> shows up sort of permanently, '!' won't help much, I think.

I am OK with that approach, but then one question remains: should we
say it is deleted, modified, both, or neither?
