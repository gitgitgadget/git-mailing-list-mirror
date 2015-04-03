From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 2/4] cat-file: teach cat-file a '--literally' option
Date: Fri, 03 Apr 2015 21:55:47 +0530
Message-ID: <551EBF0B.3060401@gmail.com>
References: <551D1F99.5040306@gmail.com>	<1427972382-15477-1-git-send-email-karthik.188@gmail.com> <xmqqd23mjqkm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye4Pt-0008Pv-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 18:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbbDCQZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 12:25:53 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36783 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbDCQZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 12:25:52 -0400
Received: by pdea3 with SMTP id a3so74604897pde.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ac06RTK6hzxNcG2Hj+NwPSFk0ySuS+hteCTLDPdOVh0=;
        b=FV3MNK9Vf6cOOhPFOHyw8/S+/uWo2R9x7Q4QqPLf9RSOb+E25QoiasAeGSJUwsVnbX
         mSBDK5mGsENKEzag00UzAMnhC/HSSkl35vip5ryz2qxX+NPl/WxvH1j1N7JeQolQt3l5
         26PFVmQRg0y5DjLexB+p1D7H3KsWa6GBdbyFVciXr1eA6xP0YioSjzNStLN2OFNi+lUJ
         4wG7JLBGw+FOEG9aDLLMfI8yA7U6SRgV3uAkAMmxVLt+S+ZJkAic2YnrVOUnFjbPuhKj
         7Yg2n2wLtsQPhB234lq2xROWnif+H+WIL2G8/OpkR3COSCDLNbSTzYfGUb25J5ZIQEOR
         IWPw==
X-Received: by 10.68.180.3 with SMTP id dk3mr5480997pbc.103.1428078351809;
        Fri, 03 Apr 2015 09:25:51 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id e4sm8539011pdi.64.2015.04.03.09.25.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 09:25:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqd23mjqkm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266714>



On 04/03/2015 12:38 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Currently 'git cat-file' throws an error while trying to
>> print the type or size of a broken/corrupt object which is
>> created using 'git hash-object --literally'. This is
>> because these objects are usually of unknown types.
>>
>> Teach git cat-file a '--literally' option where it prints
>> the type or size of a broken/corrupt object without throwing
>> an error.
>>
>> Modify '-t' and '-s' options to call sha1_object_info_extended()
>> directly to support the '--literally' option.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco
>
> s/$/.com/ perhaps?
Definitely!
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   builtin/cat-file.c | 38 +++++++++++++++++++++++++++++---------
>>   1 file changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index df99df4..91ceae0 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -9,13 +9,20 @@
>>   #include "userdiff.h"
>>   #include "streaming.h"
>>
>> -static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>> +static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>> +			int literally)
>>   {
>>   	unsigned char sha1[20];
>>   	enum object_type type;
>>   	char *buf;
>>   	unsigned long size;
>>   	struct object_context obj_context;
>> +	struct object_info oi = {NULL};
>> +	struct strbuf sb = STRBUF_INIT;
>> +	unsigned flags = LOOKUP_REPLACE_OBJECT;
>> +
>> +	if (literally)
>> +		flags |= LOOKUP_LITERALLY;
>>
>>   	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>>   		die("Not a valid object name %s", obj_name);
>> @@ -23,16 +30,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>>   	buf = NULL;
>>   	switch (opt) {
>>   	case 't':
>> -		type = sha1_object_info(sha1, NULL);
>> -		if (type > 0) {
>> -			printf("%s\n", typename(type));
>> +		oi.typep = &type;
>> +		oi.typename = &sb;
>> +		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
>> +			die("git cat-file: could not get object info");
>> +		if (type >= 0 && sb.len) {
>> +			printf("%s\n", sb.buf);
>> +			strbuf_release(&sb);
>>   			return 0;
>>   		}
>>   		break;
>>
>>   	case 's':
>> -		type = sha1_object_info(sha1, &size);
>> -		if (type > 0) {
>> +		oi.typep = &type;
>> +		oi.typename = &sb;
>> +		oi.sizep = &size;
>> +		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
>> +			die("git cat-file: could not get object info");
>> +		if (type >= 0 && sb.len) {
>>   			printf("%lu\n", size);
>>   			return 0;
>>   		}
>> @@ -323,7 +338,7 @@ static int batch_objects(struct batch_options *opt)
>>   }
>>
>>   static const char * const cat_file_usage[] = {
>> -	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
>> +	N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
>>   	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
>>   	NULL
>>   };
>> @@ -359,6 +374,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>   	int opt = 0;
>>   	const char *exp_type = NULL, *obj_name = NULL;
>>   	struct batch_options batch = {0};
>> +	int literally = 0;
>>
>>   	const struct option options[] = {
>>   		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
>> @@ -369,6 +385,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>   		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>>   		OPT_SET_INT(0, "textconv", &opt,
>>   			    N_("for blob objects, run textconv on object's content"), 'c'),
>> +		OPT_BOOL( 0, "literally", &literally,
>> +			  N_("get information about corrupt objects for debugging Git")),
>>   		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
>>   			N_("show info and content of objects fed from the standard input"),
>>   			PARSE_OPT_OPTARG, batch_option_callback },
>> @@ -380,7 +398,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>
>>   	git_config(git_cat_file_config, NULL);
>>
>> -	if (argc != 3 && argc != 2)
>> +	if (argc < 2 || argc > 4)
>>   		usage_with_options(cat_file_usage, options);
>>
>>   	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
>> @@ -405,5 +423,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>   	if (batch.enabled)
>>   		return batch_objects(&batch);
>>
>> -	return cat_one_file(opt, exp_type, obj_name);
>> +	if (literally && opt != 't' && opt != 's')
>> +		die("git cat-file --literally: use with -s or -t");
>> +	return cat_one_file(opt, exp_type, obj_name, literally);
>>   }
