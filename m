From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] git-config: Parse config files leniently
Date: Fri, 04 Sep 2009 09:13:52 +0200
Message-ID: <4AA0BE30.1030408@drmicha.warpmail.net>
References: <7vvdkmte4p.fsf@alter.siamese.dyndns.org> <f29b5893b7022f53d380504fe201303acd9ee3da.1251922441.git.git@drmicha.warpmail.net> <7vab1cfr6s.fsf@alter.siamese.dyndns.org> <4A9F733D.5050205@drmicha.warpmail.net> <7viqfz4mu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjT03-00032k-5y
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 09:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbZIDHOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 03:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbZIDHOF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 03:14:05 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58548 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785AbZIDHOE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 03:14:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 803B861668;
	Fri,  4 Sep 2009 03:14:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Sep 2009 03:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KAM4Ef8YOpbBskouMMmvxYg2SOw=; b=sRfgih3/+gjmTRWmI0MkMjytAUa/eVRaXltsuHGmARrMCKTY4GrDVrfLhILGOCRDVksPdhDiLIucJR0+Ec0P3b1vahaFfJ9fw8W7YC4nks8OaY8585sHAhK+TgjWUu7+gRpsNaU1X449clkoZSJQlu9bIS2JUJGE0kyafv7Tnbo=
X-Sasl-enc: AYl455uNQNI9N/5MYcCg2CYoq/ByheBs1a5bLO2Us9u4 1252048443
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B8D2366F60;
	Fri,  4 Sep 2009 03:14:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <7viqfz4mu3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127690>

Junio C Hamano venit, vidit, dixit 04.09.2009 01:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Why was I CC'ed, if the patch wasn't even self tested?
>>
>> Because
>> - not CC'ing you would have meant culling you from the existing CC,
>> - we've discussed v1 of this patch before,
>> - I asked in this patch (v2) whether to go for an alternative.
> 
> Oh, so you did not mean this was for inclusion but as another round
> of RFC.  I misread your intent.  Sorry about that.

OK. I'll try to distinguish better between RFC and RFI in the future.
And, yes, usually I run *all* tests before sending patches. I had even
grepped all tests for "config" in order not to miss any, but failed to
note how the patch affects all other commands as well.

> 
> The eralier analysis of the cause of the breakage indicated that the
> implementation in this patch was flawed.  What it essentially did was to
> re-define all die() to warn() in the codepaths around configuration
> variable handling [*1*].
> 
> However, it does not mean that the idea of "ignoring syntax errors while
> keeping other errors still noticed for all commands, not limited to config
> nor not limited to 'config -e'" is necessarily flawed.
> 
> For example, the test I noticed the breakage with was stuffing an invalid
> value to branch.autosetuprebase and wanted to see "git branch" fail.
> 
> Obviously we do want to fail a "git branch newbranch origin/master" when
> the value given to branch.autosetuprebase is misspelled, to avoid creating
> bogus settings the user did not intend to.  We do care about semantic
> errors (i.e. this variable can take only one of these values, but the
> value given in the file is bogus) in such a case.  But if you are running
> "git branch" only to view, but not to create, there is no reason for us to
> care about the branch.autosetuprebase variable [*2*].
> 
> This observation suggests that it may make sense to make the error
> handling _even looser_ than what you intended to do in your patch (which I
> assume was "we ignore syntax errors and try to recover, pretending that we
> saw a comment until the end of line, but we still keep the validation of
> values assigned to variables that the existing commands rely on").
> 
> Ideally, the rule would be "we care about the values of variables we are
> going to use, but allow misspelled values in variables that are not used
> by us---we have no business complaining about them."  Unfortunately that
> is much harder to arrange with the current code structure, but under that
> rule, "config -e" would care only about "core.editor" and nothing else, so
> as long as that variable can be sanely read, it should be able to start.
> 
> 
> [Footnotes]
> 
> *1* The additional test that came with the patch only checked for the
> positive case (i.e. "does the system with this patch treats errors looser
> than before?"), but failed to check the negative case (i.e. "does the
> change too much and stop catching errors that should be caught?"), which
> unfortunately is a common mistake that easily lets bugs go unnoticed.
> 
> *2* Worse yet, the parsing of branch.autosetuprebase is part of the
> default_config and commands that do not have anything to do with new
> branch creation will fail with the current setup.

Thanks for the thorough explanations. Especially *2* makes me think that
quite some restructuring would be necessary in order to "do it right".
That would be above my head (and time constraints).

Given that, I think the practical options are

a) make "git config" parse leniently (both -e and others)
b) leave as is and document how to recover from bad config
c) launch the editor on a tmp copy, check and refuse or loop on fail...

I still think of "git config -e" as a shortcut only (meaning it doesn't
warrant large specific code efforts), and it's problematic because the
user base is split in two sets:

- Those who know their way around .git/config and editors.
- Those who should stick with the get and set modes of "git config".

"git config -e" helps users from the 2nd group shoot themselves in their
feet badly enough that they can recover only with insight from the first
group...

Michael
