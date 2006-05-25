From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Wed, 24 May 2006 23:09:21 -0600
Message-ID: <m13beysnb2.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 25 07:10:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj86z-0001rj-Mn
	for gcvg-git@gmane.org; Thu, 25 May 2006 07:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWEYFKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 01:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWEYFKO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 01:10:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29080 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965040AbWEYFKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 01:10:12 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4P59MFS004356;
	Wed, 24 May 2006 23:09:22 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4P59LZx004355;
	Wed, 24 May 2006 23:09:22 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejyjpz9a.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 24 May 2006 02:07:13 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20728>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Can we fix the check in upload-pack.c something like my
>> patch below does?  Are there any security implications for
>> doing that?
>
>> Could we just make the final check before dying if (!o) ?
>
> The primary implication is about correctness, so I am reluctant
> to break it without a careful alternative check in place.
>
> The issue is that having a single object in the repository does
> not guarantee that you have everything reachable from it, and we
> need that guarantee.  Reachability from the refs is what
> guarantees that.

I don't see why having something reachable from a ref guarantees
that everything is reachable.  Given the recent patch that added
a check to make certain a ref actually existed I believe there
is some evidence that trees may become corrupted, and have the
problems you describe.

> We are careful to update the ref at the very end of the transfer
> (fetch/clone or push); so if an object is reachable from a ref,
> then all the objects reachable from that object are available in
> the repository.

In the normal case I agree.

> Imagine http commit walker started fetching tip of upstream into
> your repository and you interrupted the transfer.  Objects near
> the tip of the upstream history are available after such an
> interrupted transfer.  But a bit older history (but still later
> than what we had before we started the transfer) are not.
>
> We do not update the ref with the downloaded tip object, so that
> we would not break the guarantee.  This guarantee is needed for
> feeding clients from the repository later.  If you tell your
> clients, after such an interrupted transfer, that you are
> willing to serve the objects near the (new) tip, the clients may
> rightfully request objects that are reachable from these
> objects, some of them you do _not_ have!

I clearly would not advertise it.  My problem is that I have
evidence that someone pulled a given sha1 at some point from 
some branch on a given repository.  But I don't have that branch.

Actually trees mirrored with rsync have similar problems all of
the time when the catch a tree in the middle of an update.

> So this "on demand SHA1" stuff needs to be solved by checking if
> the given object is reachable from our refs in upload-pack,
> instead of the current check to see if the given object is
> pointed by our refs.  When upload-pack can prove that the object
> is reachable from one of the refs, it is OK to use it; otherwise
> you should not.

I have a problem with that approach.  Suppose the branch I have
evidence something came from is like your pu branch.   If I want
a copy of your pu branch at some point in the past, but you have
rebased it since that sha1 was published then there will clearly not
be a path from any current head to that branch.  But if I still have a
copy of the sha1 I should actually be able to recover the old copy of
the pu branch from your tree.

> Now, proving that a given SHA1 is the name of an object that
> exists in the repository is cheap (has_sha1_file()), but proving
> that the object is reachable from some of our refs can become
> quite expensive.  That gives this issue a security implication
> as well -- you can easily DoS the git-daemon that way, for
> example.

Exactly, which is why I aimed for the cheap test.

There is a reasonable argument that can be made that the branches
represent the policy that you are willing to serve.  If you have a
tree and share a common object store with a much lager tree, like
David Woodhouse has set up, I can see such a policy being desirable.

That is an argument I have a much harder time shooting down.
At the same time if it is just a policy question the policy it should
be modifiable with an appropriate configuration directive, or
command line option.

Eric
