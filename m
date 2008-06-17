From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Junio C Hamano] Re: Consolidate SHA1 object file close
Date: Mon, 16 Jun 2008 22:01:43 -0700
Message-ID: <7v4p7s8xjc.fsf@gitster.siamese.dyndns.org>
References: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806151057100.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 07:02:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8TLJ-0003hE-G5
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 07:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbYFQFB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 01:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYFQFB6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 01:01:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbYFQFB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 01:01:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 523C3C93A;
	Tue, 17 Jun 2008 01:01:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B51EC935; Tue, 17 Jun 2008 01:01:50 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806151057100.2949@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 15 Jun 2008 11:08:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81B2B710-3C2A-11DD-AA05-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85259>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Actually, thinking about it, the +20 was not just fairly arbitrary and 
> would have been better off with a comment, it was also not a very good 
> number to begin with - it just was the old tempfile pattern rounded up to 
> the next "even" number.
>
> The _correct_ number to use is +39, with a better tempfile pattern.
>
> That needs a few comments, though. So I added those too.
>
> This patch is totally unimportant, but it does mean that a really 
> traditional filesystem can now do the final rename in-place, because the 
> temporary file is not just in the same directory as the final one, but ti 
> also has the same length, so old-style filesystems can literally just edit 
> the name in place and mark the buffer dirty.

That's interesting and somewhat amusing ;-)

> So take this or leave it as you want - it's really not very important, I 
> just wrote this because I was thinking about what really goes on at a very 
> low level when we do that final atomic rename to create the actual 
> directory entry. This makes it theoretically just a tiny bit more atomic 
> on old-fashioned filesystems.

However, this may be more important fix.  We want to make sure that
adjust_shared_perm() is called on the success codepath, especially not
when mkdir() does _not_ fail.

diff --git a/sha1_file.c b/sha1_file.c
index 500584b..e300562 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2125,7 +2125,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	if (fd < 0 && dirlen) {
 		/* Make sure the directory exists */
 		buffer[dirlen-1] = 0;
-		if (mkdir(buffer, 0777) && adjust_shared_perm(buffer))
+		if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
 			return -1;
 
 		/* Try again */
