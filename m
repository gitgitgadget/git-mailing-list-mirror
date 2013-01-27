From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Behavior of stash apply vs merge
Date: Sun, 27 Jan 2013 09:57:28 -0800
Message-ID: <7vvcaiwltj.fsf@alter.siamese.dyndns.org>
References: <1192924141.1697155.1359285809347.JavaMail.root@dewire.com>
 <61173190.1700449.1359286556865.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzWUT-0005fl-Op
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 18:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab3A0R5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 12:57:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab3A0R5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 12:57:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B95C385;
	Sun, 27 Jan 2013 12:57:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wenXPOiecplGdeFcT9uTus/ZArI=; b=M60YWU
	dqVAbnInmNDYBPLqBdeSDKMaiYwkKe/FlmjOyQxoqirE83UXDKtLARIM4BQGgFVh
	2axCTtdKZ3tfylCnrwfc/D5TWgLpPR0ndGOS6jo/yDxL6Rkg4XQanyyS/x1WJUqi
	6TG02IZpvCCMIqRiHnme+Cp3AfY2uE2SevyJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KyF7Y3f2rL9jACupF/hfmKNRbZQ1lCnI
	pS3uZKt6JTveXKLGa62tcKLxjEHI6aUjEDxnRfvdlLsL8+fQMUv4GJGtepcbngxM
	y3bCiKk2kkIpeE9MO3J2yAqVFDueVFkm/zdhZDpeuvso6ZWzb6VxM6+GrO/dWcu0
	fgCt92Ubayo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A97FC384;
	Sun, 27 Jan 2013 12:57:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDCD0C374; Sun, 27 Jan 2013
 12:57:29 -0500 (EST)
In-Reply-To: <61173190.1700449.1359286556865.JavaMail.root@dewire.com> (Robin
 Rosenberg's message of "Sun, 27 Jan 2013 12:35:56 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0472D9F8-68AB-11E2-86E5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214711>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> What good reason is it that 'git stash apply' gives hairy conflict
> markers, while 'git merge stash' does not. No renames involved.

"git merge stash" is nonsensical and would do a vastly different
thing compared to "git stash apply" depending on where you created
the stash and where you are attempting to run that operation.

Imagine you started fixing a bug while on the 'master' branch,
realized that the fix equally well applies to your 'maint' branch.
You would do "git stash" followed by "git checkout maint".

A sane person would do "git stash apply" at this point.  It applies
the difference between the 'master' you were working on and your WIP
on top of your 'maint'.

"git merge stash" is entirely different.  The history leading to a
stash looks like this:

                   I
                  / \
      ---o---o---B---W

where

	B is the commit you were working on (i.e. 'master');
	I records the state of the index;
	W records the state of the working tree.

and "stash" refers to W.

Think what commit B is in this example and the reason why you should
never ever do "git merge stash" will become apparent.  By merging W
into 'maint', you would be pulling the entire history between
'maint' and 'master' to the result.
