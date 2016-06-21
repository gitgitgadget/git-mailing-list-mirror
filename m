Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AFE41FE4E
	for <e@80x24.org>; Tue, 21 Jun 2016 05:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbcFUFOI (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 01:14:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751628AbcFUFOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 01:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D72871E231;
	Tue, 21 Jun 2016 01:11:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JLIHcUsxG/qUshfffyztSF9Sng4=; b=hH3GT7
	kG0UUY1jRu1n+szPsEIrzdhlJweJmRaEpzeYh5ZLMbyrVdCGFYqNXXfPSkG4IYJ/
	AEdtQhfpZBq7Mwz+WCc0Ej+TOqlC+dBcEMSZtNFLUPz4IdxTNo/uNTKaknI8PsDg
	jxmsJ9nemX7PMEw0miMiY9eE+w0LVD+zoypgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YUcz3Mb9vVaLmWAlaSu7oKru90zgUkMv
	AnbH2pwyLwJ99WSahtPEDqA0097hrFDCqhIf3EBdlhBQ+75p6M3iddu7beAV0Plv
	Kyv3D516J7MSijMX0AeUeyV+EMsRvtk02hagENW3a9OPz18suju/FNBWRL/Ao2RK
	OgTRu2p+xy4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D040B1E230;
	Tue, 21 Jun 2016 01:11:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6669D1E22F;
	Tue, 21 Jun 2016 01:11:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Emily Xie <emilyxxie@gmail.com>
Cc:	git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH] pathspec: warn on empty strings as pathspec
References: <20160621021515.64964-1-emilyxxie@gmail.com>
Date:	Mon, 20 Jun 2016 22:11:20 -0700
In-Reply-To: <20160621021515.64964-1-emilyxxie@gmail.com> (Emily Xie's message
	of "Mon, 20 Jun 2016 22:15:15 -0400")
Message-ID: <xmqqd1nbrurr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9868BAC0-376E-11E6-AB46-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> For any command that takes a pathspec, passing an empty string will
> execute the command on all files in the current directory.

OK.

> This
> results in unexpected behavior.

Technically speaking, your expectation is what is wrong here.  An
empty string as a pathspec matches all paths.

> For example, git add "" adds all
> files to staging, while git rm -rf "" recursively removes all files
> from the working tree and index.

That is a logical consequence that an empty string is a pathspec
that matches everything.  If somebody wants to add everything in
their current directory, they can say 'git add ""'.  If you do not
want to do so, don't say 'git add ""'.

You need to argue why these are bad things to convince those who are
used to the current behaviour that it is OK to break them.

Here is my attempt.

	An pathspec that is an empty string has been interpreted to
	match any path, as pathspec match is a leading substring
	match that honours directory boundary.  Just like pathspec
	"dir/" (or "dir") matches "dir/file", "" matches "file".

	However, a carelessly-written script may result in an empty
	string assigned to a variable (perhaps caused by a bug in
	it), and may end up passing an empty string to a Git command
	invocation, i.e.

        	git rm "$path"
        	git add "$path"
		
	which would affect all paths in the current directory.

	We cannot simply reject an empty string given as a pathspec
	to prevent this kind of mistake.  Because there surely are
	existing scripts that take advantage of the fact that an
	empty string matches all paths, such a change will break
	scripts that legitimately have been using an empty string
	for that purpose.

	Instead, we need two step approach.  The first step is to
	notice that the caller used an empty string as a pathspec,
	give a warning to (1) declare that the use of an empty
	string as "match all" will become invalid and (2) ask them
	to use "." instead if they mean "match all".

	After some release cycles, we can remove the warning and
	turn an empty string used as a pathspec element as an error.

	This patch is the first step.


> A two-step implemetation will
> prevent such cases.

There is some leap/gap in logic here.  

> This patch, as step one, invokes a warning whenever an empty
> string is detected as a pathspec, introducing users to the upcoming
> change. For step two, a follow-up patch several release cycles later
> will remove the warnings and actually implement the change by
> throwing an error instead.

This paragraph is OK, but I think I ended up covering the whole
thing in my attempt ;-).


> Signed-off-by: Emily Xie <emilyxxie@gmail.com>
> Reported-by: David Turner <novalis@novalis.org>
> Mentored-by: Michail Denchev <mdenchev@gmail.com>
> Thanks-to: Sarah Sharp <sarah@thesharps.us> and James Sharp <jamey@minilop.net>
> ---
>  pathspec.c     | 6 +++++-
>  t/t3600-rm.sh  | 6 +++++-
>  t/t3700-add.sh | 4 ++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index c9e9b6c..79e370e 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -402,8 +402,12 @@ void parse_pathspec(struct pathspec *pathspec,
>  	}
>  
>  	n = 0;
> -	while (argv[n])
> +	while (argv[n]) {
> +		if (*argv[n] == '\0')
> +			warning(_("empty strings are not valid pathspecs and will no longer "
> +			          "be supported in upcoming releases"));
>  		n++;

Three issues:

 * if argv[1] and argv[2] are both emtpy, the user will see the same
   message twice.  Is it intended?  Is it acceptable?

 * "Empty strings are not valid pathspecs" is just plain wrong.  It
   has been valid, but the warning message notifies that we are
   going to make it invalid what has been valid.

 * "Will no longer be supported" is just plain useless.  We are
   notifying that we will turn what they have been using as a valid
   feature invalid.  What needs to accompany that notification is
   how to update their script that have been happily working, which
   we are going to break with the future change, in a way that will
   keep working, i.e. "please use . instead if you meant to match
   all".


> +test_expect_success 'rm empty string should invoke warning' '
> +	git rm -rf "" 2>&1 | grep "warning: empty string"
> +'

As your warning is in _("..."), you would need test_i18grep here, I think.

> +test_done
> \ No newline at end of file

Oops.
