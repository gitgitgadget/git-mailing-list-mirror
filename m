From: David Ripton <dripton@ripton.net>
Subject: Re: [RFC/PATCH] Add --exclude-dir option to git grep
Date: Fri, 24 Sep 2010 22:07:40 -0400
Message-ID: <4C9D596C.4060906@ripton.net>
References: <20100924042614.GA25944@nulllenny.dreamhost.com> <7v1v8iq3tu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 04:08:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzKBj-00029e-Mk
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 04:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab0IYCIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 22:08:13 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:49418 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab0IYCIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 22:08:11 -0400
Received: from homiemail-a52.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id DA16817AD84
	for <git@vger.kernel.org>; Fri, 24 Sep 2010 19:08:10 -0700 (PDT)
Received: from homiemail-a52.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a52.g.dreamhost.com (Postfix) with ESMTP id 6C1E36B80C4;
	Fri, 24 Sep 2010 19:07:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=ripton.net; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=ripton.net; b=
	3bPkUmzWYp5AuVGdkTZ0jnvmZkuQkq5A9QrAMHnacffsJlrTTtK2CSBXSrLFcGCB
	O7eG5UKL1xx2HlcsaCCwxHXWrE+OT/K9XZPsslrfsZuUtQfyszwxe4yQShRGpLBl
	Va27DVUFUy1LDfOZPa9oIslynLXK1SPyGC3qDmRccA8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ripton.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=ripton.net; bh=PgmQ/J
	cPuBUC598m8GGeEqZYOQk=; b=T3qjWDLXZ3ntr6ibLZOo4rXmwEALJgLtl+mXmT
	nmE/vqHJlkKOa/9qiE1t98zvrZTXZPwG9W0NL60rIvrNFDpNgcgGhRNlv41Dn7Rw
	lBsTTp6tv72hQL3LM4UHIB9BrK/vgi4L0Z6hg8blDvRR08bKRVmgivLoDmn8jT3N
	2Tops=
Received: from [192.168.2.175] (pool-98-118-245-254.clppva.fios.verizon.net [98.118.245.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dripton@ripton.net)
	by homiemail-a52.g.dreamhost.com (Postfix) with ESMTPSA id 1CA026B80C0;
	Fri, 24 Sep 2010 19:07:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.9) Gecko/20100908 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <7v1v8iq3tu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157106>

On 09/24/10 16:33, Junio C Hamano wrote:

> Thanks.

Thank you for the code review.

> Do you need to run this every time we visit a new directory, expanding
> directory components over and over?
>
> It is not like we are jumping around directory hierarchies, visiting
> "foo/bar" and then "xyzzy" and then "foo/baz", but rather we visit
> directories in a nicer order (i.e. after leaving "foo/bar" but before
> jumping to "xyzzy", we would visit "foo/baz"), don't we?

I agree that there's room for optimization here.

>>   	if (max_depth<  0)
>>   		return 1;
>
> Isn't this original check much cheaper than the new test based on many
> comparisons and should be at the beginning of the function?

Yes.

>> @@ -826,6 +886,25 @@ static int help_callback(const struct option *opt, const char *arg, int unset)
>>   	return -1;
>>   }
>>
>> +static int exclude_dir_callback(const struct option *opt, const char *arg,
>> +				int unset)
>> +{
>> +	struct string_list *exclude_dir_list = opt->value;
>> +	char *s1 = (char *)arg;
>
> What is this cast for?

It avoids:

"builtin/grep.c:893: warning: initialization discards qualifiers from 
pointer target type"

>> +	/* We do not want leading or trailing slashes. */
>> +	while (*s1 == '/') {
>> +		s1++;
>> +	}
>
> Can the result of this loop become an empty string, and what happens to
> the rest of the logic when it happens?

If the string is just forward slashes, then it will become an empty 
string, which will strdup successfully, and then that particular 
--exclude-dir will have no effect.  Just tested that case and did not 
find a bug.

>> +	char *s2 = strdup(s1);
>
> decl-after-statement.

Oops.

Sadly, "gcc -Wall -std=c89" does not warn for this.  ("-pedantic" does.)

> Use xstrdup().

Okay.

>> +	while (*s2&&  s2[strlen(s2)-1] == '/') {
>> +		s2[strlen(s2)-1] = '\0';
>> +	}
>
> Don't scan s2 repeatedly to find its end by calling strlen(s2) on it.
> Find its length once, and scan backwards from there yourself.

Okay.  I'll try to send out a revised version of this patch soon.

-- 
David Ripton    dripton@ripton.net
