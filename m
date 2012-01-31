From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: convert to use parse_options()
Date: Tue, 31 Jan 2012 15:29:13 -0800
Message-ID: <7v4nvb78om.fsf@alter.siamese.dyndns.org>
References: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:29:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsN8d-0004cm-4K
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 00:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab2AaX3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 18:29:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab2AaX3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 18:29:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 102C76255;
	Tue, 31 Jan 2012 18:29:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IPi4oAJMGC1T
	1pZ+iXJ9Hpzu9XA=; b=N+J7YRfcb2L0vh/xiYomTGtVsBXQv2sk5UqwLZTkc202
	JFjwI6fpy5u40kbG59Qk45qko7k4XbaePAnqbkVdUt0Q+mtYyVyF51AIZWZQVSsF
	RI/RvwbO9rhHPBaKT9alRMyzoVJUnlM2Q0uPcKaEwcrlT/JvGhdC7WwjW4AJZJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cQ2sSd
	r7sKsuRgz1GWazlIUXHq9Af20CmsCqEaReruD/EN9hFDdQCbd1hWarE13UkYQprl
	6O46O6WX2QCP//d0XrIC5voe3s9+vQAlwOjYft7VahFUbI0/ExliYaxgQXzWiYHB
	VksKzOLLsk+j+i8TPlGl0lQjvBSs0L8n19wCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0770D6254;
	Tue, 31 Jan 2012 18:29:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBCD76253; Tue, 31 Jan 2012
 18:29:14 -0500 (EST)
In-Reply-To: <1328017702-14489-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 31 Jan
 2012 20:48:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6354446C-4C63-11E1-9C18-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189483>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -2305,183 +2300,140 @@ static void get_object_list(int ac, const c=
har **av)
>  		loosen_unused_packed_objects(&revs);
>  }
> =20
> +static int option_parse_index_version(const struct option *opt,
> +				      const char *arg, int unset)
> +{
> +	char *c;
> +	const char *val =3D arg;
> +	pack_idx_opts.version =3D strtoul(val, &c, 10);
> +	if (pack_idx_opts.version > 2)
> +		die("unsupported index version %s", val);

Dying may have been the appropriate error path in the custom option
parser, but is it still so for a callback in the parse-options framewor=
k?

Or should this be a 'return error(_("..."), val)'?

> +	if (*c =3D=3D ',' && c[1])
> +		pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);

I do not think the original had this extra "&& c[1]" check and I didn't
see any explanation of this change in the log message, either.

> +static int option_parse_ulong(const struct option *opt,
> +			      const char *arg, int unset)
> +{
> +	if (unset)
> +		die("option %s does not accept negative form",
> +		    opt->long_name);
> +
> +	if (!git_parse_ulong(arg, opt->value))
> +		die("unable to parse value '%s' for option %s",
> +		    arg, opt->long_name);
> +	return 0;
> +}

Likewise on "die()".

