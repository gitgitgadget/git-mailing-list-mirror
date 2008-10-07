From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Tue, 07 Oct 2008 17:54:52 +0200
Message-ID: <48EB864C.6020000@viscovery.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net> <48EB7D74.40302@viscovery.net> <20081007153543.GA26531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEut-00011L-PV
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbYJGPy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbYJGPy5
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:54:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41827 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbYJGPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:54:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KnEti-0004wn-9D; Tue, 07 Oct 2008 17:54:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E202554D; Tue,  7 Oct 2008 17:54:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081007153543.GA26531@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97721>

Jeff King schrieb:
> On Tue, Oct 07, 2008 at 05:17:08PM +0200, Johannes Sixt wrote:
> 
>>> However, there is at least one conflicting situation: there
>>> is no way to say "use the regular rules to determine whether
>>> this file is binary, but if we do diff it textually, use
>>> this funcname pattern." That is, currently setting diff=foo
>>> indicates that the file is definitely text.
>> I don't get your point. Can you provide an example?
> 
> Let's say I have a subdirectory of files, some of which are binary. But
> for those that _aren't_ binary, I want to use a particular funcname
> pattern. So I do this:
> 
>   echo '* diff=foo' >subdir/.gitattributes
>   git config diff.foo.funcname some-regex
> 
> Under the old behavior, I have just claimed all of the subdir as text.
> But that's not necessarily what I wanted.

No, you claimed that all of the files are of type "foo". If this is not
what you wanted, be more specific.

> In practice, this doesn't happen much, because funcname tends to follow
> the file extension, as does binary-ness. So you get "*.java diff=java",
> and you really would be insane to have binary files named *.java. But I
> think it makes the concept clearer to explain, and the code simpler, if
> the various facets of a diff driver are orthogonal. In particular, I
> think this makes things cleaner for adding new driver properties in the
> future.

I tend to disagree. "Binaryness" is subordinate to the "type" of the file,
which is what the diff attribute basically specifies.

> As to your complaint (which I think is valid)...
> 
>> The reason why I'd like to understand the issue is because I like the
>> diff.foo.textconv that you introduce in patch 4/4, but I dislike that I
>> have to set diff.foo.binary to false in order to use the textconv. So, why
>> is this .binary needed?
> 
> I think this .binary is something we can and should get rid of; as it
> stands now, you always end up having to set it along with .textconv. I
> have considered two ways:
> 
>   - because textconv is for converting binary to text for diffing, the
>     result should always be text. So whenever we do the conversion, we
>     should note that it is no longer binary, and automatically treat the
>     result as a text diff. So in this case, we are explicitly saying
>     that binaryness is _not_ orthogonal to this property of the diff
>     driver.
> 
>   - textconv should arguably just be "canonicalize" or similar. That is,
>     there is no reason you couldn't take something like text XML and
>     canonicalize it for a more readable diff. Or even canonicalize a
>     binary file to get a smaller or more sensible binary diff, if you
>     wanted to.
> 
>     In that case, I think the right thing is to set it back to "unknown,
>     check the file contents" if .binary is not set. So you really are
>     saying "this is just a conversion, treat the canonicalized contents
>     exactly as you would have treated the actual contents, including
>     binary detection magic".

I see your point. But this second item goes too far, in particular,
canonicalizing binary files to some other binary form is certainly not
something that should happen under 'git diff' porcelain. (We already have
clean/smudge filters for this purpose.)

For the purpose of generating diffs at the porcelain level (*not*
generating patches to be applied, aka format-patch), we can safely stay
with the interpretation in the first item above.

-- Hannes
