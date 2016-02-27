From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] environment.c: introduce SETUP_GIT_ENV helper macro
Date: Sat, 27 Feb 2016 10:50:44 -0800
Message-ID: <xmqqsi0ef0mz.fsf@gitster.mtv.corp.google.com>
References: <1456593215-16302-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqpovighxk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:50:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjx5-0004KQ-7U
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729AbcB0Sur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 13:50:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756618AbcB0Sur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:50:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D60D144713;
	Sat, 27 Feb 2016 13:50:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CGCyqVOpyexYXJvqExDBVKFULSM=; b=VAqiMq
	dZ2xCF4lNfcmhqOMIkqH08pN95UdCD/INvJQTjdbzSIkW3Px+UQ6L3xomBnwpUfU
	fyll7b00aguw4T3aLRQoB3+EI7ypg1Mn5J+X92xnD6RBK1q2uKeHzzpTGO9AVp3b
	tBit71i9Q0K7EZhmSlKOTxVPyQ8YxanJF9N64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5v+EAd7HJlpl2nh0efDNTfmLUyHsHQ9
	Yud/LakLAvGxzpaXTjqqTPDWqPZZ+cWF8qSz9VrCr8sri6jSpR4z2V3YVFIL0Ahy
	y9BLyWq27/cJUrxVfRvOCgZf0ALJX2iVlSKDEM+5eDpQyjbiWO7ZhpT2kYy7u2+U
	Jz4ZAt8hnJY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD2EE44712;
	Sat, 27 Feb 2016 13:50:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E3124470F;
	Sat, 27 Feb 2016 13:50:45 -0500 (EST)
In-Reply-To: <xmqqpovighxk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 27 Feb 2016 09:51:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0246D1F2-DD83-11E5-82E0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287721>

Junio C Hamano <gitster@pobox.com> writes:

> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> Let's move this to the SETUP_GIT_ENV helper macro to prevent
>> code duplication in these functions.
>
> Please don't.  A macro that hides "return" makes things harder to
> follow, not easier.
>>
>> +#define SETUP_GIT_ENV(env)              \
>> +	if (!env)                       \
>> +		setup_git_env();        \
>> +	return env;
>> +
>>  static char *expand_namespace(const char *raw_namespace)
>>  {
>>  	struct strbuf buf = STRBUF_INIT;
>> @@ -199,9 +204,7 @@ int is_bare_repository(void)
>>  
>>  const char *get_git_dir(void)
>>  {
>> -	if (!git_dir)
>> -		setup_git_env();
>> -	return git_dir;
>> +	SETUP_GIT_ENV(git_dir);
>>  }

Having said that, I do think a higher-level macro that encapulates
the whole thing may not be such a bad idea, i.e. making the above
into

    DECLARE_GIT_GETTER(const char *, get_git_dir, git_dir)

and this and others

>>  char *get_object_directory(void)
>>  {
>> -	if (!git_object_dir)
>> -		setup_git_env();
>> -	return git_object_dir;
>> +	SETUP_GIT_ENV(git_object_dir);
>>  }

into

    DECLARE_GIT_GETTER(char *, get_object_directory, git_object_dir)
    DECLARE_GIT_GETTER(char *, get_index_file, git_index_file)
    DECLARE_GIT_GETTER(char *, get_graft_file, git_graft_file)
