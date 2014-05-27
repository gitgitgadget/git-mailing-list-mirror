From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 42/44] refs.c: pass a skip list to name_conflict_fn
Date: Tue, 27 May 2014 11:37:43 -0700
Message-ID: <CAL=YDWn2HrTUnjKOCa4h6S0M9fxz6hfEgrLGCkvdaUvAD2fAcQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-43-git-send-email-sahlberg@google.com>
	<20140522192717.GU12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:37:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMFy-0001hz-Ez
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbaE0Shq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:37:46 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:50345 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaE0Sho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:37:44 -0400
Received: by mail-vc0-f175.google.com with SMTP id id10so7642134vcb.6
        for <git@vger.kernel.org>; Tue, 27 May 2014 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GP780NB6tTE2IUmlLT8COvb98mPrNvNEmQLhoPCLN0c=;
        b=RWQ+VpduTEV/wWvBU/RyWZljHWe4V9rukWEBfE5q4WZXKMbhm60ro71AX4OtDsvMkL
         WW9X2UpHoL7MmqbPErSEtupY2dY0hL09vSMHXY8ir9wyj+TC4sMvZJDtRvKk4zGQ6Gkj
         8VUbyO1xx/xE2uKbcN0AjpqR3DpOs1ujq62ul3TOh92v7ymtggnavLgUeHHVP9UcN3SC
         B8hI0/Mb2MrPNmkUycIhK42dSqZXWG1BU84QCSQZ93bcntTD4zdS/dRGeIsWiPrgPTGT
         TdejGFcIYFuB4gEHM/8RBYUe3CARF1bwLy+zKWS8aM0SL/bqE41OgzpwBsmv5q9MpFxB
         iTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GP780NB6tTE2IUmlLT8COvb98mPrNvNEmQLhoPCLN0c=;
        b=GmJfy3lknI/AunnJfB3B1yH6I5oTrvZMct5AZfdM4iuHvvq6pVbC9GbIUhehiAW16b
         WF5kW3V3o3pzx9wIqJ7X89T9dQdMULz2NYlBsA8P4vfqYzSg+7d0O6h26XhNvxeWmmyg
         XQQPXyKxj8w5GUMQt5+iljzmVNnnnLtz/ZjC7eEzEP++bR7i/FV4T3ApZtrDmD8xaHAZ
         Sn/BP9o6D5H9SXOMgwHcpHcB5pcAWKD0xOooDBOhYIYGAF6ZonMWwSNCj8Jff4bKVYK8
         Rh03Pf2z8hecX5IkihbE5VCdpy5x7abq0/Nk/gWWb+AVIVbR4L+Kp2dphKDc7D3H8bz2
         wM6A==
X-Gm-Message-State: ALoCoQkSN9pCwJLi8iPnD99VtcCpQZQzoCHC/W7WCNv2wjPCuZ5ITzFSpiIhr+1tuZBxwZZo0gGE
X-Received: by 10.220.160.67 with SMTP id m3mr2875473vcx.56.1401215863598;
 Tue, 27 May 2014 11:37:43 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 27 May 2014 11:37:43 -0700 (PDT)
In-Reply-To: <20140522192717.GU12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250184>

On Thu, May 22, 2014 at 12:27 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -798,11 +798,19 @@ struct name_conflict_cb {
>>       const char *refname;
>>       const char *oldrefname;
>>       const char *conflicting_refname;
>> +     const char **skip;
>> +     int skipnum;
>
> Would a struct string_list make sense here?  (See
> Documentation/technical/api-string-list.txt.)

It would. But it is better to do that change later.
Currently we have both repack_without_ref and repack_without_refs that
take the same char ** argument.
After next series we will have removed one of these functions and have
an easier API to modify (once we start tracking the skiplist as part
of the transaction instead).

Instead of doing this change and then redoing it once we move a lot of
the actual work from _commit  to _update
I will do this change towards the end of the next series.

>
> [...]
>>  };
>>
>>  static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>>  {
>>       struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
>> +     int i;
>> +     for(i = 0; i < data->skipnum; i++) {
>

Fixed.

> (style nit) missing space after 'for'.
>
>> +             if (!strcmp(entry->name, data->skip[i])) {
>> +                     return 0;
>> +             }
>
> Style: git tends to avoid braces around a single-line if/for/etc body.
>

Fixed.

> [...]
>> @@ -817,15 +825,21 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>>   * conflicting with the name of an existing reference in dir.  If
>>   * oldrefname is non-NULL, ignore potential conflicts with oldrefname
>>   * (e.g., because oldrefname is scheduled for deletion in the same
>> - * operation).
>> + * operation). skip contains a list of refs we want to skip checking for
>> + * conflicts with. Refs may be skipped due to us knowing that it will
>> + * be deleted later during a transaction that deletes one reference and then
>> + * creates a new conflicting reference. For example a rename from m to m/m.
>
> This example of "Refs may be skipped due to" seems overly complicated.
> Isn't the idea just that skip contains a list of refs scheduled for
> deletion in this transaction, since they shouldn't be treated as
> conflicts at all (for example when renamining m to m/m)?
>
> I wonder if there's some way to make use of the result of the naive
> refname_available check to decide what to do when creating a ref.
>
> E.g.: if a refname would be available except there's a ref being
> deleted in the way, we could do one of the following:
>
>  a. delete all relevant loose refs and perform the transaction in
>     packed-refs, or
>
>  b. order operations to avoid the D/F conflict, even with loose refs
>     (the hardest case is if the ref being deleted uses a directory
>     and we want to create a file with the same name.  But that's
>     still doable if we're willing to rmdir when needed as part of
>     the loop to commit changes)
>
> The packed-refs trick (a) seems much simpler, but either should work.
>
> This could be done e.g. by checking is_refname_available with an empty
> list first before doing the real thing with a list of exclusions.
>
> [...]
>> @@ -2592,6 +2609,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>       int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
>>       const char *symref = NULL;
>>
>> +     if (!strcmp(oldrefname, newrefname))
>> +             return 0;
>
> What is the intended result if I try to rename a nonexistent ref or an
> existent symref to its own name?

Yeah, I should get rid of that.

I have renoved the rename_ref patch and moved it to the next series.
I think we can solve this easier/better once we have the other patches in first.

>
> Sorry to be so fussy about this part.  It's not that I think that this
> change is trying to do something bad --- in fact, it's more the
> opposite, that I'm excited to see git learning to have a better
> understanding and handling of refname D/F conflicts.
>
> That would allow:
>
>  * "git fetch --prune" working as a single transaction even if
>    the repository being fetched from removed a refs/heads/topic
>    branch and created refs/heads/topic/1 and refs/heads/topic/2
>
>  * "git fast-import" and "git fetch --mirror" learning the same trick
>
>  * fewer code paths having to be touched to be able to (optionally)
>    let git actually tolerate D/F conflicts, for people who want to
>    have 'topic', 'topic/1', and 'topic/2' branches at the same time.
>    This could be turned on by default for remote-tracking refs.  It
>    would be especially nice for people on Windows and Mac OS where
>    there can be D/F conflicts that people on Linux didn't notice due
>    to case-sensitivity.
>
>    Longer term, through a configuration that starts turned off by
>    default and has the default flipped as more people have upgraded
>    git, this could make D/F conflicts in refnames stop being an error
>    altogether.
>
> So it's kind of exciting to see, even though it's fussy to get it
> right.
>
> Thanks,
> Jonathan
