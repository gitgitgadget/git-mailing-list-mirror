From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash doesn't honor --work-tree or GIT_WORK_TREE
Date: Mon, 02 Dec 2013 10:01:33 -0800
Message-ID: <xmqqfvqbrv2a.fsf@gitster.dls.corp.google.com>
References: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com>
	<loom.20131130T221443-682@post.gmane.org>
	<874n6sddu7.fsf@thomasrast.ch>
	<CACsJy8BFqqy8T1zwZd7Ly1-sAKGoxh0YfhFBgX6fBMTt_b5Dbw@mail.gmail.com>
	<87zjokpo47.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 02 19:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnXoa-0006Ht-7b
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 19:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3LBSBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 13:01:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab3LBSBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 13:01:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 959F85201A;
	Mon,  2 Dec 2013 13:01:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4K2hjWMO659JlJ4xqRnwaFROiLA=; b=oYIM4J
	NIrenTbZdkugxJmGX6OGChV59eVwf/0Ji9Z3qx47V6Wr44rWZO38P9bjBJCdylTK
	b8V9Y9pj6xUhvfGFUlMeLu3TtzfrkuKJu3AdE1cwQsJtQpiGUD47kKaq0c0/s44q
	24UPB5RjS8ltBK1CjX8nsrjdAMIyWUlK96tfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EekJkgT519330wphPHnAwN71FxMzt1ca
	bFCFgFlblernUN8aGLV6BCLzmBEuqydfuJ2V5wGLgWVJN+KYJA1Qk4kVPC/N+iCT
	gxv11BlwajfyT4rT4bE25jhhWh0ey66V1qZ6hvFHsZxzl0VRDdEEP1OOJbjwuZSj
	AF4U5WcSG8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8765052018;
	Mon,  2 Dec 2013 13:01:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B114C52014;
	Mon,  2 Dec 2013 13:01:36 -0500 (EST)
In-Reply-To: <87zjokpo47.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	(Thomas Rast's message of "Sun, 01 Dec 2013 16:50:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C94902A2-5B7B-11E3-BC1A-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238640>

Thomas Rast <tr@thomasrast.ch> writes:

> The problem here is that shell scripts that want to do something with a
> worktree tend to call require_work_tree in git-sh-setup:
>
> require_work_tree () {
> 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
> 	die "fatal: $0 cannot be used without a working tree."
> }
>
> However, when an explicit GIT_WORK_TREE is in effect, that seems a bit
> silly.  The _intent_ of that command is "I need a worktree to work
> with".  But what it currently checks is something completely different,
> namely "am I _inside_ the worktree".

Correct.

I have a few issues with the proposed "solution", though.

 - require_work_tree has always meant that "This command has to be
   run inside a working tree".  That automatically implies that you
   cannot be working with a bare repository but it is much stronger
   than that.  You actually have to be inside one.

 - $GIT_WORK_TREE (and core.worktree) never meant "I do not bother
   to chdir there myself".  More specifically, "GIT_WORK_TREE=$there
   git foo" is not "cd $there && git foo".  It only means "Because
   the working tree may not have .git directory embedded in it, even
   though you may be able to know where the .git repository is
   (perhaps because I am telling you with $GIT_DIR), you may not be
   able to tell where the top level of the working tree is---hence I
   am telling you where it is".

 - "I do not bother to chdir there myself" has long been treated as
   a non-issue desire, but recently we added "git -C $there". We
   should not conflate GIT_WORK_TREE, which is a discovery mechanism
   for where the working tree is, with that.

 - Some command "git foo" may want to affect and/or look at only a
   part of the working tree, and the $cwd is one way of specifying
   that, e.g. "cd doc && git grep foo".  "If a command that needs to
   be run from somewhere in a working tree was run outside, error
   out." has been the general design principle for commands that
   interact with files in the working tree.

   It may be OK to propose changing it to "Instead of erroring out,
   pretend as if the command were run from the top-level of the
   working tree", but there is an issue of what to do with the
   command line arguments that are path-like.  For example,
   should this command sequence:

	cd /tmp
	GIT_WORK_TREE=/var/tmp/work git foo -f inputFile

   read from /tmp/inputFile, or /var/tmp/work/inputFile?  There may
   be other "unintuitive interactions with silent chdir"; with "git
   -C $there", we are very clear that chdir is the first thing that
   happens and everything path-like are relative to $there, which is
   similar to what "make" does, but doing the same for core.worktree
   or $GIT_WORK_TREE may be surprising, given that environment is
   "set and forget" (the examples in this message explicitly spell
   it out with one-shot export syntax, but that is only for
   illustration) and not visible during usual use of the commands.

> But it would give require_work_tree somewhat interesting and unintuitive
> side effects.

Exactly. My knee-jerk reaction is that I do not think we would want
to go there, but I haven't thought things through.
