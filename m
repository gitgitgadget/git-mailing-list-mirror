From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 10:59:18 -0800
Message-ID: <7vejbbz9x5.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <m38x1jbsjb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bruno Ribas <ribas@c3sl.ufpr.br>,
	"J.H." <warthog9@kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQokl-0003ff-5X
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbYBQS7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbYBQS7p
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:59:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbYBQS7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:59:44 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E1E3660E;
	Sun, 17 Feb 2008 13:59:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 25AA4660A; Sun, 17 Feb 2008 13:59:31 -0500 (EST)
In-Reply-To: <m38x1jbsjb.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 17 Feb 2008 05:52:45 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74165>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> * lt/dirstat (Tue Feb 12 17:06:58 2008 -0800) 2 commits
>>  - diff: make --dirstat binary-file safe
>>  + Add "--dirstat" for some directory statistics
>> 
>> The first one already in 'next' is the latest toy Linus showed
>> off in his 2.6.25-rc2 announcement.  The other one on top is a
>> rework to make it work more sensibly with a tree with binary
>> contents.
>
> Is this new one bytecount based rather than lines-changed based also
> for text files?

Short answer: Yes.

The issue in Linus's version is that the amount of change is
defined to be "number of lines added and deleted" for text files
while it is "number of bytes in preimage and postimage" for
binary files.  Summing them up and computing proportions among
them is comparing apples and oranges.

If you used line-based amount-of-change for text and byte-based
one for binary, you would be still comparing apples and oranges,
and you are not solving anything.  The scale used for all files
has to be consistent.

>> * br/gitweb (Fri Feb 8 14:38:04 2008 -0200) 1 commit
>>  + gitweb: Use the config file to set repository owner's name.
>> 
>> On hold per Jakub's reluctance.
> 
> It was tested by the author (Bruno Ribas) that it doesn't affect
> performance, although IMHO for a bit superficial test (1000 identical
> repositories, gitweb run as a script, dd or git-for-each-ref as an
> additional load).  I'd like to heard from larger gitweb deployments
> how it works with a webserver (ApacheBench or similar), with a real
> set of repositories, and perhaps in real load conditions... of course
> on test gitweb, not on live one.

I personally think the patch is Ok.  It would not affect really
large and loaded sites, because the top-level project list is
unusable for them without caching like John 'Warthog9' Hawley
does for k.org, due to other performance bottleneck (namely,
"the last changed timestamp") anyway.

By the way, I think "real load conditions" and "test gitweb not
live" are unfortunately mutually exclusive.  If it is known to
be "test", it will not attract the same set of "real" people as
the real one.

> I also wonder if it would make sense to make it a feature,

It might make sense, but it would not probably not help much in
practice.  It is overengineering, and I think it is spending
efforts in wrong place in the first place.

What I personally think the most important thing that should
happen to gitweb is to help cleaning up and updating John's
caching version that powers k.org, and update our version to
that.  John's version has seen a lot more real-life loads than
any other installation of the vanilla version in git.git, and we
should take advantage of his effort by slurping improvements
from his.  People who are both interested and have been involved
in gitweb might want to form a "gitweb-ng strike force" group,
and make a consolidated effort, just like msysgit folks do to
port our mess to Windows ;-).

>> * nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
>>  - Move all dashed-form commands to libexecdir
>>
>> Scheduled for 1.6.0.  I am not sure if we should merge this to
>> 'next' before 1.5.5.  Most active people will be on 'next' and
>> if we have this there, the resulting 1.5.5 release might end up
>> having issues that come from differences this one introduces.
>
> What about making separate libexecdir and moving _helper_ scripts
> (*--*) there first?

Why keep suggesting adding _more_ work, without any code nor
discussion of how that would help?
