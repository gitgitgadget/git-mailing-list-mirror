From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Wed, 25 Nov 2009 02:56:54 -0800
Message-ID: <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven J. Murdoch" <git+Steven.Murdoch@cl.cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDFYc-0007r0-Ta
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584AbZKYK46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758576AbZKYK45
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:56:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758353AbZKYK44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:56:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 025628297B;
	Wed, 25 Nov 2009 05:57:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=la+FIzpZpzXf/VICNYWjTe6Vx+w=; b=It7KNd
	ZdmmTJk7fnVWahHPK8FpYAu52QVcUEkViBhlGeD8VOgMkXP7vSTkLdXLnvajeIYu
	buJTRhMsJ4T9OGjk/Oxd43OC+ekyev2OrNDCBVrEdRE0rSQ8JEgQLJ9AuWmlKXFr
	43RB6oDfcJXjku8Tw3hec4F2iFnvCVJRnhSaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOadXCxVZ1bZtIwIL8Osr0cKyrJk0Y46
	ellApubjG/J3ZqJzvLTpUgBd9SaX21QIOGYo0mbEqKMUX5XdHllNfxZM9j/YucHB
	tOOmaywF40evXMfpACS5UrtnjzU+F/6xSOzXz8TtaxQ6LR4c5q5jnvOcaaWQjBj4
	IL+57pLXfPE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D00338297A;
	Wed, 25 Nov 2009 05:56:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A5382979; Wed, 25 Nov
 2009 05:56:56 -0500 (EST)
In-Reply-To: <20091123194523.GZ15966@cl.cam.ac.uk> (Steven J. Murdoch's
 message of "Mon\, 23 Nov 2009 19\:45\:24 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41721F3A-D9B1-11DE-B403-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133631>

"Steven J. Murdoch" <git+Steven.Murdoch@cl.cam.ac.uk> writes:

> This appears to be because I was both using -p to strip some path
> components, and --directory to add different ones in. Only creating
> new files was affected.

A very nicely done report.

In addition to your test case, I suspect that a patch that only changes
mode would have acted funny with -p<n> option.

-- >8 --
[PATCH] builtin-apply.c: pay attention to -p<n> when determining the name

The patch structure has def_name component that is used to validate the
sanity of a "diff --git" patch by checking pathnames that appear on the
patch header lines for consistency.  The git_header_name() function is
used to compute this out of "diff --git a/... b/..." line, but the code
always stripped one level of prefix (i.e. "a/" and "b/"), without paying
attention to -p<n> option.  Code in find_name() function that parses other
lines in the patch header (e.g. "--- a/..." and "+++ b/..." lines) however
did strip the correct number of leading paths prefixes, and the sanity
check between these computed values failed.

Teach git_header_name() to honor -p<n> option like find_name() function
does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index f667368..36e2f9d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -823,12 +823,13 @@ static int gitdiff_unrecognized(const char *line, struct patch *patch)
 
 static const char *stop_at_slash(const char *line, int llen)
 {
+	int nslash = p_value;
 	int i;
 
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
-		if (ch == '/')
-			return line + i;
+		if (ch == '/' && --nslash <= 0)
+			return &line[i];
 	}
 	return NULL;
 }
