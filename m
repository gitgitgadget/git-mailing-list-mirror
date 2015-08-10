From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] config: add '--names-only' option to list only variable names
Date: Mon, 10 Aug 2015 10:18:17 -0700
Message-ID: <xmqqvbcnuko6.fsf@gitster.dls.corp.google.com>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
	<1439199967-9655-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:18:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOqiO-0003LZ-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 19:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbbHJRSV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 13:18:21 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34915 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbbHJRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 13:18:20 -0400
Received: by pdrg1 with SMTP id g1so73647535pdr.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=t4/v5bwuyfgblhPCrhe/oyaepbrIykRa8vN/ne2W81E=;
        b=kvjh55oFpRYo/KP5/OjDTQ6zhleFVahN2hlkBMLJUCA/X7s9higeNP8rsG5Osng9d1
         U7wYkZcowVWXNLMCcHIdtXKzhkrHBon1uw0S7H80+RW7HuVYTRLiOginxW1kGVbxmxav
         8FVfXN+Rf1ZG58egMjszAme/EGv0lEf9A5fSED1xvqhxhHDtMYS6Mknf0OhFCgbqqaow
         G5Ze9HHy6Ny11XfjS79wU9TYPOpaFSkI/HHPLpxjPEjaZOcBJWifPQOxE52Z2fy8EDpI
         PKeWGsGrFculZERk5zpti3fXzglK9c1kpNf62CaXeCkJVLdinm/6xYSkLxO5jQMEdJ8y
         CUiQ==
X-Received: by 10.70.46.161 with SMTP id w1mr47027424pdm.66.1439227099539;
        Mon, 10 Aug 2015 10:18:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id qb10sm20785929pab.39.2015.08.10.10.18.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 10:18:18 -0700 (PDT)
In-Reply-To: <1439199967-9655-2-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 10 Aug 2015 11:46:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275636>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'git config' can only show values or name-value pairs, so if a shell
> script needs the names of set config variables it has to run 'git con=
fig
> --list' or '--get-regexp' and parse the output to separate config
> variable names from their values.  However, such a parsing can't cope
> with multi-line values.  Though 'git config' can produce null-termina=
ted
> output for newline-safe parsing, that's of no use in such a case, bec=
ase

s/becase/because/;

> shells can't cope with null characters.
>
> Even our own bash completion script suffers from these issues.
>
> Help the completion script, and shell scripts in general, by introduc=
ing
> the '--names-only' option to modify the output of '--list' and
> '--get-regexp' to list only the names of config variables, so they do=
n't
> have to perform error-prone post processing to separate variable name=
s
> from their values anymore.

I agree with Peff that "--names-only" has a subtle difference with
an existing and well known subcommand option and it would be a bit
irritating to remember which options is for which command.

> diff --git a/builtin/config.c b/builtin/config.c
> index 7188405f7e..307980ab50 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -13,6 +13,7 @@ static char *key;
>  static regex_t *key_regexp;
>  static regex_t *regexp;
>  static int show_keys;
> +static int omit_values;
>  static int use_key_regexp;
>  static int do_all;
>  static int do_not_match;
> ...
> @@ -91,7 +93,7 @@ static void check_argc(int argc, int min, int max) =
{
> =20
>  static int show_all_config(const char *key_, const char *value_, voi=
d *cb)
>  {
> -	if (value_)
> +	if (!omit_values && value_)

Hmmmm.  As we have "show_keys",

	if (show_values && value_)

would be a lot more intuitive, no?

> @@ -117,6 +119,10 @@ static int format_config(struct strbuf *buf, con=
st char *key_, const char *value
>  		strbuf_addstr(buf, key_);
>  		must_print_delim =3D 1;
>  	}
> +	if (omit_values) {
> +		strbuf_addch(buf, term);
> +		return 0;
> +	}

This hunk makes me wonder what the assignment to "must_print_delim"
is about.  When the code is told to show only keys and not values,
it shouldn't even have to worry about key_delim, but that assignment
is done to control exactly that.  It happens that you are lucky that
you can "return 0" early here so that the assignment does not have
any effect, but still conceptually the code structure is made ugly
by this patch.

Isn't it more like the existing "show_keys" can be replaced/enhanced
with a single "show" tri-state toggle that chooses one among:

    * show both keys and values (for --list)
    * show only keys (for your new feature)
    * show only value (for --get)

perhaps?

I see get_urlmatch() abuses show_keys variable in a strange way, and
it may not be as trivial as removing show_keys and replacing it with
a new tri-state toggle, though.
