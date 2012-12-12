From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Wed, 12 Dec 2012 12:22:23 -0800
Message-ID: <7vy5h32f7k.fsf@alter.siamese.dyndns.org>
References: <1141725649.20938344.1355328914240.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 21:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TispJ-0001WQ-Ug
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 21:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab2LLUW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 15:22:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601Ab2LLUW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 15:22:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3F22A4E3;
	Wed, 12 Dec 2012 15:22:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QsiANQIaPigAptaltJulApE4MOA=; b=NkFFJ8
	Dj9mYCtadLt5EWX7jYBtbPtx6MfqXLRpnQRYGa4ANjjHWzg8jhxT0t8QJ+R/nu5Q
	rMoDrRWvuHZo4CnaTJrbg+odX57IVRvni4FX9MJXjIG8BTBy/Eq3WTsqKbID+qxx
	LBQfxUloWSTYoWJQ7N7WyjSvlw99i+/uPtzcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WJ+dkc22c5oK1LaJ45ROmL9YKvOhB07i
	eqTqa/Gxp6TrjUziPWJJRuyfbimmRFyvslpqsUnEDsDeil5njc/IBAvmwI6I6HnH
	EMMDb5MgcKt8Haadf2FzBjUGypZPfQiyHUXfx4avKhYnWPv4Pe879t8bvDmuoo25
	vamwZwufqlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C10E5A4E2;
	Wed, 12 Dec 2012 15:22:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29A95A4E0; Wed, 12 Dec 2012
 15:22:26 -0500 (EST)
In-Reply-To: <1141725649.20938344.1355328914240.JavaMail.root@dewire.com>
 (Robin Rosenberg's message of "Wed, 12 Dec 2012 17:15:14 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4E66E30-4499-11E2-845D-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211391>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> I want the copy on checkout. The intent is to change things and
> then commit.

That largely depends on what purpose each symlink is used for in the
project.

Suppose you have a symlink A and another symlink X in the project,
where A points at another path B inside the working tree, and X
points at a path outside, say, /etc/motd.  Upon checkout, you make
regular files A and X that store the contents of the files they
point at, and then you edit A and X.

Now, what should happen on the next "git add A X"?

 * Perhaps it (or any step before "git add", or something even
   outside git) should notice that you modified A that is supposed
   to represent a copy of B but their contents have drifted.  It
   should raise a red flag, or take a remedial action, no?

 * Perhaps it should copy the updated contents in A to B and run
   "git add" on that one instead, without changing anything else?

 * Imagine a project with many template files B, C, ..., where A
   points at "the default template".  You may be designating a
   different template file as the new default.  On a symlink-capable
   system you would just do "rm -f A && ln -s C A", but because you
   chose to make a copy of B and store it as a regular file in A, a
   natural way to update it may be to do "cp C A".

   Would you find another file C in the working tree that may be
   different from B that has the same contents as A, and update the
   symbolic link A to point at C instead?  Do so only with the
   contents of A and all the other files in the working tree?  What
   if there is another template file identical to C?

I didn't even touched the cases where you have to deal with your
updates to X.

This is looking more and more outside the scope of Git to me.
