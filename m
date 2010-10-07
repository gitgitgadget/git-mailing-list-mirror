From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] worktree: provide better prefix to go back to
 original cwd
Date: Wed, 06 Oct 2010 22:54:50 -0700
Message-ID: <7veic2y2c5.fsf@alter.siamese.dyndns.org>
References: <y> <4cad50da.0e958e0a.40e3.5efd@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, judge.packham@gmail.co, Jens.Lehmann@web.de,
	jrnieder@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 07 07:55:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jRw-0000A7-70
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 07:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab0JGFzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 01:55:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab0JGFzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 01:55:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10AAEDCF60;
	Thu,  7 Oct 2010 01:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=taf+bBQUcTlp
	gPbe9VmQD6FNifo=; b=E2BPIUBojbr56+PO6yeJc2QxWWUSkNv0Wk6hXR9REZYz
	evtGGJYBEopjEd7f3JyiGZMwg53bHzXoGjaO0F/g0Zs/HS3M6zWyRS7hKgmdaogN
	r0zq0q5mUFDdCgYp2idKNoeYEt0yNMAfVXjZm3/svZ6WBWngK9rbHOYd1CyivC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C5pqX+
	XK/mkroDQ6AM87ZGzvuD/5UyrctGWZI00jwLuMOQNjdn5ZclDjEGd6bZfZ/0x0vP
	JCStfFEiL+jFF1UFf0usT4omimktbB/66JqaAYys/xTwP3ssL0GVhIuVMCRj2r+/
	2JgPfVHjLG0f/csOb9lRMnyCeWZ1NwZhnmgXE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B19E0DCF5E;
	Thu,  7 Oct 2010 01:54:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8681EDCF5D; Thu,  7 Oct
 2010 01:54:52 -0400 (EDT)
In-Reply-To: <4cad50da.0e958e0a.40e3.5efd@mx.google.com> (pclouds@gmail.com's
 message of "Thu\,  7 Oct 2010 11\:46\:53 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AF4B9C0-D1D7-11DF-B537-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158373>

pclouds@gmail.com writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside
> worktree, prefix (the one passed to every builtin commands) will be
> set to NULL, which means "user stays at worktree topdir", but cwd is
> not moved to worktree topdir.

Well, NULL traditionally meant "_if_ the cwd is inside the working tree=
,
it is at the top", not "stays at worktree topdir" if you started from
elsewhere.

And when cwd is inside the working tree, we do want to feed paths given
from the command line after adding the prefix, so that we will see the
paths relative to the cwd after we do cd-to-topdir.

Obviously when you run git command that requires you to be in a working
tree from outside the working tree, relative or full paths would not ma=
ke
any difference.  The command should simply fail.

I suspect that you are introducing a new semantics on top of that
traditional semantics; if so, you may want to state it more clearly.

=46or example:

    When you run git command that requires you to be in a working tree
    from outside the working tree, the command should simply fail.

    When GIT_WORK_TREE is in use, however, it could be argued that we d=
o
    not necessarily have to be in anywhere in the working tree to perfo=
rm
    a whole-tree operation.  Instead, we could just say the operation
    always runs as if the command was started at the root level of the
    working tree.

    To support this new mode of operation, however, prefix needs to be
    adjusted to allow the program, after running chdir(2) to the root o=
f
    the working tree, to refer to non-absolute paths originally given f=
rom
    the command line as relative to the original cwd.  This patch adds =
a
    mechanism to support that.

I have a queasy feeling about the idea of the second paragraph above,
though.

If the original cwd is inside GIT_WORK_TREE, limiting ourselves inside
prefix naturally limits the operation to the subdirectory we started fr=
om
(if the original cwd is at GIT_WORK_TREE, that would make it a whole-tr=
ee
operation).  A natural extension of this idea to limit the operation to
the part of the subtree of the working tree we started from is to refus=
e
to work in the case where the original cwd is outside GIT_WORK_TREE (th=
e
current implementation of GIT_WORK_TREE may or may not correctly implem=
ent
it, though---I never use it myself).

=46utzing with the prefix that is not a prefix to reach into the workin=
g
tree from sideways may make the relative paths given from the command l=
ine
mean something to the current implementation, but it doesn't change the
fundamental fact that you are introducing a funny special case where yo=
ur
cwd does _not_ mean anything with respect to which part of the working
tree should be affected.

> Some commands may want "path in repository" and "path in file system"
> to be identical. Moreover, output from commands in such situations ar=
e
> relative to worktree topdir (because prefix is NULL), not what users
> expect. It's just confusing.

My gut feeling is that this is probably made more confusing, not less,
with the change.  Perhaps we should instead make sure this fails?

    $ cd /srv/git/git.git
    $ export GIT_DIR=3D$(pwd)/.git GIT_WORK_TREE=3D$(pwd)
    $ cd /var/tmp ;# no git stuff there
    $ git status
