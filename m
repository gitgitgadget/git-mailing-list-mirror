From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 11 Dec 2008 17:41:03 -0800
Message-ID: <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
 <fcaeb9bf0811300229v4e7bfbb7g9a0ac72dcddb4326@mail.gmail.com>
 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 02:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAx31-0005i5-9o
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 02:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764AbYLLBlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 20:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbYLLBlN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 20:41:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYLLBlN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 20:41:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 891908683D;
	Thu, 11 Dec 2008 20:41:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 285798683A; Thu,
 11 Dec 2008 20:41:04 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0812111520490.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 11 Dec 2008 15:30:45 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F493B1F4-C7ED-11DD-A323-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102857>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> That's the point. CE_VALID does not define checkout area while
>> CE_NO_CHECKOUT does.  If an entry is CE_VALID, it is still in checkout
>> area. But if it is CE_NO_CHECKOUT, "git grep" should ignore that path.
>> core.defaultsparse has nothing to do here.
>
> My point is that the index cannot tell git grep whether it should search a 
> path if the path isn't in the index.

Let's step back a bit.  I think "git grep" that stays silent outside of
the checkout area when used to grep in the work tree or in the index is a
mistake.

The problem "sparse checkout" attempts to address is not this:

    I ran "git init && git add ." in /usr/src by mistake.  There is no
    reason for coreutils that is in /usr/src/coreutils and gnucash that is
    in /usr/src/gnucash to share the same development history nor their
    should be any ordering between commits in these two independent
    projects.  I should have done N separate "init & add" independently at
    one level deeper in the directory hierarchy, but I am too lazy to
    filter branch the resulting mess now.

At least, it should not be that, at least to me.

"Sparse" is "I am not going to modify the files in these areas, and I know
they do not need to be present for my purposes (e.g. build), so I do not
need copies in the work tree."  It still works on the whole tree structure
recorded in the commit, but gives you a way to work inside a sparsely
populated work tree, iow, without checking everything out.

So "git grep -e frotz Documentation/", whether you only check out
Documentation or the whole tree, should grep only in Documentation area,
and "git grep -e frotz" should grep in the whole tree, even if you happen
to have a sparse checkout.  By definition, a sparse checkout has no
modifications outside the checkout area, so whenever grep wants to look
for strings outside the checkout area it should pretend as if the same
content as what the index records is in the work tree.  This is consistent
with the way how "git diff" in a sparsely checked out work tree should
behave.

If you understand that, it is clear what "git grep -e frotz HEAD^" should
do.  No checkout area is involved.
