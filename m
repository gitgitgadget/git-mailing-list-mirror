Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B251FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933527AbcGLQUl (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:20:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:34938 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbcGLQUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 12:20:39 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2016 12:20:39 EDT
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id AC9D284610;
	Tue, 12 Jul 2016 12:12:59 -0400 (EDT)
Subject: Re: [PATCH] Add very verbose porcelain output to status
To:	Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>
References: <1467919588-11930-1-git-send-email-jeffhost@microsoft.com>
 <20160712150749.GD613@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, gitster@pobox.com
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5785170E.9070000@jeffhostetler.com>
Date:	Tue, 12 Jul 2016 12:13:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160712150749.GD613@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Thanks for the feedback.  I like the overall direction of your
suggestions.  Going for a porcelain V2 feels better than piling
onto verbose.  I think that would also give us a little more license
to address some of the line format issues that you point out.
Let me retool what I have along these lines and see how it looks.

Thank again,
Jeff




On 07/12/2016 11:07 AM, Jeff King wrote:
> On Thu, Jul 07, 2016 at 03:26:28PM -0400, Jeff Hostetler wrote:
>
>> Tools interacting with Git repositories may need to know the complete
>> state of the working directory. For efficiency, it would be good to have
>> a single command to obtain this information.
>>
>> We already have a `--porcelain` mode intended for tools' consumption,
>> and it only makes sense to enhance this mode to offer more information.
>>
>> Just like we do elsewhere in Git's source code, we now interpret
>> multiple `--verbose` flags accumulatively, and show substantially more
>> information in porcelain mode at verbosity level 2.
>
> Using "--verbose" to change the stable output feels a little funny to
> me. Usually --verbose is about increasing the human-readable output to
> stderr. Of course "--verbose" for git-status is already a little weird.
> A single "-v" seems to do nothing, but two will turn on a diff for the
> long-format output.
>
> But it seems to me this just confuses things more. Why does "git status
> --porcelain -v" do nothing, for example? What happens when we want to
> add more information to the porcelain output later? Do we have to
> require "-vvv" to trigger it, and if so, is there a way to get that
> information without the "-vv" information?
>
> I think the existing example for adding to the --porcelain format is
> the --branch option. Could we have "--state" or something to trigger
> the extra lines?
>
>> +If --branch is given, the first line shows a summary of the current
>> +operation in progress.  This line begins with "### state: ", the name
>> +of the operation in progress, and then operation-specific information.
>> +Fields are separated by a single space.
>
> This seems like a good bit of information to have, and AFAIK we don't
> expose the state information in a machine-readable way. A few nits:
>
>> +    Operation   Fields                     Explanation
>> +    ------------------------------------------------------------------
>> +    clean
>
> Using "clean" here seems weird, as that term is usually meant to mean
> the opposite of dirty (i.e., there is something in your working tree
> that can be committed). But there is no "dirty" here. Would "normal" or
> "none" be a good description?
>
>> +    ------------------------------------------------------------------
>> +    merge       <nr>                       Number unmerged
>
> This <nr> (and others below) is redundant with the rest of the output,
> right (i.e., you could count up the "U" entries yourself)? I don't mind
> it as a convenience, but I'm kind of curious of why it's useful.
>
>> +    ------------------------------------------------------------------
>> +    am          [E]                        Present if the current patch
>> +                                           is empty
>> +    ------------------------------------------------------------------
>> +    rebase      <nr>                       Number unmerged
>> +                [S]                        Present if split commit in
>> +                                           progress during rebase
>> +                [E]                        Present if editing a commit
>> +                                           during rebase
>
> Can a rebased commit be empty? If so, should that state get "E" to match
> "am"?
>
> Does editing differentiate between "stopped because of a conflict that
> needs addressing" versus "stopped because the interactive insn sheet
> told us to"?
>
>> +                [I(<done>/<total>)]        Present if in an interactive
>> +                                           rebase. Step counts are given.
>> +                [<current>:<onto>]         Rebase branches
>
> I wonder if we ought to just use "<current> <onto>" here, as separate
> arguments. A ":" between refs usually signifies a refspec, but that is
> not what this is.
>
> I note this is optional, though. Is there a case where we might have one
> but not the other? That would make things more difficult syntactically.
>
>> +If --branch is given, the second line shows branch tracking information.
>> +This line begins with "### track: ".  Fields are separated by a single
>> +space, unless otherwise indicated.
>> +
>> +    Field                    Meaning
>> +    --------------------------------------------------------
>> +    <sha> | "(initial)"      Current commit
>> +    <branch> | "(detached)"  Current branch
>> +    ":"<upstream>            Upstream branch, if set
>> +    "+"<ahead>               Ahead count, if upstream present
>> +    "-"<behind>              Behind count, if upstream present
>> +    --------------------------------------------------------
>
> This really _ought_ to have been how --branch worked in the first place
> with --porcelain. But unfortunately the existing format has been in the
> wild for a long time. To top it off, the existing format is translated!
> So you cannot even match "Initial commit on (.*)". Yech.
>
> So this looks like a big improvement. And I see now why you wanted
> something like "-vv" to implement this, instead of "--state". In
> addition to adding new lines, this is fixing mistakes made in the prior
> format.
>
> I'm still not convinced that it makes sense to trigger this more-sane
> format with a "verbose" option, though. It's not more verbose. It's just
> less crappy. It would make more sense to me if this was "porcelain v2",
> and triggered with "--porcelain=2" or similar.
>
> Ditto with the new per-file format you introduce (which at least _is_
> more verbose).
>
>> +A series of lines are then displayed for the tracked entries.
>> +Lines have one of the following formats:
>> +
>> +    XYS mH mI mW shaH shaI PATH
>> +    XYS mH mI mW shaH shaI score OLD_PATH\tPATH
>> +    XYS m1 m2 m3 mW sha1 sha2 sha3 PATH
>
> So this is sort of like a --raw diff, but covering the 3 states. That
> makes some sense to me.
>
> I notice in the middle one that there is room for only one rename
> (between the index and HEAD). I guess we cannot have a rename between
> the working tree and the index, because the dst file would have to be a
> new file, which by definition is untracked, and not eligible.
>
> One of the nasty points of the current format is that it is
> context-sensitive. You don't know if you have "PATH" with a space, or
> "score OLD_PATH" until you see whether "X" tells you if you have a
> rename or not. So simple parsing with things like "cut" doesn't work.
>
> Can we collapse these into a single line format where some entries just
> end up with some nil state (e.g., "0" for the score of something that
> isn't a rename)?
>
> While I'm thinking about it, have you looked at how this all works with
> "-z"?
>
>> +* X and Y were described in the short format section.
>> +* S is a one character summary of the submodule status with values '0'..'7'
>> +  representing the sum of: 4 when submodule has a new commit, 2 when the
>> +  submodule is modified, and 1 when the submodule contains untracked changes.
>
> Is there any reason not to give these non-numeric constants? I.e., to
> treat it as a sequence of flags, which can be present or not?
>
>> +  The value is ' ' if the entry is not a submodule.
>
> So would it be:
>
>    XY  100644 ...
>
> with two spaces in that case?
>
> I wonder if it would be less mysterious if the submodule data got its
> own bitfield, like:
>
>    N - not a submodule
>    S[C][M][U] - is a submodule, with one or more of:
>                  - commits (C)
> 		- modifications (M)
> 		- untracked files (U)
>
>> @@ -1380,7 +1382,20 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>   	fd = hold_locked_index(&index_lock, 0);
>>
>>   	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
>> +	if (!s.is_initial)
>> +		hashcpy(s.sha_commit, sha1);
>> +
>>   	s.ignore_submodule_arg = ignore_submodule_arg;
>> +	if (verbose > 1 && status_format == STATUS_FORMAT_PORCELAIN) {
>> +		/* Capture extra data for very verbose porcelain output. */
>> +		s.verbose = verbose;
>
> The existing s.verbose setup happens in the big format-specific switch
> statement below. Should this go there, too? (Though if you have read the
> rest of my email, you know I'd prefer this actually end up as a new
> format).
>
>> +		/* Force safe_crlf off to prevent normal LF/CRLF warning
>> +		 * message from being printed on stderr for each new file.
>> +		 */
>> +		safe_crlf = SAFE_CRLF_FALSE;
>> +	}
>
> Hmm, this seems like something that would be useful for all formats. It
> comes from doing a diff at all, right?
>
>> [...]
>
> I gave only a brief skim over the rest of the code, as I think the
> design issues are more interesting at this stage.
>
> Please don't let the length of my comments discourage you; I think this
> is a good direction to be going. I did find I had to piece together the
> rationale a bit from looking at the patch itself. I think it would be
> easier to understand as a few patches:
>
>    - add infrastructure and rules for a new v2 porcelain format; the
>      format is still in flux for the next few patches, but will be
>      cemented at release time (in your world-view this is the "more
>      verbose format", but I'm taking the liberty of pretending you agree
>      with everything I wrote above ;) ).
>
>    - add v2 per-file format; the rationale is that the existing format
>      leaves out some details. And also that it's hard to parse (if you
>      agree that we should clean up those cases).
>
>    - convert "--branch" output in v2 to what you have here; the rationale
>      is that the existing format is horribly unstable
>
>    - add "--state"; the rationale is that there isn't a machine-readable
>      way to get this data right now. This can be independent of the v1/v2
>      flag, since we output it only when asked for, and v1-era git didn't
>      have it at all.
>
>    - the SAFE_CRLF_FALSE tweak above; this seems orthogonal to the rest
>      of it, but offhand seems like a reasonable idea to me.
>
> -Peff
>
