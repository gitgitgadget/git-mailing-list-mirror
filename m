From: Keith McGuigan <kmcguigan@twopensource.com>
Subject: Re: [PATCH 1/1] Don't free remote->name after fetch
Date: Mon, 13 Jun 2016 20:14:43 -0400
Message-ID: <CALnYDJNS9QAtu37a76Q6N3C=GRbfgU8Xq3g7F1q7vX+b=rwOOA@mail.gmail.com>
References: <1465841837-31604-1-git-send-email-kmcguigan@twopensource.com>
	<xmqqbn34buak.fsf@gitster.mtv.corp.google.com>
	<CALnYDJO=_hfcQf+=+XuHQwmH4XewqHo4qggzB0rM79WVt+e6nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 02:15:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCc0d-00010B-3b
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 02:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423136AbcFNAOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 20:14:45 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37744 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423055AbcFNAOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 20:14:44 -0400
Received: by mail-it0-f42.google.com with SMTP id e5so55401024ith.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=K0RqYv/3mw+L6CNFz8iNhY7kIpKGUngPNcZwzQ4ymsw=;
        b=MHoLJ5+f1cnatKJpEoAdA1J9dOPGaAxFNjILq1IqC5P10KNabMP+c0voxp9hns+MKk
         /9z7foBoKVwyfmPpc6EvIcX+nSkoRSyENR5QFeNYuK3LgXX6Z0ZVx3hXIYH+QRcqFkne
         Oey39/oTla3/5hHkNE43xWLuPg2MbkLIG2ew6NgiOCPfb5UGNg/K/t+gcUl2DNXXoacO
         WHBETikfTIpOCRUEepwEHmpxcXkAmaviKwBQm9nZFgeQRH4UNUA4joAk/gWEalHto6ia
         Ojs8uzOTm9D5+EY0jTnljfWnkq+oj9mSBKQ5lVzFzypH35EE5EI45abI8VVcPzfNwrMS
         Fsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=K0RqYv/3mw+L6CNFz8iNhY7kIpKGUngPNcZwzQ4ymsw=;
        b=JTUJ0TgDP3of7EQinNmF/p5MlgiNzHPHFyf+u4EgoU5gt20hF1UjIcMR4LFlZpLrZ/
         XkxB6tkyplX6XTriRYOKjP+4RH3RjXlm/nG0LOqBWthwcTfLv6l0ux3s5QUo9rRY7M9/
         ul3ekwDsmpo5O5l21r2aNWvfu/bObvcm/SPJVB/QNM7xxQf2J4OrvuVlsE8OzIZu3ove
         /EYsROkEWsVMM9w45YwPa+ZQOC/eEfXAyxtXT1G8HpA8yPvbTkqabVmvd34+biO54WOP
         VnOmjR1Pgyd5lt5IH554TrzgQ2MyW1Le8FboXnlIcaN18veuUGE1w7EsLjzk+n0DUobi
         C4bw==
X-Gm-Message-State: ALyK8tLVayfvsgEQPhACISobfJUP3VBjB/OWhcekQ33gcyel4hn4oP/4xj9+HjAtgwgsrrubgZuV4ajc1p+ZYg==
X-Received: by 10.36.9.14 with SMTP id 14mr3852546itm.68.1465863283105; Mon,
 13 Jun 2016 17:14:43 -0700 (PDT)
Received: by 10.50.152.67 with HTTP; Mon, 13 Jun 2016 17:14:43 -0700 (PDT)
In-Reply-To: <CALnYDJO=_hfcQf+=+XuHQwmH4XewqHo4qggzB0rM79WVt+e6nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297260>

Right.  The string_list ends up getting (potentially) populated with a
mix of dup'd
and borrowed values.  I figured it was safer to leak here (especially
as we're on
the way out anyway), than free memory that shouldn't be freed.

Actually, what motivates this (and I apologize that I didn't say this
earlier) is that
we added (in our repo) a bit of stats collection code that executes after the
string_list_clear(), and calls remote_get() which goes all sideways when some of
its memory has been freed.

As an alternative, I could xstrdup each instance where remote->name is appended,
which would make the string_list a homogenous dup'd list, which we
could then free.
If you prefer that I'll do a re-roll in that style (it just seemed to
me at the time like
it would be doing some useless allocations).  I don't much mind either way.

--
- Keith

