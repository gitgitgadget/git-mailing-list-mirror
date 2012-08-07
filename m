From: David Kastrup <dak@gnu.org>
Subject: Re: info: display '--' as '-'
Date: Tue, 07 Aug 2012 09:17:50 +0200
Message-ID: <874nofcgrl.fsf@fencepost.gnu.org>
References: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
	<20120807060157.GA13222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mofaph <mofaph@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 09:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sye3W-00058p-Au
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 09:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab2HGHSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 03:18:13 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:38134 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2HGHSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 03:18:12 -0400
Received: from localhost ([127.0.0.1]:40740 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Sye3P-0007VV-9x; Tue, 07 Aug 2012 03:18:11 -0400
Received: by lola (Postfix, from userid 1000)
	id 55915209D55; Tue,  7 Aug 2012 09:17:50 +0200 (CEST)
In-Reply-To: <20120807060157.GA13222@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Aug 2012 02:01:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203022>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 06, 2012 at 11:08:39AM +0800, mofaph wrote:
>
>> I am using Git 1.7.11.4 now. I compile and then install it from the repo.
>> 
>> $ git checkout v1.7.11.4
>> $ make prefix=$HOME/opt/git/1.7.11.4 all doc info
>> $ make prefix=$HOME/opt/git/1.7.11.4 install{,-doc,-html,-info}
>> 
>> Recently, I found some problem when I read the git.info.
>> 
>> For example, you can see it in "3.7.1 Getting conflict-resolution
>> help during a
>> merge":
>> 
>> $ git log -merge
>> $ gitk -merge
>> 
>> See, it should be type like this:
>> 
>> $ git log --merge
>> $ gitk --merge
>> 
>> You will see this typo almost in the whole info file.
>
> Yeah, I can reproduce it here. The data goes through these
> transformations to get to the final info form:
>
>   user-manual.txt  (source)
>    -> user-manual.xml (via asciidoc)
>      -> user-manual.texi (via docbook2x-texi)
>        -> git.info (via makeinfo)
>
> The data looks OK in user-manual.texi,

If you are interpreting it visually instead of as Texinfo source...

> but "--" is converted to "-" in git.info. So either:
>
>   1. There is a bug in makeinfo, which should not be doing this
>      conversion inside a "@display" section.

Not really: @display does not change fonts, merely indentation.  From
the Texinfo manual:

    The `@display' command begins a kind of example, where each line of
    input produces a line of output, and the output is indented.  It is
    thus like the `@example' command except that, in a printed manual,
    `@display' does not select the fixed-width font.  In fact, it does not
    specify the font at all, so that the text appears in the same font it
    would have appeared in without the `@display' command.

         This is an example of text written between an `@display' command
         and an `@end display' command.  The `@display' command
         indents the text, but does not fill it.

But in non-typewriter fonts, -- is a shorthand for an en-dash (see
"conventions" in the Texinfo manual):

   * Use three hyphens in a row, `---', to produce a long dash--like
     this (called an "em dash"), used for punctuation in sentences.
     Use two hyphens, `--', to produce a medium dash (called an "en
     dash"), used primarily for numeric ranges, as in "June 25-26".
     Use a single hyphen, `-', to produce a standard hyphen used in
     compound words.  For display on the screen, Info reduces three
     hyphens to two and two hyphens to one (not transitively!).  Of
     course, any number of hyphens in the source remain as they are in
     literal contexts, such as `@code' and `@example'.

So somewhere in your conversion chains, you should try detecting code
examples and translate them into @example...@end example rather than the
merely indented @display ... @end display.  It is likely that it will
look better in other parts of the production chain as well.

>   2. There is a bug in docbook2x-texi, which should be quoting the
>      contents of the <literallayout> when generating the @display
>      section.

Quoting won't help.  You can likely get by with @w{-}@w{-} (putting the
hyphens separately in an unbreakable box), but the real formatting fix
is to use an environment suitable for literal character quotings rather
than free-flow text.

> I don't know enough about texinfo to say which. But I'm sure that the
> contents of user-manual.xml are correct, because I do actually speak
> docbook, which means the problem happens after that step.
>
> Cc-ing David Kastrup, who added the info version originally, and might
> be more clueful about that part of the toolchain.

I think you are significantly overstating my contribution.  Unless my
memory is failing me (always an option), I probably raised the main
stink at one time about the info documentation falling into a decrepit
state, but I don't think that I was all that much involved with getting
it up to scratch again, and I don't think I had been responsible for
originally implementing it.

-- 
David Kastrup
