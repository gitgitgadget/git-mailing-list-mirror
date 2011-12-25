From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Sun, 25 Dec 2011 01:30:03 -0800
Message-ID: <7vsjk99exw.fsf@alter.siamese.dyndns.org>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sun Dec 25 10:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RekQJ-0005Hg-D2
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 10:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab1LYJaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 04:30:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab1LYJaw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 04:30:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B57105C10;
	Sun, 25 Dec 2011 04:30:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvWUYnVVAumnxt4MQVWGwN4rDZU=; b=DMZZtS
	CMbSvaE8mY3gbdpsaUrw3USZJImXNd+rxc51KHf42ytYwwWjD3hR/JJnJHjl/KDw
	UrNU4BnNC2gq172C9tO/cPgj5wykMmZNIUzWkDe1eHBcXYF3duBWEK1meq2O0K4C
	P/3mTcqvs95OwC8D9yFi6TVwahFOmycaRuj8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qV8MAwOUj+b6h+SNO/ajzqsqGu/+uhIV
	Gf6WeXlB+YfAuKifi3+EcgiOVe3S8/cQfRStXkos83h8TBke+tBOW+F6KN0nUeag
	61u4s/W4eT6mK8Z9CikEuoxo7pUUjnQB8Hyfd6r1k9nRJUyHbtLeDyVc9PiBicDP
	xgPWghjWf2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACA9E5C0F;
	Sun, 25 Dec 2011 04:30:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9E5F5C06; Sun, 25 Dec 2011
 04:30:04 -0500 (EST)
In-Reply-To: <20111225035059.GA29852@gnu.kitenet.net> (Joey Hess's message of
 "Sat, 24 Dec 2011 23:50:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 071A1AA0-2EDB-11E1-B82E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187679>

Joey Hess <joey@kitenet.net> writes:

> Junio C Hamano wrote:
>> If we _were_ to sanction the use of the hook to tweak the result, I do not
>> want to see it implemented as an ad-hoc hack that tells the hook writers
>> that it is _entirely_ their responsiblity to update the remote tracking
>> branches from what it fetched, and also update $GIT_DIR/FETCH_HEAD to
>> maintain consistency between these two places.
>> 
>> A very cursory look at the patch tells me that there are a few problems
>> with it.  It does not seem to affect what will go to $GIT_DIR/FETCH_HEAD
>> at all, and hence it does not have any way to affect the result of the
>> fetch that does not store it to any of our remote tracking branches.
>
> True, it does not update FETCH_HEAD. I had not considered using the hook
> that way.

Perhaps I misread what you wrote in the commit log message then.  I
somehow got an impression that one of the advertised way for the hook to
be used was to lie which commits the remote tracking refs point at by
letting it run "update-ref refs/*/*" and the lie is later picked up by
re-reading them, but I wasn't reading the patch very carefully.

If your use case does not involve updating the remote tracking refs nor
FETCH_HEAD (updating only one and not the other is a no-starter), then we
should explicitly forbid it in the documentation, as allowing updates will
invite inconsistencies.

Although I do not deeply care between such a "trigger to only notify, no
touching" hook and a full-blown "allow hook writers to easily lie about
what happened in the fetch" hook, I was hoping that we would get this
right and useful if we were spending our brain bandwidth on it. I am not
very fond of an easier "trigger to only notify" hook because people are
bound to misuse the interface and try updating the refs anyway, making it
easy to introduce inconsistencies between refs and FETCH_HEAD that will
confuse the later "merge" step.

As hook writers are more prone to write such an incorrect code than people
who implement the mechanism to call hooks on the git-core side, the more
the hook interface helps hook writers to avoid such mistakes, the better.

So if we were to allow the hook to lie what commits were fetched and store
something different from what we fetched in the remote tracking refs, I
think the correct place to do so would be in store_updated_refs(),
immediately before we call check_everything_connected().

 - Feed the contents of the ref_map to the hook. For each entry, the hook
   would get (at least):
   . the object name;
   . the refname at the remote;
   . the refname at the local (which could be empty when we are not
     copying it to any of our local ref); and
   . if the entry is to be used for merge.

 - The hook must read _everything_ from its standard input, and then
   return the
   re-written result in the same format as its input. The hook could
   . update the object name (i.e. re-point the remote tracking ref);
   . update the local refname (i.e. use different remote tracking ref);
   . change "merge" flag between true/false; and/or
   . add or remove entries

 - You read from the hook and replace the ref_map list that is fed to
   check_everything_connected(). This ref_map list is what is used in the
   next for() loop that calls update_local_ref() to update the remote
   tracking ref, records the entry in FETCH_HEAD, and produces the report.

This way, the hook cannot screw up, as what it tells us will consistently
be written by us to where it should go.
