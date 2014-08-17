From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: partially staged file is committed in whole, if there is another staged file
Date: Sun, 17 Aug 2014 12:03:26 -0700
Message-ID: <xmqq7g27ym4h.fsf@gitster.dls.corp.google.com>
References: <96FA86FB-D017-470F-899F-EA0F6F28C1E4@beckingham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Beckingham <paul@beckingham.net>
X-From: git-owner@vger.kernel.org Sun Aug 17 21:03:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ5kA-0006lP-Ft
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 21:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbaHQTDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 15:03:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54037 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbaHQTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 15:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A732631DF6;
	Sun, 17 Aug 2014 15:03:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3oVlcBbB3R0PuoAgkaMkemPFhps=; b=MH8k12
	CCPwjBIfFx+RLB5NM/vUgYgNa6568dwEr67Yt1FCtJjGcOivKMoetRqqUpBbCpFG
	zvyxO0ZUzFNKu06lTf9smJDU+DiCNb41VSc2BNNXh49zcHMbPhHYUcSc/+RuRyUJ
	X9HJoX0ZZmYiEyoB9q+iR3npLZ2fyQjcmLDQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HSWhmpIAtOomDuTfWLHBTzGFOgOFmKQ/
	HWKIhWQbkyIa4P0ee5whrMg+i4gK1cEeNQ4zHlWUdoB5ZatuX3cgKZgcnVnkVe9C
	yevHBMMikrGBh+QaQjsQY3On8+85qaHT3+IruSkRwF6hupnwwk3aoURhY4izeeTr
	gPhDAkM+Usw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D15031DF5;
	Sun, 17 Aug 2014 15:03:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 110DF31DE4;
	Sun, 17 Aug 2014 15:03:27 -0400 (EDT)
In-Reply-To: <96FA86FB-D017-470F-899F-EA0F6F28C1E4@beckingham.net> (Paul
	Beckingham's message of "Sun, 17 Aug 2014 13:05:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2BFF2710-2641-11E4-9D4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255371>

Paul Beckingham <paul@beckingham.net> writes:

> $ git status -sb
> ## master
> M  file1
> MM file2
> $ git commit file2 -m "adding patch"
> [master 066a6e2] adding patch
>  1 file changed, 2 insertions(+)
>
> $ git status -sb
> ## master
> M  file1
> $

You would likely to have seen

    $ git diff --name-only HEAD^ HEAD
    file2

This is a very deliberate design decision, and the command is
working as expected.  Here is why.

The filenames (technically, they are not filenames but pathspecs,
i.e. can be patterns to match the filenames) on the command line of
"git commit" are used to first "git add" them internally to form the
tree used for the next commit, and are not used to limit the paths
with changes that are already in the index.

I am not opposed to adding a new mode to use pathspecs to limit the
paths to be committed from the index without consulting the working
tree at all, but unless this is explicitly done as a new mode, you
would end up forcing people to say

    $ edit file3 file4
    $ git add file3
    $ git commit file3

while all existing users have been expecting that after modifying a
file "file3" and commit the changes to that file (and to no other
files), they can say

    $ edit file3 file4
    $ git commit file3

without the extra step of adding it.

We could however add a check to detect the case where your pathspec
matches a path that has changes both in the index and in the working
tree, and error it out.  To those who never use "git add", there is
no change to the path in the index and the check will not trigger.
To those who do "git add file3" the path and then not modify the
working tree before running "git commit file3", there is no change
to the path in the working tree relative to the index and the check
will not trigger.

Such a change may still bite the people who often start working
incrementally with repeated "edit file2 && git add -p file2" and
then when they are satisfied with the full contents of file2 run
"git commit file2" without an extra "git add file2" to add the last
remaining change in the working tree to the index, though, and we
would need to let people override the check with "--force" or
something to work this extra check around if we were to do so; I do
not offhand know if it is worth it.

Thanks.
