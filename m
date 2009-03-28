From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Move chmod(foo, 0444) into move_temp_to_file()
Date: Fri, 27 Mar 2009 23:14:39 -0700
Message-ID: <7vskky18ds.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <49CB51E2.9010903@viscovery.net> <200903261602.37857.johan@herland.net>
 <200903261616.47185.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Mar 28 07:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnRq7-0004v7-EA
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 07:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZC1GOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 02:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZC1GOt
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 02:14:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbZC1GOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 02:14:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BA6D79259;
	Sat, 28 Mar 2009 02:14:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 722459256; Sat,
 28 Mar 2009 02:14:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBFE41F4-1B5F-11DE-853B-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114936>

Johan Herland <johan@herland.net> writes:

> When writing out a loose object or a pack (index), move_temp_to_file() is
> called to finalize the resulting file. These files (loose files and packs)
> should all have permission mode 0444 (modulo adjust_shared_perm()).
> Therefore, instead of doing chmod(foo, 0444) explicitly from each callsite
> (or even forgetting to chmod() at all), do the chmod() call from within
> move_temp_to_file().
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

I think you would need this on top.

-- >8 --
move_temp_to_file(): do not forget to chmod() in "Coda hack" codepath

Now move_temp_to_file() is responsible for doing everything that is
necessary to turn a tempfile in $GIT_DIR into its final form, it must make
sure "Coda hack" codepath correctly makes the file read-only.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3bd20e7..8869488 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2268,7 +2268,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	 */
 	if (ret && ret != EEXIST) {
 		if (!rename(tmpfile, filename))
-			return 0;
+			goto out;
 		ret = errno;
 	}
 	unlink(tmpfile);
@@ -2279,6 +2279,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
+out:
 	if (chmod(filename, 0444) || adjust_shared_perm(filename))
 		return error("unable to set permission to '%s'", filename);
 	return 0;
