From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Fri, 12 Nov 2010 20:48:18 +0100
Message-ID: <4CDD9A02.6000507@web.de>
References: <4CDB3063.5010801@web.de> <4CDB30D6.5040302@web.de> <20101111000216.GA14189@burratino> <4CDBA5FD.20802@web.de> <20101111082748.GA15525@burratino> <7v1v6rhfut.fsf@alter.siamese.dyndns.org> <20101111190053.GH16972@burratino> <4CDD2AF9.6040403@web.de> <20101112155210.GA15141@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 20:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGzbp-00084s-Be
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 20:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193Ab0KLTsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 14:48:23 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:45632 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab0KLTsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 14:48:22 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id A312E171E1DF0;
	Fri, 12 Nov 2010 20:48:21 +0100 (CET)
Received: from [93.240.101.21] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGzbh-00051B-00; Fri, 12 Nov 2010 20:48:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101112155210.GA15141@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19hEoUatuQrQHVgzKmrLLSyCIdJiRPJq5OmGtt3
	F5gsj3p3VSeWcZ4KKEv8Cc+p12ar1mYOBf9qP4nuC79v517KSy
	WpVlfTpRm1bc/nM7jXug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161357>

Am 12.11.2010 16:52, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> Am 11.11.2010 20:00, schrieb Jonathan Nieder:
> 
>>> Yes, that makes some sense to me.  Except wouldn't it be a single
>>> configuration item?  "These submodules should be checked out in all
>>> but unusual situations, so check them out automatically and keep them
>>> updated."
>>
>> Hmm, but we have at least three modes of how to update them:
>>
>> 1) Never fetch the submodule (to get new commits the user has to run
>>    "git fetch --recurse-submodules" by hand)
>>
>> 2) Fetch the submodule each time you fetch the superproject (Which is
>>    really handy when you do development in the submodule too but can
>>    be really inconvenient when you don't)
>>
>> 3) Update submodules only when new recorded commits are fetched in
>>    the superproject (This mode is not added with the current patch
>>    series but will be in one of the next)
>>
>> So you would need a config option for that anyway, no? And that is why
>> I'd rather like to have a separate fetch option to control that behavior
>> instead of an implicit "if-it's-to-be-checked-out-fetch-it-too" approach.
> 
> I still think I am missing something.

Ok, I'll try harder to explain my view ;-)

> Traditionally, git has been a _content_ tracker.  The configuration that
> gets transmitted (.gitignore, .gitattributes, .gitmodules) would only
> represent basic information needed for that content to remain usable and
> sensible.

Ack.

> In the case of .gitmodules, it seems that two concepts are being
> conflated:
> 
>  A. Configuration based on the user's preferences.  Absolutely, a person
>     deserves to be able to easily choose between (1), (2), and (3) as
>     described above.
> 
>  B. Metadata about the content that should be shared.  For example, "this
>     submodule would be checked out in all but unusual circumstances" is a
>     useful thing to be able to declare.

No, I think these concepts aren't conflated at all:

- Category A is handled by .git/config

- Category B is handled by the .gitmodules file

Category A should not be handled by a file in the work tree while
category B stuff belongs there to be able to share it. That is why git
searches all new options in both files with the values from .git/config
overriding those from .gitmodules: to provide useful defaults and let
the user choose otherwise if he wants to.

> Probably I am missing something big, but fetchsubmodules as currently
> defined seem like something in category A and not in category B.
> Partially because if we ever implement option (3), that is what almost
> _every_ casual consumer will want.  So why should they be stuck with these
> configuration files specifying (1) and (2) when they check out old
> revisions?

With submodules there never is a one-size-fits-all solution :-)
(And we are currently working on option (3), so it will exist rather
sooner than later)

There are people putting lots of large files in submodules for better
performance and they almost always never want to fetch (or even stat)
them, so (1) is for them and it's cool that their upstream can configure
that, avoiding to have every developer to repeat their "obvious" choice
after each clone again (and that might only be needed for some submodules,
so a repo-wide config doesn't necessarily help them).

And when you are on a superproject branch actively developing inside a
submodule, you may want to increase fetch-activity to fetch all new
commits in the submodule even if they aren't referenced in the
superproject (yet), as that might be just what your fellow developers
are about to do. And the person setting up that branch could do that
once for all users so they don't have to repeat it in every clone. And
when switching away from that branch all those developers cannot forget
to reconfigure to fetch-on-demand, so not having that in .git/config is
a plus here too.

And right, "almost _every_ casual consumer" should start with (3), and
that is why it will be the default. So most people will get along
without having ever to configure fetch behavior in .gitmodules because
git does The Right Thing for them. But in my opinion we should allow
that for those other users ...

> All that said, I do not think it is unreasonable in some situations for a
> project to want to share configuration of type (A) between members of a
> project; for example, lots of projects share hooks and that's great.  I
> just don't think git should set it up automatically --- better to require
> an explicit user action like "sh useprojectconfiguration.sh" (an action
> more explicit than "please initialize and checkout all relevant
> submodules") for such cases.

You have no other choice for hooks because of security concerns. But I
can't see any downsides in leaving upstream *the choice* to configure
default submodule behavior. Lots of people - including me - want that for
clone and checkout. And to be consistent the same configuration abilities
should be available for fetch too, and if only to follow the principle of
least surprise.


Thanks
Jens
