From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 20/24] introduce GIT_INDEX_VERSION environment variable
Date: Wed, 27 Nov 2013 14:08:27 -0800
Message-ID: <xmqqk3ftsdk4.fsf@gitster.dls.corp.google.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
	<1385553659-9928-21-git-send-email-t.gummerer@gmail.com>
	<CAPig+cSHcL62EW5z5n68jQcS4BWW9cZ=GqRwZaoyYM69NE55+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 23:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlnHg-0004Ed-RL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 23:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541Ab3K0WId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 17:08:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227Ab3K0WIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 17:08:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 907A751910;
	Wed, 27 Nov 2013 17:08:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X9E5Iwi0HecRUMBnp6TFWamz2+Y=; b=gEF4Gi
	GOEskuDCJJxutT7aCQ2nHMs5uVlGfT13pEBxoi/P3bmqdeSLvTw49DfxRHXdfn2f
	O5p6a78d3XGceElrLwuUrmswCDSa9HPsr+QhkZiJAIU6XdfaLMMO8ZjjN6yXEVDS
	b8izd7fzmCj5yW8Him9QAUBBLgps+i1WinCds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EcnD/YGXill7NXV1C9OXcjFYR/Ehzzcn
	SN3LjGg40dmrffP6q/pLs3MhwNp1dsRUEgkcBe+4lcmMs7eixdqu/F4smi0GrWmn
	eBxUZsHetE2XCb9+ivYRL7r79DMO+yerRihh5EQ/PYGvJGnmvWiQe3sDJcCHvBWd
	8ABTWwqhVW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C7505190F;
	Wed, 27 Nov 2013 17:08:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA8DC5190D;
	Wed, 27 Nov 2013 17:08:30 -0500 (EST)
In-Reply-To: <CAPig+cSHcL62EW5z5n68jQcS4BWW9cZ=GqRwZaoyYM69NE55+w@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 27 Nov 2013 16:57:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7316D78E-57B0-11E3-A782-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238468>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Nov 27, 2013 at 7:00 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Respect a GIT_INDEX_VERSION environment variable, when a new index is
>> initialized.  Setting the environment variable will not cause existing
>> index files to be converted to another format for additional safety.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>> diff --git a/read-cache.c b/read-cache.c
>> index 46551af..04430e5 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1233,8 +1233,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
>>  void initialize_index(struct index_state *istate, int version)
>>  {
>>         istate->initialized = 1;
>> -       if (!version)
>> -               version = INDEX_FORMAT_DEFAULT;
>> +       if (!version) {
>> +               char *envversion = getenv("GIT_INDEX_VERSION");
>> +               if (!envversion)
>> +                       version = INDEX_FORMAT_DEFAULT;
>> +               else
>> +                       version = atoi(envversion);
>
> Do you want to check that atoi() returned a valid value and emit a
> diagnostic if it did not?


Good eyes.

We use strtoul() for this kind of thing instead of atoi() for format
checking.  The code also needs to make sure that the value obtained
thusly are among the versions that are supported.

Thanks.
