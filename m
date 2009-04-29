From: Junio C Hamano <gitster@pobox.com>
Subject: Re: different git-merge behavior with regard to submodules in
 1.6.2.4 vs. 1.6.2.1
Date: Wed, 29 Apr 2009 11:54:45 -0700
Message-ID: <7vskjrb896.fsf@gitster.siamese.dyndns.org>
References: <gt7err$3m4$1@ger.gmane.org>
 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org>
 <20090429084209.GA24064@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEwv-0003Rz-L7
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbZD2SzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbZD2SzJ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:55:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983AbZD2Syz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:54:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C3CCAEF3C;
	Wed, 29 Apr 2009 14:54:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9E05DAEF3B; Wed,
 29 Apr 2009 14:54:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AA6C884-34EF-11DE-A1F3-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117918>

Clemens Buchacher <drizzd@aon.at> writes:

> The fatal error is indeed caused by 0eb6574 (update cache for conflicting
> submodule entries). The problem is also documented by t7405. The test
> exposes a problem even previous to this commit, wherein "git diff" aborts
> with
>
> 	fatal: read error 'sub'
>
> which is why I thought this was broken anyways. Only I see now that I have
> made things worse.

Your "git diff" calls into the combine-diff logic, and it was not updated
when the "gitlink" was added.  With your change you are merely hiding the
issue under the rug.  I've sent a fix as a separate patch.

How about doing this to fix the merge-recursive part?  Looks a lot simpler;
I haven't tested it very much, though.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 29 Apr 2009 11:08:18 -0700
Subject: [PATCH] merge-recursive: do not die on a conflicting submodule

We cannot represent the 3-way conflicted state in the work tree
for these entries, but it is normal not to have commit objects
for them in our repository.  Just update the index and the life
will be good.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d6f0582..a3721ef 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -520,8 +520,12 @@ static void update_file_flags(struct merge_options *o,
 		unsigned long size;
 
 		if (S_ISGITLINK(mode))
-			die("cannot read object %s '%s': It is a submodule!",
-			    sha1_to_hex(sha), path);
+			/*
+			 * We may later decide to recursively descend into
+			 * the submodule directory and update its index
+			 * and/or work tree, but we do not do that now.
+			 */
+			goto update_index;
 
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
-- 
1.6.3.rc3.16.gb37759
