From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 14:12:24 -0800
Message-ID: <xmqqsit6nid3.fsf@gitster.dls.corp.google.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com> <52C5D201.5070008@gmail.com>
	<xmqq8uuyoz5g.fsf@gitster.dls.corp.google.com>
	<xmqqzjnenjcd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 23:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyqVE-0004mR-QX
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 23:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaABWM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 17:12:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaABWM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 17:12:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D676B5EE18;
	Thu,  2 Jan 2014 17:12:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3SP505WlECEBUwp1rfVqWLRLWic=; b=xUiUJk
	sZqXAVNP0VAuwpin7j+2FhdGZc+x0S0uFppVtouxFJUz5x0ANZbL1q7JnsmAfhCq
	pe/eQ67tk1aE2PnD8y5OGFjBoWznvvk2W7MLi8hcRkryiTcknnHTJkR6gs1t1WJp
	+VltyC8YLOUE0tgBD7CAWXq3Bw0QjDmFFWMyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RbECypS3kEGilmY9n7iWUf6tc1cPxJAh
	mpcwQRhX7UOh4Px92qW9FUG8IfZhPsDfQjpSU2Tf98u/GJnhjDAG/UjnUyKmYxj9
	K5Xt1r/t/CwOmumpin+qH88NRhR//WEbR6L+TF2TF7M5k39P7xM6HfXMB6MbJzPO
	sSxOs+r0slY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B65E25EE17;
	Thu,  2 Jan 2014 17:12:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB91F5EE15;
	Thu,  2 Jan 2014 17:12:26 -0500 (EST)
In-Reply-To: <xmqqzjnenjcd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 02 Jan 2014 13:51:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6B17E9E-73FA-11E3-ADE5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239891>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> This has a bit of conflict with another topic in flight; I think I
>> resolved it correctly, but please double check.  The following is
>> how it would apply on top of 'pu'.
>>
>>  sha1_file.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 131ca97..9e686eb 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -113,11 +113,12 @@ int safe_create_leading_directories(char *path)
>>  
>>  	while (!retval && next_component) {
>>  		struct stat st;
>> -		char *slash = strchr(next_component, '/');
>> -
>> -		if (!slash)
>> +		char *slash = next_component;
>> +		while (!is_dir_sep(*slash))
>
> Gaah; we need to check for the end of string here, i.e.
>
> 		while (*slash && !is_dir_sep(*slash))
>
> will be what I'll queue on 'pu' for today.
>
>> +			++slash;
>> +		if (!*slash)
>>  			return 0;
>> -		while (*(slash + 1) == '/')
>> +		while (is_dir_sep(*(slash + 1)))
>>  			slash++;
>>  		next_component = slash + 1;
>>  		if (!*next_component)

Another thing I noticed (but I won't fix it up myself today, as I am
deep into today's integration cycle already) is that we temporarily
replace the slash with NUL and then restore them before we return,
but the restoration is done with the slash.  If we were to go in the
direction of this patch, you may want to update that one to use
whatever dir-sep was used in the input string.
