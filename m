From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/3] fetch: Only call a new ref a "branch" if it's
 under refs/heads/.
Date: Tue, 17 Apr 2012 08:26:58 -0700
Message-ID: <7vbomqpef1.fsf@alter.siamese.dyndns.org>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Tue Apr 17 17:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKAJK-0007Pg-AG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 17:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab2DQP1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 11:27:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab2DQP1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 11:27:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C15B9501C;
	Tue, 17 Apr 2012 11:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1cbV657UREpPgKKOj9yTGwcAmiI=; b=ySblX/
	VxIeSetAXLs2j9nYDAiseE/1TWjFCmc5DFJOuOljYibdegxMjtrZkUt4lnHVNt64
	5Y00tv7ZMJCfVm1RD9aHbzOxclzsWQcNKQNYebKByYfOBkRNMxbOH/FtSihybH+1
	p5MFVP2Fy21LjDX+tYrCyeEi8YHdHdMJ6uRJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kB4gbV99BUVvwnz5q+s9ZIxwagwWgxjq
	mXq2SICMB0YKw/ZQCflW5pR1ggL7FiHbzd2D16ml/p7DL2+e3J5/2pznkV38sE0P
	htH2gOiwN4OgYiHl9+FC+pS7KuCHXcA4VY43in6Yi4SLznwa5UxfWcVBctxpMb8c
	net8D92tWGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7ACD501B;
	Tue, 17 Apr 2012 11:27:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52C64501A; Tue, 17 Apr 2012
 11:27:01 -0400 (EDT)
In-Reply-To: <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
 (marcnarc@xiplink.com's message of "Mon, 16 Apr 2012 18:08:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C759E5F0-88A1-11E1-9F55-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195763>

marcnarc@xiplink.com writes:

> It turns out that ref->peer_ref is always NULL in update_local_ref().  So I
> made its caller pass in the full remote ref as a new parameter.  I also added
> a unit test.
>
> This series is a complete resend of all the patches discussed in these
> threads, including Jens's submodule recursion fix.

Thanks, but I'd prefer to keep unrelated things as separate unless there
is a compelling reason not to.

Also I do not think renaming of the existing parameter in the first patch
is warranted, especially when the new parameter you are adding is more
descriptive (i.e. "remote_ref" in the context of that function makes it
clear enough that it is not just a string but is a pointer to a ref
structure).

So let's do this.

-- >8 --
From: Marc Branchaud <marcnarc@xiplink.com>
Date: Mon, 16 Apr 2012 18:08:49 -0400
Subject: [PATCH 1/2] fetch: Give remote_ref to update_local_ref() as well

This way, the function can look at the remote side to adjust the
informational message it gives.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ec4eae..06d71e4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -240,6 +240,7 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
+			    const struct ref *remote_ref,
 			    struct strbuf *display)
 {
 	struct commit *current = NULL, *updated;
@@ -466,7 +467,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 			strbuf_reset(&note);
 			if (ref) {
-				rc |= update_local_ref(ref, what, &note);
+				rc |= update_local_ref(ref, what, rm, &note);
 				free(ref);
 			} else
 				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-- 
1.7.10.332.g1863c
