From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] remote prune: warn dangling symrefs
Date: Wed, 11 Feb 2009 09:30:20 -0800
Message-ID: <7vhc30g9ub.fsf@gitster.siamese.dyndns.org>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <1234170565-6740-4-git-send-email-gitster@pobox.com>
 <1234170565-6740-5-git-send-email-gitster@pobox.com>
 <20090209191526.GC27037@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIwj-0002DI-FJ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758019AbZBKRaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757970AbZBKRa3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:30:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946AbZBKRa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:30:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CCF498990;
	Wed, 11 Feb 2009 12:30:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CA4519898F; Wed,
 11 Feb 2009 12:30:21 -0500 (EST)
In-Reply-To: <20090209191526.GC27037@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 9 Feb 2009 14:15:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AAB1D51C-F861-11DD-918D-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109452>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 09, 2009 at 01:09:23AM -0800, Junio C Hamano wrote:
>
>> If you prune from the remote "frotz" that deleted the ref your tracking
>> branch remotes/frotz/HEAD points at, the symbolic ref will become
>> dangling.  We used to detect this as an error condition and issued a
>> message every time refs are enumerated.
>> 
>> This stops the error message, but moves the warning to "remote prune".
>
> Very nice. As a bonus, this fixes certain (admittedly unlikely) renames,
> too (which don't need to pass the BROKEN flag, since ref_rename uses
> get_loose_refs directly):
>
>   # without this patch
>   $ git symbolic-ref refs/heads/foo/bar refs/heads/nonexistant
>   $ git branch -m master foo
>   error: refs/heads/foo/bar points nowhere!
>   error: there are still refs under 'refs/heads/foo'
>   error: unable to lock refs/heads/foo for update
>   fatal: Branch rename failed
>
>   # with this patch
>   $ git branch -m master foo
>   error: 'refs/heads/foo/bar' exists; cannot create 'refs/heads/foo'
>   fatal: Branch rename failed

As a bonus, this issues unwarranted warning when creating the initial
commit in an empty repository.

The following fixes it.

-- >8 --
Subject: [PATCH] Squelch overzealous "ignoring dangling symref" in an empty repository

057e713 (Warn use of "origin" when remotes/origin/HEAD is dangling,
2009-02-08) tried to warn dangling refs/remotes/origin/HEAD only when
"origin" was used to refer to it.  There was one corner case a symref is
expected to be dangling and this warning is unwarranted: HEAD in an empty
repository.

This squelches the warning for this special case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3bd2ef0..2f75179 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -278,7 +278,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if (flag & REF_ISSYMREF)
+		} else if ((flag & REF_ISSYMREF) &&
+			   (len != 4 || strcmp(str, "HEAD")))
 			warning("ignoring dangling symref %s.", fullref);
 	}
 	free(last_branch);
-- 
1.6.2.rc0.55.g7a105
