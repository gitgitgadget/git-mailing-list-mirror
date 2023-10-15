Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0B7461
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m4H/sj2n"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F35AB
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 10:36:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A78829AA1;
	Sun, 15 Oct 2023 13:36:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ThXsOf5rSvikG/4ds2hxN7dQQIgLFLv6hXnVLF
	RdnUg=; b=m4H/sj2npmKcePPt+MJT/l6H243NpaWn7W6N0jAx/FyOMxZ5Ga5vT5
	ueq6t/d5mYi2i2yfGhmRtSHr1CeQwlpCB9yJulRjCOX7BTzOg9EtUv35PqNqCsT5
	hJddQSbs9TtUBG0nuIpV8uuyJdcwE1aZJNN6+o39/KUoy0/IKM2Ls=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0342229AA0;
	Sun, 15 Oct 2023 13:36:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FFA929A9D;
	Sun, 15 Oct 2023 13:36:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] bugreport: include +i in outfile suffix as needed
In-Reply-To: <20231015034238.100675-2-jacob@initialcommit.io> (Jacob Stopak's
	message of "Sat, 14 Oct 2023 20:42:35 -0700")
References: <20231014040101.8333-1-jacob@initialcommit.io>
	<20231015034238.100675-1-jacob@initialcommit.io>
	<20231015034238.100675-2-jacob@initialcommit.io>
Date: Sun, 15 Oct 2023 10:36:35 -0700
Message-ID: <xmqqr0lvpz30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6474A892-6B81-11EE-9F7A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jacob Stopak <jacob@initialcommit.io> writes:

> When the -s flag is absent, git bugreport includes the current hour and
> minute values in the default bugreport filename (and diagnostics zip
> filename if --diagnose is supplied).
>
> If a user runs the bugreport command more than once within a calendar
> minute, a filename conflict with an existing file occurs and the program
> errors, since the new output filename was already used for the previous
> file. If the user waits anywhere from 1 to 60 seconds (depending on
> _when during the calendar minute_ the first command was run) the command

Drop "calendar" here (see below).  "If the user waits from running
the command within the same minute" may be easier to understand than
"from 1 to 60 seconds"; after all, the user does not have to wait
for more than 0.5 seconds if the previous attempt was within 0.5
seconds from the minute boundary.

> works again with no error since the default filename is now unique, and
> multiple bug reports are able to be created with default settings.
>
> This is a minor thing but can cause confusion especially for first time
> users of the bugreport command, who are likely to run it multiple times
> in quick succession to learn how it works, (like I did).

Perhaps we should refine the error message we give in this case and
we are done, then?

$ GIT_EDITOR=: git bugreport ; GIT_EDITOR=: git bugreport
Created new report at 'git-bugreport-2023-10-15-1008.txt'.
fatal: unable to create 'git-bugreport-2023-10-15-1008.txt': File exists

The second message can be a bit more friendly and suggest removing
the stale file.

> Add a '+i' into the bugreport filename suffix to make the filename
> unique, where 'i' is an integer starting at 1 and able to grow up to 9
> in the unlikely event a user runs the command 9 times in a single
> minute. This leads to default output filenames like:

What downside do you see in using 2023-10-15-1008+10 after you tried
9 of them?  The code to limit the upper bound smells like a wasted
effort that helps nobody in practice because it is "unlikely".

And limiting the upper bound also means you now have to have extra
code to deal with "we ran out---error out and help the user how to
recover" anyway.

Notice that you said "in a single minute" without "calendar" and the
sentence is perfectly understandable? (see above and below).

> This means the user will end up with multiple bugreport files being
> created if they run the command multiple times quickly, but that feels
> more intuitive and consistent than an error arbitrarily occuring within
> a calendar minute, especially given that the time window in which the
> error currently occurs is variable as described above.

And drop "calendar" here, too (see above).
"Within the same minute" is fine.

