From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Fri, 25 Jul 2008 23:46:02 -0700
Message-ID: <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 26 08:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMdYg-0001qx-74
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 08:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYGZGqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 02:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYGZGqO
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 02:46:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYGZGqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 02:46:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 12EE73C67A;
	Sat, 26 Jul 2008 02:46:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DFA4E3C677; Sat, 26 Jul 2008 02:46:05 -0400 (EDT)
In-Reply-To: <20080721002508.26773.92277.stgit@localhost> (Petr Baudis's
 message of "Mon, 21 Jul 2008 02:25:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8752E9B0-5ADE-11DD-9B6E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90186>

Petr Baudis <pasky@suse.cz> writes:

> The rewrite of git-mv from a shell script to a builtin was perhaps
> a little too straightforward: the git add and git rm queues were
> emulated directly, which resulted in a rather complicated code and
> caused an inconsistent behaviour when moving dirty index entries;
> git mv would update the entry based on working tree state,
> except in case of overwrites, where the new entry would still have
> sha1 of the old file.
>
> This patch introduces rename_index_entry_at() into the index toolkit,
> which will rename an entry while removing any entries the new entry
> might render duplicate. This is then used in git mv instead
> of all the file queues, resulting in a major simplification
> of the code and an inevitable change in git mv -n output format.
> ...

Thanks.  I think I've managed to fix the rename_index_entry_at() in a
satisfactory way, and also made builtin-mv to allow "mv -f symlink file"
and "mv -f file symlink".

I do not agree with the semantics of this test seems to want, though.

> +test_expect_failure 'git mv should follow symlink to a directory' '
> +
> +	rm -fr .git &&
> +	git init &&
> +	echo 1 >moved &&
> +	mkdir -p dir &&
> +	touch dir/.keep &&
> +	ln -s dir symlink &&
> +	git add moved dir/.keep symlink &&
> +	git mv moved symlink &&
> +	[ ! -e moved ] &&
> +	[ -f symlink/moved ] &&
> +	[ $(cat symlink/moved) = 1 ] &&
> +	[ "$(ls dir)" = "$(ls symlink)" ] &&
> +	git diff-files --quiet
> +
> +'

A symlink to us is just a different kind of blob, and by definition a blob
is the leaf level of a tree structure that represents the working tree in
the index. There won't be anything hanging below it, and when adding
things to the index we should not dereference the symlink to see where it
leads to.

Traditionally we have been loose about this check, and the normal "git
add" and "git update-index" codepath is still forever broken, and we
allow:

	$ mkdir dir
        $ >dir/file
        $ ln -s dir symlink
        $ git add symlink/file

but some codepaths that matter more (because they do larger damage
unattended, as opposed to the above command sequence that can be avoided
by user education a bit more easily), such as "git apply" and "git
read-tree", have been corrected using has_symlink_leading_path() since mid
2007.  We would need to follow through c40641b (Optimize symlink/directory
detection, 2008-05-09) and further fix "git add" and "git update-index"
codepaths to forbid the above command sequence.

So my take on the above test piece is that after:

	>moved
	mkdir dir
        >dir/file
        ln -s dir symlink
	git add moved dir symlink

This should fail, as it is an overwrite:

	git mv moved symlink

and with "-f", the command should simply remove symlink and replace it
with a regular file whose contents come from the original "moved".

IOW, what a symlink points at should not matter.