On Mon, Jun 13, 2016 at 6:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> kmcguigan@twopensource.com writes:
>
> > From: Keith McGuigan <kmcguigan@twopensource.com>
> >
> > The string_list gets populated with the names from the remotes[] array,
> > which are not dup'd and the list does not own.
> >
> > Signed-of-by: Keith McGuigan <kmcguigan@twopensource.com>
> > ---
>
> For names that come from remote_get()->name, e.g.
>
>     static int get_one_remote_for_fetch(struct remote *remote, void *priv)
>     {
>             struct string_list *list = priv;
>             if (!remote->skip_default_update)
>                     string_list_append(list, remote->name);
>             return 0;
>     }
>
> you are correct that this is borrowed memory we are not allowed to
> free.  But is borrowing from remote->name the only way this list is
> populated?  For example, what happens in add_remote_or_group(),
> which does this?
>
>     struct remote_group_data {
>             const char *name;
>             struct string_list *list;
>     };
>
>     static int get_remote_group(const char *key, const char *value, void *priv)
>     {
>             struct remote_group_data *g = priv;
>
>             if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
>                     /* split list by white space */
>                     while (*value) {
>                             size_t wordlen = strcspn(value, " \t\n");
>
>                             if (wordlen >= 1)
>                                     string_list_append(g->list,
>                                                        xstrndup(value, wordlen));
>
> This newly allocated piece of memory is held by g->list, which was...
>
>                             value += wordlen + (value[wordlen] != '\0');
>                     }
>             }
>
>             return 0;
>     }
>
>     static int add_remote_or_group(const char *name, struct string_list *list)
>     {
>             int prev_nr = list->nr;
>             struct remote_group_data g;
>             g.name = name; g.list = list;
>
> ... passed as a callback parameter from here.
>
>             git_config(get_remote_group, &g);
>             if (list->nr == prev_nr) {
>                     struct remote *remote = remote_get(name);
>                     if (!remote_is_configured(remote))
>                             return 0;
>                     string_list_append(list, remote->name);
>
> This makes remote->name borrowed, which we cannot free() as you
> point out.
>
>             }
>             return 1;
>     }
>
> So, while I agree that many should not be freed, this change makes
> the code leak some at the same time.
>
>
>
> >  builtin/fetch.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 630ae6a1bb78..181da5a2e7a3 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >               argv_array_clear(&options);
> >       }
> >
> > -     /* All names were strdup()ed or strndup()ed */
> > -     list.strdup_strings = 1;
> >       string_list_clear(&list, 0);
> >
> >       close_all_packs();

On Mon, Jun 13, 2016 at 8:11 PM, Keith McGuigan
<kmcguigan@twopensource.com> wrote:
> Right.  The string_list ends up getting (potentially) populated with a mix
> of dup'd
> and borrowed values.  I figured it was safer to leak here (especially as
> we're on
> the way out anyway), than free memory that shouldn't be freed.
>
> Actually, what motivates this, and I apologize that I didn't say this
> earlier, is that
> we added (in our repo) a bit of stats collection code that executes after
> the
> string_list_clear(), and calls remote_get() which goes all sideways when
> some of
> its memory has been freed.
>
> As an alternative, I could xstrdup each instance where remote->name is
> appended,
> which would make the string_list a homogenous dup'd list, which we could
> then free.
> If you prefer that I'll do a re-roll in that style (it just seemed to me at
> the time like
> it would be doing some useless allocations).  I don't much mind either way.
>
> --
> - Keith
>
> On Mon, Jun 13, 2016 at 6:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> kmcguigan@twopensource.com writes:
>>
>> > From: Keith McGuigan <kmcguigan@twopensource.com>
>> >
>> > The string_list gets populated with the names from the remotes[] array,
>> > which are not dup'd and the list does not own.
>> >
>> > Signed-of-by: Keith McGuigan <kmcguigan@twopensource.com>
>> > ---
>>
>> For names that come from remote_get()->name, e.g.
>>
>>     static int get_one_remote_for_fetch(struct remote *remote, void *priv)
>>     {
>>             struct string_list *list = priv;
>>             if (!remote->skip_default_update)
>>                     string_list_append(list, remote->name);
>>             return 0;
>>     }
>>
>> you are correct that this is borrowed memory we are not allowed to
>> free.  But is borrowing from remote->name the only way this list is
>> populated?  For example, what happens in add_remote_or_group(),
>> which does this?
>>
>>     struct remote_group_data {
>>             const char *name;
>>             struct string_list *list;
>>     };
>>
>>     static int get_remote_group(const char *key, const char *value, void
>> *priv)
>>     {
>>             struct remote_group_data *g = priv;
>>
>>             if (skip_prefix(key, "remotes.", &key) && !strcmp(key,
>> g->name)) {
>>                     /* split list by white space */
>>                     while (*value) {
>>                             size_t wordlen = strcspn(value, " \t\n");
>>
>>                             if (wordlen >= 1)
>>                                     string_list_append(g->list,
>>                                                        xstrndup(value,
>> wordlen));
>>
>> This newly allocated piece of memory is held by g->list, which was...
>>
>>                             value += wordlen + (value[wordlen] != '\0');
>>                     }
>>             }
>>
>>             return 0;
>>     }
>>
>>     static int add_remote_or_group(const char *name, struct string_list
>> *list)
>>     {
>>             int prev_nr = list->nr;
>>             struct remote_group_data g;
>>             g.name = name; g.list = list;
>>
>> ... passed as a callback parameter from here.
>>
>>             git_config(get_remote_group, &g);
>>             if (list->nr == prev_nr) {
>>                     struct remote *remote = remote_get(name);
>>                     if (!remote_is_configured(remote))
>>                             return 0;
>>                     string_list_append(list, remote->name);
>>
>> This makes remote->name borrowed, which we cannot free() as you
>> point out.
>>
>>             }
>>             return 1;
>>     }
>>
>> So, while I agree that many should not be freed, this change makes
>> the code leak some at the same time.
>>
>>
>>
>> >  builtin/fetch.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/builtin/fetch.c b/builtin/fetch.c
>> > index 630ae6a1bb78..181da5a2e7a3 100644
>> > --- a/builtin/fetch.c
>> > +++ b/builtin/fetch.c
>> > @@ -1347,8 +1347,6 @@ int cmd_fetch(int argc, const char **argv, const
>> > char *prefix)
>> >               argv_array_clear(&options);
>> >       }
>> >
>> > -     /* All names were strdup()ed or strndup()ed */
>> > -     list.strdup_strings = 1;
>> >       string_list_clear(&list, 0);
>> >
>> >       close_all_packs();
>
>
