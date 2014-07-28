From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 10:32:45 -0700
Message-ID: <xmqqtx614cea.fsf@gitster.dls.corp.google.com>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
	<20140728103504.GB10737@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 19:32:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBonD-00050U-93
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 19:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbaG1Rcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 13:32:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64045 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaG1Rcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 13:32:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28AD72BE14;
	Mon, 28 Jul 2014 13:32:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KF3adtIpE3e7stpz0OTD+NjgL54=; b=R1kk+u
	3R/kZ8mORUFHRJcANe8PsbeXFi9uNuDGVXSU8VHKpSawlmaslleVjvQGhToPav59
	lX09UjnQuiiCKMhmPwcfpNFbj5nHXzlJg3dj0UVDuMj99J7YYQIPkCJHF1zNw8vT
	IxBFEdc3bNOvVM6XLjcrTlZyhXgqQWdNE/Ee8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PeREYfmMqprMzXASEt1GwHRQ/UKVEix+
	JzB6Mg4C7raZeF8bCue+AYZ6FZaz2yAQ4qb1vxwvnkt0SiJ5M7fJcZYGrARTfbuY
	NZ4znP2hSw1KqajToQMADYlKkWY/Ds+2RjBHaCTEjzMhLFwc69ved5K2+ryawLpe
	8I9dJ9dIRZk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D0CA2BE13;
	Mon, 28 Jul 2014 13:32:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF3622BE03;
	Mon, 28 Jul 2014 13:32:46 -0400 (EDT)
In-Reply-To: <20140728103504.GB10737@peff.net> (Jeff King's message of "Mon,
	28 Jul 2014 06:35:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3097F91A-167D-11E4-BCFA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254328>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 28, 2014 at 07:42:16PM +1000, Bryan Turner wrote:
>
>> Running a git bisect between v2.0.1, which does not manifest this
>> issue, and v2.0.2 fingers the following commit:
>> bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
>> c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0 is the first bad commit
>> commit c1b3c71f4b4571abb2b2a457122fd100dc9f7eb0
>> Author: Jeff King <peff@peff.net>
>> Date:   Tue Jun 10 17:43:02 2014 -0400
>> 
>>     commit: convert commit->buffer to a slab
>
> I haven't reproduced here yet, but this is almost certainly the bug
> where lookup_unknown_object causes a bogus commit->index field (and
> prior to the commit you found, diff-tree did not use commit->index).
>
> The series that Junio has in jk/alloc-commit-id should fix the problem
> (it's in master already, and slated for v2.1.0).
>
> Junio, we should consider a v2.0.4 with that series, I think. This is a
> pretty serious regression in diff-tree (I didn't even realize that the
> buffer-slab work went into the maint series; that may have been a little
> ambitious).

Or v2.0.4 without that series, which is how we usually do things,
but let me see if jk/alloc-commit-id is easily applicable there
first.

Thanks.
