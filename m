From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git
 interpret-trailers'
Date: Sun, 25 May 2014 10:37:21 +0200 (CEST)
Message-ID: <20140525.103721.1806399553055631284.chriscool@tuxfamily.org>
References: <534414FB.6040604@alum.mit.edu>
	<20140425.230710.1024850359228182788.chriscool@tuxfamily.org>
	<535E2A69.30600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	jrnieder@gmail.com
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun May 25 10:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoTwF-0002vF-8r
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 10:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbaEYIhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 04:37:48 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:39800 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751031AbaEYIho (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 04:37:44 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 027BB38;
	Sun, 25 May 2014 10:37:21 +0200 (CEST)
In-Reply-To: <535E2A69.30600@alum.mit.edu>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250084>

From: Michael Haggerty <mhagger@alum.mit.edu>

> On 04/25/2014 11:07 PM, Christian Couder wrote:
>> 
>> I don't think there is a lot of complexity.
>> But maybe I need to explain how it works better.
>> Feel free to suggest me sentences I could add.
> 
> I am really excited about having better support for trailers in Git, and
> I want to thank you for your work.  For me the promise of trailers is
> 
> * A way for users to add information to commits for whatever purpose
>   they want, without having to convince upstream to built support in.

Yeah, I agree this is the main purpose of trailers.

> * A standard format for that information, so that all tools can agree
>   how to read/write trailers without being confused by or breaking
>   trailers that they didn't know about in advance.

Yeah, but don't you think this goal can sometimes go against the
previous goal?

I mean, if some users for their project think that it's better, for
example, if they use trailers like "Fix #42" instead of "Fix: 42",
because their bug tracking system supports "Fix #42" better, we should
let them do what suits them better, even if Git supports them not as
well as if they used "Fix: 42".

> * A format that is straightforward enough that it can be machine-
>   readable with minimum ambiguity.

Yeah, but again this could go against the main purpose of trailers
above.

> * Some command-line tools to make it easy for scripts to work with
>   trailers, and that serve as a reference implementation that other
>   Git implementations can imitate.

Yeah, ok, as long as we keep in mind the main purpose.

> For example, I totally expect that
>   we will soon want a command-line tool for inquiring about the
>   presence and contents of trailers, for use in scripting.  Eventually
>   we will want to be able to do stuff like
> 
>       git trailers --get-all s-o-b origin/master..origin/next
>       git rev-list --trailer=s-o-b:gitster@pobox.com master
>       git trailers --pipe --draft \
>           --add-first fixes \
>           --append '# You can delete the following line:' \
>           --append s-o-b:"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
>           --unset private
>       git trailers --pipe --verify --tidy-up

Yeah, feel free to help make this kind of things possible :-)

> I think it is really important to nail down the format of trailers
> tightly enough that everybody who reads/writes a commit message agrees
> about exactly what trailers are there.

I think we should have a default format for trailers that is clear,
but we should not force users to use this format. Because forcing it
would go against the main goal of trailers that you listed first
above.

> For example the specification
> might look something like:
> 
>     A commit message can optionally end with a block of trailers.
>     The trailers, if present, must be separated from the rest of the
>     commit message by one or more blank lines (lines that contain only
>     whitespace).  There must be no blank lines within the list of
>     trailers.  It is allowed to have blank lines after the trailers.
> 
>     Each trailer line must match the following Perl regular
>     expression:
> 
>         ^([A-Za-z0-9_-]+)\s*:\s*(.*[^\s])\s*$
> 
>     The string matching the first group is called the key and the string
>     matching the second is called the value.  Keys are considered to be
>     case-insensitive [or should they be case-sensitive?].  The
>     interpretation of values is left entirely up to the application.
>     Values must not be empty.

I tried to be clearer in the v12 I just posted, and I think it should
be enough to be very clear. We might want to tweak a little the
specifications later, so being too strict might be counter productive.

And as other tools might already use trailers in a case-sensitive way
and yet other tools in a case-insensitive way, I am not sure we would
gain anything by specifying if keys or values should be interpreted in
a case-sensitive or case-insensitive way. On the contrary we might
upset people already using some of these tools for no good reason.

>     However, in --draft and --cleanup modes, empty values *are*
>     allowed, as are comments (lines starting with `core.commentchar`)
>     within the trailer block.  In --draft mode such lines are passed
>     through unchanged, and in --cleanup mode such lines are removed.

I am not sure we should use modes. I think options like
"--trim-empty", "--allow-comments", "--allow-empty" might be clearer.

> I'm not saying this is the exact definition that we want; I'm just
> providing an example of the level of precision that I think is needed.

Yeah, but I think too much precision can be counter productive.

> With regard to the separator character, my concern is not about how to
> document the rules for this one tool.  It's more about having really
> well-defined rules that are consistent between reading and writing.  For
> me it seems silly to let "git interpret-trailers" output trailers that
> it doesn't know how to read back in, and pretty much be a show-stopper
> if the presence of such trailers makes the tool unable to read other
> trailers in the same commit message.

We might allow an option to specify witch separator(s) should be
allowed in the input messages for example. Right now I think it is
enough if we support well the default separator, ':' in the input
message.

> So my preference would be to make the format of trailers really strict;
> for example, only allowing colon separators as in the regexp above.
> People who want to work with trailers using Git tools will just have to
> conform to this format.

I don't think we should cast in stone the format for trailers, because
of the main purpose of trailers.

The format of the commit header for example is cast in stone, but
that's ok because it is mostly for Git internal use. Trailers are
mostly for external use by users who already have tools expecting
different formats.

There are already users who are not happy that they cannot easily have
other commit headers, and we point them to trailers. If we specify
trailers too strictly, where will we point them to?

> But if we must support flexibility in the separator characters, then I
> think it is important that we be able to read whatever we can write.

