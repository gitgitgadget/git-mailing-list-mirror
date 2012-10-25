From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv2] git-status: show short sequencer state
Date: Thu, 25 Oct 2012 12:05:16 -0400
Message-ID: <5089633C.8030307@cisco.com>
References: <1351022574-27869-1-git-send-email-hordp@cisco.com> <1351022574-27869-2-git-send-email-hordp@cisco.com> <20121025092919.GG8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRPw7-0001m0-Db
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 18:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908Ab2JYQFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 12:05:22 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:24847 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab2JYQFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=9339; q=dns/txt; s=iport;
  t=1351181121; x=1352390721;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=iClpCn9lIazFx8HZae9Cz4QCnklHQQ+pXyfinKPq93A=;
  b=FsMkz+D42tOFVg7yKnGchMavGZ88fXtRQpDQCxb6TOTC3NAPokr8ApVW
   sLRHz4FU/FAKZX3zI+Cl23Vc2Ss23Iigdpi2+v0HcgOLeRqefuOaJlbMk
   d/bEVVOin+AbiiebCS8vitsxRWZToNWoCVh/D0X3H0yLiHS2p0ty5dyjW
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFANxiiVCtJV2Z/2dsb2JhbABEhha8DIEIgh4BAQEDARIBEFUBBQsLDgoCAgUWCwICCQMCAQIBRQYNAQcBAR6HXAaeVI0iknqBIIpBhVqBEwOVdIVmiGyBa4ML
X-IronPort-AV: E=Sophos;i="4.80,648,1344211200"; 
   d="scan'208";a="135332122"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-6.cisco.com with ESMTP; 25 Oct 2012 16:05:20 +0000
Received: from [64.100.104.96] (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id q9PG5JH5015942;
	Thu, 25 Oct 2012 16:05:19 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <20121025092919.GG8390@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121025120516259
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208405>


Jeff King wrote:
> On Tue, Oct 23, 2012 at 04:02:54PM -0400, Phil Hord wrote:
>
>> Teach git-status to report the sequencer state in short form
>> using a new --sequencer (-S) switch.  Output zero or more
>> simple state token strings indicating the deduced state of the
>> git sequencer.
>>
>> Introduce a common function to determine the current sequencer
>> state so the regular status function and this short version can
>> share common code.
>>
>> Add a substate to wt_status_state to track more detailed
>> information about a state, such as "conflicted" or "resolved".
>> Move the am_empty_patch flage out of wt_status_state and into
> This patch ended up quite long. It might be a little easier to review
> if it were broken into refactoring steps (I have not looked at it too
> closely yet, but it seems like the three paragraphs above could each be
> their own commit).

I can do that.

>> State token strings which may be emitted and their meanings:
>>     merge              a git-merge is in progress
>>     am                 a git-am is in progress
>>     rebase             a git-rebase is in progress
>>     rebase-interactive a git-rebase--interactive is in progress
> A minor nit, but you might want to update this list from the one in the
> documentation.

I considered it, but I also considered the audience; then I took the
easier path.  I'll look again.

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index a17a5df..9706ed9 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -114,7 +114,8 @@ static struct strbuf message = STRBUF_INIT;
>>  static enum {
>>  	STATUS_FORMAT_LONG,
>>  	STATUS_FORMAT_SHORT,
>> -	STATUS_FORMAT_PORCELAIN
>> +	STATUS_FORMAT_PORCELAIN,
>> +	STATUS_FORMAT_SEQUENCER
>>  } status_format = STATUS_FORMAT_LONG;
> Hmm. So the new format is its own distinct output format. I could not
> say "I would like to see short status, and by the way, show me the
> sequencer state", as you can with "-b". Is it possible to do this (or
> even desirable; getting the sequencer state should be way cheaper, so
> conflating the two may not be what some callers want).
>
> Not complaining, just wondering about the intended use cases.

Originally I did place this output in the short-format display.  I
particularly want this info to be available for scripts. But it feels
"right" to include it with the short status, since the long-form is
already available with 'git status --no-short'.

Since there may be more than one line reported, I did not feel there was
a simple way to contain these details in with the short status.  For
branch this is a simple decision as the reported branch will take
exactly one line.

  git status -b -s
  ## master
   M Foo

But for sequencer state, this seemed like it could be too convoluted or
might encourage too much reliance line-counting:

  git status -b -s -S
  ## master
  ## merge
  ## conflicted
   M Foo

Maybe a different line-prefix would help make this clearer:

  git status -b -s -S
  ## master
  #! merge
  #! conflicted
   M Foo

It seemed to me this was someone else's itch and I might not scratch it
properly.  But I am willing to try if you think this is more useful than
distracting.

> Also, does there need to be a --porcelain version of this output? It
> seems like we can have multiple words (e.g., in a merge, with conflicted
> entries). If there is no arbitrary data, we do not have to worry about
> delimiters and quoting.  But I wonder if we would ever want to expand
> the information to include arbitrary strings, at which point we would
> want NUL delimiters; should we start with that now?

This works, though I haven't tested it on v2:

   git status -S -z


>> +	// Determine main sequencer activity
> Please avoid C99 comments (there are others in the patch, too).

Thanks.

