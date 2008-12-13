From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 12 Dec 2008 21:51:57 -0800
Message-ID: <7vprjw7hc2.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0812120813m2949e36ar7905d5688b8f6ecb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 06:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBNRW-0001o6-HM
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 06:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYLMFwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 00:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbYLMFwK
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 00:52:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009AbYLMFwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 00:52:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DD3BA1A2F2;
	Sat, 13 Dec 2008 00:52:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4ADA419AE9; Sat,
 13 Dec 2008 00:51:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D452770-C8DA-11DD-BD6F-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102987>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 12/12/08, Junio C Hamano <gitster@pobox.com> wrote:
>>  So "git grep -e frotz Documentation/", whether you only check out
>>  Documentation or the whole tree, should grep only in Documentation area,
>>  and "git grep -e frotz" should grep in the whole tree, even if you happen
>>  to have a sparse checkout.  By definition, a sparse checkout has no
>>  modifications outside the checkout area, so whenever grep wants to look
>>  for strings outside the checkout area it should pretend as if the same
>>  content as what the index records is in the work tree.  This is consistent
>>  with the way how "git diff" in a sparsely checked out work tree should
>>  behave.
>
> Assume someone is using sparse checkout with KDE git repository. They
> sparse-checkout kdeutils module and do "git grep -e foo". I would
> expect that the command only searches in kdeutils only (and is the
> current behavior).

Yes it is the "current in next" behaviour, and no that is not what you
should expect, and that is why I earlier said it is a mistake.  The
ability to choose which part to leave out of the working tree should not
change the fact that git is about managing the history of the whole tree,
not an individual file nor a subset of files.

I do not think it is unreasonable to have a mechanism to let the user
limit the area of the whole tree often used Porcelain commands look at.
We already have pathspec "git grep -e foo kdeutils/" mechanism that lets
you do such limiting.  It is conceivable that some workflows _might_ find
having the default pathspec convenient in end-user initiated operations,
but then it would be convenient whether the end-user uses the sparse
checkout to limit the area to kdeutils/ or has the whole checkout.
Although I think it would be Okay to default the default pathspec match
the checkout area when the sparse checkout feature is in use, I think the
"checkout area" and "area of interest" should be two independent concepts.

I said "_might_" in the above because I do not think it is such a good
idea to have _the_ default pathspec to begin with, though.  It would
probably be more useful to allow people to use shorthands to pathspecs,
and at that point you can use usual shell variables to do that already,
e.g. instead of having to say "git grep -e foo arch/x86 include/asm-i386",
you would say "git grep -e foo $i386", after "i386=arch/x86 include/asm-i386",
or something like that.
