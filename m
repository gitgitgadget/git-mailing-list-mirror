From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Wed, 27 Aug 2008 11:36:55 +0200
Message-ID: <48B52037.7030405@fastmail.fm>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 11:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYHTl-0003RY-O7
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbYH0JhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYH0JhN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:37:13 -0400
Received: from main.gmane.org ([80.91.229.2]:32948 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbYH0JhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 05:37:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYHSe-0005WZ-TC
	for git@vger.kernel.org; Wed, 27 Aug 2008 09:37:08 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 09:37:08 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 09:37:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93882>

Junio C Hamano venit, vidit, dixit 27.08.2008 08:13:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Aug 26, 2008 at 04:31:30PM -0700, Junio C Hamano wrote:
>>
>>>> This allows the use of author abbreviations when specifying commit
>>>> authors via the --author option to git commit. "--author=$key" is
>>>> resolved by looking up "user.$key.name" and "user.$key.email" in the
>>>> config.
>>> Maybe it is just me, but I am hesitant about the contamination of user.*
>>> configuration namespace.  This patch as a general solution does not scale
>>> well, once you start working with more than a few dozen people.
>> It is not just you. I think this version of the patch is much improved,
>> but I am still against user.$key.*. At the very least, it needs its own
>> namespace.
> 
> It's not just that.  Having many of these in .git/config will slow down
> any unrelated thing that needs to read from config.

I don't see a namespace problem as long as nobody uses "name" or "email"
as $key. That said I'd suggest useralias.$key.{name,email} then which
gives a cleaner separation and leaves the possibility to

- use the alias for other cases than --author
- use other fields than name, email

at a later time.

> I am not married to the "reuse existing information" idea, but doing it
> the way this sample patch does at least makes only people who uses this
> feature to pay the price and only when they use it.

People who don't use this feature don't have any entries and don't pay
anything.
People who use this feature and have a moderate number of entries don't
pay a recognizable price.
People who use this feature and have a vast amount of entries should be
told to implement an alias file parser ;)

> Not extensively tested, beyond the usual test suite, and using it for real
> only once to commit this with "git commit --author=Jeff".  I wanted to say
> "Michael J" instead, but there is this little chicken-and-egg problem ;-)
[patch snipped]

I'd be happy with that approach as well for my use case. In general it
may suffer from the uniqueness problem: If there's a recent commit
authored by "Michael@Jeff.com" your "--author=Jeff" will resolve
differently from yesterday, and you won't even notice (not even commit
-v tells you). [ A typo is punished by a search through all commits;
that's fine.]

But I won't compete with an alternative patch from The Man, of course ;)

+	die("No existing author found with '%s'", name);
Minor suggestion:
"...or malformed --author parameter"
I foresee questions like "Huh? What does it mean not existing" when
people don't get the A U Thor <author@example.com> format right.

Michael
