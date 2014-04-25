From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git
 interpret-trailers'
Date: Fri, 25 Apr 2014 23:07:10 +0200 (CEST)
Message-ID: <20140425.230710.1024850359228182788.chriscool@tuxfamily.org>
References: <5343A589.10503@alum.mit.edu>
	<CAP8UFD0RftewWj-oivojUrXCDqXUq6xX7ndQdixA2i=1BzZEFg@mail.gmail.com>
	<534414FB.6040604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	jrnieder@gmail.com
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 25 23:07:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdnLP-0007BY-0J
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 23:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaDYVHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 17:07:34 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:38661 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751091AbaDYVHc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 17:07:32 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6A6EC42;
	Fri, 25 Apr 2014 23:07:10 +0200 (CEST)
In-Reply-To: <534414FB.6040604@alum.mit.edu>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247113>

From: Michael Haggerty <mhagger@alum.mit.edu>
>
> On 04/08/2014 01:35 PM, Christian Couder wrote:
>> 
>> The trailers are recognized in the input commit message using the
>> following rules:
>>  - only lines that contains a ':' are considered trailers,
>>  - the trailer lines must all be next to each other,
>>  - after them it's only possible to have some lines that contain only spaces,
>>  - before them there must be at least one line with only spaces
> 
> Thanks for all the explanation.  I think that most/all of this
> information should be included in the documentation.

Ok, I included the above rules in v11, but maybe not other pieces of
information that you might have wanted.

>>>> +OPTIONS
>>>> +-------
>>>> +--trim-empty::
>>>> +     If the 'value' part of any trailer contains only whitespace,
>>>> +     the whole trailer will be removed from the resulting message.
>>>
>>> Does this apply to existing trailers, new trailers, or both?
>> 
>> Both.
>> 
>>> If it applies to existing trailers, then it seems a bit dangerous, in the
>>> sense that the command might end up changing trailers that are unrelated
>>> to the one that the command is trying to add.
>> 
>> The command is not just for adding trailers.
>> But there could be an option to just trim trailers that are added.
> 
> Maybe that should be the *only* behavior of this option.
> 
> Maybe there should be a trailer.<token>.trimEmpty config option.

One possible usage of the "git interpret-trailers" command that was
discussed in the early threads was the following:

1) You have a commit message template like the following:

-----------------
***SUBJECT***

***MESSAGE***

Fixes: 
Cc: 
Cc: 
Reviewed-by: 
Reviewed-by: 
Signed-off-by: 
-----------------

2) The user add some information when committing:

$ git commit --trailer "Fixes:534" --trailer "Signed-off-by: Michael <mhagger@alum.mit.edu>"

3) "git interpret-trailers" is used automatically by "git commit"
without --trim-empty, and it is passed the --trailer arguments and the
commit message template, so the user is shown the result which is for
example the following:

-----------------
***SUBJECT***

***MESSAGE***

Fixes: 534
Cc: 
Cc: 
Reviewed-by: 
Reviewed-by: 
Signed-off-by: Michael <mhagger@alum.mit.edu>
-----------------

4) The user adds some information and the resulting message is for
example:

-----------------
Doing foo and bar

And also baz.

Fixes: 534
Cc: 
Cc: Peff <peff@peff.net>
Reviewed-by: Junio <gitster@pobox.com>
Reviewed-by: 
Signed-off-by: Michael <mhagger@alum.mit.edu>
-----------------

5) Then a post commit hook automatically uses "git interpret-trailers
--trim-empty" on the result, so the commit message is eventually the
following:

-----------------
Doing foo and bar

And also baz.

Fixes: 534
Cc: Peff <peff@peff.net>
Reviewed-by: Junio <gitster@pobox.com>
Signed-off-by: Michael <mhagger@alum.mit.edu>
-----------------

So I think it could be very useful to have --trim-empty work on all
the trailers, not just those passed as arguments.

>>> If a commit message containing trailer lines with separators other than
>>> ':' is input to the program, will it recognize them as trailer lines?
>> 
>> No, '=' and '#' are not supported in the input message, only in the output.
>> 
>>> Do such trailer lines have to have the same separator as the one listed
>>> in this configuration setting to be recognized?
>> 
>> No they need to have ':' as a separator.
>> 
>> The reason why only ':' is supported is because it is the cannonical
>> trailer separator and it could create problems with many input
>> messages if other separators where supported.
>> 
>> Maybe we could detect a special line like the following:
>> 
>> # TRAILERS START
>> 
>> in the input message and consider everyhting after that line as trailers.
>> In this case it would be ok to accept other separators.
> 
> It would be ugly to have to use such a line.  I think it would be
> preferable to be more restrictive about trailer separators than to
> require something like this.

The code is already very restrictive about trailer separators.

