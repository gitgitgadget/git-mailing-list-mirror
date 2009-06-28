From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git mailinfo strips important context from patch subjects
Date: Sun, 28 Jun 2009 16:04:37 -0700
Message-ID: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
References: <20090628193858.GA29467@codelibre.net>
	<20090628200259.GB8828@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 29 01:04:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML3QU-0005V7-TD
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 01:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbZF1XEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 19:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbZF1XEf
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 19:04:35 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50738 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbZF1XEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 19:04:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090628230438.EXAS17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 28 Jun 2009 19:04:38 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9b4d1c0074aMwMQ04b4dQG; Sun, 28 Jun 2009 19:04:37 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=kWde_uB_ifgA:10 a=PKzvZo6CAAAA:8
 a=ZBoUXCDuE0o-4So301sA:9 a=085HplncQFGXlwKD3pMA:7
 a=K9vZ4RzddYMv_BDljG1tXPW3VhEA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090628200259.GB8828@sigio.peff.net> (Jeff King's message of "Sun\, 28 Jun 2009 16\:02\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122428>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 28, 2009 at 08:38:58PM +0100, Roger Leigh wrote:
>
>> In most of the projects I work on, the git commit message has
>> the affected subsystem or component in square brackets, such as
>> 
>>   [foo] change bar to baz
>>
>> [...]
>>
>> The [sbuild] prefix has been dropped from the Subject, so an
>> important bit of context about the patch has been lost.
>> 
>> It's a bit of a bug that you can't round trip from a git-format-patch
>> to import with git-am and then not be able to produce the exact same
>> patch set with git-format-patch again (assuming preparing and applying
>> to the same point, of course).
>
> As an immediate solution, you probably want to use "-k" when generating
> the patch (not to add the [PATCH] munging) and "-k" when reading the
> patch via "git am" (which will avoid trying to strip any munging).
>
> However:
>
>> Would it be possible to change the git-mailinfo logic to use a less
>> greedy pattern match so it leaves everything after
>> ([PATCH( [0-9/])+])+ in the subject?  AFAICT this is cleanup_subject in
>> builtin-mailinfo.c?  Could this rather complex function not just do a
>> simple regex match which can also take care of stripping ([Rr]e:) ?
>
> Yes, I think in the long run it makes sense to strip just the _first_
> set of brackets. I don't think we want to be more specific than that in
> the match, because we allow arbitrary cruft inside the brackets (like
> "[RFC/PATCH]", etc). But if format-patch always puts exactly one set of
> brackets, and am strips exactly one set, then that should retain your
> subject in practice, even if it starts with [foo].

I think it may still make sense to insist that PATCH appears somewhere in
the first set of brackets, but I have stop and wonder if it is even
necessary.

Because git removes [sbuild] at the beginning, Roger is unhappy.

 * Is he happy that git removes [PATCH]?  In E-mail based workflow it is
   a good practice to mark messages that are patches clearly so that they
   can be quickly found among the discussions that lead to them, and it is
   plausible that his project accepted that as an established practice
   supported well by git.

 * Is he happy that git treats the first paragraph of the commit message
   specially from the rest of the message?  In a project with many
   commits, it is essential that people write good commit summaries that
   fits on a single line so that tools like shortlog and gitweb can be
   used to get a bird-eye view of what happened recently.  Perhaps his
   project picked it up as the best current practice supported well by
   git.

 * Is he happy that git takes "---" as the end of message marker, so that
   any other commentary can be added to the message to facilitate the
   communication without adding noise to the commits?  Perhaps he is and
   his project picked it up as a good practice supported well by git.

There are many other conventions in git that does not have anything to do
with what the underlying git datastructure supports, but conventions can
always be seen as "don't do that, instead do it this way", limitations,
and to some of them Roger may not be happy.  Where would we draw a line?

_An_ established (note that I did not say _the_ nor _best current_)
practice supported well by git to note the area being affected in a
project of nontrivial size is to prefix the single line summary with the
name of the area followed by a colon.  There is no difference between
"[sbuild] foo" and "sbuild: foo" at the information content point-of-view,
but the latter has an advantage of being one letter shorter and less
distracting in MUA.  He does not have a very strong reason to choose
something different only to make his life harder, does he?

Users can take advantage of this established practice when running
shortlog with "--grep=^area:" to limit the birds-eye-view to a specific
area.  If this turns out to be useful, we could even add an option to "git
log --area=name" that limits this kind of match to the first paragraph of
the commit log message, for example.

Supporting a slightly different convention may seem to be accomodating and
nice, but if there is no real technical difference between the two (and
again, "area:" is one letter shorter ;-), letting people run with
different convention longer, when they can switch easily to another
convention that is already well supported, may actually hurt them in the
long run.  "[sbuild]" will not match "--area=sbuild" that will internally
become "--grep-only-first-line=sbuild:" so either he will miss out
benefiting from the new feature, or the implementation of the new feature
unnecessarily needs more code.

It is not about discouraging a wrong workflow or practice, because there
is nothing _wrong_ per-se in [sbuild] prefix.  It is just that it makes
things harder in the long run.  In this particular case, it is only very
slightly harder, but these things tend to add up from different fronts.
