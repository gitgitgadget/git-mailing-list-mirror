From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v14 24/40] receive-pack.c: use a reference transaction for
 updating the refs
Date: Wed, 11 Jun 2014 11:44:41 -0700
Message-ID: <CAL=YDWn8gFep1Hhp2gnQsd4PCuRT+vBb6wBcsbL9Sjriyf-ePw@mail.gmail.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
	<1402093758-3162-25-git-send-email-sahlberg@google.com>
	<20140610231841.GC8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 20:45:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WunW6-0006tn-QY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 20:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbaFKSoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 14:44:44 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:45177 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbaFKSom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 14:44:42 -0400
Received: by mail-ve0-f173.google.com with SMTP id db11so347527veb.4
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n7YCq2Y/Q13lNdtbFbiTydzWcmC8uOUBuf9NKMSHQNk=;
        b=Ldni5z/U1XMLHzzDypAHumuGIGwW55BAiqzy6qrECC5KtWNLFewyqyiX80R7B22UTA
         1N610gFme6Y+1ujw+QZdGmtOMisf2/2Q5Z8rgPOUxxd/MN1+vJ2jtPL3ktFWZUt35zjX
         wOazzu+VtAUflf7+Wgwjwe2kWD7PJolD/AnXabDyvjPAk1YHJaovMEc/UkkmGehhmhSs
         W3HwZNYZwXJOkqSlDgovKAQ1cXHgtjn5yiiFf8xXu1JAlPsVCLATn2/x8wujin4aOArV
         E+claHFfJuwu6w9wO7TieSVIs9pncNCRaiE4B4dsAYoeeaWKZrR1re2Q/1JhzV7Rt4wD
         x5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n7YCq2Y/Q13lNdtbFbiTydzWcmC8uOUBuf9NKMSHQNk=;
        b=BGBM17yvazRZ2UsDtoPjJZiG5Gq78ohRJ0E3OnhnEcPvWGK8VbdWUGAIF3E5qgUhbJ
         CrMioo/klB4zAjqwQfTnTWb88jCmK1ygJHkW65mlSDhfa2bofcdHVYnbs03ztvcq9+Rp
         F5Go5jl57jIUlaN1mL6rEjNFWNj5XAFdCPIjJ3HiwFe5fI7cUGHGLx9fHSJqCLWUagPv
         Xc6mJgzf4jY4D5KI2n0LppzP32JwKVnFdtRXK4QUK742M7ZzlCt3oycouv20NAK+Zxa8
         GxYwis20f/9vuJDR6knKprYfnM7cf4W7aG/StN8bBRgen8CZfhf9Vyn3ukTBvJxnbgPH
         oFlw==
X-Gm-Message-State: ALoCoQm+cquvWeYajfy4o0futzQosfEEE/aNFG5iECwdCJ+L6PVWsSP+H52+HSor/AwQOpHEcQoW
X-Received: by 10.52.164.70 with SMTP id yo6mr1657333vdb.67.1402512281707;
 Wed, 11 Jun 2014 11:44:41 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 11 Jun 2014 11:44:41 -0700 (PDT)
In-Reply-To: <20140610231841.GC8557@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251381>

Thanks.

Done.
I added a function to stop leaking commands too.

