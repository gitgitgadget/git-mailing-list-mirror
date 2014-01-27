From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 3/3] builtin/blame.c: large-scale rewrite
Date: Mon, 27 Jan 2014 20:45:06 +0100
Organization: Organization?!?
Message-ID: <87a9eh8b0d.fsf@fencepost.gnu.org>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
	<1390674221-25767-1-git-send-email-dak@gnu.org>
	<1390674221-25767-4-git-send-email-dak@gnu.org>
	<xmqq8uu1pdqq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 20:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7s7g-0004aw-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 20:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbaA0Tp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 14:45:29 -0500
Received: from plane.gmane.org ([80.91.229.3]:35444 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbaA0Tp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 14:45:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W7s7U-0004Ug-Nd
	for git@vger.kernel.org; Mon, 27 Jan 2014 20:45:20 +0100
Received: from x2f3d3f3.dyn.telefonica.de ([2.243.211.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 20:45:20 +0100
Received: from dak by x2f3d3f3.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 20:45:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3d3f3.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:0XqYHQusrpZnNhsIrfHyJVoEkwc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241153>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> The previous implementation uses a sorted linear list of struct
>> blame_entry in a struct scoreboard for organizing all partial or
>> completed work.  Every task that is done requires going through the
>> whole list where most entries are not relevant to the task at hand.
>>
>> This commit reorganizes the data structures in order to have each
>> remaining subtask work with its own sorted linear list it can work off
>> front to back.  Subtasks are organized into "struct origin" chains
>> hanging off particular commits.  Commits are organized into a priority
>> queue, processing them in commit date order in order to keep most of
>> the work affecting a particular blob collated even in the presence of
>> an extensive merge history.  In that manner, linear searches can be
>> basically avoided anywhere.  They still are done for identifying one
>> of multiple analyzed files in a given commit, but the degenerate case
>> of a single large file being assembled from a multitude of smaller
>> files in the past is not likely to occur often enough to warrant
>> special treatment.
>> ---
>
> Sign-off?

Not while this is not fit for merging because of #if 0 etc and missing
functionality.  This is just for review.

> Actually, I'd like to take my previous suggestion to add this as
> blame2 (to replace blame in the future) back.  That was based on my
> fear/hope to see an implementation based on a completely different
> approach, but the basic premise of having one blame_entry record per
> the lines of the final image in the scoreboard, using diff between
> parents to the child to find common lines for passing the blame up,
> etc. have not changed at all and the change is all about organizing
> the pieces of data in a *much* *better* way to avoid needlessly
> finding what we already have computed.

Yes.  Basically, the call graph outside of blame.c itself should be
pretty much the same.

> Style; please make /* and */ sit on their own line without anything
> else in multi-line comments.

Will do.

>> +	struct origin *next;
>>  	struct commit *commit;
>> +	/* `suspects' contains blame entries that may be attributed to
>> +	 * this origin's commit or to parent commits.  When a commit
>> +	 * is being processed, all suspects will be moved, either by
>> +	 * assigning them to an origin in a different commit, or by
>> +	 * shipping them to the scoreboard's ent list because they
>> +	 * cannot be attributed to a different commit.
>> +	 */
>> +	struct blame_entry *suspects;
>>  	mmfile_t file;
>>  	unsigned char blob_sha1[20];
>>  	unsigned mode;
>> +	/* shipped gets set when shipping any suspects to the final
>> +	 * blame list instead of other commits
>> +	 */
>> +	char shipped;
>
> Unused?

More like "added, forgotten, added under yet another name":

>> +	char guilty;

I'll have to decide which one to keep.

>> +		/* Should be present exactly once in commit chain */
>> +		for (p = o->commit->util; p; l = p, p = p->next) {
>> +			if (p == o)
>> +			{
>
> Style; please have { sit with the control structure that opens the
> block, unless it is the opening brace of the function body or
> struct/union definition.

Ok.

>> +static struct blame_entry *
>> +blame_merge(struct blame_entry *list1,
>> +	    struct blame_entry *list2)
>
> Style; we do not do GNU-ish "function name begins a line".  Even
> though I personally find it easier to use for things like 'grep',
> that is not the style we use around here.

Ok.  I'm also certain to have a few "space between function name and
arguments" left and will grep for those before submitting the next
version.

Next version will at least include -M option, possibly leaving -C for
later.

-- 
David Kastrup