> @@ -3,7 +3,6 @@
>  #include "editor.h"
>  #include "gettext.h"
>  #include "parse-options.h"
> -#include "strbuf.h"

Looks like an unrelated change here.  The updated code does use
strbuf service, so even if other header files happen to include
it, keep including it here is a good discipline for readability.

> @@ -101,12 +101,13 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct strbuf report_path = STRBUF_INIT;
> +	struct strbuf option_suffix = STRBUF_INIT;
> +	struct strbuf default_option_suffix = STRBUF_INIT;
>  	int report = -1;
>  	time_t now = time(NULL);
>  	struct tm tm;
>  	enum diagnose_mode diagnose = DIAGNOSE_NONE;
>  	char *option_output = NULL;
> -	char *option_suffix = "%Y-%m-%d-%H%M";
>  	const char *user_relative_path = NULL;
>  	char *prefixed_filename;
>  	size_t output_path_len;
> @@ -118,11 +119,14 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  			       PARSE_OPT_OPTARG, option_parse_diagnose),
>  		OPT_STRING('o', "output-directory", &option_output, N_("path"),
>  			   N_("specify a destination for the bugreport file(s)")),
> -		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
> +		OPT_STRING('s', "suffix", &option_suffix.buf, N_("format"),
>  			   N_("specify a strftime format suffix for the filename(s)")),
>  		OPT_END()
>  	};
>  
> +	strbuf_addstr(&default_option_suffix, "%Y-%m-%d-%H%M");
> +	strbuf_addstr(&option_suffix, default_option_suffix.buf);

It usually pays for a reviewer when two variables, one called
default and the other not, gets initialized to the same value,
because it is a sign that there is something fishy going on.  A more
normal pattern is to set up the default, do whatever is needed and
if the non-default one has not been touched, then copy that default
value to the real one, and the code needed deviation from it for
whatever reason.  Let's read on.

> @@ -134,9 +138,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  	output_path_len = report_path.len;
>  
>  	strbuf_addstr(&report_path, "git-bugreport-");
> -	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
> +	strbuf_addftime(&report_path, option_suffix.buf, localtime_r(&now, &tm), 0, 0);
>  	strbuf_addstr(&report_path, ".txt");

OK.

> +	if (strbuf_cmp(&option_suffix, &default_option_suffix) == 0) {

Style: never compare with 0 or NULL inside a conditional.

	if (!compare(...)) {

is the idiom to use.

You may have written it this way to avoid appending after what the
user gave you as a custom pattern, but this if() statement is a
failed way to do so.  The user can give what happens to be the same
as the hardcoded default pattern and you cannot tell if it came from
them or your initially hardcoded one by string comparison.

> +		int i = 1;
> +		int pos = report_path.len - 4;

Totally unclear where the magic "4" comes from.

> +		while (file_exists(report_path.buf) && i < 10) {
> +			if (i > 1)
> +				strbuf_remove(&report_path, pos, 2);
> +			strbuf_insertf(&report_path, pos, "+%d", i);
> +			i++;
> +		}
> +	}

We see TOCTOU here.

Do it more like this instead.

    * Discard default_option_suffix variable.

    * Introduce a boolean option_suffix_is_from_user and
      initialize it to false.

    * Initialize option_suffix to an empty string.

    * After parse_options() returns, if option_suffix is still
      empty, then add the default pattern.  Otherwise toggle
      option_suffix_is_from_user true.

    * Prepare the code so that you can recompute report_path as you
      need to increment the suffix added to option_suffix.

Then where we do xopen() on report_path.buf, have a fallback loop,
and you can do something like

    again:
	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
	if (report < 0 && errno == EEXISTS && !option_suffix_is_from_user) {
		increment_suffix(&report_path);
		goto again;
	} else if (report < 0) {
		die_errno(_("unable to open '%s'", report_path.buf));
	}

to avoid TOCTOU.

HTH.
