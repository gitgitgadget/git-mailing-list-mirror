From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Thu, 02 May 2013 01:25:05 +0530
Message-ID: <51817319.6060201@gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com> <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com> <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXd7b-0005Za-72
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab3EATzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:55:19 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:59562 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab3EATzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:55:17 -0400
Received: by mail-pd0-f181.google.com with SMTP id q10so970401pdj.12
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=sHbbtp0+Tbvj7PaOvTkXB28luvR7qqbgvEbng7rCN4w=;
        b=aStLjtekspub2fBMgBnbrnmS641L2RSrNf0rnVKTQaI8ESuPJQkd6EaVfo9N6DDUid
         P0beVNVUxvBrJ4pGnvhVuUgodfNGlR93Mrw9opoN4lTBnicBW331nbCEMNWfja/xrHbA
         yddUvNkkwsxlHkvtdi7NBQEy9pQKa2Jswja8o9e755Hi9crthkqDQzI+8mCOj5NbC5dZ
         jJFB4+KOjs7RDBRvz8EBlg/PpNhTx83arrKc5ZYD5fHInn88ARar+kRgVzaZw2Su66e+
         qcjrqjToj5ZFsD8SgYI5PPqZwichyP4er6mUskMYbW3bRUuq1jbpw+Zzsu11IrgrImr6
         9xVw==
X-Received: by 10.66.220.197 with SMTP id py5mr6542581pac.86.1367438116913;
        Wed, 01 May 2013 12:55:16 -0700 (PDT)
Received: from [192.168.1.109] (triband-mum-59.183.180.112.mtnl.net.in. [59.183.180.112])
        by mx.google.com with ESMTPSA id dr6sm4879548pac.11.2013.05.01.12.55.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 12:55:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223134>

On 01-05-2013 17:53, Ramkumar Ramachandra wrote:
> Vikrant Varma wrote:
>> Give better advice when trying to merge a branch that doesn't exist. If
>> the branch exists in any remotes, display a list of suggestions.
>
> Interesting.  Thanks for working on this.
>
> You say advice, but you're not invoking advise() or guarding the
> advice with an advice.* -- the advice is undoubtedly helpful, but not
> everyone wants to see it.
>

I agree with Matthieu, the people who don't want to see this advice 
never will, because they won't make that mistake. Maybe advice is the 
wrong word, corrections might be more appropriate.

>> diff --git a/help.c b/help.c
>> index 02ba043..faf18b9 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -7,6 +7,7 @@
>>   #include "string-list.h"
>>   #include "column.h"
>>   #include "version.h"
>> +#include "refs.h"
>>
>>   void add_cmdname(struct cmdnames *cmds, const char *name, int len)
>>   {
>> @@ -404,3 +405,46 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>>          printf("git version %s\n", git_version_string);
>>          return 0;
>>   }
>> +
>> +struct similar_ref_cb {
>
> I see that there are other structs in our codebase suffixing _cb, to
> indicate "callback data".  I normally reserve _cb for callback
> functions.

I'm following the convention (builtin/merge.c: struct append_ref_cb). If 
there's a better way to name it, I'll use that.

>> +static int append_similar_ref(const char* refname, const unsigned char *sha1, int flags, void *cb_data)
>> +{
>> +        int i;
>> +        struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
>> +        for (i = strlen(refname); refname[i] != '/'; i--)
>> +               ;
>
> Er, what is this?  A re-implementation of strrchr()?
>

Oh so that's what it's called. Apologies, will fix this.

>> +        /* A remote branch of the same name is deemed similar */
>> +        if (!prefixcmp(refname, "refs/remotes/") && !strcmp(refname + i + 1, cb->base_ref))
>> +               string_list_append(&(cb->similar_refs), refname + 13);
>
> What is 13?  Please use strlen("refs/remotes/") for readability.
>

Yes, will fix this too.

>> +void help_unknown_ref(const char* ref) {
>> +        int i;
>> +        struct similar_ref_cb ref_cb;
>> +        ref_cb.similar_refs = (struct string_list)STRING_LIST_INIT_NODUP;
>
> Why are you casting STRING_LIST_INIT_NODUP?
>
>> +        ref_cb.base_ref = ref;


ref_cb.similar_refs has already been defined. The compiler won't let me 
assign to it unless I cast first. However, I think compound literals are 
a C99/gcc feature. Is this better?

	struct similar_ref_cb ref_cb = {ref, STRING_LIST_INIT_NODUP};


>> +        if (ref_cb.similar_refs.nr > 0) {
>> +               fprintf_ln(stderr,
>> +                          Q_("\nDid you mean this?",
>> +                             "\nDid you mean one of these?",
>> +                             ref_cb.similar_refs.nr));
>
> Hm, why did you use Q_?
>

Q_ is a pluralization helper that picks one of the two strings based on 
ref_cb.similar_refs.nr. It's used in help.c:help_unknown_cmd for the 
same reason.

>> +               for (i = 0; i < ref_cb.similar_refs.nr; i++)
>> +                       fprintf(stderr, "\t%s\n", ref_cb.similar_refs.items[i].string);
>> +        }
>> +        exit(1);
>
> die() exits with 128, no?  Why are you exiting with 1 now?
>

Again, because help_unknown_cmd exited with 1. I've tried to follow the 
convention as laid down there. What's the significance of the error code 
for die()? When is it correct to use die(), and when to use error() 
followed by exit(128)?
