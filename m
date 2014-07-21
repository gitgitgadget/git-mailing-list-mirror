From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 2/6] branch.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 23:41:15 +0530
Message-ID: <53CD57C3.4000806@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>	<1405941145-12120-3-git-send-email-tanayabh@gmail.com> <xmqqiomqk2yu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:11:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9I3Z-0000G0-3N
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 20:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbaGUSLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 14:11:21 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33516 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbaGUSLV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 14:11:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so9606048pde.18
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/p2O+N/tdGt2ejdecTxtk00fw279fjakk9CcysKko+Y=;
        b=ytrxg1SaR34c5VBuQzswzpisqu/3bkJdoB+SB+A+WcKUn7ktZjgJgY5hqrYmUQf0Ue
         A427Bd3j+eIi+u48ig+jA4TYlIveTdwYZiCaMACpV01Hamcfw/NHxLMZPrYREc4qwW/v
         XY3vqxh69g1a3jxZez+4adGBB5CSDlS2qmKO3Q9fpO2G+SgRl0jtz75nJ9kqxdH91f31
         3ygOlpK9iHiRubhIXqwUiQnizXGlFWhbSE+TaLQbglr6EoCV/tL0KlkNyjUBp4rvckkV
         LNkupS250+66NpPI4n1Ru3TC1gwDKpp80LCxp00+x9HaE82EXSsHXg4NxEpzSRtv2i8R
         ys/A==
X-Received: by 10.66.142.42 with SMTP id rt10mr27489892pab.1.1405966280711;
        Mon, 21 Jul 2014 11:11:20 -0700 (PDT)
Received: from [127.0.0.1] ([223.185.254.108])
        by mx.google.com with ESMTPSA id qa8sm2007844pdb.55.2014.07.21.11.11.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 11:11:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqiomqk2yu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253986>



On 7/21/2014 11:29 PM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Use `git_config_get_string()` instead of `git_config()` to take advantage of
>> the config-set API which provides a cleaner control flow.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  branch.c | 24 ++++--------------------
>>  1 file changed, 4 insertions(+), 20 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 46e8aa8..827307f 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -140,33 +140,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>>  	return 0;
>>  }
>>  
>> -struct branch_desc_cb {
>> -	const char *config_name;
>> -	const char *value;
>> -};
>> -
>> -static int read_branch_desc_cb(const char *var, const char *value, void *cb)
>> -{
>> -	struct branch_desc_cb *desc = cb;
>> -	if (strcmp(desc->config_name, var))
>> -		return 0;
>> -	free((char *)desc->value);
>> -	return git_config_string(&desc->value, var, value);
>> -}
>> -
>>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>>  {
>> -	struct branch_desc_cb cb;
>> +	const char *v = NULL;
>>  	struct strbuf name = STRBUF_INIT;
>>  	strbuf_addf(&name, "branch.%s.description", branch_name);
>> -	cb.config_name = name.buf;
>> -	cb.value = NULL;
>> -	if (git_config(read_branch_desc_cb, &cb) < 0) {
>> +	if (git_config_get_string(name.buf, &v)) {
>>  		strbuf_release(&name);
>>  		return -1;
>>  	}
>> -	if (cb.value)
>> -		strbuf_addstr(buf, cb.value);
>> +	strbuf_addstr(buf, v);
>> +	free((char*)v);
> 
> In this cast, I smell an API mistake to insist an extra constness to
> the output parameter of git_config_get_string() in [3/4] of the
> previous series.  Unlike the underlying git_config_get_value(),
> which lets the caller peek into the internal cached copy, the caller
> of git_config_get_string() is given its own copy, and I do not
> offhand see a good reason to forbid the caller from modifying it.
>

I modeled git_config_get_string() on the previously existing API function
git_config_string() with the signature,
int git_config_string(const char **dest, const char *var, const char *value).

But after writing this series I do think there isn't a good reason to
keep the constness in the new function also since the dest is given
its own copy.


>>  	strbuf_release(&name);
>>  	return 0;
>>  }