An option like --input-separator might be enough to support this.

> For me this means:
> 
> * Enumerating a list of allowed separators (e.g., [:=#])

Junio suggested in a message that users might use different separators
like '%'.
 
> * Specifying how it is decided what separator to use when generating
>   new trailers

This is already possible with the 'trailer.<token>.key' config
variable.

> * Specifying what appends when a trailer is read and then written again:
>   is its separator preserved, or is the trailer converted to use the
>   separator configured for that particular key in the config.  And if
>   the latter, what happens if a key's separator is not configured?

Right now we only accept ':' as input separator for the messages and
':' and '=' for the --trailer option, and the default output separator
is ':'. If the user specify a different separator in a key, this
separator will be used only in the output for this key.

If this is not clear in the documentation, please susggest specific
improvements.

> * Specifying whether whitespace around a separator is adjusted when
>   reading then writing a trailer.  For example, is
> 
>       Foo SP SP : HT bar SP
> 
>   canonicalized to
> 
>       Foo: SP bar
> 
>   (SP=space, HT=tab)?  What about
> 
>       Fixes SP #33
> 
>   ?  What if the separator for the "fixes" key is not configured?

I tried to be very clear in the doc in v12.

> The reason that I prefer supporting only colons is that more flexibility
> inevitably raises lots of questions like this, makes the documentation
> and implementation more complicated, and makes it harder for other
> implementations to be sure they agree 100% with the reference
> implementation.

Yeah, but we should not forget the main purpose of trailers.

>>> It seems to me that the current behavior (rewriting exactly one existing
>>> line) is not that useful.  Why not make "overwrite" overwrite *all*
>>> existing matching lines?
>> 
>> I was thinking that people could use the following template message:
>> 
>> ---------------
>> Signed-off-by: 
>> Signed-off-by: YOU-WILL-BE-AUTOMATICALLY-ADDED-HERE
>> ---------------
>> 
>> and the following config:
>> 
>> ---------------
>> [trailer "s-o-b"]
>> 	 key = "Signed-off-by: "
>> 	 ifexist = overwrite
>> 	 command = echo \"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>\"
>> ---------------
>> 
>> This way the user can add other people's s-o-b before the last one
>> which will always contain his own s-o-b.
> 
> That seems fragile.  For example, if the user changes the lines to
> 
>     Signed-off-by: Somebody Else <...>
> 
> (deleting the "YOU-WILL-BE" line, maybe because they don't want to sign
> off the commit) then not only will their wish be contradicted, but also
> Somebody Else would be deleted.

I agree that it is fragile, but we can add an overwriteAll option if
that suits people needs better. "overwrite" is needed anyway for
trailers where there should be only one trailer with a given key.

> What about allowing a --draft option, which allows blank trailer values
> plus comments interspersed in the trailer lines?  (I.e., the equivalent
> of --trim-empty could be the default and --draft would turn it off plus
> allow interspersed comments.)

Yeah, or --allow-comments. As I said above prefer many orthogonal
options, rather than some general options like --draft.

> Then the template could be
> 
>     # You can add one or more Signed-off-by lines for other people here.
>     # A Signed-off-by line for you will be appended automatically when
>     # you commit.
>     Signed-off-by:
> 
> Or, even better:
> 
>     # You can add one or more Signed-off-by lines here:
>     Signed-off-by:
>     Signed-off-by:
>     # You can delete the following line if you don't want it:
>     Signed-off-by: Me <me@example.com>
> 
> ; i.e., the Signed-off-by line for the author could be filled in
> *before* the user is asked to edit the commit message.  There could also
> be a --cleanup mode that allows blank values and comments on input but
> removes them from the output.

I would prefer to add --trim-comments rather than a --cleanup mode. 

>> [...]
> 
> Given Git's requirements for backwards compatibility, a specification
> that we release now will have to be supported forever (because it will
> be baked into commits and can *never* be changed), and any
> trailer-handling tools that we release now will have to be supported for
> years (until at least Git 3.0).

Yeah, I know that. So if we are too strict in the specification will
be stuck for a long time.

> All in all, I think that there has been a lot of discussion about the
> interface of this one command, "git interpret-trailers", including its
> quite complicated configuration and a command-line behavior.  And yet it
> seems to me that not many Git developers have been very engaged in the
> conversation, and Junio (who has) still doesn't seem satisfied with it.
>  I (though among the too-little engaged) have the feeling that it is
> still a ways from maturity.

My opinion is that many Git developers have been engaged and you can
see that in the Cc.

I cannot tell if they are all very happy or not but I suppose that if
they were very unhappy they would tell it.

> On the contrary, the data format and semantics of the finished trailers
> seem to have gotten too little attention, even though they are simpler
> to define and even more important than the interface of the command used
> to manipulate trailers.
> 
> I think it would be really helpful to have a careful specification of
> the data format, and make sure that everybody agrees on what we want.
> For example, I think it is crucial that the trailers can be read and
> written unambiguously.
> 
> Once that's clear, it will be a lot easier to be sure that the tool(s)
> for working with trailers conform to the specification.

Please realize that too much specification is not always good and that
it cuts both ways...

> Even then, I think it might be prudent to mark "git interpret-trailers"
> as "experimental" and/or put it under "contrib" rather than among the
> main Git commands for a couple of releases.  Luckily, it is very loosely
> coupled to the rest of Git, so I don't see any urgency to having it in
> core [1].  After people have had time to experiment with it, then it
> could be moved to core.

Yeah, it is very loosely coupled to the rest of Git by design. I
posted the first version of this series around last November. So
people have had a very long time to review it, comment on it,
experiment with it, bikeshed many details... And in the same time many
users have asked for some features that "git interpret-trailers"
provides...

Regards,
Christian.