>> +void wt_sequencer_print(struct wt_status *s)
>> +{
>> +	struct wt_status_state state;
>> +
>> +	wt_status_get_state(s, &state);
>> +
>> +	if (state.merge_in_progress)
>> +		wt_print_token(s, "merge");
>> +	if (state.am_in_progress)
>> +		wt_print_token(s, "am");
>> +	if (state.rebase_in_progress)
>> +		wt_print_token(s, "rebase");
>> +	if (state.rebase_interactive_in_progress)
>> +		wt_print_token(s, "rebase-interactive");
>> +	if (state.cherry_pick_in_progress)
>> +		wt_print_token(s, "cherry-pick");
>> +	if (state.bisect_in_progress)
>> +		wt_print_token(s, "bisect");
>> +
>> +	switch (state.substate) {
>> +	case WT_SUBSTATE_NOMINAL:
>> +		break;
>> +	case WT_SUBSTATE_CONFLICTED:
>> +		wt_print_token(s, "conflicted");
>> +		break;
>> +	case WT_SUBSTATE_RESOLVED:
>> +		wt_print_token(s, "resolved");
>> +		break;
>> +	case WT_SUBSTATE_EDITED:
>> +		wt_print_token(s, "edited");
>> +		break;
>> +	case WT_SUBSTATE_EDITING:
>> +		wt_print_token(s, "editing");
>> +		break;
>> +	case WT_SUBSTATE_SPLITTING:
>> +		wt_print_token(s, "splitting");
>> +		break;
>> +	case WT_SUBSTATE_AM_EMPTY:
>> +		wt_print_token(s, "am-empty");
>> +		break;
>> +	}
>> +}
> It is clear from this code that some tokens can happen together, and
> some are mutually exclusive. Should the documentation talk about that,
> or do we want to literally keep it as a list of tags?
>
> -Peff

I want to literally keep it as a list of tags.  This code does not
presume any exclusivity in the main state and I I do not think it
should.  I can imagine being in a "rebase cherry-pick conflicted" state,
even though the current wt_status_get_state function does not allow
detecting it.  I think that function is overly restrictive, but it was
not important to me yet.

Perhaps it is useful to indicate that the substate values are mutually
exclusive, but I also feel like this is an implementation detail.  It is
possible to be in "rebase-interactive edited conflicted" state, but it
is not possible for this code to tell you that. But should we document
that fact and thus restrict future improvement in this area?  My first
inclination is to say no, that we should leave this open.  But on the
other hand, I can see how someone could be confused if their expected
token never appeared only because another one took precedence.

Maybe the exclusive states should be explicit in the implementation. 
Maybe I should not have a substate at all but each of these substates
should be a separate boolean (or ternary).  Something like this:

 struct wt_status_state {
        int merge_in_progress;
        int am_in_progress;
+       int am_empty_patch;
-       int rebase_in_progress;
-       int rebase_interactive_in_progress;
+       int rebase_in_progress;       /* 0=no, 1=normal, 2=interactive */
        int cherry_pick_in_progress;
        int bisect_in_progress;
        enum wt_status_substate substate;
+       int conflicts;                    /* 0=none, 1=yes, 2=resolved */
+       int editing;                      /* 0=no, 1=editing, 2=edited */
 };

My primary motivation is to standardize the detection of these various
states so scripts do not need to know, for example, to look for the
presence of '$GIT_DIR/rebase-merge' or that a zero-length
'$GIT_DIR/rebase-apply/patch' is significant.  An immediate need is to
show some tags in my shell prompt when my current state is not clean. 
The current patch meets this latter need well.  If I add the output of
$(git status -S) to my prompt, I see nothing when I am "clean" and I see
_something_ when I am not.

But the former need is not so clear.  A script today which is interested
in an interactive rebase may simply say $(git status -S | grep
"^rebase-interactive$").  But a new flavor of rebase in the future could
muddy the waters.  Maybe there is a need for another reporting state
which provides a definitive answer on all possible tokens.  Consider
that I am in an interactive-rebase which has encountered a conflict. 

1. Simple state, useful for humans and prompts:

  $ git status -S    
  rebase-interactive
  conflicted


2. More details for scripts who may not care to distinguish between
inclusive things like "rebase" and "rebase-interactive":

  $ git status -S=detailed
  rebase
  rebase-interactive
  conflicted


3. Complete disambiguation:

  git status -S=all
  no-merge
  no-am
  rebase
  rebase-interactive
  no-cherry-pick
  no-bisect
  conflicted
  no-resolved
  no-edited
  no-editing
  no-splitting
  no-am-empty

Now a script interested in a condition can check for it explicitly in
two forms: "condition" and "no-condition".  If neither is found, he can
assume that his token is obsolete (possibly it was replaced with
something more explicit).  And if his goal is to detect any kind of
rebase, he can look for the "rebase" token rather than worrying about
its myriad types.

But at this point I feel overwhelmed by the possibilities.  Uncertainty
comes from trying to scratch someone else's itch.  But at the same time,
I do want to make this status-detector appealing as "The One True Way to
check git's state" to avoid more deviating implementations in the future.

And so I am conflicted.

I apologize for being so long-winded on this.  Thanks for playing
along.  I welcome your thoughts and advice.

Phil
