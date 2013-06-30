From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git stash: Avoid data loss when saving a stash
Date: Sun, 30 Jun 2013 12:14:26 -0700
Message-ID: <7vppv3jtrh.fsf@alter.siamese.dyndns.org>
References: <7vhaghnct4.fsf@alter.siamese.dyndns.org>
	<20130630132017.GQ12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:14:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtN58-0004nC-U6
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab3F3TO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 15:14:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab3F3TO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 15:14:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A37E02C63B;
	Sun, 30 Jun 2013 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDC69ijt2EXJO7s/h9N7kkF7QUg=; b=Vp3ZmH
	ZEIEd/9S/I5ey3vMT3XNYSwM9579G6mzZdGOzVn/TJfAOBX94LDBf0GTvd08Kt0O
	d5nXdtfwFf7Pv6bR5tNOcJ1+q6c6kAz35L6aOdRIfzFMRpPQ3v5KrWMt9I89vEIF
	JAKnHqZOGiqVnDpaOYWGwZTSj0PoS2PowAMdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jT6vBoBRIjvlbCn2mwdeY+jcH8b05slh
	4CtVUcQFhpWiA0HllL1shdbkhC/Wt9ek2/rqp0/yLEnfFMl5Le0T2zbS78dsuwDy
	zWoa6808/XAx8isuFIsza03PNVjmgmk1uuXusvTEYd1rLE74xM2a2ZypQjRTXtbV
	Gp+LtzsGJDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A8532C63A;
	Sun, 30 Jun 2013 19:14:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0001A2C637;
	Sun, 30 Jun 2013 19:14:27 +0000 (UTC)
In-Reply-To: <20130630132017.GQ12252@machine.or.cz> (Petr Baudis's message of
	"Sun, 30 Jun 2013 15:20:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48BD0D54-E1B9-11E2-9700-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229282>

Petr Baudis <pasky@ucw.cz> writes:

>   Hi!
>
> On Fri, Jun 28, 2013 at 11:39:16AM -0700, Junio C Hamano wrote:
>> Thanks.  I'll queue it with a pair of fix-up commits on top, so that
>> they can later be squashed in.
>> 
>> The result of squashing the fix-ups would look like this.
>
>   Thanks! I agree with all of your changes.
>
>> -- >8 --
>> From: Petr Baudis <pasky@ucw.cz>
>> Date: Fri, 28 Jun 2013 17:05:32 +0200
>> Subject: [PATCH] git stash: avoid data loss when "git stash save" kills a directory
>
>   Hmm, it's a pity that the note that `git reset --hard` itself should
> perhaps also abort in that case got lost. I don't insist on mentioning
> it in the commit message, though.

I do not agree with your `git reset --hard` at all.  With the
command, the user demands "no matter what, I want get rid of any
funny state in my working tree so that I can start my work from that
specified commit (default to HEAD)".

Imagine that this is you did to arrive that "funny state":

	$ git rm foo ;# foo used to be tracked and in HEAD
        $ cp /somewhere/else/foo foo
	$ cp /somewhere/else/bar bar ;# bar is not in HEAD
	$ cp /somewhere/else/bar baz ;# baz is in HEAD
        ... do various other things ...

and then "git reset --hard".  At that point, "foo" and "bar" are not
tracked and completely unrelated to the project.  "baz" is tracked
and have unrelated contents from that of "HEAD".

In order to satisfy your desire to go back to the state of HEAD with
minimal collateral amage, we need to get rid of the updated "foo"
and "baz" and replace them with those from HEAD.  We do not have to
touch "bar" so we leave it as-is.

And the "killed" case is just like "foo" and "baz".  If the state
you want to go back to with "--hard" has a directory (a file) where
your working tree's funny state has a file (a directory), the local
cruft needs to go away to satisify your request.

I do not mind if you are proposing a different and new kind of reset
that fails if it has to overwrite any local changes (be it tracked
or untracked), but that is not "reset --hard".  It is something else.

> On Fri, Jun 28, 2013 at 02:30:15PM -0700, Junio C Hamano wrote:
>> -- >8 --
>> Subject: treat_directory(): do not declare submodules in index to be untracked
>
>   Oh, you are truly awesome! I admit that properly reviewing this patch
> is a little out of my depth right now as I'm not familiar with this
> infrastructure. I'd just like to note...
>
>>  	case index_gitdir:
>>  		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>>  			return path_none;
>> -		return path_untracked;
>> +		return path_none;
>
> ...that the if-test can be removed now as both branches are the same.

Thanks for noticing.  What was queued on 'pu' should already have
fixed that one.
