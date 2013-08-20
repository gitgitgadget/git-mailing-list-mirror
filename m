From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 20:57:16 +0200
Message-ID: <5213BC0C.6090901@web.de>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org> <52138686.1070304@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:57:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBr7S-0001mR-BM
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab3HTS50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:57:26 -0400
Received: from mout.web.de ([212.227.15.14]:61932 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3HTS5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:57:25 -0400
Received: from [192.168.2.102] ([79.253.175.147]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MOAjQ-1V8XCB3A4C-005Yge for <git@vger.kernel.org>;
 Tue, 20 Aug 2013 20:57:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <52138686.1070304@googlemail.com>
X-Provags-ID: V03:K0:NHA5QG+X9vKg9xFcxg5ZbsTJZ/HugtfX/OI3gKR5JVANHtCVi0Z
 4/86cNpD0h4b7m7iE9eU2iWGI6t/2vijR7jOKTX6GnJkqmNZHlUQyxrj0ZdJuzpoHBOhVoU
 yrzCmpT+ECCGGGO0I4TL6ZrE1oQ2XNPsOLnPHQzFHP/5rH+fNm4x8Xk2AAJZtXFIGYhKqk5
 09KuY78nUPSijQ+XJ9Mmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232631>

Am 20.08.2013 17:08, schrieb Stefan Beller:
> On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>>
>> Are the long forms of options your invention?
>
> I tried to keep strong similarity with the shell script for
> ease of review. In the shellscript the options where
> put in variables having these names, so for example there was:
>
> 	-f)	no_reuse=--no-reuse-delta ;;
> 	-F)	no_reuse=--no-reuse-object ;;
>
> So I used these variable names as well in here. And as I assumed
> the variables are meaningful in itself.
>
> In the shell script they may be meaningful, but with the option
> parser in the C version, I overlooked the possibility for
> --no-<option> being possible as you noted below.
>
> Maybe we should inverse the logic and have the variables and options
> called reuse-delta and being enabled by default.

That's what git repack-objects does, which gets it passed to eventually.

But I think Johannes also wanted to point out that the git-repack.sh 
doesn't recognize --no-reuse-delta, --all etc..  I think it's better to 
introduce new long options in a separate patch.  Switching the 
programming language is big enough of a change already. :)

>>> +        OPT_BOOL('f', "no-reuse-delta", &no_reuse_delta,
>>> +                N_("pass --no-reuse-delta to git-pack-objects")),
>>> +        OPT_BOOL('F', "no-reuse-object", &no_reuse_object,
>>> +                N_("pass --no-reuse-object to git-pack-objects")),
>>
>> Do we want to allow --no-no-reuse-delta and --no-no-reuse-object?
>
> see above, I'd try not to.

The declaration above allows --reuse-delta, --no-reuse-delta and 
--no-no-reuse-delta to be used.  The latter looks funny, but I don't 
think we need to forbid it.  That said, dropping the no- and thus 
declaring them the same way as repack-objects is a good idea.

>>
>>> +        OPT_BOOL('n', NULL, &no_update_server_info,
>>> +                N_("do not run git-update-server-info")),
>>
>> No long option name?
>
> This is also a negated option, so as above, maybe
> we could have --update_server_info and --no-update_server_info
> respectively. Talking about the shortform then: Is it possible to
> negate the shortform?

Words in long options are separated by dashes, so --update-server-info. 
  The no- prefix is provided for free by parseopt, unless the flag 
PARSE_OPT_NONEG is given.

There is no automatic way to provide a short option that negates another 
short option.  You can build such a pair explicitly using OPTION_BIT and 
OPTION_NEGBIT or with OPTION_SET_INT and different values.

>>> +    if (pack_everything + pack_everything_but_loose == 0) {
>>> +        argv_array_push(&cmd_args, "--unpacked");
>>> +        argv_array_push(&cmd_args, "--incremental");
>>> +    } else {
>>> +        struct string_list fname_list = STRING_LIST_INIT_DUP;
>>> +        get_pack_filenames(packdir, &fname_list);
>>> +        for_each_string_list_item(item, &fname_list) {
>>> +            char *fname;
>>> +            fname = mkpathdup("%s/%s.keep", packdir, item->string);
>>> +            if (stat(fname, &statbuffer) && S_ISREG(statbuffer.st_mode)) {

"t7700-repack.sh --valgrind" fails and flags that line...

>>
>>             if (!stat(fname, &statbuffer) && ...

... but with this fix it runs fine.  I suspect that explains you 
sporadic test failures.

>>
>> But you are using file_exists() later. That should be good enough here
>> as well, no?
>
> will do.
