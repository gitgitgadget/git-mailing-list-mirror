From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] index_name_exists() conversion
Date: Thu, 21 Feb 2008 01:07:20 -0800
Message-ID: <7vy79evfsn.fsf@gitster.siamese.dyndns.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 10:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS7PW-0005c3-Hz
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 10:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYBUJHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 04:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbYBUJHd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 04:07:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbYBUJH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 04:07:27 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7DC2A4D;
	Thu, 21 Feb 2008 04:07:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 B184C2A4C; Thu, 21 Feb 2008 04:07:22 -0500 (EST)
In-Reply-To: <7v7igywvnj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Feb 2008 00:39:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74609>

While (hopefully) I have your attention, I have another question
about the recent optimization.

        commit cf558704fb68514a820e3666968967c900e0fd29
        Author: Linus Torvalds <torvalds@linux-foundation.org>

            Create pathname-based hash-table lookup into index

        diff --git a/dir.c b/dir.c
        index 1b9cc7a..6543105 100644
        --- a/dir.c
        +++ b/dir.c
        @@ -346,7 +346,7 @@ static struct dir_entry *dir_entry_new(cons...

         struct dir_entry *dir_add_name(struct dir_struct *dir, const c...
         {
        -	if (cache_name_pos(pathname, len) >= 0)
        +	if (cache_name_exists(pathname, len))
                        return NULL;

                ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);

This used to check if there is a stage#0 entry of that name in
the index.  But the name-hash based index look-up does not care
about the stage as far as I can tell.

I haven't managed to come up with a failure case to demonstrate,
but I think this can affect ls-files and clean, potentially in a
bad way.  "git add dir/" to resolve unmerged paths under dir/
somewhere should not be affected, as the codepath calls
read_directory() before reading the cache (so the check will
always say "Nope, we do not have such a path in the index yet").

I am not sure what the right solution would be.  The motivation
for the patch was to make "does this name exist in the index"
and also "does this exist under an equivalent name" efficient,
but it is asking a question that is not precise enough.  Are we
interested in such an entry at any stage, or only at stage#0, or
what?

This could be related to the recent "status segfaults, bisected
to cf558704" issue posted to the list.  I dunno.
