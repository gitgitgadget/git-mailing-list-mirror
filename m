From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame performance
Date: Fri, 06 Nov 2015 09:53:57 -0800
Message-ID: <xmqqwptv2eve.fsf@gitster.mtv.corp.google.com>
References: <563CAD30.6040608@alcatel-lucent.com>
	<563CBEC8.7070209@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:54:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZulDD-0005OF-65
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 18:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161724AbbKFRyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 12:54:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161008AbbKFRyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 12:54:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDA2224646;
	Fri,  6 Nov 2015 12:53:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UifXpKzJ3PFYC5LCsTpbyOubj0E=; b=b7W0RK
	CBLR+WqHFq3ntx1UtmUx+Oj3WZAoxfbIC9wZX/lgx8k63DMbfq/lGaTZn0eH0JBQ
	4q2hVRTSc47y9BzeSr9OPrF56uJMpdys4ncJlMtFUVT4XBDSveA9dHvC7OvcGESO
	3JTCCWbB+Se6IFp5A1ssTFqlwNfQ4eDkvNuN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSHFf8UA5eaAtJjx8wQvXFDv9dOlDKDa
	JVWgy4YmAcWeFKsnewhOs0ajpePxsluSehImkhEUAelicq4O+te1BciNgW8SVl/u
	wi2lEqN5mIZN5lZ7GqzMSy+FgWoAdL/lWIKFtJ6BRVUHt0R7/t9yQz8XSajlrtey
	3gyhnPmF8Dg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4B4124644;
	Fri,  6 Nov 2015 12:53:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 288FE24643;
	Fri,  6 Nov 2015 12:53:59 -0500 (EST)
In-Reply-To: <563CBEC8.7070209@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 06 Nov 2015 15:52:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B5F2730-84AF-11E5-918F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280992>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The reason that cvs annotate is so much faster than git blame is that
> CVS stores revisions filewise, with all of the modifications to file
> $FILE being stored in a single $FILE,v file. So in the worst case, CVS
> only has to read this one file.
>
> Git, on the other hand, stores revisions treewise. It has no way of
> knowing, ab initio, which revisions touched a given file. (In fact, this
> concept is not even well-defined because the answer depends on things
> like whether copy (-C) and move (-M) detection are turned on and what
> parameters they were given.) This means that git blame has to traverse
> most of history to find the commits that touched $FILE.
>
> Slow git blame is thus a relatively unavoidable consequence of Git's
> data model. That's not to say that it can't be sped up somewhat, but it
> will never reach CVS speeds.

Another thing to consider for a converted repository is that mass
converters tend to either not make a pack at all or make a pack that
is horribly inefficient to access.  Running "git repack -a -d -f"
with a small value of "--depth" may be a thing worth trying, if that
is contributing to the performance.