> From what you've said above, it sounds like your code might get confused
> with the following input commit message:
> 
>     This is the human-readable comment
> 
>     Foo: bar
>     Fixes #123
>     Plugh: xyzzy
> 
> It seems to me that none of these lines would be accepted as trailers,
> because they include a non-trailer "Fixes" line (non-trailer in the
> sense that it doesn't use a colon separator).

Yeah, they would not be accepted because the code is very restrictive.

The following would be accepted:

     Foo: bar
     Fixes: 123
     Plugh: xyzzy

>>> I suppose that there is some compelling reason to allow non-colon
>>> separators here.  If not, it seems like it adds a lot of complexity and
>>> should maybe be omitted, or limited to only a few specific separators.
>> 
>> Yeah, but in the early threads concerning this subject, someone said
>> that GitHub for example uses "bug #XXX".
>> I will have a look again.
> 
> Yes, that's true: GitHub recognizes strings like "fixes #33" but not if
> there is an intervening colon like in "fixes: #33".  OTOH GitHub
> recognizes such strings wherever they appear in the commit message (they
> don't have to be in "trailer" lines).  So I'm not sure that the added
> complication is worth it if GitHub is the only use case.  (And maybe we
> could convince GitHub to recognize "Fixes: #33" if such syntax becomes
> the de-facto Git standard for trailers.)

I don't think there is a lot of complexity.
But maybe I need to explain how it works better.
Feel free to suggest me sentences I could add.

>>>> +With `addIfDifferent`, a new trailer will be added only if no trailer
>>>> +with the same (token, value) pair is already in the message.
>>>> ++
>>>> +With `addIfDifferentNeighbor`, a new trailer will be added only if no
>>>> +trailer with the same (token, value) pair is above or below the line
>>>> +where the new trailer will be added.
>>>> ++
>>>> +With `add`, a new trailer will be added, even if some trailers with
>>>> +the same (token, value) pair are already in the message.
>>>> ++
>>>> +With `overwrite`, the new trailer will overwrite an existing trailer
>>>> +with the same token.
>>>
>>> What if there are multiple existing trailers with the same token?  Are
>>> they all overwritten?
>> 
>> No, if where == after, only the last one is overwritten, and if where
>> == before, only the first one is overwritten.
>> 
>> I could add an "overwriteAll" option. It could be interesting to use
>> when a command using "$ARG" is configured, as this way the command
>> would apply to all the trailers with the given token instead of just
>> the last or first one.
> 
> It seems to me that the current behavior (rewriting exactly one existing
> line) is not that useful.  Why not make "overwrite" overwrite *all*
> existing matching lines?

I was thinking that people could use the following template message:

---------------
Signed-off-by: 
Signed-off-by: YOU-WILL-BE-AUTOMATICALLY-ADDED-HERE
---------------

and the following config:

---------------
[trailer "s-o-b"]
	 key = "Signed-off-by: "
	 ifexist = overwrite
	 command = echo \"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>\"
---------------

This way the user can add other people's s-o-b before the last one
which will always contain his own s-o-b.

>>>> +If the command contains the `$ARG` string, this string will be
>>>> +replaced with the 'value' part of an existing trailer with the same
>>>> +token, if any, before the command is launched.
>>>
>>> What if the key appears multiple times in existing trailers?
>> 
>> It will be done only once for the last or first trailer with the key
>> depending on "where".
> 
> It seems like the UI for "git interpret-trailers" is optimized for
> trailers that appear only once.  That's a bit limiting.

As I said, it is possible to add an overwriteAll option.
I think that would fix the current limitations.

> Maybe it would
> be better to pipe the existing values to the command's standard input,
> one per line?  For example, suppose we run
> 
>     git interpret-trailers \
>         Signed-off-by='Christian Couder <christian.couder@gmail.com>'
> 
> with the following input:
> 
>     Human-readable subject
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     Signed-off-by: Christian Couder <christian.couder@gmail.com>
> 
> Then the following three lines could be piped to the command (i.e., one
> value per line, without the key):
> 
>     Junio C Hamano <gitster@pobox.com>
>     Christian Couder <christian.couder@gmail.com>
>     Christian Couder <christian.couder@gmail.com>
> 
> Then, supposing the command were "sort --unique", the command's output
> would be
> 
>     Christian Couder <christian.couder@gmail.com>
>     Junio C Hamano <gitster@pobox.com>
> 
> which would be converted back into trailer lines by prepending
> "Signed-off-by: ", resulting in the modified commit message
> 
>     Human-readable subject
> 
>     Signed-off-by: Christian Couder <christian.couder@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> (Not that we would want to do with "Signed-off-by" trailers, but you get
> the idea.)

Yeah, but I think the existing options like addIfDifferent and
addIfDifferentNeighbor are simpler to do these kind of things.

And it is also possible to add a "where = sorted" option.

And if later we realize that people are still not happy, we can still
add a special "trailer.<token>.filter" that could do what you suggest.

Thanks,
Christian.
