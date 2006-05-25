From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 11:00:59 -0600
Message-ID: <m1lksqdook.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 19:02:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjJDf-0007nG-OC
	for gcvg-git@gmane.org; Thu, 25 May 2006 19:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWEYRBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWEYRBw
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 13:01:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46751 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030281AbWEYRBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 13:01:51 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4PH10fK010290;
	Thu, 25 May 2006 11:01:00 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4PH0xFo010289;
	Thu, 25 May 2006 11:00:59 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtcay5k8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 24 May 2006 23:36:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20749>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> I clearly would not advertise it.  My problem is that I have
>> evidence that someone pulled a given sha1 at some point from 
>> some branch on a given repository.  But I don't have that branch.
>
> If that was over rsync (as you mention later), then I would
> consider that is an unfortunate unfixable issue.  rsync mirrors
> are fundamentally unsafe for git -- Linus and I do not keep
> saying rsync should be deprecated without good reasons.
>
> There still might be bugs that breaks this guarantee outside
> rsync, but if that is the case we should fix it.

Sounds reasonable.  So far I don't believe anything I have
proposed would result in a reference getting written
if we don't transfer all of the dependencies.

I do need to examine the algorithm by which we compute what
to transmit and make certain I have not broke that.
I believe I am still only using the existing references
for finding a common point in the history.

> I do not want to rehash the thread around Sep 29th 2005 here.
> The entry point of that thread is this message:
>
> 	http://marc.theaimsgroup.com/?l=git&m=112795140820665
>
> and the punch line are these two messages:
>
> 	http://marc.theaimsgroup.com/?l=git&m=112801874021223
> 	http://marc.theaimsgroup.com/?l=git&m=112802808030710
>
> I did not realize what I was breaking initially.  I am not
> ashamed of having been wrong, but it was embarrassing ;-).
>
>> If I want
>> a copy of your pu branch at some point in the past, but you have
>> rebased it since that sha1 was published then there will clearly not
>> be a path from any current head to that branch.  But if I still have a
>> copy of the sha1 I should actually be able to recover the old copy of
>> the pu branch from your tree.
>
> Not necessarily.  I occasionally prune after rewinding.  When my
> "pu" branch head does not point at the lost commit, the
> repository may or may not have that object you happen to know I
> used to have anymore.

Agreed.  Of course the simple object existence test works in that
instance.  Not that it does in general.  The could be a git-prune
versus upload-pack race for instance.

>>> Now, proving that a given SHA1 is the name of an object that
>>> exists in the repository is cheap (has_sha1_file()), but proving
>>> that the object is reachable from some of our refs can become
>>> quite expensive.  That gives this issue a security implication
>>> as well -- you can easily DoS the git-daemon that way, for
>>> example.
>>
>> Exactly, which is why I aimed for the cheap test.
>
> But the thing is the cheap test is broken, eh, rather,
> propagates brokenness downstream (which is perhaps worse).

As I understand it brokenness is writing a ref when you don't
have the complete tree it points to.  I have no desire
to do that.

My basic argument is that starting a pull with a commit that is not a
reference is no worse than staring a pull from a broken repository.  The
same checks that protects us should work in either case.

So as long as what I have done does not compromise the computation
of a common ancestor I think we should be fine.

I can see the argument that in a non-broken repository that finding
a path from an existing ref is proof that everything will work.
However if the code can be made to work without requiring that
proof it should be an even stronger guarantee of correctness,
and the expensive step of walking down from an existing ref would
be unnecessary.

Eric
