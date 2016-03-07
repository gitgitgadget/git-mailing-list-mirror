From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: honor no_http env variable to bypass proxy
Date: Mon, 07 Mar 2016 12:33:06 -0800
Message-ID: <xmqqr3fmni4d.fsf@gitster.mtv.corp.google.com>
References: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
	<xmqqio179uxn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jiang Xin <xin.jiang@huawei.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Mar 07 21:33:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad1q6-0006F5-MW
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 21:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbcCGUdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 15:33:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753207AbcCGUdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 15:33:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7F50499C8;
	Mon,  7 Mar 2016 15:33:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ybwGNspV3vwUtpuElfyoCanTWXA=; b=VmcHn1
	4yOoDoTX/cFHugybp6CT9QlrpQoldRXc0o9ibRmBwTjT9ciu/vKeSjlNk09qvDSr
	mcJTdvHmnty+fGo1TUalIy18HqH7dI3Ph2y4s/4MxbxOBw/aWEruLJO/chLIM0WM
	7lHzHNR73pj7ZNrBGlsk6VKU5Q5WRY6q8Mspk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OM7ZvbnaQ7IrxMvi3xBH9PiElN8toGfn
	vVtUVHSgpNu1B9VjaWrxOz8hA1/fsFdMGegLIR/BOn/uGnJKbEPgSr+J/ozDUZZ0
	Zwjjw3f54VuxiDScNAhPA5HqI7yJrVefOFbQJd+qGRo5NV9XW6r+tSOcFQj0e7AG
	K4HJVpUhTiI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD83B499C7;
	Mon,  7 Mar 2016 15:33:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E3AB499C5;
	Mon,  7 Mar 2016 15:33:07 -0500 (EST)
In-Reply-To: <xmqqio179uxn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 29 Feb 2016 11:29:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CCE9A868-E4A3-11E5-81B5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288399>

Junio C Hamano <gitster@pobox.com> writes:

Second call for help.  I hate having to revert 30f302f7 (Merge
branch 'kf/http-proxy-auth-methods', 2016-02-03) this late in the
cycle.

> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> From: Jiang Xin <xin.jiang@huawei.com>
>>
>> Curl and its families honor several proxy related environment variables:
>>
>> * http_proxy and https_proxy define proxy for http/https connections.
>> * no_proxy (a comma separated hosts) defines hosts bypass the proxy.
>>
>> This command will bypass the bad-proxy and connect to the host directly:
>>
>>     no_proxy=* https_proxy=http://bad-proxy/ \
>>     curl -sk https://google.com/
>>
>> Before commit 372370f (http: use credential API to handle proxy auth...),
>> Environment variable "no_proxy" will take effect if the config variable
>> "http.proxy" is not set.  So the following comamnd won't fail if not
>> behind a firewall.
>>
>>     no_proxy=* https_proxy=http://bad-proxy/ \
>>     git ls-remote https://github.com/git/git
>>
>> But commit 372370f not only read git config variable "http.proxy", but
>> also read "http_proxy" and "https_proxy" environment variables, and set
>> the curl option using:
>>
>>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>>
>> This caused "no_proxy" environment variable not working any more.
>>
>> Set extra curl option "CURLOPT_NOPROXY" will fix this issue.
>>
>> Signed-off-by: Jiang Xin <xin.jiang@huawei.com>
>> ---
>>  http.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> Sounds sensible; I am guessing that this is 2.8.0-rc0 regression
> that we need to fast-track?
>
> Knut, does this look good?
>
> Thanks.
>
>> diff --git a/http.c b/http.c
>> index 1d5e3bb..69da445 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -70,6 +70,7 @@ static long curl_low_speed_limit = -1;
>>  static long curl_low_speed_time = -1;
>>  static int curl_ftp_no_epsv;
>>  static const char *curl_http_proxy;
>> +static const char *curl_no_proxy;
>>  static const char *http_proxy_authmethod;
>>  static struct {
>>  	const char *name;
>> @@ -624,6 +625,11 @@ static CURL *get_curl_handle(void)
>>  		}
>>  
>>  		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>> +#if LIBCURL_VERSION_NUM >= 0x071304
>> +		var_override(&curl_no_proxy, getenv("NO_PROXY"));
>> +		var_override(&curl_no_proxy, getenv("no_proxy"));
>> +		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
>> +#endif
>>  	}
>>  	init_curl_proxy_auth(result);
