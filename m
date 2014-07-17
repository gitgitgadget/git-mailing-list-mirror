From: Michael Barabanov <michael.barabanov@windriver.com>
Subject: Re: [PATCH] use local cloning if insteadOf makes a local URL
Date: Thu, 17 Jul 2014 11:41:26 -0700
Message-ID: <53C818D6.7020907@windriver.com>
References: <1405580972-26078-1-git-send-email-michael.barabanov@windriver.com> <xmqqwqbbq4qb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:41:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7qca-0008D7-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 20:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbaGQSlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 14:41:31 -0400
Received: from mail1.windriver.com ([147.11.146.13]:58626 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbaGQSla (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 14:41:30 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s6HIfSV8012777
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 17 Jul 2014 11:41:28 -0700 (PDT)
Received: from [10.88.70.17] (172.25.45.237) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.169.1; Thu, 17 Jul
 2014 11:41:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqwqbbq4qb.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [172.25.45.237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253770>



On 07/17/2014 10:23 AM, Junio C Hamano wrote:
> Michael Barabanov <michael.barabanov@windriver.com> writes:
>> Move the is_local logic to the place where origin remote has been setup and
>> check if the remote url can be used to do local cloning.
>>
>> This saves a lot of space (and time) in some of the mirroring scenarios that
>> involve insteadOf rewrites.
>>
>> Signed-off-by: Michael Barabanov <michael.barabanov@windriver.com>
>> ---
>
> Strictly speaking, this change introduces a regression to those who
> would rather use --no-local if they knew the are cloning from a
> local copy, but they can rewrite their insteadOf to use file:// URL
> as a workaround.

Plus --no-local still works on command line, even if rewritten URL ends 
up to be local.

>
> The code change looked OK from a cursory read, modulo possibly
> introducing a new memory leak on the old value of "path" (I didn't
> check carefully).

In fact, I couldn't find where original "path" is freed anyway.
Memory will be freed when the clone process exits of course.

Michael.

>
> Thanks.
>
>>  builtin/clone.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index f0dabec..bbd169c 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -799,18 +799,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>  		die(_("repository '%s' does not exist"), repo_name);
>>  	else
>>  		repo = repo_name;
>> -	is_local = option_local != 0 && path && !is_bundle;
>> -	if (is_local) {
>> -		if (option_depth)
>> -			warning(_("--depth is ignored in local clones; use file:// instead."));
>> -		if (!access(mkpath("%s/shallow", path), F_OK)) {
>> -			if (option_local > 0)
>> -				warning(_("source repository is shallow, ignoring --local"));
>> -			is_local = 0;
>> -		}
>> -	}
>> -	if (option_local > 0 && !is_local)
>> -		warning(_("--local is ignored"));
>>
>>  	/* no need to be strict, transport_set_option() will validate it again */
>>  	if (option_depth && atoi(option_depth) < 1)
>> @@ -903,6 +891,19 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>
>>  	remote = remote_get(option_origin);
>>  	transport = transport_get(remote, remote->url[0]);
>> +	path = get_repo_path(remote->url[0], &is_bundle);
>> +	is_local = option_local != 0 && path && !is_bundle;
>> +	if (is_local) {
>> +		if (option_depth)
>> +			warning(_("--depth is ignored in local clones; use file:// instead."));
>> +		if (!access(mkpath("%s/shallow", path), F_OK)) {
>> +			if (option_local > 0)
>> +				warning(_("source repository is shallow, ignoring --local"));
>> +			is_local = 0;
>> +		}
>> +	}
>> +	if (option_local > 0 && !is_local)
>> +		warning(_("--local is ignored"));
>>  	transport->cloning = 1;
>>
>>  	if (!transport->get_refs_list || (!is_local && !transport->fetch))
>
