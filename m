From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 30 Jan 2012 10:48:54 -0800
Message-ID: <7v39axc9gp.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwHm-0007eo-VA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab2A3Ss6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:48:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab2A3Ss5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:48:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648636E20;
	Mon, 30 Jan 2012 13:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AHvIH9o7P3/ZHA4ztNLJy76A/Xs=; b=mcsfvI
	b7d9oLDg1ToDiG5ptE21kV/tA88rdxf++ddkATmou3IplC7mjJjP5npYyXjFSl/s
	HNg/wUs7vegJMI551BS67HcbFiEGMT7Kvnld36lrmH9yx40398afPwd/usFtYMXI
	KT3X9UF0id/FlCjUOwK+LIvODvr6VGhfceGls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GXX9TbzWb9Utm1TsFoPAZYgRjJZNqvkR
	OoD6Pn+wZxc4aA+NJ8YMOykKMDxyvHTb/PhrUyQ951RLhRsJqIG8sfbzeczI8BB7
	SKebhyzAJf4qD3eKk7eF7PoJuUeBgYtVsjnRbJz4wB7RANrGaSTF5EDaug7sPTGk
	4Yy1B7KBin8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A3BE6E1F;
	Mon, 30 Jan 2012 13:48:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8CE86E1E; Mon, 30 Jan 2012
 13:48:55 -0500 (EST)
In-Reply-To: <4F263AEE.4080409@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 30 Jan 2012 07:38:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FD90228-4B73-11E1-8879-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189394>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> [3] If commit 0000000 were treated specially, then there would be no
> unborn branches but only branches pointing at the empty commit.  In that
> case, my expectation would change--the old branch should be left
> pointing at 0000000.  But currently git has no concept of an unborn
> branch that is not HEAD.

And it probably is not a good thing to add such. Under that constraints,
HEAD that says refs/heads/foo where foo does not exist yet needs to be
special cased at places where it matters.

For that matter, even if we artificially created refs/heads/foo before any
commit is made and made it point at 0{40}, you would need to add special
cases to other parts of the system (e.g. "commit" needs to notice that the
result should be a root, not a child of 0{40}; "checkout other_branch"
needs to notice that it should refrain from running the equivalent of
"read-tree -m HEAD other_branch" because HEAD does not point at a real
tree; etc.), so it does not change the fact that the unborn branch is case
is special.

Note that I am not saying that we shouldn't add support for special cases
with special case codepaths.

Perhaps we would need to sprinkle more special case magic like this (this
is for the special case that arises from the same cause)?

 builtin/branch.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7095718..0997e75 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -640,6 +640,13 @@ static int edit_branch_description(const char *branch_name)
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
 
+	strbuf_addf(&name, "refs/heads/%s", branch_name);
+	if (!ref_exists(name.buf)) {
+		strbuf_reset(&name);
+		return error("No such branch '%s'.", branch_name);
+	}
+	strbuf_reset(&name);
+
 	read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
