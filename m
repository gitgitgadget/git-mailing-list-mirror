From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] diff and blame difference
Date: Tue, 26 Jul 2011 12:25:51 -0700
Message-ID: <7vzkk0q1xc.fsf@alter.siamese.dyndns.org>
References: <4E2ECABD.7050601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 21:26:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlnGS-0000Wf-PR
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab1GZTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 15:25:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab1GZTZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 15:25:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF70D475E;
	Tue, 26 Jul 2011 15:25:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1q34EUa6T1+cG4aj31aWpyknR0=; b=VIK7mC
	5Nu2TDuYulEGzIMYdCmxCqNbJc2iVEWXgc06dRuATns+ZPYRmeTxxiNhd1bIDwRj
	wI5ea+VAoMkuaDcFbXvfTNlKb2/uDf/F1ID+abvDwfpBNfGKqTFItpyej366j76Y
	1vU4wgDWRXVQLVnDdIzTrnU6ZydsVZzc7FFPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+Ci9CRWvITMLQoVDZUpbEcXNwIlJ9iP
	nJjFHFI0C9JwbKREFYiogeHXkFtnykgZrMGUsp2s4AB0O8YL87jPueO5rieOt588
	4rIH5bCKrxCHfdZm57S/YoAayyJIos0if6CyaNxbQAYiQnPnfNbmrL8TS58Ln7ez
	zxBDvqiFHyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6187475D;
	Tue, 26 Jul 2011 15:25:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DE78475C; Tue, 26 Jul 2011
 15:25:53 -0400 (EDT)
In-Reply-To: <4E2ECABD.7050601@gmail.com> (Semyon Kirnosenko's message of
 "Tue, 26 Jul 2011 18:10:05 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1412FABE-B7BD-11E0-B93D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177898>

You need to realize that diff is to express changes as deletion and
insertion for humans, while blame is not about expressing changes, but
showing the origin of each line.

An example. Imagine you have a file with ten lines (whose contents you
will call A, B, C, ..., J). Starting from this initial state, if you make
the first three lines to "X B Y", think about what happens.

Most likely, "diff" would give you a single hunk that says "you deleted A
B C and then inserted X B Y", making the result look as if B was added by
your change.

But that is not the only possible output "diff" could produce.  It would
also be a valid output if it instead showed two hunks. One hunk would
delete A from the first line and add X in its place, and the other hunk
would delete C from the third line and add Y in its place.  But "git diff"
would not do that, in order to make it more readable for humans, these
adjacent changes that _could_ be in separate hunks are coalesced into a
single hunk.

But "blame" is not constrained by the requirement to show a readable
"patch" to humans. It is allowed to, and it does, see this change through,
notice and show that B stayed from the older version. Only lines X and Y
are new.

Instead of "git --git-dir=D:\src\git\.git diff-tree -p", run it with zero
lines of context and you will see lines 184 and 215 indeed stayed from the
previous version, which exactly explains why you thought 184 was added by
looking at the output of "diff". You can tell that in fact the previous
version already had that contents there by looking at "show -U0" output.

And that is what "blame" told you.

Another example that you may not have noticed with just "blame", but would
have noticed if you gave it -M or -C option is this.

Starting from the same ten lines, If you move the first three lines and
tuck them at the end after J, diff needs to say "remove the first three
lines" and then "add these three lines at the end". There is no way for
diff to say "these three lines were moved". If you look at "diff" output,
you would think "the last three lines A B C were added", while "blame" can
see it through and can say "A B C stayed from the beginning".
