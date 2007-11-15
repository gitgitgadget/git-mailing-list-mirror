From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Unify the use of standard set of exclude files
Date: Wed, 14 Nov 2007 23:41:02 -0800
Message-ID: <7vk5ok6jn5.fsf@gitster.siamese.dyndns.org>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
	<7v4pfo813i.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: shunichi fuji <palglowr@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 08:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZLu-00007v-OY
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbXKOHlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755125AbXKOHlM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:41:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50270 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070AbXKOHlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:41:11 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CB7052F2;
	Thu, 15 Nov 2007 02:41:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BAD294BA5;
	Thu, 15 Nov 2007 02:41:26 -0500 (EST)
In-Reply-To: <7v4pfo813i.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 14 Nov 2007 22:38:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65078>

By the way, I think the way in which excluded() is called inside
ls-files for --cached, --staged, --deleted and --modified is
totally bogus, and as a result, ls-files does not honor
per-directory exclude files properly.

This is because dir.c:excluded() needs to be called after
setting up the exclude_list stack properly, just like how
dir.c:read_directory() and unpack-trees.c:unpack_trees_rec()
do.  The directory traversal should look like this:

 - Call push_exclude_per_directory() upon entering a directory.
   This reads the per directory exclude file (.gitignore) from
   the directory, and push it into the existing stack.  This
   way, the patterns from the file is set up to override the
   existing patterns from the .gitignore files of higher level
   directories.

 - Ask excluded() if your paths in that directory matches, and
   do whatever you want to happen.

 - Call pop_exclude_per_directory() when leaving the directory,
   to free the patterns read from the .gitignore file there.

Because the codepaths in question just iterate over the cache
entries without telling the per-directory exclude file stack
which set of .gitignore files should apply to the inquiry using
push/pop mechanism, I _think_ excluded(dir, "a/b") calls in the
codepaths do not honor .gitignore nor a/.gitignore file when
checking if "a/b" is to be ignored.

The push/pop mechanism was designed to be used in read_directory()
and it was a good match to the code structure to make recursive
calls to read_directory_recursive().  Because the paths are
sorted in the pathname order, we can make appropriate calls to
push/pop while iterating over the cache in these codepaths to
fix this issue.

As a longer term fix, I think it makes more sense to make
excluded() automatically push/pop the per directory exclude file
stack, just like the gitattributes mechanism maintains the
attribute stack to match and cache the last checked path.
