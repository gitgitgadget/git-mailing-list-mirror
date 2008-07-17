From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] git mv: Support moving submodules
Date: Wed, 16 Jul 2008 19:37:57 -0700
Message-ID: <7vhcapme0q.fsf@gitster.siamese.dyndns.org>
References: <20080716190753.19772.93357.stgit@localhost>
 <20080716191129.19772.41903.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 04:39:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJJOc-0003qf-M1
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 04:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYGQCiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 22:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYGQCiG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 22:38:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYGQCiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 22:38:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E213C2ECF1;
	Wed, 16 Jul 2008 22:38:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 279112ECF0; Wed, 16 Jul 2008 22:38:00 -0400 (EDT)
In-Reply-To: <20080716191129.19772.41903.stgit@localhost> (Petr Baudis's
 message of "Wed, 16 Jul 2008 21:11:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60C59284-53A9-11DD-BBDC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88799>

Petr Baudis <pasky@suse.cz> writes:

> The usage of struct path_list here is a bit abusive,...

I do not think use of path_list->util is particularly bad.  It is a data
structure to store a bag of random pointers that can be indexed with
string keys, which is exactly what you are doing here.

> ... The horrid
> index_path_src_sha1 hack is unfortunately much worse,

This one certainly is ugly beyond words.

By the way, why is it even necessary to rehash the contents when you run
"mv"?

IOW,

	$ >foo
        $ git add foo
        $ echo 1 >foo
        $ git mv foo bar

makes "foo" disappear from the index and adds "bar", but it makes the
local change added to the index at the same time.

	Side note. It actually is a lot worse than that.  When you move
	something to another existing entry, the code does not even add
	the object name of moved entry recorded in the index, nor rehashes
	the moved file.  This is totally inconsistent!

I personally think these buggy behaviours you are trying to inherit are
making this patch more complex than necessary.  Perhaps this needs to be
fixed up even further (you did some fix with the first patch) before
adding new features?  For example, I think it is a bug that the
"overwrite" codepath does not work with symlinks.

But let's assume that we do not want to "fix" any of these existing
(mis)behaviour, because doing so would change the semantics.

There are a few cases:

 (1) gitlink exists and so is directory but no repository (i.e. the user is
     not interested);

 (2) gitlink exists and there is a repository.  Its HEAD matches what
     gitlink records;

 (3) gitlink exists and there is a repository.  Its HEAD does not match what
     gitlink records;

The (mis)behaviour that automatically adds moved files to the index we saw
earlier suggests that in case (3) you would want to update the gitlink in
the index with whatever HEAD the submodule repository has to be
consistent.

So instead of adding a index_path_src_sha1 hack like that, how about

 * When you see ce_is_gitlink(j), you keep the original gitlink object
   name.  That is very good in order to preserve it for not just (1) but
   also for (3) once we decide to fix this "auto adding" misbehaviour in
   the later round.  But you do not have to do this for case (2) if you
   are going to rehash anyway, don't you?

   So when you see ce_is_gitlink(j), you check if it has repository and
   HEAD, and record the path_list->util only when it is case (1).

 * Then, only for case (1), you do not call add_file_to_cache() -- because
   you know you do not have anything you can rehash; instead, factor out
   the codepath "git-update-index --cacheinfo" uses and call that.
