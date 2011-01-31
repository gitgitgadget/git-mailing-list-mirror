From: Junio C Hamano <gitster@pobox.com>
Subject: [1.8.0] default "git merge" without argument to "git merge @{u}"
Date: Mon, 31 Jan 2011 09:06:33 -0800
Message-ID: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 18:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjxDC-0007Rp-QN
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 18:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab1AaRGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 12:06:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1AaRGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 12:06:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 789384167;
	Mon, 31 Jan 2011 12:07:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tGxpV/wTec13+EeGCzPl/i9x2p4=; b=P/rCON
	gk34WT4ctr/3afzp3BAWyAOFuaAqOFVOMhJVNZafhcN5/vgECFHT33aYHpeBOhce
	iT+WTWD/mhhCuOUVGHaU/dtQ1v3Cjsowk5Gm1HK/RereNzV4kdxCKc+LNrgV7OrD
	/r26X1yLEhyUbe+ZnoejtBGmg1mRuFfnvduTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KVp9VDEuXEOVJlHwKQytyK9BMPNpgi2G
	G2G3TEHDkVFMAwSy4sBBeUrFjLGZOboO1GtDryMwc64J6HjbirFUakGcqfKxPEuk
	NkmYVj8vpmHJYz4EFmNEQ/cYur8pKEzD2xZdx0BfW/geMk8SMLACFaCm6Xd6eDEB
	QGAsU2u9Nas=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53E074166;
	Mon, 31 Jan 2011 12:07:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B7D24162; Mon, 31 Jan 2011
 12:07:28 -0500 (EST)
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 31 Jan 2011 09\:05\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96E66C3C-2D5C-11E0-8B0D-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165736>

Proposal:

Currently "git merge" without saying what to merge is a no-op, and
succeeds silently.  As many downstream developers (that are by definition
more numerous than people who do not have "upstream") run merge from the
configured upstream of the current branch most of the time, it would make
it more convenient for them to change the default to merge from the
upstream of the current branch.  Running "git merge" without argument,
when there is no upstream defined for the current branch, will be an
error.

Risks:

Existing scripts may prepare what to merge in an array (e.g. in Bourne,
accumulating them in "$@" by repeatedly doing 'set "$@" "$newbranch"') and
call 'git merge "$@"', relying on the current behaviour that zero argument
means no-op.  Such scripts will be broken by this change.  Driving "git
merge" with xargs without --no-run-if-empty (not POSIX), feeding the
branches to merge in an Octopus, will be broken the same way.

Migration plan:

Add merge.defaultUpstream configuration variable, which defaults to false
when unconfigured.  Change "git merge" so that when this configuration is
set and the command is run without the commit to merge to use the
configured upstream of the current branch (or error out if there isn't
one).  Merge this change in the next 1.7.x series.

One release before 1.8.0, issue a warning when "git merge" is run without
the commit to merge and this configuration variable is not explicitly set
either way, and notify the user of upcoming incompatibility.

In 1.8.0, flip the default for merge.defaultUpstream to true.
