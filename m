From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 08:50:44 +0100
Message-ID: <4F361DD4.9020108@alum.mit.edu>
References: <20120210185516.GA4903@tgrennan-laptop> <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 08:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw7jU-0002xO-5m
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 08:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab2BKHuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 02:50:52 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51021 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab2BKHuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 02:50:51 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED675.dip.t-dialin.net [84.190.214.117])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B7oihX023507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 11 Feb 2012 08:50:45 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190498>

On 02/11/2012 04:06 AM, Junio C Hamano wrote:
> Tom Grennan <tmgrennan@gmail.com> writes:
>> The following series implements !<pattern> with: git-tag, git-branch, and
>> git-for-each-ref.
>>
>> This still requires Documentation and unit test updates but I think these are
>> close to functionally complete.
>
> Do we allow a refname whose pathname component begins with '!', by the
> way?  If we do, how does a user look for a tag whose name is "!xyzzy"?
> "Naming your tag !xyzzy used to be allowed but it is now forbidden after
> this patch" is not an acceptable answer---it is called a regression.  If
> the negation operator were "^" or something that we explicitly forbid from
> a refname, we wouldn't have such a problem.

According to git-check-ref-format(1), '!' are allowed in reference
names.  (Whether that was a good idea is another question, but now we
have to support it.)

So using "^" would be an option.  A problem is that the new meaning is
not consistent with the use of "^" in rev-list, and therefore would (1)
be confusing and (2) prevent the addition of a similar syntax in rev-list.

Currently,

    git rev-list A B ^C

means "revisions reachable from A or B but not from C".  (For simplicity
assume that A, B, and C are literal reference names without wildcards.)
 The proposal, amended to use "^" instead of "!", is that

    git for-each-ref A B ^C

should mean "the reference names A and B but not C".  Therefore, the command

    git rev-list $(git for-each-ref A B ^C)

, which consistency suggests should do the same thing as the first
command, would in fact be equivalent to

    git rev-list A B

Moreover, it *would* be nice to have this kind of exclude-branch-name
syntax in rev-parse.  Many times I have wanted to type the equivalent of

    gitk --all --not-branch=remotes/korg/*

That is, "show the commits starting at *all branches except for the
specified branches*".  This is different than "show *the commits
starting at all branches* except for *the commits reachable from the
specified branches*", because I want to see the *complete* history of
the non-excluded branches.  (Is there an easy way to do this now?)  The
proposed functionality is a step forward; I could type

    gitk $(git for-each-ref !remotes/korg/*)

But it would be even nicer if this could be expressed directly in rev-parse.

In summary, I suggest we consider using a more verbose syntax for this
new functionality (probably via one or more new options, for example
--not-branch=PATTERN, --not-tag=PATTERN, and/or --not-ref=PATTERN) that
cannot be confused with the existing syntax for excluding commits.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
