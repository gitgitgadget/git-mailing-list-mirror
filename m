From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 4/4] notes: add per-ref configuration of merge strategy
Date: Wed, 05 Aug 2015 14:10:11 -0700
Message-ID: <xmqqa8u530i4.fsf@gitster.dls.corp.google.com>
References: <1438510226-1163-1-git-send-email-jacob.e.keller@intel.com>
	<1438510226-1163-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN5x8-0000Y3-4y
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbbHEVKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:10:15 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:32963 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbbHEVKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:10:13 -0400
Received: by pdrh1 with SMTP id h1so5227568pdr.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nFW1eQ+KS1bEVWU0PVP6lHmR9XN8+oH3wykncpUijRc=;
        b=j385+EmiU3VicX/1Rid6cBrnHB3v2xyXe+kqTxzbr25MDvcdgiwwqxVnRxkVlpCMLr
         lzPcRnHGYv8qyV760z4/GlR1dYYAxfxy7yT8jPpeg0x34UJzNIGo8X0tUUpkVA2BVKV0
         V02zdWYnw45olQCJyNOqnxsjNhyKHqKrvWcP6/slRn3X7+fBI3TGJ3oQTQzTG4VB31ou
         HbRWN+NH5te9UwJunyd0bfaNoxfJCn/mhkeOAanZEqF10c5nKpvD15HhRl1CPQgidd0r
         3HNxot49+cZSRpaCNdOwMj+VWmMetf35xXAMgvsgCupzzmkKVpHhe7PahB+Y++9RBQo3
         T/rA==
X-Received: by 10.70.130.34 with SMTP id ob2mr23110016pdb.15.1438809013262;
        Wed, 05 Aug 2015 14:10:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id fj6sm3952149pdb.21.2015.08.05.14.10.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 14:10:12 -0700 (PDT)
In-Reply-To: <1438510226-1163-5-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Sun, 2 Aug 2015 03:10:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275398>

Jacob Keller <jacob.e.keller@intel.com> writes:

> +notes.<localref>.merge::
> +	Which merge strategy to choose if the local ref for a notes merge
> +	matches <localref>. Is overridden by notes.merge and takes the same
> +	values. <localref> may be fully qualified or just under refs/notes/.
> +	See "NOTES MERGE STRATEGIES" section in linkgit:git-notes[1] for more
> +	information on each strategy.

If I have notes.refs/notes/commit.merge and notes.merge specified,
I'd expect the former overrides the latter.  The second sentence may
need correcting.

I think it is a mistake to allow both notes.refs/notes/commit.merge
and notes.commit.merge.  You'd end up needing to implement quite a
complicated "the last one wins" rule if you did so.

> +notes.<localref>.merge::
> +	Which strategy to choose when merging into <localref>. Uses the same
> +	values as notes.merge. <localref> may be either a fully qualified ref
> +	or the shortname under "refs/notes/". See "NOTES MERGE STRATEGIES"
> +	section above for more information about each strategy.

As a reviewer, I can tell that "Uses the same values" wants to say
that the set of allowed values is the same, but a casual reader is
bound to read it as "notes.commit.merge must be set to the same
value as the value set to notes.merge".

> diff --git a/builtin/notes.c b/builtin/notes.c
> index de0caa00df1b..b0174d1024dc 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -92,6 +92,10 @@ static const char * const git_notes_get_ref_usage[] = {
>  static const char note_template[] =
>  	"\nWrite/edit the notes for the following object:\n";
>  
> +static struct note_ref **note_refs;
> +static int note_refs_alloc;
> +static int note_refs_nr;
> +static struct hashmap note_refs_hash;
>  static enum notes_merge_strategy merge_strategy;
>  
>  struct note_data {
> @@ -757,12 +761,87 @@ static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *stra
>  	return 0;
>  }
>  ...
> +struct note_refs_hash_key {
> +	const char *str;
> +	int len;
> +};
> + ...
> +static void set_strategy_for_ref(const char *ref)
> +{
> + ...
> +}

Hmmm, I do not see why you need all the complexity above.

When you come to merge(), after calling default_notes_ref(), you
know exactly which notes ref you are merging into, no?  Shouldn't
then the change required for this feature just the matter of asking
the configuration system values for notes.$remote_ref.merge and
notes.merge?

IOW,

	struct strbuf key = STRBUF_INIT;
	char *value = NULL;

        strbuf_addf(&key, "notes.%s.merge", remote_ref.buf);

	git_config_get_string(key.buf, &value) ||
	git_config_get_string_const("notes.merge", &value));

	if (value)
        	parse_notes_strategy(value, &configured_merge_strategy);

	...

        parse_options();
	if (strategy)
        	parse_notes_strategy(value, &configured_merge_strategy);

or something?
