From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git notes merge' implementation questions
Date: Wed, 21 Apr 2010 14:29:44 -0700
Message-ID: <7viq7ka3zr.fsf@alter.siamese.dyndns.org>
References: <201004210957.48138.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:29:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hUc-0007Lz-Uo
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab0DUV3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:29:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab0DUV3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:29:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1B0AC80F;
	Wed, 21 Apr 2010 17:29:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ht1LgyTF3FzLl0rcDWhJOOXqNc=; b=axLJaC
	UZYUH6cYbh+S83KJYCNO7Av/v1ZtNZKY7B+DJHnlprk3D1qBQv/WExBEBI7d7k40
	Ybf5dkwMBayFJI+p9OxboTqtOLf+osbON7uwjgbAPjwS5aijv9M/A6GRJQeN5bl8
	SNQfYZMh28vaNNsMvvNd1XohgitkMMHZFzbF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRYtrTABIWfbH4+mQNp2jwy7OiiIRS9l
	ktDhE0HKhET4UCo9tiDTaTLgeWKt1wea5iRfiMLh2ISLnQRQwjzVW9ix8RPQ2SgT
	CmLN1FFO+72w1/WlSYSg31hfmn4EPV5FNnFtR5vHXBqGQh5Wq/xfRAO1hLJ6CH4h
	P/DuPj4qgQo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B773DAC80E;
	Wed, 21 Apr 2010 17:29:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F172DAC80D; Wed, 21 Apr
 2010 17:29:45 -0400 (EDT)
In-Reply-To: <201004210957.48138.johan@herland.net> (Johan Herland's message
 of "Wed\, 21 Apr 2010 09\:57\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03671416-4D8D-11DF-B4E2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145460>

Johan Herland <johan@herland.net> writes:

> For merges between notes refs with no common history the merge should be
> a straightforward joining of trees. This also covers the "history-less"
> notes refs, like Peff's notes-cache, and should work whether the notes
> refs point to parentless commits, or point directly to tree objects (if
> we want to support that). For merges between notes refs with common
> history we want to do a (more or less regular) three-way merge.

Note that a "history-less" merge is just a special three-way merge
pretending as if their common ancestor is an empty tree.  There is no
point in special casing the former.

> In both cases (with or without common history), conflicts may ensue,
> and these must of course be resolved in some way. Since the notes refs
> have no accompanying worktree, we must find some other way to resolve
> conflicts.

I would say we may not even have to "resolve" the conflicts in the usual
sense of the word.

You can run "ls-tree" on three trees, removing '/' from the output to
obtain the list of objects that are annotated, and do a three-way merge at
the object level first.  For the ones that do have diverging changes on
both sides, you just run "git notes append" to add the data from the other
side and be done with it ;-).

That way you don't have to worry about how "git merge" merges things, how
it uses the index, nor how it uses the working tree, as you won't be using
anything from "git merge" at all.

That would be the first step.

The second step would be to designate a special directory that would exist
only during a conflicted "notes merge" in $GIT_DIR, just like MERGE_HEAD
serves as the signal we are in a conflicted merge.  When

    $ git notes merge <other>

is run, if (and only if) you need a manual merge resolution, you would
create this directory, which will have:

 - a temporary index that has the result of the tree level merge, but you
   will:

   (1) only register the entries that have conflicted; and 
   (2) flatten the fan-out structure.

 - files that have conflicted merge result, whose names are 40-byte object
   names that are annotated; and

 - something like MERGE_HEAD to keep track of the <other>, so that you can
   create a merge commit when concluding the merge.

You can chdir to the directory and use "git diff" and "git ls-files -u" to
inspect the conflicts, and run "git add <filename>" to mark a resolved
note.

You would need a separate command ("git notes commit" perhaps) to conclude
the merge.  At that point, you would iterate over this temporary index
(which only has conflicted notes), pulling out the list of <object name
being annotated, the annotation>, add these annotates to produce a new
notes tree, record that tree as a merge commit in the notes namespace, and
finally remove the notes merge working directory.
