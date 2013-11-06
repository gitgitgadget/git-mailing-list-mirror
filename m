From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Wed, 06 Nov 2013 07:43:55 +0100 (CET)
Message-ID: <20131106.074355.225932577498673677.chriscool@tuxfamily.org>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
	<xmqqli14yoqi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 06 07:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdwql-0000aI-S2
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 07:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab3KFGoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 01:44:20 -0500
Received: from [194.158.98.15] ([194.158.98.15]:63997 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750811Ab3KFGoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 01:44:19 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 26C594F;
	Wed,  6 Nov 2013 07:43:56 +0100 (CET)
In-Reply-To: <xmqqli14yoqi.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237348>

From: Junio C Hamano <gitster@pobox.com>
> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>> * "trailer" seems better than "commitTrailer" as the config key because
>> it looks like all the config keys are lower case and "committrailer" is not
>> very readable.
> 
> And closes the door for other things from later acquiring trailers?

I don't think it really closes the door, as they can have a name like
"stufftrailer" then. Or better they could call it something else than
"trailer" everywhere from the beginning to avoid mistakes in the first
place.

Or if they are really trailers, for example maybe tag trailers, then
in many cases they might want to share the same configuration as
commit trailers. In this case, it would be a mistake to use
"commitTrailer" when most people would like them to also apply to
tags.

If/when tag trailers appear, then we can decide that "trailer"  is
common for all trailers, "commitTrailer" is for commits only and
"tagTrailer" for tags only.

And anyway commit trailers have existed since the beginning or nearly
the beginning of Git, and we haven't seen yet any other kind of
trailer, so it's reasonnable to think that we can safely take the name
and not worry, be happy.

>> * "trailer.<token>.value" looks better than "trailer.<token>.trailer", so
>> I chose the former.
> 
> If that is a literal value, then I think ".value" is indeed good.

That was what I thought first too.

But, after thinking about what Johan said, I think that it might be
confusing for some people, so now I wonder if I should call it "key".

>> * Rather than only one "trailer.<token>.style" config option, it seems
>> better to me to have both "trailer.<token>.if_exist" and
>> "trailer.<token>.if_missing".
> 
> As there is no ".if_exist", ".if_missing", etc. here, I cannot guess
> what these "seemingly independent and orthogonal, but some
> combinations are impossible" configuration variables are meant to be
> used, let alone agreeing to the above claim that they are better
> than a single ".style".

Yeah, I should have explained more. So I will do it now.

In the code I used the following enums:

enum style_if_exist { DONT_REPEAT, OVERWRITE, REPEAT };
enum style_if_missing { DONT_APPEND, APPEND };

The style_if_exist enum is meant to decide what is done when we have
to deal with 2 or more trailers, from the infile or the command line,
that have the same key but different not empty values.

For example, me might have the 3 following trailers:

"Acked-by: joe <joe@example>"
"Acked-by: bob <bob@example>"
"Acked-by: joe <joe@example>"

- The DONT_REPEAT style, which should be the default in my opinion,
would mean that we don't repeat the same values. So we would get:

"Acked-by: joe <joe@example>"
"Acked-by: bob <bob@example>"

- The OVERWRITE style would mean that we keep only one, (for example
the last one). So we would get:

"Acked-by: joe <joe@example>"

- The REPEAT style would mean that we keep everything. So we would
get:

"Acked-by: joe <joe@example>"
"Acked-by: bob <bob@example>"
"Acked-by: joe <joe@example>"

The style_if_missing enum is meant to decide what is done when we have
no trailer with the specified key. Then DONT_APPEND means that we do
nothing, which should be the default, and APPEND means that we append
a trailer with the specified key.

Of course in the latter case, a command should probably be specified
to tell which value should be used with the key.

For example:

[trailer "signoff"]
	 key = "Signed-off-by:"
	 if_missing = append
	 command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

would append a s-o-b line only if there is no s-o-b already. 

Note that to always append a specific trailer one could use:

[trailer "signoff"]
	 key = "Signed-off-by:"
	 if_missing = append
	 if_exist = repeat
	 command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

> I think you took the ".style" from my
> thinking-aloud message the other day, but that aloud-thinking lead
> to ".style" by taking various use cases people wanted to have
> footers into account, including:

Ok, I will try to guess below, how the use cases could be configured.

>  - just appending, allowing duplication of the field name (e.g. more
>    than one "cc:" can name different recipients);

That would be the default (if_exist = dont_repeat, if_missing = dont_append).

>  - appending, allowing duplication of the field <name,val> pair
>    (e.g. a patch that flowed from person A to B and possibly
>    somewhere else then finally back to A may have "Signed-off-by:
>    A", chain of other's Sob, and another "Signed-off-by: A");

That would be: if_exist = repeat, if_missing = dont_append

>  - appending, but without consecutive repeats (e.g. the same
>    "Signed-off-by:" example; person A does not pass a patch to
>    himself, adding two same <name,val> pair next to each other);

I could add a DONT_REPEAT_PREVIOUS into the style_if_exist enum, for
this case.

Then that would be: if_exist = dont_repeat_previous, if_missing = dont_append

>  - adding only if there is no same <name> (e.g. "Change-Id:");

I could add a DONT_APPEND into the style_if_exist enum, for this case.

Then that would be: if_exist = dont_append, if_missing = append

>  - adding only if there is no <name,val> pair (e.g. "Closes: #bugId");

That would be: if_exist = dont_repeat, if_missing = append

>  - adding one if there is none, replacing one if there already is.

That would be: if_exist = overwrite, if_missing = append

> I do not think it is easier for users to express these (and other)
> semantics as combinations of "seemingly independent and orthogonal,
> but some combinations are impossible" configuration variables.

With what I suggest, I don't think there would be some impossible
combinations.

>> * I might send a patch series instead of just one big patch when there will
>> be fewer big changes in the code.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  .gitignore                    |   1 +
>>  Makefile                      |   1 +
>>  builtin.h                     |   1 +
>>  builtin/interpret-trailers.c  | 284 ++++++++++++++++++++++++++++++++++++++++++
>>  git.c                         |   1 +
>>  strbuf.c                      |   7 ++
>>  strbuf.h                      |   1 +
> 
> I think you're better off having trailers.c at the top level that is
> called from builtin/interpret-trailers.c (aside from names), so that
> we can later hook the former up with builtin/commit.c codepath.

Ok, I will do that.

Thanks,
Christian.
