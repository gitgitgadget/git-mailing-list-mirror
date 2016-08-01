Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB861F855
	for <e@80x24.org>; Mon,  1 Aug 2016 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbcHAPvf (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 11:51:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:37294 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753935AbcHAPvd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 11:51:33 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 82776845D2;
	Mon,  1 Aug 2016 11:41:46 -0400 (EDT)
Subject: Re: [PATCH v3 7/8] status: update git-status.txt for --porcelain=v2
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
 <1469567483-58794-8-git-send-email-git@jeffhostetler.com>
 <fe5d1dd7-11da-e09b-5880-cf103e34fb9a@gmail.com>
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <579F6D3A.3010704@jeffhostetler.com>
Date:	Mon, 1 Aug 2016 11:39:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <fe5d1dd7-11da-e09b-5880-cf103e34fb9a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/30/2016 01:22 PM, Jakub Narębski wrote:
> W dniu 26.07.2016 o 23:11, Jeff Hostetler pisze:
>
> This is a nice change, available because of lack of backward
> compatibility with v1.  The porcelain v2 format branch-related
> information could be enhanced without risk of breaking parsers,
> or having new information put at the end even if it does not fit
> there (like in previous iteration).
>
> One thing that can serve as goal for the series is using the
> question: would it make __git_ps1() from git-prompt.sh be able
> to render fully decorated prompt with all bells and whistles,
> and with all combinations of options.  Thus beside upstream
> in the future we might want SVN upstream, and/or pushed-to
> remote branch (and remote push upstream repository), etc.
>
> But that's for the future (and it is possible for the future)...
>

Yes, I was hoping to be able to simplify and/or speed up
__git_ps1() with this data.  "Namespacing" the branch data
here.  And then later add the state data (in a merge,
in a rebase, and etc.) in a series of "# state.*" headers.
And so on, until we get everything that __git_ps1() needs.
However, to really make that work, we might want to add
a --no-scan (or minimial scan) option, to just return the
header data, since __git_ps1() doesn't care about the list
of changes.


>> +
>> +A series of lines are then displayed for the tracked entries.
>> +Ordinary changed entries have the following format:
>> +
>> +    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
>> +
>> +Renamed or copied entries have the following format:
>> +
>> +    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><nr> <path>\t<pathSrc>
>
> Nice solution to avoid those all zeros / null-SHA1s

Thanks.


>> +Unmerged entries have the following format; the first character is
>> +a "u" to distinguish from ordinary changed entries.
>> +
>> +    u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
>> +
>> +    Field       Meaning
>> +    --------------------------------------------------------
>> +    <XY>        A 2 character field describing the conflict type
>> +                as described in the short format.
>> +    <sub>       A 4 character field describing the submodule state
>> +                as described above.
>> +    <m1>        The octal file mode for stage 1.
>> +    <m2>        The octal file mode for stage 2.
>> +    <m3>        The octal file mode for stage 3.
>> +    <mW>        The octal file mode in the worktree.
>> +    <h1>        The SHA1 value for stage 1.
>> +    <h2>        The SHA1 value for stage 2.
>> +    <h3>        The SHA1 value for stage 3.
>> +    <path>      The current pathname.
>> +    --------------------------------------------------------
>
> A question: do unmerged entries always have only one single filename?
> Or unmerged entries are always only about CONFLICT(contents), and no
> other?

As far as I could tell, unmerged rename conflicts appear with a single
filename.

When I did a divergent rename (in both branches), merge creates
     a stage-1 "DD" entry,
     a stage-2 "AU" entry, and
     a stage-3 with a "UA" entry.
     Status reports it as 3 rows.

When I did a rename in one branch and an edits in both, merge
creates: either a "DU" or "UD" conflict (depending on the direction
of the merge).

Given that the index is ordered and accessed by path (and there is
no pathname field in a cache entry to link it to a different one),
I have to say that this is true.

>
> Would a note (or a link to other documentation) about octopus merges
> be out of place here?

I put a note in the code about it reporting the last entry at each
stage that are present in the index, but I'm not sure about how much
we want to say here.

If octopus finds conflicts, the worktree will probably be in a
funky state anyway.

>
>> +
>> +A series of lines are then displayed for untracked and ignored entries.
>> +
>> +    <x> <path>
>> +
>> +Where <x> is "?" for untracked entries and "!" for ignored entries.
>
> A question: are they displayed in that order, i.e. first all untracked,
> then all ignored, or it is something one cannot rely about?

With the unique prefix character it shouldn't matter.  I do print
all the '?' lines first then all the '!' lines, so the manpage
could be clarified if we wanted. I was just trying to save another
paragraph in the manpage.

>
>> +
>> +In all 3 line formats, pathnames will be "C Quoted" if they contain
>
> "C Quoted" or "C-Quoted"?  How it is described in other places of
> the Git documentation?
>

I was probably inconsistent, I think it should be "c-quoted" (with the
hypen) providing we like this term.

Each of the git-diff*.txt and diff-format.txt files talk about
this quoting scheme, but none give it an explicit name.


>> +any of the following characters: TAB, LF, double quotes, or backslashes.
>> +These characters will be replaced with \t, \n, \", and \\, respectively,
>> +and the pathname will be enclosed in double quotes.
>> +
>> +When the `-z` option is given, a NUL (zero) byte follows each pathname;
>> +serving as both a separator and line termination. No pathname quoting
>> +or backslash escaping is performed. All fields are output in the same
>> +order.
>
> Does it mean that
>
>      2 [...] <cq-path>\t<cq-pathSrc>\n
>
> line (including line terminator) is replaced with
>
>      2 [...] <path>\0<pathSrc>\0
>
> that is, it replaces a separator (TAB, "\t") and line termination (LF, "\n");
> here spelled in full?
>

Yes.  Let me try to clarify that in the manpage.

Thanks,
Jeff


