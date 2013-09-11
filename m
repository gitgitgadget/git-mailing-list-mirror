From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 18:20:44 +0700
Message-ID: <CACsJy8BQWSthAKePsBDyc5nAofLiTpXO5oc+jbSGx33YBioTeg@mail.gmail.com>
References: <cover.1378840318.git.john@keeping.me.uk> <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <52300838.5040703@kdbg.org> <20130911082042.GR2582@serenity.lan>
 <CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com> <20130911110806.GT2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 11 13:21:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJiU5-0002Jb-0C
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 13:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab3IKLVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 07:21:16 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:61321 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab3IKLVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 07:21:15 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so9116307oah.23
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7dG1cZlroYj/5lCIiHU8SJJfAWbhZ758voz5oj331Bs=;
        b=DFFWoMDfkbsku+JE7nAJiP/Q73I9bRdyJCUfFmvOaR2JaGChPpiQTG0DAct/DPj1j9
         Kr5iSueQrJnrWEV3crgJXmTRqj09jIvXwEGT2Imzy/rE3XEQsALsWr5wyGdt4s8/BYbI
         35JiYarLRELiTKIROUJT1SVDwN8Ov41FZIQCF0HIEnjH1MXw0Lz4VhWTlLMX0KIxNznd
         nUXgjEMlr/6cfD6rynI7aLT1mF1diERkh7ZXyKKdZHUWgXlP1NRv6r+sKfuN+Y5AGpjl
         UIJ4Rgo9COelJtFKvAM5kpQhjdJTJGK9JSG1qph2+Q9REjwmiuAisR/Blh068Fr7/8Ig
         +1wA==
X-Received: by 10.182.230.135 with SMTP id sy7mr955411obc.24.1378898475049;
 Wed, 11 Sep 2013 04:21:15 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 11 Sep 2013 04:20:44 -0700 (PDT)
In-Reply-To: <20130911110806.GT2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234559>

On Wed, Sep 11, 2013 at 6:08 PM, John Keeping <john@keeping.me.uk> wrote:
>> > -- >8 --
>> > diff --git a/builtin/reset.c b/builtin/reset.c
>> > index 9efac0f..800117f 100644
>> > --- a/builtin/reset.c
>> > +++ b/builtin/reset.c
>> > @@ -143,7 +143,6 @@ static int read_from_tree(const struct pathspec *pathspec,
>> >         opt.output_format = DIFF_FORMAT_CALLBACK;
>> >         opt.format_callback = update_index_from_diff;
>> >
>> > -       read_cache();
>> >         if (do_diff_cache(tree_sha1, &opt))
>> >                 return 1;
>> >         diffcore_std(&opt);
>> > @@ -169,7 +168,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
>> >
>> >  static void die_if_unmerged_cache(int reset_type)
>> >  {
>> > -       if (is_merge() || read_cache() < 0 || unmerged_cache())
>> > +       if (is_merge() || unmerged_cache())
>> >                 die(_("Cannot do a %s reset in the middle of a merge."),
>> >                     _(reset_type_names[reset_type]));
>>
>> reset --soft does not go through these code paths (i.e. it does not
>> need index at all). If we fail to load index index in "reset --soft" I
>> think it's ok to die(). Corrupt index is fatal anyway. But "reset
>> --soft" now has to pay the cost to load index, which could be slow
>> when the index is big. Assuming nobody does "reset --soft" that often
>> I think this is OK.
>>
>> Alternatively we could load index lazily in _CHEAP code only when we
>> see trailing slashes, then replace these read_cache() with
>> read_cache_unless_its_already_loaded_earlier() or something.
>
> read_cache() already has an early return if the index is already loaded
> so I don't think we need to worry about a special function for that.
>
> I'm not sure it's worth optimizing this case too heavily, but it might
> be a nice change to make parse_pathspec() not rely on the index being
> loaded before it is called with certain flags.

Yeah I ddin't check. I agree putting read_cache() in _CHEAP code
sounds nice. We won't need to worry about forgotten read_cache()
elsewhere.
-- 
Duy
