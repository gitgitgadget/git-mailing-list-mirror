From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Wed, 26 Aug 2009 22:00:56 -0700
Message-ID: <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <1251337437-16947-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 27 07:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgX72-0004d3-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 07:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbZH0FBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 01:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZH0FBT
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 01:01:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbZH0FBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 01:01:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B45438501;
	Thu, 27 Aug 2009 01:01:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dmNCQBSrseVWxk1wW/V61NkeV4M=; b=Q96rIrfu3/HqK5mndO5LIQB
	EjrfRbISo+i3ULwjPYZBw8kBZofDpo9NKf2TNA6WfgU3cSwTcqmpd5xAJ3o9DyBA
	Oeib0754SxLwnb0I7pKrAgJw5md86vPLcNnbbyE53uP9GbGCceJ+QChjkC5xGh/s
	2uS6gDyt/3Aoq/x86aZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=b/gJJgPFALEpdu+byA5I29BEQn3mtVV0vlLqp/S1dDNJ/NG6M
	27f8rTH54JGfcOtRqlJGNaQHgzpwWTdk1j9IE4ZjRzPtGJlmRhG6QOVLvrL9jRDq
	y/ZbolV4ZC2756RnGSYbdphADUuhCQkoUP7cx32L1IHD5bDr8bO50JTRc8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CEDC384FA;
	Thu, 27 Aug 2009 01:01:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3BE40384F8; Thu, 27 Aug 2009
 01:00:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3632AAE-92C6-11DE-8306-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127141>

Johan Herland <johan@herland.net> writes:

> The semantics used when parsing notes trees (with regards to fanout subtrees)
> follow Dscho's proposal fairly closely:
> - No concatenation/merging of notes is performed. If there are several notes
>   objects referencing a given commit, only one of those objects are used.
> - If a notes object for a given commit is present in the "root" notes tree,
>   no subtrees are consulted; the object in the root tree is used directly.
> - If there are more than one subtree that prefix-matches the given commit,
>   only the subtree with the longest matching prefix is consulted. This
>   means that if the given commit is e.g. "deadbeef", and the notes tree have
>   subtrees "de" and "dead", then the following paths in the notes tree are
>   searched: "deadbeef", "dead/beef". Note that "de/adbeef" is NOT searched.
> - Fanout directories (subtrees) must references a whole number of bytes
>   from the SHA1 sum they subdivide. E.g. subtrees "dead" and "de" are
>   acceptable; "d" and "dea" are not.
> - Multiple levels of fanout are allowed. All the above rules apply
>   recursively. E.g. "de/adbeef" is preferred over "de/adbe/ef", etc.

If I am reading this correctly, the earlier parts of the series were
aiming to let multiple people to add notes to the same commit more or less
uncordinated while still allowing to merge them sensibly, but now such a
workflow becomes impossible with this change.  

The above claims notes trees with different levels of fan-out are allowed,
but what it really means is that merging notes trees with different levels
of fan-out will produce a useless result that records notes for the same
commit in different blobs all over the notes tree, and asking the notes
mechanism to give the notes for one commit will give only one piece that
originates in the tree whose creator happened to have used the longest
prefix while ignoring all others.  It may _allow_ such a layout, but how
would such semantics be useful in the first place?

I suspect that I am missing something but my gut feeling is that this
change turns an interesting hack (even though it might be expensive) into
a hack that is not useful at all in the real world, without some order,
discipline, or guideline is applied.

What's the recommended way to work with this system from the end user's
point of view in a distirbuted environment?  Somebody up in the project is
supposed to decide what fan-out is to be used for the whole project and
everybody should follow that structure?  If a participant in the project
forgets that rule (or makes a mistake), a notes tree that mistakenly
merges his notes tree becomes practically useless?  If so, perhaps we
would need a mechanism to avoid such a mistake from happening?
