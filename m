From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug - diff in commit message.
Date: Fri, 09 Sep 2011 09:00:08 -0700
Message-ID: <7vpqj9vh87.fsf@alter.siamese.dyndns.org>
References: <1315493353942-6772145.post@n2.nabble.com>
 <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: anikey <arty.anikey@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:00:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23V7-0003zU-QU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759328Ab1IIQAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:00:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab1IIQAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:00:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 933094558;
	Fri,  9 Sep 2011 12:00:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=etfcrKxLh/aHHL6UB7WjqqGPl4c=; b=lhoOcp
	ibFBIPNdIKn9t4fC9AB0U0VI2kVhbtanUCE7H1k4mW9d9wJ7T05tTNRgA/+F/If/
	fZL6c56IHMzbXFBBSmyZhWdH6mo9KUoDoJMQ5HK7sZ2woQbXlXCyKvqIaoBb8Q0U
	zbwns6DqwHaD5V5K/B6cYDHqhiwJDF4Fi/lMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRzUkH5qobWb+VCAPIzWCRpwxQDq1/EH
	ercc0/ZOjn2mqlJX2Wngd3tkYq9MPFzWXIDAS1Vp/RAI04Pg7sSe3tRwJj4TsxB1
	8oN15ZmqVpb4HBJPZzUbS4KHrgYZ9nn2rtfdyUUkV/1Cni7IjZ0jWBZVV54nLXXW
	yfuXWeeK/BU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A8F14557;
	Fri,  9 Sep 2011 12:00:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F70F4554; Fri,  9 Sep 2011
 12:00:10 -0400 (EDT)
In-Reply-To: <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com> (Michael
 Witten's message of "Thu, 8 Sep 2011 16:26:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC07177E-DAFC-11E0-9D05-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181085>

Michael Witten <mfwitten@gmail.com> writes:

> It would appear that `git rebase' is in fact producing patches with
> `git format-patch' and then applying the resulting patches with `git
> am', which gets confused by your inline diff; this can be clearly seen
> in the `git-rebase--am[.sh]' file.
>
> Perhaps `git rebase' should be reimplemented to use `git cherry-pick',
> or does that suffer from the same problem?

I think it just is a simple matter of this one-liner.  We were already
bending backwards to preserve the original message by not parsing and
running stripspace the message in the output from mailinfo, and instead
using the log message from the original, but were still using the patch
text that came from mailinfo that was split incorrectly because it was
fooled by the diff in the commit log message.

In the longer term, I think "git-rebase--am.sh" should be rewritten to
have format-patch avoid the cost of actually generating the patch text,
and the "mailinfo" call that comes above the context shown in this patch
should be made conditional---when using "am" for rebasing we do not really
care anything but the commit object names, and everything else is figured
out from the commit this codepath.

 git-am.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 016b505..9a4cb2d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -632,6 +632,7 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 			echo "$commit" > "$dotest/original-commit"
 			get_author_ident_from_commit "$commit" > "$dotest/author-script"
+			git diff-tree --root --binary -m --first-parent "$commit" >"$dotest/patch"
 		else
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
