From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't git stash after using git add -N
Date: Tue, 15 Mar 2016 16:46:48 -0700
Message-ID: <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
References: <20160315230754.GA12058@cloud>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 00:47:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afyfy-0001WK-ON
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 00:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965953AbcCOXqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 19:46:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964852AbcCOXqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 19:46:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45F4E4D7DA;
	Tue, 15 Mar 2016 19:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pcpUI4ewKxIRzU/zSQJB2uRaFMM=; b=lDemAL
	i2mxsD8+B8pb8u4ACa6jpDzfQnOfJ577er27DfRFfuOfdyHBt/Mg1myRWp/QkDt2
	LThxXgIxyP33p3WopvM6wkDZQZKF3peNKASsgo+JxOKXWBf/UAoXnk5c0QQxtpec
	ah9QhWSN7sUtv6TI4FkIWHDf4fLyyLh1jalvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vUcgOtlxOs04xasDjoGojuDaeZvkGNW8
	dt/xmHBs6TlVsKhdfl/6qvlHNoguZOHTgp8Gsyo/kcaB0eROAkQar9of4lKJN/a4
	ENLi5Nv2NNF/vBo0KwI9U5JVloikvFunAMVLoFqhCMbPvNEObopOA85sOFFj7txm
	K0qd64CDAJA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C64F4D7D9;
	Tue, 15 Mar 2016 19:46:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B7C944D7D8;
	Tue, 15 Mar 2016 19:46:49 -0400 (EDT)
In-Reply-To: <20160315230754.GA12058@cloud> (Josh Triplett's message of "Tue,
	15 Mar 2016 16:07:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FBA1B66-EB08-11E5-B026-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288928>

Josh Triplett <josh@joshtriplett.org> writes:

> After using "git add -N", "git stash" can no longer stash:

I think this is unfortunately one of the fundamental limitations
that comes from the way how "stash" is implemented.  It uses three
tree objects (i.e. HEAD's tree that represents where you started at,
the tree that results by writing the index out as a tree, and
another tree that would result if you added all the changes you made
to the working tree to the index and then writing the resulting
index out as a tree), but there are some states in the index that
cannot be represented as a tree object.  "I know I would eventually
want to add this new path, but I cannot decide with what contents
just yet" aka "git add -N" is one of them (the other notable state
that cannot be represented as a tree object is paths with unresolved
conflicts in the index).

"git rm --cached" the path and then running "stash save" would be a
workaround, but then you'd probably need to use "--untracked" hack
when you run "stash save" if you are stashing because you are going
to do something to the same path in the cleaned-up working tree.