On Tue, Jun 10, 2014 at 4:18 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -46,6 +46,7 @@ static void *head_name_to_free;
>>  static int sent_capabilities;
>>  static int shallow_update;
>>  static const char *alt_shallow_file;
>> +static struct string_list error_strings = STRING_LIST_INIT_DUP;
> [...]
>> @@ -576,19 +576,31 @@ static const char *update(struct command *cmd, struct shallow_info *si)
> [...]
>> +             transaction = ref_transaction_begin(&err);
>> +             if (!transaction ||
>> +                 ref_transaction_update(transaction, namespaced_name,
>> +                                        new_sha1, old_sha1, 0, 1, &err) ||
>> +                 ref_transaction_commit(transaction, "push", &err)) {
>> +
>> +                     const char *str;
>> +                     string_list_append(&error_strings, err.buf);
>> +                     str = error_strings.items[error_strings.nr - 1].string;
> [...]
>> +                     return str;
> [...]
>> @@ -1215,5 +1227,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>>               packet_flush(1);
>>       sha1_array_clear(&shallow);
>>       sha1_array_clear(&ref);
>> +     string_list_clear(&error_strings, 0);
>>       return 0;
>
> I think it's okay to let error strings accumulate like this because
> there will not be too many of them.  Still I wonder, would it work to
> change the convention to transfer ownership of the string to the caller?
>
> Ultimately 'commands' is leaked so we could even avoid the strdups but
> I'd rather leave it possible to clean up.
>
> Something like this:
>
> diff --git i/builtin/receive-pack.c w/builtin/receive-pack.c
> index 13f4a63..d8ab7b2 100644
> --- i/builtin/receive-pack.c
> +++ w/builtin/receive-pack.c
> @@ -46,7 +46,6 @@ static void *head_name_to_free;
>  static int sent_capabilities;
>  static int shallow_update;
>  static const char *alt_shallow_file;
> -static struct string_list error_strings = STRING_LIST_INIT_DUP;
>
>  static enum deny_action parse_deny_action(const char *var, const char *value)
>  {
> @@ -195,7 +194,7 @@ static void write_head_info(void)
>
>  struct command {
>         struct command *next;
> -       const char *error_string;
> +       char *error_string;
>         unsigned int skip_update:1,
>                      did_not_exist:1;
>         int index;
> @@ -469,7 +468,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>         return 0;
>  }
>
> -static const char *update(struct command *cmd, struct shallow_info *si)
> +static char *update(struct command *cmd, struct shallow_info *si)
>  {
>         const char *name = cmd->ref_name;
>         struct strbuf namespaced_name_buf = STRBUF_INIT;
> @@ -589,12 +588,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>                                            new_sha1, old_sha1, 0, 1, &err) ||
>                     ref_transaction_commit(transaction, "push", &err)) {
>
> -                       const char *str;
> -                       string_list_append(&error_strings, err.buf);
> -                       str = error_strings.items[error_strings.nr - 1].string;
> -                       strbuf_release(&err);
> -
> +                       char *str = strbuf_detach(&err, NULL);
>                         ref_transaction_free(transaction);
> +
>                         rp_error("%s", str);
>                         return str;
>                 }
> @@ -659,6 +655,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
>         char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
>         int flag;
>
> +       if (cmd->error_string)
> +               die("BUG: check_alised_update called with failed cmd");
> +
>         strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
>         dst_name = resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
>         strbuf_release(&buf);
> @@ -670,7 +669,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
>         if (!dst_name) {
>                 rp_error("refusing update to broken symref '%s'", cmd->ref_name);
>                 cmd->skip_update = 1;
> -               cmd->error_string = "broken symref";
> +               cmd->error_string = xstrdup("broken symref");
>                 return;
>         }
>
> @@ -696,8 +695,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
>                  cmd->ref_name, cmd_oldh, cmd_newh,
>                  dst_cmd->ref_name, dst_oldh, dst_newh);
>
> -       cmd->error_string = dst_cmd->error_string =
> -               "inconsistent aliased update";
> +       cmd->error_string = xstrdup("inconsistent aliased update");
> +       free(dst_cmd->error_string);
> +       dst_cmd->error_string = xstrdup("inconsistent aliased update");
>  }
>
>  static void check_aliased_updates(struct command *commands)
> @@ -745,7 +745,9 @@ static void set_connectivity_errors(struct command *commands,
>                 if (!check_everything_connected(command_singleton_iterator,
>                                                 0, &singleton))
>                         continue;
> -               cmd->error_string = "missing necessary objects";
> +               if (cmd->error_string)  /* can't happen */
> +                       continue;
> +               cmd->error_string = xstrdup("missing necessary objects");
>         }
>  }
>
> @@ -782,9 +784,9 @@ static void reject_updates_to_hidden(struct command *commands)
>                 if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
>                         continue;
>                 if (is_null_sha1(cmd->new_sha1))
> -                       cmd->error_string = "deny deleting a hidden ref";
> +                       cmd->error_string = xstrdup("deny deleting a hidden ref");
>                 else
> -                       cmd->error_string = "deny updating a hidden ref";
> +                       cmd->error_string = xstrdup("deny updating a hidden ref");
>         }
>  }
>
> @@ -798,8 +800,11 @@ static void execute_commands(struct command *commands,
>         struct iterate_data data;
>
>         if (unpacker_error) {
> -               for (cmd = commands; cmd; cmd = cmd->next)
> -                       cmd->error_string = "unpacker error";
> +               for (cmd = commands; cmd; cmd = cmd->next) {
> +                       if (cmd->error_string)  /* can't happen */
> +                               continue;
> +                       cmd->error_string = xstrdup("unpacker error");
> +               }
>                 return;
>         }
>
> @@ -812,8 +817,9 @@ static void execute_commands(struct command *commands,
>
>         if (run_receive_hook(commands, "pre-receive", 0)) {
>                 for (cmd = commands; cmd; cmd = cmd->next) {
> -                       if (!cmd->error_string)
> -                               cmd->error_string = "pre-receive hook declined";
> +                       if (cmd->error_string)
> +                               continue;
> +                       cmd->error_string = xstrdup("pre-receive hook declined");
>                 }
>                 return;
>         }
> @@ -1091,7 +1097,8 @@ static void update_shallow_info(struct command *commands,
>                 if (is_null_sha1(cmd->new_sha1))
>                         continue;
>                 if (ref_status[cmd->index]) {
> -                       cmd->error_string = "shallow update not allowed";
> +                       free(cmd->error_string);
> +                       cmd->error_string = xstrdup("shallow update not allowed");
>                         cmd->skip_update = 1;
>                 }
>         }
> @@ -1227,6 +1234,5 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>                 packet_flush(1);
>         sha1_array_clear(&shallow);
>         sha1_array_clear(&ref);
> -       string_list_clear(&error_strings, 0);
>         return 0;
>  }
