From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ignore trailing slash when creating leading directories
Date: Tue, 02 Sep 2008 14:10:15 -0700
Message-ID: <7v1w02jlu0.fsf@gitster.siamese.dyndns.org>
References: <20080902081909.GA2059@localhost>
 <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
 <20080902191322.GA11172@localhost>
 <7vod36jne1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kad9s-0000xN-1U
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYIBVKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbYIBVKW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:10:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYIBVKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:10:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 609255A51D;
	Tue,  2 Sep 2008 17:10:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9A5F85A51A; Tue,  2 Sep 2008 17:10:17 -0400 (EDT)
In-Reply-To: <7vod36jne1.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Sep 2008 13:36:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8CD1AFD4-7933-11DD-8F6A-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94715>

Junio C Hamano <gitster@pobox.com> writes:

> I am not saying the current semantics of c-l-d is optimal.  I am just
> worried about breaking people's private patches that may depend on the
> current behaviour.  It would be nice if we can clean it up without
> breaking people, and after doing so, if somebody really want to have
> "create all directories, the last one is also a directory", they can
> invent a cleaner function that takes that insn as a separate paremeter,
> not as an obscure "trailing slash means create all", which may be cute but
> not clean nor clear at all, which is what c-l-d does.

And just so that you do not misunderstand that I am opposed to the change
to c-l-d, here is a replacement to your original patch.  I didn't fix the
caller, as I didn't want to do an overlapping fix with you.

-- >8 --
safe_create_leadign_directories(): make it about "leading" directories

We used to allow callers to pass "foo/bar/" to make sure both "foo" and
"foo/bar" exist and have good permissions, but this interface is too error
prone.  If a caller mistakenly passes a path with trailing slashes
(because it forgets to verify the user input, perhaps) even when it wants
to later mkdir "bar" itself, it will find that it cannot mkdir "bar".  If
such a caller does not bother to check the error for EEXIST, it may even
errorneously die().

Because we have no existing callers to use that obscure feature, this
patch removes it to avoid confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git i/sha1_file.c w/sha1_file.c
index 9ee1ed1..bc6176e 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -99,7 +99,11 @@ int safe_create_leading_directories(char *path)
 		pos = strchr(pos, '/');
 		if (!pos)
 			break;
-		*pos = 0;
+		while (*++pos == '/')
+			;
+		if (!*pos)
+			break;
+		*--pos = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode)) {
