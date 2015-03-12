From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] list-files: show paths relative to cwd
Date: Thu, 12 Mar 2015 14:28:05 -0700
Message-ID: <xmqqoanx29ei.fsf@gitster.dls.corp.google.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-4-git-send-email-pclouds@gmail.com>
	<xmqqsid929rb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 22:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWAeL-0000zt-9o
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 22:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbbCLV2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 17:28:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753277AbbCLV2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 17:28:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4E8A4056A;
	Thu, 12 Mar 2015 17:28:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LufZ8SLGt0zgrYOwWDhLYpIlytg=; b=r7/9iZ
	brjXMJe+RUBZ4vEnSsXmPs6ZlfmK7xU1Rydhquzx+8cZZbLKHEmk4A7IvIpVtdcR
	RJwqOMJY6MgagI4ouscdLm0YXebRrC/TeJGsC8lC5dOjTxl+fgf/WZdN6KqnV/rr
	S4o+K6OvkePLElG0AJmmcXXTIFHSeOIEiyTXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DVPE5JnbJ5nabvOMGeZJNfMEuL28Ujse
	LWHbLc4r+fm+gCV+vlxTbABG/86NU7TOKnOFfKrKy+tunajtRPwIVYzdBUKrGbUf
	UX3wGyUs0kRuRLE7Jq3kWOQdqlrsT8gbCBzwrz7uTTQIFHnnqKcAYWRgO8muGb9d
	zIYydB2rclY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE51340568;
	Thu, 12 Mar 2015 17:28:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6667040567;
	Thu, 12 Mar 2015 17:28:06 -0400 (EDT)
In-Reply-To: <xmqqsid929rb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 Mar 2015 14:20:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC358310-C8FE-11E4-A2DD-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265373>

Junio C Hamano <gitster@pobox.com> writes:

>>  static struct pathspec pathspec;
>>  static const char *prefix;
>> @@ -22,7 +23,7 @@ static void add_one(struct string_list *result, const char *name)
>>  	struct strbuf sb = STRBUF_INIT;
>>  	struct string_list_item *item;
>>  
>> -	strbuf_addstr(&sb, name);
>> +	quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
>>  	item = string_list_append(result, strbuf_detach(&sb, NULL));
>>  	item->util = (char *)name;
>>  }
>
> Hmph, wouldn't it make it more cumbersome and problematic to do
> things like this here in add_one() phase?  I am imagining that the
> endgame of this program will be
>
>     - populate_cached_entries() reads from the data source (at this
>       step, there is just "the index"), calling add_one() whose
>       responsibility is to record the paths that are interesting
>       to an in-core structure;
>
>     - perform some interesting filtering, annotating, ordering,
>       etc. (at this step, there is none) yet to come;
>
>     - display() will iterate over the result and then format the
>       result.
>
> For example, if you do the "quote" thing too early, don't codepaths
> in the later phases have to worry about item->string not matching
> the original pathname anymore?  If you want to do something like
> "/bin/ls -t", you may have to lstat() the paths for each item, but
> if these store a path relative to the prefix, wouldn't you have to
> prepend the prefix again before running lstat()?
>
> I am just wondering if this prefix-stripping and quoting belongs to
> the output phase, not the input phase.

Hmph, another interpretation of this patch is that your item->string
are not the true filenames but the result of applying some
interesting processing to the filenames and the true filenames are
kept in item->util.  Is that what is going on?

If that is the case, it sort of makes sense to me, even though it
would feel a bit unusual way to use the string-list.

Thanks.
