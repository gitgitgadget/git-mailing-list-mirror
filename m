From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Sun, 03 Feb 2013 15:10:50 -0800
Message-ID: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 00:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U28iS-0007oY-Df
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 00:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab3BCXKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 18:10:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab3BCXKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 18:10:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E1BAC054;
	Sun,  3 Feb 2013 18:10:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	JQaIyWmD+VURrI2+VGbMkSuWhY=; b=pMLg/9rTLk1TkMAXV4z039T747r6o/SOF
	wQuwu/3oBDhQ2ccMMt+/OLIdMzMuOwSEKqdSjRG6lexk+apesE3yMK0Dcity8l7P
	C9T5Gye/ZmWZLXX6Ul5MwjwGUUtBWGdn9F8L/FZQBn9wjCr12trYcNo9blTJ2wT7
	pkQPzdQ8X4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qKl
	hQl/hRo8mPCvtAIHo6RUIJHxZ3Q5Mj2LFT5waiBM22GPMXAL0MvWEWL87g+jex3O
	HWnq6vnKY9i4Io+NR+tB90VMl8gohKHdmfpgz9ONYrGYnZCieywrDtfjktY2EHi3
	pmtyBJQahF+OX8hLRlzRgzoqfaHm+4SeF9vWSXfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9445AC053;
	Sun,  3 Feb 2013 18:10:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 081FBC052; Sun,  3 Feb 2013
 18:10:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F45B558E-6E56-11E2-9797-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215341>

I think a natural way to ask reviewing the recent merges while
showing tricky ones would be to say:

	$ git log --first-parent --cc master..pu

But this does not to show what I expect to see, which is an output
of:

	$ git log --first-parent --cc -p master..pu

This is only a minor irritation, but I think it might make sense to
make it notice the --cc in the former and turn -p on automatically.

The same for

	$ git log --cc next~3..next

which may make sense to turn into "git log -p --cc next~3..next".

When deciding if the above makes sense, there are a few things to
know to be true as prerequisites for the discussion:

 * Neither of these

	$ git log --first-parent -p master..pu
	$ git log -p master..pu

   shows any patches, and it is not a bug.  No patches are shown for
   merges unless -m is given, and when -m is given, we give pairwise
   2-way diffs for the number of parents.

 * We recently tweaked this:

	$ git log --first-parent -m -p master..pu

   to omit diffs with second and later parents, as that is what the
   user wishes with --first-parent.

 * The "--cc" option, when comparing two trees (i.e. showing a
   non-merge commit), is designed to show a normal patch.  In other
   words, you can view "--cc" as a modifier when you request a patch
   output format with "-p".  For "git show", "--cc -p" is turned on
   by default, and giving "-m" explicity (i.e. "git show -m") you
   can turn it off and have it do "-m -p" instead.
