From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Thu, 17 Apr 2014 12:40:11 -0700
Message-ID: <xmqqy4z3d9t0.fsf@gitster.dls.corp.google.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 21:40:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasAX-0008WS-R8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbaDQTkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 15:40:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbaDQTkP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 15:40:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 999A87BF54;
	Thu, 17 Apr 2014 15:40:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QLNFomMtrqSY
	D4ChYJ+ZpYMMvrk=; b=vf3629DJzlYDYE5DolXsLKhrC7yiYC7ev2jRQ6G7uzkU
	/rIvbEtPGHvP/8fJGkC1193VClkEgdhCZ++jWOKV0Ew2H0yEi4lPsAS7pzAYXK6z
	VE9YtNJj28HgFajlCLk18wD9Olqh+gcf6sMtp+iZ9VJlvkOJddTYXaQG/574QI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HU3KKn
	UggwdMJPnn8yF7J+7b4md3A2qZzU7xbYNYfOGGRZJKrX4LdYtXdM2awZ11tYw2pE
	tei5LkRP+MJjuzkUHtxjTbCajCixhA5lLNHb19xWOoV7h6TRHfjxx56KZvAB2hSn
	ELOm28SJJIM6BNxVyfNtyMkdlPc68fOJ7ZOM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B177BF53;
	Thu, 17 Apr 2014 15:40:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D358B7BF4E;
	Thu, 17 Apr 2014 15:40:12 -0400 (EDT)
In-Reply-To: <1397713918-22829-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 17
 Apr 2014 12:51:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 17C4F218-C668-11E3-A5E6-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246436>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>            first run  second (cached) run
> gentoo-x86    500 ms             71.6  ms
> wine          140 ms              9.72 ms
> webkit        125 ms              6.88 ms
> linux-2.6     106 ms             16.2  ms
>
> Basically untracked time is cut to one tenth in the best case
> scenario. The final numbers would be a bit higher because I haven't
> stored or read the cache from index yet. Real commit message follows.=
=2E

As you allude to later with "if you recompile a single file, the
whole hierarchy in that directory is lost", two back-to-back runs of
"git status" is not very interesting.

>  - The list of files and directories of the direction in question
>  - The $GIT_DIR/index
>  - The content of $GIT_DIR/info/exclude
>  - The content of core.excludesfile
>  - The content (or the lack) of .gitignore of all parent directories
>    from $GIT_WORK_TREE
>
> If we can cheaply validate all those inputs for a certain directory,
> we are sure that the current code will always produce the same
> results, so we can cache and reuse those results.
>
> This is not a silver bullet approach. When you compile a C file, for
> example, the old .o file is removed and a new one with the same name
> created, effectively invalidating the containing directory's
> cache. But at least with a large enough work tree, there could be man=
y
> directories you never touch. The cache could help there.
>
> The first input can be checked using directory mtime. In many
> filesystems, directory mtime is updated when direct files/dirs are
> added or removed (*).

An important thing is that creation of new cruft or deletion of
existing cruft can be detected without any false negative with the
mechanism, and mtime on directory would be a good way to check it.

> The second one can be hooked from read-cache.c. Whenever a file (or a
> submodule) is added or removed from a directory, we invalidate that
> directory. This will be done in a later patch.

I would imagine that it would be done at the same places as we
invalidate cache-trees, with the same "invalidation percolates up"
logic.

> On subsequent runs, read_directory_recursive() reads stat info of the
> directory in question and verifies if files/dirs have been added or
> removed.

Hmph.  If you have a two-level hierarchy D1/D2 and you change the
list of crufts in D2 but not in D1, the mtime of D1/D2 changes but
not the mtime of D1, as you observed below.

> With the help of prep_exclude() to verify .gitignore chain,
> it may decide "all is well" and enable the fast path in
> treat_path(). read_directory_recursive() is still called for
> subdirectories even in fast path, because a directory mtime does not
> cover all subdirs recursively.

I wonder if you can avoid recursing into D1 when no cached mtime
(and .gitignore) information has changed in any subdirectory of it
(e.g. both D1 and D1/D2 match the cache).
