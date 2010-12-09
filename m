From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Fri, 10 Dec 2010 00:07:50 +0100
Message-ID: <4D016146.9010907@web.de>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino> <4CDD391C.2000905@web.de> <7vei9qfxzy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 00:08:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQpan-0000q0-Tj
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 00:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab0LIXH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:07:59 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:37134 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab0LIXH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:07:58 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 19A9A18CDFDF6;
	Fri, 10 Dec 2010 00:07:57 +0100 (CET)
Received: from [93.240.98.155] (helo=[192.168.178.51])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PQpaf-0006PY-00; Fri, 10 Dec 2010 00:07:57 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vei9qfxzy.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/Ne/HL0IbL3qu+Ol0ZT8pnGxgnaaVLqI4ZBkCQ
	g57q25Z3sATt60xCKTr5VrrDMh5fVKw+BkHfIyZ9g6cffFZcKQ
	ENLZfuh+fx/J9CfnQXSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163355>

Am 09.12.2010 22:16, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Until now you had to call "git submodule update" (without -N|--no-fetch
>> option) or something like "git submodule foreach git fetch" to fetch
>> new commits in populated submodules from their remote.
>> ...
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index d35f000..db3fba3 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> ...
>> @@ -784,28 +790,36 @@ static int add_remote_or_group(const char *name, struct string_list *list)
>>  	return 1;
>>  }
>>
>> -static int fetch_multiple(struct string_list *list)
>> +static void add_options_to_argv(int *argc, const char **argv)
>>  {
>> -	int i, result = 0;
>> -	const char *argv[11] = { "fetch", "--append" };
>> -...
>> +static int fetch_multiple(struct string_list *list)
>> +{
>> +	int i, result = 0;
>> +	const char *argv[12] = { "fetch", "--append" };
> 
> This used to be 11; are we adding something new?  Ahh, possibly
> "--recurse_submodules".

Yup, that's why! (see a few lines down between "--keep" and "-v").

>> diff --git a/submodule.c b/submodule.c
>> index 91a4758..4d9b774 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -63,7 +63,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>>  	}
>>  }
>>
>> -static int submodule_config(const char *var, const char *value, void *cb)
>> +int submodule_config(const char *var, const char *value, void *cb)
>>  {
>>  	if (!prefixcmp(var, "submodule."))
>>  		return parse_submodule_config_option(var, value);
>> @@ -229,6 +229,70 @@ void show_submodule_summary(FILE *f, const char *path,
>>  	strbuf_release(&sb);
>>  }
>>
>> +int fetch_populated_submodules(int num_options, const char **options,
>> +			       const char *prefix, int quiet)
>> +{
>> +	int i, result = 0, argc = 0;
>> +	struct child_process cp;
>> +	const char **argv;
>> +	struct string_list_item *name_for_path;
>> +	const char *work_tree = get_git_work_tree();
>> +	if (!work_tree)
>> +		return 0;
>> +
>> +	if (!the_index.initialized)
>> +		if (read_cache() < 0)
>> +			die("index file corrupt");
>> +
>> +	argv = xcalloc(num_options + 5, sizeof(const char *));
> 
> Where is this '5' coming from?  "fetch" "--submodule-prefix", the prefix,
> and the terminating NULL?  What did I miss?

No, you didn't miss anything but I have been off by one ... '4' is
sufficient here.
