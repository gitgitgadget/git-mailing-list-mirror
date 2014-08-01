From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set
 API
Date: Fri, 01 Aug 2014 14:34:47 +0530
Message-ID: <53DB582F.8040501@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>	<vpqr411bhd5.fsf@anie.imag.fr> <53DA7C23.3090603@gmail.com>	<vpqa97p8koq.fsf@anie.imag.fr> <53DA8A54.6060208@gmail.com> <vpqoaw55q16.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 01 11:04:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD8lm-000308-0u
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 11:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaHAJEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 05:04:53 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:52867 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbaHAJEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 05:04:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so5443979pac.32
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4iwDJoG56CTcvtrDnzp5xLkHtM9Woi6JQO4cd35BrYk=;
        b=ehFaa18O8NEBBNbL9Cyinz1VLkXye0zbcUmFnnKAxOeyIhxEzj0ceJi7pBP6zTAEDw
         y/u6Cau4BJGE9vlEH1eB9jqgS8CFYSmkmc3X+t7NRAr7vsKKPCk0t+MGjS3uHlKGYqM2
         QtFZJgff9gx8oz/VHG464r5CUFm9IYofIv1hg2LnB9i1mBzLXAy8MqCnJg/vABdh93GN
         w7uKFe0BZ90/v9LJw3MZh1KCyDcQYOtKbQEUgpdrbqw9JBzZA/EM+tpHOx2giVxfC+mK
         gO60HNBq/z5kpQrAsyDRjmLOO8k283X6ZeRpk01FF7shZ0fxqeZ1UfVNIWaWx16lWUez
         pl6A==
X-Received: by 10.66.154.200 with SMTP id vq8mr4287016pab.69.1406883890904;
        Fri, 01 Aug 2014 02:04:50 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.231.102])
        by mx.google.com with ESMTPSA id hu11sm12085624pdb.53.2014.08.01.02.04.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 02:04:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqoaw55q16.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254624>



On 8/1/2014 12:11 AM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 7/31/2014 11:39 PM, Matthieu Moy wrote:
>>
>>> This is the part I find weird. You're calling git_die_config_exact() on
>>> the first boggus value, and git_die_config_exact() will notify an error
>>> at the line of the last boggus value.
>>
>> Hmn, we may have some confusion here. I meant the implementation of
>> git_config_exact() to look like this,
>>
>> void git_die_config_exact(const char *key, const char *value)
>> {
>> 	int i;
>> 	const struct string_list *values;
>> 	struct key_value_info *kv_info;
>> 	values = git_config_get_value_multi(key);
>> 	for (i = 0; i < values.nr; i++) {
>> 		kv_info = values->items[i].util;
>> 		/* A null check will be here also */
>> 		if (!strcmp(value, values->items[i].string)) {
>> 			if (!kv_info->linenr)
>> 				die(_("unable to parse '%s' from command-line config"), key);
>> 			else
>> 				die(_("bad config variable '%s' at file line %d in %s"),
>> 					key,
>> 					kv_info->linenr,
>> 					kv_info->filename);
>> 		}
>> 	}
>> }
>>
>> The above code would print the info on first bogus value.
> 
> OK, I got confused because git_die_config() errors out at the first
> error. So, your version works, but I do not see any added value in this
> extra complexity.
> 
> To be cleary, my version would be
> 
> NORETURN static /* not sure about the "static" */
> void git_die_config_linenr(const char *key,
>                            const char *filename, int linenr)
> {
> 	if (!linenr)
> 		die(_("unable to parse '%s' from command-line config"), key);
> 	else
> 		die(_("bad config variable '%s' at file line %d in %s"),
> 			key,
> 			linenr,
> 			filename);
> }
> 
> (hmm, I actually do not need the value, it's not printed)
> 
> NORETURN
> void git_die_config(const char *key)
> {
> 	const struct string_list *values;
> 	struct key_value_info *kv_info;
> 	values = git_config_get_value_multi(key);
> 	kv_info = values->items[values->nr - 1].util;
> 	git_die_config_linenr(key, kv_info->linenr, kv_info->filename);
> }
> 
> (we forgot the NORETURN in previous version BTW. It should be there in
> both functions here and in the .h file)
> 
> In my version, git_die_config uses git_die_config_linenr, and there's no
> issue with first/last boggus value. Callers of git_die_config_linenr
> have all the information to call it directly.
> 
> There are 3 code path that leads to the final die() calls, and having
> this little helper allows making sure the messages are the same for
> every callers, by construction (as opposed to cut-and-pasting).
> 
> Really, I don't see any reason to do anything more complex.
>

Thanks, I am sending your version with the reroll.
Also, for clarity the multi value use case would look like,

	struct key_value_info *kv_info;
	if (load_config_refs) {
		values = git_config_get_value_multi("notes.displayref");
		if (values) {
			for (i = 0; i < values->nr; i++) {
				if (!values->items[i].string) {
					config_error_nonbool("notes.displayref");
					kv_info = values->items[i].util;
					git_die_config_linenr("notes.displayref",
							      kv_info->filename,
							      kv_info->linenr);
				}
				else
					string_list_add_refs_by_glob(&display_notes_refs,
								     values->items[i].string);
			}
		}
	}

with my function it would have looked like,

	if (load_config_refs) {
		values = git_config_get_value_multi("notes.displayref");
		if (values) {
			for (i = 0; i < values->nr; i++) {
				if (!values->items[i].string) {
					config_error_nonbool("notes.displayref");
					git_die_config_exact("notes.displayref", values->items[i].string);
				}
				else
					string_list_add_refs_by_glob(&display_notes_refs,
								     values->items[i].string);
			}
		}
	}

Thanks.
