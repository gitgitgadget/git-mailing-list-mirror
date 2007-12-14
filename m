From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Fri, 14 Dec 2007 09:33:55 +0100
Message-ID: <47623FF3.1050601@op5.se>
References: <20071213055226.GA3636@coredump.intra.peff.net>	<20071213090604.GA12398@artemis.madism.org>	<20071213091055.GA5674@coredump.intra.peff.net>	<20071213093536.GC12398@artemis.madism.org>	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>	<20071213180347.GE1224@artemis.madism.org>	<1197570521.28742.0.camel@hinata.boston.redhat.com>	<1197571656.28742.13.camel@hinata.boston.redhat.com>	<20071214040803.GA10169@sigill.intra.peff.net> <7vir31vmsn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 09:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35zz-000713-Sm
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 09:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbXLNIeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 03:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbXLNIeA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 03:34:00 -0500
Received: from mail.op5.se ([193.201.96.20]:56009 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756141AbXLNId7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 03:33:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B18C71F08088;
	Fri, 14 Dec 2007 09:33:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WElr8komoS5d; Fri, 14 Dec 2007 09:33:56 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 31BD51F08029;
	Fri, 14 Dec 2007 09:33:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vir31vmsn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68264>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I agree. I am already a little bit uncomfortable with the "--abbrev 10"
>> won't work but "--foo 10" will, because it requires that the user
>> remember which arguments are optional and which are required. But
>> switching it to "--abbrev 10 works, but --abbrev $foo does not, unless
>> of course $foo is an integer, in which case you must use --abbrev=$foo"
>> is just a little bit too DWIM. E.g., if you are scripting, it's just one
>> more source of error (if I have $foo, how must I write --abbrev $foo for
>> it to ensure that I _don't_ trigger the optional argument?).
> 
> Oh, there is no question that scripted callers need a way to safely
> disambiguate, and be able to call "git cmd" with always the default
> abbreviation for whatever $foo it gets from the user unambiguously.
> 
> I do not disagree with that.
> 
> But that is different from making it harder for end users (not scripters
> but command line users).
> 
> Again, I am not saying that my suggested alternative is superiour; I
> just threw it out to as an example of a different approach to achieve
> disambiguation than the "some flags must have its parameter stuck with
> it, some don't" behaviour, which will surely be confusing to the command
> line end users.
> 
> To contrast the two, with Pierre's, if you want $n-digit abbreviations
> and $cnt-lines of output in your script, your script would say:
> 
> 	git cmd --abbrev=$n -n $cnt $foo
> 
> because you as a script writer are required to know --abbrev is such a
> magic flag that take optional parameter and cannot be fed as two options
> (you can also write "-n=$cnt", but I am talking about --abbrev part).
> 
> If you are accepting the default abbreviation, on the other hand:
> 
> 	git cmd --abbrev -n $cnt $foo
> 
> which looks nice.  The latter needs to be written in a funky way:
> 
> 	git cmd --abbrev= $foo
> 
> if we take "empty parameter to a flag that take optional parameter means
> use the default setting"; we could introduce a magic 'default' token to
> read it slightly better:
> 
> 	git cmd --abbrev=default $foo
> 
> but that does not change the fact that it makes it harder for
> scripters.  I do not disagree with that.
> 
> The command line end users, who want to do the same, but has a bit more
> concrete than unknown $n, $cnt, or $foo, can do
> 
> 	git cmd --abbrev HEAD~4
> 
> in either approach.  However, with Pierre's, the command line end users
> can say either:
> 
> 	git cmd --abbrev=10 -n=4
> 	git cmd --abbrev=10 -n 4
> 	git cmd --abbrev=10 -n4
> 
> but they cannot say:
> 
> 	git cmd --abbrev 10 -n 4
> 
> They need to learn the difference between --abbrev and -n, because you
> avoid DWIMmery for the sake of script writers.  I have a slight
> suspicion that it is backwards.
> 
> If there is _no_ existing users and previous versions of git, one
> plausible alternative that would be much cleaner than anything we
> discussed so far would be to always require '-n=4' (or "-n4") form and
> never accept "-n 4", even for a flag that takes mandatory parameter.
> Then there is no room for confusion.  Users (both command line end users
> and script writers) need to learn only one rule: flag parameters are
> always with the flag, not given as two words.
> 
> I really wish the world were that simple, but I do no think that would
> fly well with the existing users' fingers.

I think you're right in that last sentence. It would also be terribly
inconsistent with the other 3000 or so command-line programs one has
in ones path.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
