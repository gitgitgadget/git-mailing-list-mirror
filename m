From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH (WIP)] Show a dirty working tree and a detached HEAD
 in status for submodule
Date: Tue, 12 Jan 2010 23:09:57 -0800
Message-ID: <7vbpgyqy4a.fsf@alter.siamese.dyndns.org>
References: <4B4BA096.5000909@web.de>
 <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUxMz-0004nY-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 08:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab0AMHKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 02:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766Ab0AMHKP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 02:10:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab0AMHKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 02:10:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C05901B6;
	Wed, 13 Jan 2010 02:10:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=h1QWfKY6lvGcuWCths2AbRXyrV0=; b=K2SXT8tsRxVegYvtYSENk2p
	ijr7CnFWDCyBMWgvY4Z8eZX/NwPblDTKjbHswadD4XiYCo7gT8FszE7BYaumDp8c
	pQr2EPfuQg4h4brCTZWYFsMNcYP1DzJLuPg0RaHmeDhp4f0HZe7oaIhsMVZF28oA
	rRPexWC+jb34g3zvN1aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=W50NEi9utyzbY1rn0SZN2yGAgEp/8yUmcDdFZjMuGr/0TcwEi
	HSBW1wu0ZpEGZujWjcvsRUO6cQmMuAnKbstG6kvZD6KqVbThEZjyy4iwcvtNTJI3
	54vT0/I4WKSF0YAARX+ej75DlNEfVvvaW5iqEERMGoFfXSYxeLuE7A3JzE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64169901B1;
	Wed, 13 Jan 2010 02:10:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3BA5901AF; Wed, 13 Jan
 2010 02:09:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD6EB9F0-0012-11DF-AD04-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136787>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> To avoid possible loss of commits.
> ... Or the remote branch the
> user thinks the submodule is tracking has been deleted or rebased. You
> might want to know that before e.g. committing it in the superproject.

The interaction between recursive reset/checkout and gc in submodule
repository is something I didn't think about thoroughly, but I think you
are solving the issue in a wrong place at a wrong level.

We have so far neglected the object reachability analysis across
repositories.  When people use "clone --reference" to take advantage of
alternate object store, we tell them not to use any repository that
rewinds its branches as reference.  Putting it the other way around, we
tell owners of repositories that somebody borrows objects from not to run
gc, because objects they themselves do not use may be used by others who
borrow from them.  But we don't _enforce_ it; it is merely a social
convention.  We might want to do something about it, perhaps by having
typed back-pointers from a borrowed repository to borrowing repositories.

I think commits in submodules that are pointed at by _some_ superproject
commits are in the same situation.  Just like some objects in a borrowed
repository may have to be protected by refs in borrowing repositories,
some commits in a submodule repository (here I am only talking about
repositories that serve as distribution points---a private repository of a
user who is not interested in that particular submodule is excluded from
this discussion and may not follow the same rules) may have to be
protected by commits reachable by refs in its superproject repository.

The right solution to your "gc might soon remove objects from submodule
repository even when commits in the superproject uses them" may be to
teach "gc" run in the submodule repository to behave better.  After all,
even if the commit were reachable from some of the refs in the submodule
when you created a commit that points at it at the superproject level,
next "git submodule update" might rewind that ref in the submodule that
reached the commit and make it unreachable; your check to be careful at
commit time wouldn't buy you much, even if the check were 100% accurate.

Also in _your_ repository you may have the submodule commit with your
check at the time you make commit in the superproject, but if you forget
to push it out from the submodule before you push the commit out from the
superproject, other people will suffer from the same issue you are trying
to guard against.

In any case, this "where in the submodule's history does the commit being
recorded lie" does not have anything to do with "diff/status" that lets
you know "has it been _modified_?" at the level of the superproject.  As
you mentioned, it is more similar to "Untracked files" section in "status"
output of a flat project.  It doesn't belong to "diff", nor to "Changed
but not updated" section.

>>> * This behavior is not configurable but activated by default. A config
>>>   option is needed here.
>> 
>> I doubt it.
>> 
>> My gut feeling is that this should be _always_ on for a submodule
>> directory that has been "submodule init/update".  The user is interested
>> in that particular submodule, and any change to it should be reported for
>> both classes of users.  Those who meant to use the submodule read-only
>> need to be able to notice that they accidentally made the submodule dirty
>> before making a commit in the superproject.  Those who wanted to work in
>> submodule needs to know if the state is in sync with what they expect
>> before making a commit in the superproject.
>
> Yes, me too thinks it should default to on for every initialized
> submodule.
>
> But this is a major change in behavior, so it might be a good idea to be
> able to turn it off (e.g. if it breaks scripts).

If scripts are broken by this change, I think it is actually a good thing.

They've been operating happily as if everything is clean when some
submodule directories are *not*, and your patch starts showing something
closer to the reality, the changes they should care about.  If on the
other hand the scripts are willing to commit the index while leaving local
modifications behind, they will not be checking with "diff" output
(instead they will be checking "diff --cached") and you won't change the
output with your patch for that codepath, so they will keep working
happily.

>> But the thing is, in a distributed environment, the submodule HEAD being
>> at the tip of _some_ branch (either local or remote) you have doesn't mean
>> anything to help them.  IOW, for protect others, you would need a check
>> when you _push out_ (either in 'push' or on the receiving end).

The right place to do this check is at the receiving end. Just like they
can be (and by default are) configured to reject a non ff push into the
repository, the receiving end of the superproject can inspect the incoming
history and make sure that the commits bound at submodule paths are all
available to others that might want to fetch those superproject commits
from it in associated submodule repositories.  It would forbid people from
first pushing superproject and then pushing submodule projects, but I
think that is a better workflow anyway (you make sure prerequisites are
available in the submodule repositories to others first, and then make the
superproject commit that depends on the submodules).

You may also need to check at the receiving end when pushing into the
submodule repository; if the push is a non ff one, it _might_ lose commits
that are still needed by the associated superproject.

>> So I'd suggest dropping this condition in "status/diff" that is about
>> preparing to make the next commit in your _local_ history.
>
> I would rather have this patch merged without c) than not at all. But i
> think it is a worthwhile and rather cheap test.

Did I ever say "drop (c) because it is *too expensive*"?

I suggested to drop it because it is a _pointless_ check in the context of
the codepath, even though I was too polite to put it that bluntly in the
message you are responding to.

I think this topic of yours overall is going in the right direction.  I
have no issue with the intent to show submodules with local changes in
"Changed but not updated" section of status, or do the "+sha1-dirty" thing
in diff.

Thanks.
