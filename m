From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] cache-tree: Create/update cache-tree on checkou
Date: Tue, 02 Sep 2014 13:52:38 -0700
Message-ID: <xmqqfvg9zqw9.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<20140831120703.GA1240@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:52:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOv4M-0005Hh-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 22:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbaIBUwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 16:52:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52098 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889AbaIBUwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 16:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 318CB374D9;
	Tue,  2 Sep 2014 16:52:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MemdBk0sByDT+WgL3/t+MTJIJOw=; b=kJheh2
	DWdNbspqHIjMjizOj4lRzn1S8jXojwZfWesN+fyy+T87NtA7lBF3MJt29jBXnWrC
	dK/gcV8+soabZzFhbTkJWZf9suacSAOjdiiLISwfftlU0B7H29Y9++XQl2GJnuVS
	DybApEBZbBnMZ9CfcUt2g8G+/RIkVv0wc2O+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQZpriFTkJUd1Fk081M5IE9rqWOHo6mk
	R6zZCkdzZtZSHppOSimBWF79bFVJpqNtdXAIQxyjJtgoC21gOvRviQHkUet9K9QG
	ZFIE9Wo6RBbGniUt9KoLVhDwuvcSOEtEGV9t9t56GHcoSvbT0m13Bg071bOZ50Kr
	U31R/tdQBoU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 288BC374D8;
	Tue,  2 Sep 2014 16:52:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58C40374BE;
	Tue,  2 Sep 2014 16:52:40 -0400 (EDT)
In-Reply-To: <20140831120703.GA1240@serenity.lan> (John Keeping's message of
	"Sun, 31 Aug 2014 13:07:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14133084-32E3-11E4-9AE7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256345>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Jul 11, 2014 at 09:44:33PM -0700, David Turner wrote:
>> When git checkout checks out a branch, create or update the
>> cache-tree so that subsequent operations are faster.
>> 
>> update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
>> WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
>> correspond to existing tree objects are invalidated (and portions which
>> do are marked as valid).  No new tree objects are created.
>> 
>> Signed-off-by: David Turner <dturner@twitter.com>
>> ---
>
> This causes an incorrect error message to be printed when switching
> branches with staged changes in a subdirectory.  The test case is pretty
> simple:
>
> 	git init test &&
> 	cd test &&
> 	mkdir sub &&
> 	echo one >sub/one &&
> 	git add sub/one &&
> 	git commit -m one &&
> 	echo two >sub/two &&
> 	git add sub/two &&
> 	git checkout -b test
>
> After this commit the output is:
>
> 	error: invalid object 040000 0000000000000000000000000000000000000000 for 'bar'
> 	A       bar/quux
> 	Switched to branch 'test'
>
> but the "error:" line should not be there.

Yeah, this seems to be broken and I am unhappy that I didn't notice
it myself as I always use a version that is somewhat ahead of 'next'
myself.
