From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 20:28:44 +0100
Message-ID: <20160111192844.GD10612@hank>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
 <xmqqh9ikxbv7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:28:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIi8v-0004TM-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933932AbcAKT2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:28:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35949 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934548AbcAKT2V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:28:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so27696175wmf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0PQPxKsYC9OQnf/O9NHmneNa8X0LX3N+ienw6MLE19Y=;
        b=YQdVW985cco2WJO/Fu5XgxznMtIZTqhSWEamYd4Xt+qpMpYSoHi3seAuAGy2mr1dJv
         qCO86QVM465ZZVdodlLTZdsbQzilQIYygoLUl4Avx8JmIOMkZWCV2nlgpyRmtJHTfVPi
         xNNhm7DMfKKBBDbCgwD7xBywbed2oSvmukJSkC9UUt7ATDKXqOtS+b+sPYtKTXz7OREL
         rNcygg1fovAMrufMtAtTxoCkS6EbPTIfgbA+L3qP5cxORK/SDlknMqUMbHh5UG3hMYSI
         C49qSR69HIpFSFMOat5XWRqR5A/9Y0gqv/0C1vyrNP/veopc6onwF7t70AgKXhpCmUq1
         ujNQ==
X-Received: by 10.28.51.17 with SMTP id z17mr10567894wmz.26.1452540499554;
        Mon, 11 Jan 2016 11:28:19 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id c26sm14213943wmi.21.2016.01.11.11.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 11:28:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqh9ikxbv7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283699>

On 01/11, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > Currently when git grep is used outside of a git repository without the
> > --no-index option git simply dies.  For convenience, implicitly make git
> > grep behave like git grep --no-index when it is called outside of a git
> > repository.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  builtin/grep.c  | 32 ++++++++++++++++++++++++--------
> >  t/t7810-grep.sh | 41 ++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 62 insertions(+), 11 deletions(-)
> >
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 3a27bd5..a886af1 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -19,6 +19,9 @@
> >  #include "dir.h"
> >  #include "pathspec.h"
> >
> > +#define GREP_NO_INDEX_EXPLICIT 1
> > +#define GREP_NO_INDEX_IMPLICIT 2
>
> I am not sure this is the best way to do this.  For things like
> this, the usual pattern is to initialize "no_index" to an "unknown"
> value, allow "--no-index" to toggle it to true (by the way, I think
> we should reject "--no-no-index", but that is a separate topic), and
> then after command line parsing finishes, tweak the no_index if it
> is still "unknown".

The reason for this (and the change in 02/03) is so we can distinguish
whether there is an explicit no-index or not for the error messages.
I think it would be okay to have more generic error messages
("--cached or --untracked cannot be used without index" and
"--untracked or no index mode cannot be used with revs").  What do you
think?

