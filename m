From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Wed, 12 Oct 2011 12:20:18 -0700
Message-ID: <7vipnu81al.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4Lt-0000z3-D7
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab1JLTUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:20:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab1JLTUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:20:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 211D85146;
	Wed, 12 Oct 2011 15:20:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=22IT9raGP40ceLkBzp3UfHjC/ls=; b=MsOiFAn/WTZJiRm9JkUA
	DazxmABs4b1Gg6gYmo/Fy0bmm+s2nCF1euUPP6IUzKAYrRFZc+vIIelvIHZgER75
	W4YZR+oxdv+cwNr7cv/WkhSpr+0FiUVp0fXZeSZmDm3A33ACBJFS/ferZnafgTic
	47VuHhK/cWmgDtTVjLvLn5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BlA5UjBCqcLdeLxhxzQDsM0/PRZKELin+nIv5JtXWPnhkg
	q0QiNOe59ESEusxyVlVtI4cag3inMmy6hbWFOjIhir1fTCZgpzaQUPso4oWWq3Uf
	vNMe1hDCq2aOInKJUSD26pQ8LbgRExaKpIXbuUFYRF7h7qEeuhOhVy/5Xi8vI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1773A5145;
	Wed, 12 Oct 2011 15:20:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B6AB5144; Wed, 12 Oct 2011
 15:20:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3953DF46-F507-11E0-84AA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183404>

Jeff King <peff@peff.net> writes:

> We also look at ref_rev_parse_rules in shorten_unambiguous_ref. So even
> with your patch, I still get the warning with:
>
>   $ git branch config
>   $ git for-each-ref --format='%(refname:short)' refs/heads/
>
> It looks like we also use it in remote.c:count_refspec_match, but I
> haven't figured out if that can trigger a warning or not.

I do not think this is "do not trigger a warning" exercise. This is "we no
longer consider names outside refs/ as potential magic refs unless they
are all uppercase".

If the updated dwim_ref() says $GIT_DIR/frotz will no longer create
ambiguity with $GIT_DIR/refs/heads/frotz, then refname_match() needs to
know about it, and cause count_refspec_match() to say that "frotz"
uniquely names "refs/heads/frotz".

The same stands for shorten_unambiguous_ref(). If $GIT_DIR/frotz no longer
is ambiguous with $GIT_DIR/refs/heads/frotz, then %(refname:shrot) for
refs/heads/frotz should yield "frotz", and we should not have to qualify
it as "heads/frotz".
