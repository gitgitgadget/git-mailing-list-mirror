From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Sat, 21 Mar 2015 21:40:18 +0800
Message-ID: <CACRoPnThLStsBo3XH7AjZ5W+8G1G3M-tPr=fKGvduykykDoQCQ@mail.gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
	<xmqqpp86kkn9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 14:41:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZJe4-0003M0-0r
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 14:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbCUNkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 09:40:21 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34115 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbCUNkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 09:40:20 -0400
Received: by lbbsy1 with SMTP id sy1so92434971lbb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mE4ZbZGX2950BHNyYfZBXAw3aDkdwj/94yG7YkRZW88=;
        b=HMXEy62wXvFQxyWjaDpigSgnofI6lJpi3sbLqb+SK9DpuUQXa208Z/Z08JBrdC1HBg
         9fLSaMKXp5zemx4z+A48QQY6ttaOzc70FdvafTIzBTIfSjdcyhHwa29HdCkWb4/9quVp
         61RypBjNyt2ZCYxTq+gOBQ4dF1HY3C59VTosXVs8/0cYwA3VACUd2ElkUGx3MW3RlzYA
         bxk8O8pLt7zbai2EsTAUdb1rJQ202ySg6jK57jFuQceRLVeMoWe0VEuscd1CI2ro5N8Q
         +XOhBBJ2UaQd3A0M0y9uK50r41VIOr4Wg32YXl0/T615q/81EJoU71lu/cylbp7qv4xJ
         nR2w==
X-Received: by 10.112.44.132 with SMTP id e4mr76618768lbm.66.1426945218557;
 Sat, 21 Mar 2015 06:40:18 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sat, 21 Mar 2015 06:40:18 -0700 (PDT)
In-Reply-To: <xmqqpp86kkn9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266022>

Hi,

On Thu, Mar 19, 2015 at 6:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> +/* Global vars since they are used often */
>> +static char *head_name;
>> +static const char *head_name_short;
>> +static unsigned char head_sha1[20];
>> +static int head_flags;
>> +
>> +enum rebase_type {
>> +     REBASE_FALSE = 0,
>> +     REBASE_TRUE = 1,
>> +     REBASE_PRESERVE = 2
>> +};
>> +
>> +/**
>> + * Parse rebase config/option value and return corresponding int
>> + */
>> +static int parse_rebase(const char *arg)
>> +{
>> +     if (!strcmp(arg, "true"))
>> +             return REBASE_TRUE;
>> +     else if (!strcmp(arg, "false"))
>> +             return REBASE_FALSE;
>> +     else if (!strcmp(arg, "preserve"))
>> +             return REBASE_PRESERVE;
>> +     else
>> +             return -1; /* Invalid value */
>> +}
>
> Even though the original does not use bool-or-string-config, we
> would want to do the same by doing something like
>
>         case (config_maybe_bool()) {
>         case 0:
>                 return REBASE_FALSE;
>         case 1:
>                 return REBASE_TRUE;
>         default:
>                 if (!strcmp(arg, "preserve"))
>                         return REBASE_PRESERVE;
>                 return -1;
>         }
>
> and then use that in rebase_config_default().

If you mean letting "yes", "on", "no", "off" be accepted on the
command line as well, then yes I guess it will be a good idea.

>
>> +
>> +/**
>> + * Returns default rebase option value
>> + */
>> +static int rebase_config_default(void)
>> +{
>> +     struct strbuf name = STRBUF_INIT;
>> +     const char *value = NULL;
>> +     int boolval;
>> +
>> +     strbuf_addf(&name, "branch.%s.rebase", head_name_short);
>> +     if (git_config_get_value(name.buf, &value))
>> +             git_config_get_value("pull.rebase", &value);
>
> What happens when neither is defined?
>
>> +     strbuf_release(&name);
>> +     if (!value)
>> +             return REBASE_FALSE;
>
> Hmph, are you sure about this?  Isn't this "[pull] rebase" that does
> not have "= value", in which case pull.rebase is "true"?
>
> You cannot use NULL as the sentinel value to tell that you did not
> find either branch.*.rebase nor pull.rebase (in which case you want
> to default to 'false').  Either of them can be spelled as an
> equal-less true, which you will see as value==NULL, and you want to
> take that as 'true'.
>
>         const char *value = "false";
>         ...
>         if (get_value(..., &value))
>                 get_value(..., &value));
>         strbuf_release(&name);
>         if (!value)
>                 return REBASE_TRUE;
>         return parse_rebase(value);
>
> or something along that line, perhaps?

Whoops, didn't take into account the possibility that the config value
could be NULL. Thanks.

>
>> +     boolval = git_config_maybe_bool("pull.rebase", value);
>> +     if (boolval >= 0)
>> +             return boolval ? REBASE_TRUE : REBASE_FALSE;
>> +     else if (value && !strcmp(value, "preserve"))
>> +             return REBASE_PRESERVE;
>
> Is value something you need to free before returning from this
> function?

>From my reading if config.c, the memory of value comes from the
config_set the_config_set (the config cache), so there is no need to
free it.

>
>> +static int parse_opt_recurse_submodules(const struct option *opt, const char *arg, int unset)
>> +{
>> +     if (!arg)
>> +             *(int *)opt->value = unset ? RS_NO : RS_YES;
>> +     else if (!strcmp(arg, "no"))
>> +             *(int *)opt->value = RS_NO;
>> +     else if (!strcmp(arg, "yes"))
>> +             *(int *)opt->value = RS_YES;
>> +     else if (!strcmp(arg, "on-demand"))
>> +             *(int *)opt->value = RS_ON_DEMAND;
>> +     else
>> +             return -1;
>> +     return 0;
>
> I suspect that maybe-bool-or-string comment applies equally here for
> the UI consistency.

Yup, I'll keep that in mind.

> I'll stop here for now.  Thanks.

Thanks.
