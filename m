From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on --abbrev[-commit]
Date: Mon, 26 Apr 2010 08:47:54 +0100
Message-ID: <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com> 
	<1272232579-18895-2-git-send-email-wmpalmer@gmail.com> <1272232579-18895-3-git-send-email-wmpalmer@gmail.com> 
	<20100426031012.GA29953@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 09:48:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6J3F-0004SB-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 09:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab0DZHsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 03:48:16 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46474 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab0DZHsP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 03:48:15 -0400
Received: by bwz19 with SMTP id 19so199630bwz.21
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lVZeHleuYP0KuXZRq4hod9k+itySIq29fFvVHTOmpWE=;
        b=s44eeMsOLcBPnmBIBO0HZ6Jq/aPkfzqvv/5xExHYr3JupJqggulsqkyHxELEW3N2Bh
         tZqAYoec8i0t/TVy2v/JK72IgAA/To/kIKswKwIU84elnhkFE7inIfq9PrchxGV5wFw/
         uNbdIg+z0R6CLQSAAvxNxMDevjnoLac/uYS8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SjYo6BVP8jS0/X9Vfc6sNW99BtkEGBlhRkl9YmdlwvbYWWOVgQRkO24qhHvt2Tuggv
         c5bzDnhNQNra19BQSW4WqMqRw5d2CZXFM7lM0qi5vwZxI4uDwQ5o70mIYoNMqTroJa6t
         q6bwcrZdtzHx3sf6SXlL/ObHg1/3fqE0SRmDw=
Received: by 10.103.78.31 with SMTP id f31mr1980397mul.79.1272268094077; Mon, 
	26 Apr 2010 00:48:14 -0700 (PDT)
Received: by 10.103.239.12 with HTTP; Mon, 26 Apr 2010 00:47:54 -0700 (PDT)
In-Reply-To: <20100426031012.GA29953@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145796>

> I agree that this is the right to do, since this is how the built-in
> formats work (the =91commit ...=92 line follows the semantics of your=
 %H,
> and =91Merge: ...=92 line your %p, for example).
>
> Documentation and tests?
Tests, noted. I'll include some in the next version of the patch.
As for documentation, I'm not entirely sure what to add, as it seemed
like the change
merely implements what I would expect when reading the docs for
git-log. Still, noted.
I'll stick a short note in each of %H, %h, %P, %p, and %t


> Shortlog doesn=92t print commit hashes, does it?

Shortlog accepts --format, though this doesn't seem to be documented
(if I type "man" and search
for "format"), so perhaps it should be.

>
>> diff --git a/commit.h b/commit.h
>> index b6caf91..7a476a0 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -72,6 +72,7 @@ struct pretty_print_context
>> =A0 =A0 =A0 int need_8bit_cte;
>> =A0 =A0 =A0 int show_notes;
>> =A0 =A0 =A0 int use_color;
>> + =A0 =A0 int abbrev_commit;
>> =A0 =A0 =A0 struct reflog_walk_info *reflog_info;
>> =A0};
>>
>
> nitpick: I=92d stick this up with abbrev and maybe add a comment to
> explain their distinct uses.
Noted. Thanks

>
>> diff --git a/log-tree.c b/log-tree.c
>> index 6bb4748..0a2309c 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -282,6 +282,8 @@ void show_log(struct rev_info *opt)
>> =A0 =A0 =A0 int abbrev_commit =3D opt->abbrev_commit ? opt->abbrev :=
 40;
>> =A0 =A0 =A0 const char *extra_headers =3D opt->extra_headers;
>> =A0 =A0 =A0 struct pretty_print_context ctx =3D {0};
>> + =A0 =A0 ctx.abbrev =3D opt->abbrev;
>> + =A0 =A0 ctx.abbrev_commit =3D opt->abbrev_commit;
>> =A0 =A0 =A0 ctx.use_color =3D DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF=
);
>>
>> =A0 =A0 =A0 opt->loginfo =3D NULL;
>
> There is a
>
> ctx.abbrev =3D opt->diffopt.abbrev;
>
> later in the same function; how do these interact?

I hadn't caught that. My guess: stupidly doing the same thing twice.
I'll double-check,
and take out one of them if that's the case.

What all this
has shown me is that there are really too many ways to specify "context=
 when
printing information about a commit". I don't like it, and the lot of
them can probably
be re-factored, perhaps by getting rid of pretty_context and passing
rev_info around
everywhere. I don't know the full implications of that and it seems
outside the scope
of this change.


>
>> @@ -741,24 +744,29 @@ static size_t format_commit_one(struct strbuf =
*sb, const char *placeholder,
> [...]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(sb, find_u=
nique_abbrev(
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 p->item->object.sha1, DEFAULT_ABBREV));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 p->item->object.sha1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 c->pretty_ctx->abbrev));
>
> nitpick: the new indentation makes these look like parameters to
> strbuf_addstr.

Noted. I'll restore the extra indent, which I had assumed was a typo.

>
> Here=92s an alternative implementation of the more controversial half=
 of
> your patch, for your amusement. =A0The big downside is that it requir=
es
> one to specify --abbrev-commit before the --format option.
>
> Thanks for the pleasant read.
>
> Jonathan
>
> diff --git a/pretty.c b/pretty.c
> index 7cb3a2a..1008a41 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -12,10 +12,31 @@
>
> =A0static char *user_format;
>
> +static void abbreviate_commit_hashes(char *fmt)
> +{
> + =A0 =A0 =A0 char *p;
> + =A0 =A0 =A0 for (p =3D fmt; p !=3D NULL; p =3D strchr(p + 1, '%')) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (*p) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'H':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p =3D 'h';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'P':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p =3D 'p';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'T':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> =A0static void save_user_format(struct rev_info *rev, const char *cp,=
 int is_tformat)
> =A0{
> =A0 =A0 =A0 =A0free(user_format);
> =A0 =A0 =A0 =A0user_format =3D xstrdup(cp);
> + =A0 =A0 =A0 if (rev->abbrev_commit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 abbreviate_commit_hashes(user_format);
> =A0 =A0 =A0 =A0if (is_tformat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev->use_terminator =3D 1;
> =A0 =A0 =A0 =A0rev->commit_format =3D CMIT_FMT_USERFORMAT;
>

I had been thinking that this wouldn't be safe, but then that was my
being overly-cautious:
it's just been xstrdup()ed, so what we're parsing is ours, no real
reason not to do it.
I think the "must be specified after --abbrev-commit" is a rather
large nail, though. If you work
out the bugs mentioned by Jeff King, and it works, I'll stick it in
there, as I don't like
falling through case statements any more than the next guy. (well,
maybe a little more than
the next guy).

Thanks for the review!
-- Will Palmer
