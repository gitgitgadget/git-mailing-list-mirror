From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 11:48:29 -0700
Message-ID: <7vehejsfpe.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <7vr4ijsish.fsf@alter.siamese.dyndns.org>
 <CALkWK0=Py3_LiL=88GOiQkHsYWERnNPvvU1M5wDhu+WioN56Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:48:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdaw-0005Zb-6F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071Ab3DISsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:48:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab3DISsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:48:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 394AF15026;
	Tue,  9 Apr 2013 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8NVMEC6C74hwpPUvRVlWdFxsoNs=; b=v9PkVU
	6Tbp59AJ8iRHuKrgwHEymfd84YFfKSZ/rRpDSuuzMSrEQ98TkFrVAvZ4RYT9iHRN
	B78Zt4dR39Qr3ieV7ZcBNNa49dxLo78XHGHqMwUQToGrrn819suJf9/GCz8zRjAj
	Q+zceKfdgS5U6SZ/jvEPWoaxCZIjD2zCcA0/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KhkdudDY8JXA8XrHh6R5qrAvJbrVfYxL
	Dfs0gIW5buUCuIMtbX6TLePzipgT+2p/cWWrGfQXnJNvo9IWp+9V1yMiYV8Jy3Bu
	yEUkK+XyYaqRXwfn4nQccGFKywnz+6zVUBQsG8iGnsTOlUGMBf5ebpOSWl8PCMk+
	6gUj5d5DnkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B5DD15025;
	Tue,  9 Apr 2013 18:48:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FA1915022; Tue,  9 Apr
 2013 18:48:31 +0000 (UTC)
In-Reply-To: <CALkWK0=Py3_LiL=88GOiQkHsYWERnNPvvU1M5wDhu+WioN56Uw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 23:26:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13046CEC-A146-11E2-B989-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220612>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I think what the callers of this function care about is if the name
>> is a path that should not be added to our index (i.e. points
>> "outside the repository").  If you had a symlink d that points at e
>> when our project does have a subdirectory e with file f,
>>
>>         check_leading_path("d/f")
>>
>> wants to say "bad", even though the real file pointed at, i.e. "e/f"
>> is inside our working tree, so "outside our working tree" is not
>> quite correct in the strict sense (this applies equally to
>> has_symlink_leading_path), but
>
> Actually, you introduced one naming regression:
> has_symlink_leading_path() is a good name for what the function does,
> as opposed to die_if_path_outside_our_tree(), which is misleading.
> What about die_if_path_contains_links() to encapsulate gitlinks and
> symlinks?

The cases we know that "$d/f" (where $d is a path that is one or
more levels, e.g. "dir", "d/i", or "d/i/r") is bad are when

 - "$d" is a symlink, because what you could add to the index is "$d"
   and nothing underneath it; or

 - "$d" is a directory that is the top level of the working tree
   that is controled by "$d/.git", because what you could add to the
   index is "$d" and nothing underneath it.

If "$d" were added to our index, the former will make 120000 entry
and the latter will make 160000 entry.  But the user may not want to
add $d ever to our project, so in that case, neither will give us a
symlink or a gitlink.

We should find a word that makes it clear that "this path is beyond
something we _could_ add".  I do not think "link" is a good word for
it.  It shares the same mistake that led to the original misnomer,
i.e. "the case we happened to notice was when we have symlink so
let's name it with 'symlink' somewhere in it."

>> I think we should treat the case
>> where "d" (and "d/f") belongs to the working tree of a repository
>> for a separate project, that is embedded in our working tree the
>> same way.
>
> I'm not too sure about this.  It means that I can have symlinks to
> files in various parts of my worktree, but not to directories.

It does not mean that.  It is valid to do

	ln -s myetc /etc
        git add myetc

It is NOT valid to do

	git add myetc/passwd

One can have symlinks to anywhere all one wants.  We track symlinks.

It is the same for the top-level of the working tree of a separate
project, be it a submodule or not.  It is valid to do

	mkdir foo && (cd foo && git init && >file)
        git add foo

It is NOT valid to do

	git add foo/file
