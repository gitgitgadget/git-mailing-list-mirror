From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] submodule-config: keep labels around
Date: Wed, 11 May 2016 14:28:24 -0700
Message-ID: <xmqqfutojnd3.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-4-git-send-email-sbeller@google.com>
	<xmqqh9e5l7id.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYSxccNLvJ-=UghabQ_MG73jRSabVy5rgfNo-A6Fjz_yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 23:28:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0bgG-0006KY-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcEKV22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:28:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbcEKV22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:28:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9512A1BFC5;
	Wed, 11 May 2016 17:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=63v+RxG2zQYVcpTzInddbN551Pc=; b=rzSBLd
	tNI5SIMV+HDHF9pk5b8fW5Bjso7KSZNVQNIwwZW5VdeQoAzF8ZJmX/BtXcgvJteC
	8dHPcEZLXa+L0Ih4olUOSWzbeksNJnkbwnjZNcdzoM6h1cnHxEBp4rUdWi4lcsSG
	GTzvpfIv/v8mAxwt0qwRo7EYWJRAqd6avWGi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZO0wBUckP2SjNYE0R9A6X4XhfVP1JO1X
	RBVdvdHchWkeG4c4ghGKQnbqi3gUUO/fNn+asasb5AQwHu+1RJ1+O35go3l2gCg4
	3WcCTVB4paMRPQQfsjY84j4lF53yE1iqGzKaQ9BIz2i/tR/YrgUUbYXocETPd7HG
	Q67cuFoyIPQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D52A1BFC4;
	Wed, 11 May 2016 17:28:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13AAF1BFC3;
	Wed, 11 May 2016 17:28:26 -0400 (EDT)
In-Reply-To: <CAGZ79kYSxccNLvJ-=UghabQ_MG73jRSabVy5rgfNo-A6Fjz_yQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 11 May 2016 10:41:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BE60398-17BF-11E6-8880-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294367>

Stefan Beller <sbeller@google.com> writes:

> On Tue, May 10, 2016 at 6:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> @@ -199,6 +203,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>>>       submodule->update_strategy.command = NULL;
>>>       submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>>>       submodule->ignore = NULL;
>>> +     submodule->labels = NULL;
>>
>> Hmph, is there a reason to do this, instead of embedding an instance
>> of "struct string_list" inside submodule structure?
>>
>> I am not yet claiming that embedding is better.  Just wondering if
>> it makes it easier to handle initialization as seen in the hunk
>> below, and also _clear() procedure.
>
> Thanks for pointing out that alternative.  That looks so much
> better in this patch. Let's see how the follow up patches develop.
> As we'd not check != NULL first, but check against the count of the
> string list. (I expect no problems down that road though).

I also wonder if we can say the same for the .ignore field, by the
way, if we agree that it is a better direction to go.
