From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Wed, 26 Aug 2009 02:03:50 -0700
Message-ID: <7vk50reykp.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908240144530.28290@iabervon.org>
 <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk>
 <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
 <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org>
 <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org>
 <20090825151424.GJ1033@spearce.org> <20090826021057.GL1033@spearce.org>
 <4A94DF84.4050906@viscovery.net> <20090826082256.GO1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:04:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgEQV-0003Ew-En
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbZHZJEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbZHZJEI
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:04:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532AbZHZJEG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:04:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3841197A2;
	Wed, 26 Aug 2009 05:04:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=lCSZJxsaqzZzuF6/tudUuio6jv0=; b=fhlw+YQyQ4fgoaWVmkwE3G7
	0KvZIuqUaAPpBvQYcmSTm3v2cN70v8Gl1dBqvoLR+Z/VTJu7oqeWQHl5+PHTIb7q
	46I/bnpkaSvtm0bagZqxLdw1K4zZrdAdHu1UwdsOqRJ4vv+z+rvoCrNvtcA54S8t
	k9VBzsamK2wafvGNQgBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Oty+YKS9e2lXwsbonM02P5It8cIcjoz2lFdDS4LfyMSJg14GG
	L8UeB9stdFuaPebmTClsO4FmV/2c2NnXOer+MbucmF1BtiULSH1JOFqO8HMA1G8/
	inPg9ATE51+E6I5PJE2o+t2Lt585L42WfJ8p/r+m55HgFKpGSXmYqgL3a0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59EB6197A0;
	Wed, 26 Aug 2009 05:04:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C86C41979F; Wed, 26 Aug
 2009 05:03:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6590A85C-921F-11DE-9D01-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127075>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> How will this mesh with 'git clone --mirror'?
>
> Not well.
>
>> Is the client expected to
>> ask with 'expand refs/*'?
>
> If the client is new enough to understand the "expand" extension,
> yes, it would ask for "expand refs/*" and get everthing, allowing
> it to complete a full mirror.
>
> If the client is older and doesn't know this extension, then it
> is hopeless.  The server isn't advertising refs/*, doesn't know
> that the client can't ask for refs/*, and the client doesn't know
> it is missing refs when it makes the mirror.
>
> This backwards incompatible breakage is something I have no real
> solution for.  :-|

But we at least can assume that the server operator is reasonable and
wouldn't go overboard, (ab)using this "abbreviated advertisement" feature
to hide heads and tags from the clients.  I would suspect that a server
operated by such a sick person who hides these normal refs will be shunned
by users so it won't either happen in practice, or even if it happens, it
won't be a problem---simply because nobody would want to interact with
such a server.  

Think about in what situation you would want to do a mirror clone.  The
most obvious is to have a back-up or secondary distribution point, and I
do not think of any other sane reason (other than "because I can", which
does not count).  If the original repository has so many refs to benefit
from the "abbreviated advertisement" feature (otherwise there is no point
using it in the first place), then its mirror repository would also want
to use the feature when talking to its clients, acting as a back-up
distribution point.  That means the version of git used to prime, update
and serve the mirror will know the expand extention.

I am hoping that we can finish 1.6.5 by mid September (let's tentatively
say we will shoot for 16th).  I expect the expand extention to be in
'next' by that time, cooking for 1.7.0.  How does that timetable sound?
