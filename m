From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix "diff --raw" on the work tree side
Date: Sun, 02 Mar 2008 09:48:02 -0800
Message-ID: <7vlk51nhkd.fsf@gitster.siamese.dyndns.org>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
 <46dff0320803020241l29277bd4m1a711ff0a863e7f8@mail.gmail.com>
 <7v7igloxtu.fsf@gitster.siamese.dyndns.org>
 <46dff0320803020915u565ce50eraa663f9e5a795b81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVsIq-000281-3u
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbYCBRsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbYCBRsL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:48:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbYCBRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:48:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E1EA23F6;
	Sun,  2 Mar 2008 12:48:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3013923F3; Sun,  2 Mar 2008 12:48:04 -0500 (EST)
In-Reply-To: <46dff0320803020915u565ce50eraa663f9e5a795b81@mail.gmail.com>
 (Ping Yin's message of "Mon, 3 Mar 2008 01:15:55 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75818>

"Ping Yin" <pkufranky@gmail.com> writes:

> On 3/3/08, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I do not think re-introducing the inconsistency like the third one does is
>> a palatable option.
>>
>> Wouldn't grabbing (cd $submodule && git rev-parse HEAD) yourself be more
>> portable across git before and after the bugfix of "git diff --raw"?
>
> OK, i will parse it myself

Just to clarify, I am somewhat torn on [3/3].

We can certainly re-introduce the special casing for submodule across diff
family consistently, but the rationale for doing that would be "The real
object name is very cheaply available in that case so why not show it."

That line of thinking would lead to re-hashing of symbolic link blobs as I
hinted in the message, but then it would also mean we would show
inconsistent output between a symlink that points at foo.c and a regular
file whose content is foo.c (without the trailing LF), the latter of which
would still show 0{40}, and we will eventually end up saying "Let's
re-hash small regular file blobs."

That would lead to inconsistencies between smaller and larger regular file
blobs, and the line between them is drawn at an arbitrary size limit.  The
logical conclusion of this would be to re-hash everything when showing
"diff --raw" (and "diff-anything --raw").

Which may turn out not to be such a bad thing after all, and we might even
end up doing exactly that in future releases, although I highly doubt it.
In any case, such a huge semantics change takes time to get right.
People's scripts in the wild know 0{40} with non 0 mode in the raw format
means it refers to an entity in the work tree (which is a correct thing to
assume), but the convention has been used for the entire lifetime of git
and they can (arguably incorrectly) be assuming that the inverse is also
true (i.e. work tree entity is represented as 0{40} with non 0 mode).

And the point is that "submodule summary" can be useful without waiting
for the conclusion of the above confusion caused by the can of worms [3/3]
opens.  If we decide to always show the real object name for work tree
entities in the future, we might want to update the implementation of
"submodule summary" to _take advantage of it_, but by starting the new
feature not to depend on the current misbehaviour, we can try it out much
earlier.

