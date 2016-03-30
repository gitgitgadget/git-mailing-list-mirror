From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 14:07:14 -0700
Message-ID: <xmqqegarsmil.fsf@gitster.mtv.corp.google.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-2-git-send-email-sbeller@google.com>
	<CAPig+cTeVgyNHa5uHUMDZ6ifxyjk2wvm=jGd9tP1+BuBKKVR+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 23:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alNKp-0005SE-8J
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 23:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbcC3VHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 17:07:20 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752994AbcC3VHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 17:07:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8E205182C;
	Wed, 30 Mar 2016 17:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wKzzbx8t6tEz5rGLzt5N4F9bbXo=; b=pHZQIF
	p4m4cFxbipPOmP5g4RkH9WaVP2yqjxXyeazKmS5bQUU3YwrJRryKZsO43j1J7LqZ
	qu8rlz4Tedw0jpyYWg0+Ocmy1rf6HFv+Yf/4bEjf+MUQW7rF2GRL+OL+vMlU0RlL
	UFBgiVGu3o6RbRubEG8SGqWLT+pKzYPx11tRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OhPNm4g6WeEjLI9WylKh+CPmFBxrC23j
	oPWmtfuU3/Yiw3+z8Kt5grXISWbKvEyYEzFOYsgLTQ+CB3eZZFs7F/8FxF00xR+F
	TUzjoBqlT/fHlTKR+R/g8821s8m5sorIhneZmG8gKXTiEfyKq0IDg7y/8EzK8j/z
	6X0HI7vVweE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8E955182B;
	Wed, 30 Mar 2016 17:07:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B64851828;
	Wed, 30 Mar 2016 17:07:15 -0400 (EDT)
In-Reply-To: <CAPig+cTeVgyNHa5uHUMDZ6ifxyjk2wvm=jGd9tP1+BuBKKVR+g@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 30 Mar 2016 13:32:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 611CC960-F6BB-11E5-9528-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290348>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/builtin/notes.c b/builtin/notes.c
>> @@ -744,13 +744,14 @@ static int merge_commit(struct notes_merge_options *o)
>>  static int git_config_get_notes_strategy(const char *key,
>>                                          enum notes_merge_strategy *strategy)
>>  {
>> -       const char *value;
>> +       char *value;
>>
>> -       if (git_config_get_string_const(key, &value))
>> +       if (git_config_get_string(key, &value))
>>                 return 1;
>>         if (parse_notes_merge_strategy(value, strategy))
>>                 git_die_config(key, "unknown notes merge strategy %s", value);
>>
>> +       free(value);
>>         return 0;
>>  }
>
> Hmm, I thought Peff's suggestion of using git_config_get_value() was
> accepted as superior since it avoids the allocation altogether, thus
> no need for free() and no leak.

I agree that this caller can avoid taking ownership of value by
using git_config_get_value() and that would be a cleaner solution
here.

This is a tangent, but am I the only one who finds that the naming
of functions in config-get API is confusing?  Just wondering if we
should rename the ones that keeps the memory ownership to the config
subsystem with s/get/peek/ or something.
