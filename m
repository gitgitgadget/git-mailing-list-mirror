From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodule design
Date: Tue, 02 Oct 2012 10:49:36 -0700
Message-ID: <7vr4pg932n.fsf@alter.siamese.dyndns.org>
References: <CALkWK0kYh3tKXRqRO9SFMHkrytmhXFkR3yHwmiTpw6KocuLzZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:50:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ6bR-0002zc-LH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab2JBRtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:49:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298Ab2JBRtj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:49:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B69D2896E;
	Tue,  2 Oct 2012 13:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+n5BGz3pWSfiBhE4OebHmh61md8=; b=aXiTHo
	XxRw9mm4Jqd4uHuLkLn8KBs7Ur2dSj4cthUqxqoQ/+MqEAh7SVkCyoFOuNTyGcZh
	DVtyT8VAgTkPl0zbj2owEMQhY0PuuYBjrAUblT9xZDa0OcAon0zu4RyOMQFbF3GX
	iXW2g+JgSl2NP2nvgUJDv3qRt9TRRE3iFu1yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9+KqwynFY6B2PKf6lP3bSiHQzuR/DG6
	5bwP3yH0hhjm0Gw2GSEcou+UvO5NvY1nk5FfF2TdVgooY0T9qLkuITrRiZw2hWtf
	4O5jBs7Nr6LNKNMhTmIXQ8mddiFBYyx6k9b0yi5K6MNyPl8AHaacVVPydj1O1vv+
	mkbNh56r5IA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A31BE896D;
	Tue,  2 Oct 2012 13:49:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08FD98969; Tue,  2 Oct 2012
 13:49:37 -0400 (EDT)
In-Reply-To: <CALkWK0kYh3tKXRqRO9SFMHkrytmhXFkR3yHwmiTpw6KocuLzZw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 2 Oct 2012 20:53:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88EFF04C-0CB9-11E2-A3A1-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206828>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi,
>
> Today I learnt that a gitlink is a commit object embedded in a tree.
> However, I can't seem to be able to cat it.
>
>     $ git ls-tree HEAD
>     100644 blob 5a91f388f3648b98ae34a19ec42ba9acc7852ef4    .gitmodules
>     160000 commit 8daa12004db8862b22f6c7dd244a88ac6108b194  dotfiles
>     $ git cat-file 8daa12004db8862b22f6c7dd244a88ac6108b194
>     fatal: git cat-file 8daa12004db8862b22f6c7dd244a88ac6108b194: bad file

Is this handcrafted typescript?  You do not have "-t" nor "commit"
after cat-file, so you should have got the usage message.

In any case, not having the commit object available in the
superproject is essential and fundamental.

Binding a separate project as a submodule at a specific path in the
superproject, instead of adding the tree structure as a subdirectory
as part of the superproject, is what allows you (note this is not
"requires") to work with the superproject _without_ having to
populate the submodule.  Imagine a submodule for the source of a
library the superproject uses and the superproject is arranged in
such a way that you can build the whole thing from the source, or
you can use the installed library and link to it.  When doing the
latter, you do not have to "submodule init" that part.

The only thing the superproject needs to record is what specific
state of the submodule is meant to appear, if it is instantiated, in
the path.  We (primarily Linus, actually) chose to do so by
recording the name of the commit object from the submodule after
considering other possibilities (check the list archive).

And having to include that commit object in the superproject defeats
the whole point of binding a _separate_ and _independent_ project as
a submodule.  You could deliberately arrange the submodule so that
it shares the object store with the superproject, but that is not
the common or default mode of operation.  Not finding an object from
the submodule's history in the superproject is perfectly normal.

> What is going on?  Shouldn't we get rid of these ugly inconsistencies?

I do not see anything ugly or inconsistent, except that the way you
phrased your message may be unnecessarily an ugly way to show
frustration coming either from a lack of understanding or from a
simple misunderstanding.