> +#define OPT_ULONG(s, l, v, h) \
> +	{ OPTION_CALLBACK, (s), (l), (v), "n", (h),	\
> +	  PARSE_OPT_NONEG, option_parse_ulong }
> +
>  int cmd_pack_objects(int argc, const char **argv, const char *prefix=
)
>  {
>  	int use_internal_rev_list =3D 0;
>  	int thin =3D 0;
>  	int all_progress_implied =3D 0;
> -	uint32_t i;
> -	const char **rp_av;
> -	int rp_ac_alloc =3D 64;
> -	int rp_ac;
> +	const char *rp_av[6];

Nice stackframe shrinkage.

> +	int rp_ac =3D 0;
> +	int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =3D=
 0;
> +	struct option pack_objects_options[] =3D {
> +		OPT_SET_INT('q', "quiet", &progress,
> +			    "do not show progress meter", 0),
> +		OPT_SET_INT(0, "progress", &progress,
> +			    "show progress meter", 1),
> +		OPT_SET_INT(0, "all-progress", &progress,
> +			    "show progress meter during object writing phase", 2),

Sounds as if the progress is not shown during the counting phase.
Nothing ", too" at the end could not fix, though.

> +		OPT_BOOL(0, "all-progress-implied",
> +			 &all_progress_implied,
> +			 "similar to --all-progress when progress meter is shown"),

Hrm, interesting wording.

> +		{ OPTION_CALLBACK, 0, "index-version", NULL, "version",
> +		  "force generating pack index at a particular version",
> +		  0, option_parse_index_version },

Sounds as if you can generate a pack index at HEAD~24, but that is not
what you meant. "version" is too loaded a word that needs qualification=
=2E

Perhaps "write the pack index file in the specified idx format version"=
=2E

"index" is also a loaded word, and our documentation tries to use "idx"
when we talk about the pack index (we say "index" when we mean the
dircache).

> +		OPT_INTEGER(0, "window", &window,
> +			    "limit pack window by objects"),
> +		OPT_ULONG(0, "window-memory", &window_memory_limit,
> +			  "limit pack window by memory"),
> +		OPT_INTEGER(0, "depth", &depth,
> +			    "limit pack window by maximum delta depth"),

These descriptions are somewhat interesting.

The "pack window" is limited by number of objects given by --window (an=
d
by default this is set to 10), but if you give --window-memory, it coul=
d
further dynamically shrink it under memory pressure. If the logic were =
to
use this dynamic shrinkage without any limit on the number of objects i=
n
flight when --window-memory and no --window is given, then you could sa=
y
"limit by memory" as if the "pack window" is counted in terms of number=
 of
bytes in the window instead of number of objects and the description wo=
uld
be accurate. But that is not quite the case as far as I know.

And --depth does not affect the size of the pack window at all. It reje=
cts
an object with deep enough delta chain as a delta-base candidate to lim=
it
the run-time performance penalty for the user of the resulting pack, bu=
t
does not stop the caller from trying the next object in the window.
"maximum length of delta chain allowed in the resulting pack", perhaps?

> +		OPT_BOOL(0, "reuse-delta", &reuse_delta,
> +			 "reusing existing deltas"),
> +		OPT_BOOL(0, "reuse-object", &reuse_object,
> +			 "reusing existing objects"),

s/reusing/reuse/???

> +		OPT_BOOL(0, "delta-base-offset", &allow_ofs_delta,
> +			 "use OFS_DELTA objects"),
> +		OPT_INTEGER(0, "threads", &delta_search_threads,
> +			    "use threads when searching for best delta matches"),
> +		OPT_BOOL(0, "non-empty", &non_empty,
> +			 "only create if it would contain at least one object"),

create what? "do not create an empty pack output"?

> +		OPT_BOOL(0, "revs", &use_internal_rev_list,
> +			 "read revision arguments from standard output"),

s/output/input/???

> +		{ OPTION_SET_INT, 0, "unpacked", &rev_list_unpacked, NULL,
> +		  "limit the objects to those that are not already packed",
> +		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },

s/already/yet/???

> +		{ OPTION_SET_INT, 0, "all", &rev_list_all, NULL,
> +		  "include all refs under $GIT_DIR/refs directory",
> +		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
> +		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
> +		  "include objects referred by reflog entries",
> +		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },

The latter is more correct---packfile does not pack refs, it packs
objects.

Perhaps former should match: "include objects reachable from any
reference". I would also prefer to avoid "$GIT_DIR/refs _directory_"
to discourage people from running "ls -R .git/refs/".

> +		OPT_BOOL(0, "stdout", &pack_to_stdout,
> +			 "output pack to stdout"),
> +		OPT_BOOL(0, "include-tag", &include_tag,
> +			 "include unasked-for annotated tags"),

"include tag objects that refer to objects to be packed"?

> +		OPT_BOOL(0, "keep-unreachable", &keep_unreachable,
> +			 "keep unreachable objects"),

What does this option mean these days (aka "where are they kept")?

IIRC, this was meant to be used in conjunction with the --unpacked=3D a=
nd
later with --kept-pack-only (see 03a9683d22) and then was later further
modified by 4d6acb70411.

I *think* this meant to include objects that are in packfiles that are =
not
marked with .keep even when they are not in the revision range to be
packed, so that we won't lose them during gc.

But I think --unpack-unreachable introduced by ca11b21 (let pack-object=
s
do the writing of unreachable objects as loose objects, 2008-05-14) tha=
t
writes these unreachable objects out of the pack to loose form made thi=
s
option unnecessary, and it remains unused ever since. It may not be a b=
ad
idea to deprecate this option.

Obviously it is outside of the scope of this patch.

> +		OPT_BOOL(0, "unpack-unreachable", &unpack_unreachable,
> +			 "unpack unreachable objects"),
> +		OPT_BOOL(0, "thin", &thin,
> +			 "create thin packs"),
> +		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
> +			 "ignore packs that have companion .keep file"),
> +		OPT_INTEGER(0, "compression", &pack_compression_level,
> +			    "pack compression level"),
> +		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
> +			    "do not hide commits by grafts", 0),

It is noteworthy that this is truly "do not hide".

A graft entry can also add extra commits, but this option will not prev=
ent
the command from including them, so that the result of repacking will k=
eep
the union of parents in the real history (i.e. in commit objects) and
parents in the pretend history (i.e. added by grafts).

> +		OPT_END(),
> +	};
> =20
>  	read_replace_refs =3D 0;
> ...
> -			continue;
> -		}
> -		usage(pack_usage);
> +	if (rev_list_unpacked) {
> +		use_internal_rev_list =3D 1;
> +		rp_av[rp_ac++] =3D "--unpacked";
> +	}
> +	if (rev_list_all) {
> +		use_internal_rev_list =3D 1;
> +		rp_av[rp_ac++] =3D "--all";
> +	}
> +	if (rev_list_reflog) {
> +		use_internal_rev_list =3D 1;
> +		rp_av[rp_ac++] =3D "--reflog";
>  	}

I'd prefer to have "unpacked" the last, to match the order of parameter=
s
in which the typical caller, i.e. repack, calls us, but that is minor.

> @@ -2497,12 +2449,25 @@ int cmd_pack_objects(int argc, const char **a=
rgv, const char *prefix)
>  	 * walker.
>  	 */
> =20
> -	if (!pack_to_stdout)
> -		base_name =3D argv[i++];
> -
> -	if (pack_to_stdout !=3D !base_name)
> -		usage(pack_usage);
> +	if (!pack_to_stdout) {
> +		if (!argc)
> +			die("base name required if --stdout is not given");
> +		base_name =3D argv[0];
> +		argc--;
> +	}
> +	if (argc)
> +		die("base name or --stdout are mutually exclusive");

Doesn't this change regress the most basic, i.e.

	$ git pack-objects
        usage: ...

Other than that, thanks for a pleasant and thought-provoking read.