> >  static char const * const grep_usage[] = {
> >  	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
> >  	NULL
> > @@ -632,7 +635,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  		OPT_BOOL(0, "cached", &cached,
> >  			N_("search in index instead of in the work tree")),
> >  		OPT_BIT(0, "no-index", &no_index,
> > -			N_("find in contents not managed by git"), 1),
> > +			N_("find in contents not managed by git"),
> > +			GREP_NO_INDEX_EXPLICIT),
> >  		OPT_BOOL(0, "untracked", &untracked,
> >  			N_("search in both tracked and untracked files")),
> >  		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
> > @@ -755,9 +759,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  			     PARSE_OPT_STOP_AT_NON_OPTION);
> >  	grep_commit_pattern_type(pattern_type_arg, &opt);
> >
> > -	if (!no_index && !startup_info->have_repository)
> > -		/* die the same way as if we did it at the beginning */
> > -		setup_git_directory();
> > +	if (!no_index && !startup_info->have_repository) {
> > +		int nongit = 0;
> > +
> > +		setup_git_directory_gently(&nongit);
> > +		if (nongit)
> > +			no_index = GREP_NO_INDEX_IMPLICIT;
> > +	}
> >
> >  	/*
> >  	 * skip a -- separator; we know it cannot be
> > @@ -873,13 +881,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >  	if (!show_in_pager && !opt.status_only)
> >  		setup_pager();
> >
> > -	if (no_index && (untracked || cached))
> > -		die(_("--cached or --untracked cannot be used with --no-index."));
> > +	if (untracked || cached) {
> > +		if (no_index == GREP_NO_INDEX_EXPLICIT)
> > +			die(_("--cached or --untracked cannot be used with --no-index."));
> > +		else if (no_index == GREP_NO_INDEX_IMPLICIT)
> > +			die(_("--cached or --untracked cannot be used outside a git repository."));
> > +	}
> >
> >  	if (no_index || untracked) {
> >  		int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
> > -		if (list.nr)
> > -			die(_("--no-index or --untracked cannot be used with revs."));
> > +		if (list.nr) {
> > +			if (no_index == GREP_NO_INDEX_IMPLICIT)
> > +				die(_("cannot use revs outside of a git repository."));
> > +			else
> > +				die(_("--no-index or --untracked cannot be used with revs."));
> > +		}
> >  		hit = grep_directory(&opt, &pathspec, use_exclude);
> >  	} else if (0 <= opt_exclude) {
> >  		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
> > diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> > index ab94716..4ba955d 100755
> > --- a/t/t7810-grep.sh
> > +++ b/t/t7810-grep.sh
> > @@ -794,11 +794,9 @@ test_expect_success 'outside of git repository' '
> >  		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> >  		export GIT_CEILING_DIRECTORIES &&
> >  		cd non/git &&
> > -		test_must_fail git grep o &&
> >  		git grep --no-index o >../actual.full &&
> >  		test_cmp ../expect.full ../actual.full
> >  		cd sub &&
> > -		test_must_fail git grep o &&
> >  		git grep --no-index o >../../actual.sub &&
> >  		test_cmp ../../expect.sub ../../actual.sub
> >  	) &&
> > @@ -808,7 +806,6 @@ test_expect_success 'outside of git repository' '
> >  		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> >  		export GIT_CEILING_DIRECTORIES &&
> >  		cd non/git &&
> > -		test_must_fail git grep o &&
> >  		git grep --no-index --exclude-standard o >../actual.full &&
> >  		test_cmp ../expect.full ../actual.full &&
> >
> > @@ -821,6 +818,44 @@ test_expect_success 'outside of git repository' '
> >  	)
> >  '
> >
> > +test_expect_success 'outside of git repository without --no-index' '
> > +	rm -fr non &&
> > +	mkdir -p non/git/sub &&
> > +	echo hello >non/git/file1 &&
> > +	echo world >non/git/sub/file2 &&
> > +	{
> > +		echo file1:hello &&
> > +		echo sub/file2:world
> > +	} >non/expect.full &&
> > +	echo file2:world >non/expect.sub &&
> > +	(
> > +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> > +		export GIT_CEILING_DIRECTORIES &&
> > +		cd non/git &&
> > +		git grep o >../actual.full &&
> > +		test_cmp ../expect.full ../actual.full
> > +		cd sub &&
> > +		git grep o >../../actual.sub &&
> > +		test_cmp ../../expect.sub ../../actual.sub
> > +	) &&
> > +
> > +	echo ".*o*" >non/git/.gitignore &&
> > +	(
> > +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> > +		export GIT_CEILING_DIRECTORIES &&
> > +		cd non/git &&
> > +		git grep --exclude-standard o >../actual.full &&
> > +		test_cmp ../expect.full ../actual.full &&
> > +
> > +		{
> > +			echo ".gitignore:.*o*"
> > +			cat ../expect.full
> > +		} >../expect.with.ignored &&
> > +		git grep --no-exclude o >../actual.full &&
> > +		test_cmp ../expect.with.ignored ../actual.full
> > +	)
> > +'
> > +
> >  test_expect_success 'inside git repository but with --no-index' '
> >  	rm -fr is &&
> >  	mkdir -p is/git/sub &&

--
Thomas Gummerer
