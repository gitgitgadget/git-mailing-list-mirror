From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Mon, 23 Mar 2009 16:22:44 -0700
Message-ID: <7vhc1j6czf.fsf@gitster.siamese.dyndns.org>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com>
 <49C7A20E.7060503@drmicha.warpmail.net> <20090323163343.GB16258@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 00:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LltVJ-0002CS-A9
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbZCWXW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 19:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbZCWXWz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:22:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZCWXWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 19:22:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A4DEBA449A;
	Mon, 23 Mar 2009 19:22:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 20388A4498; Mon,
 23 Mar 2009 19:22:45 -0400 (EDT)
In-Reply-To: <20090323163343.GB16258@gmail.com> (David Aguilar's message of
 "Mon, 23 Mar 2009 09:33:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86FDCA26-1801-11DE-B8E1-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114360>

David Aguilar <davvid@gmail.com> writes:

> Keep in mind that the syntax that this patch added does not have file~3
> = HEAD~3.  file~3 means finding file as it existed 3 changes-to-file
> ago, which is != to HEAD~3 if file did not change in the last 3 commits.

If your motive is to introduce inconsistency to the UI by adding this kind
of new notation _only to difftool_, I have to reconsider moving it out of
contrib/ area.

While I do not fundamentally oppose to add convenient notations for useful
concepts, you need to start at making sure if this "three changes ago" is
a well defined concept to begin with.

And it is not a well defined concept in a merge-heavy environment, unless
you define what you mean by "three changes ago".

If you consider this history:

 ---Y---o---X---M---o mainline = HEAD
               /
   ---A---B---C topic

where A, B, C and X, Y are the only commits that touched the file you are
interested in, how do you define 3-changes-ago?

Maybe X was just a totally uninteresting typofix to a comment, while A, B
and C were adding a very interesting new feature.  Don't forget that M
also changes the file from either of its parents (X or C).  Does M count
as the last change?  Or does it not count because it is just a mechanical
unconflicting merge?  Which one of X or C is the penultimate change?  The
one with an earlier committer timestamp?  Tiebreaking with timestamps is
known to be flawed in the presense of clock skew.

For the consistency of the UI, "starting at HEAD, following first-parent
ancestry, find N-th commit that touches the path, ignoring all the side
branches" MUST be the semantics of a notation that uses tilde followed by
number (so file~3 must mean Y in the above picture), because HEAD~3 is
defined as "three parents ago, only following the first parent ancestry".
Anything else will invite user confusion.

But I do not think it is necessarily useful to follow only the first
parent ancestry to find "three-changes ago" (if such a concept exists).
If you want a notation that means something else, such as X (because
chronologically the commits that touched the file are M, C and X in the
ideal world that everybody has well synchronized clock), you shouldn't use
tilde-number notation but use something else.
