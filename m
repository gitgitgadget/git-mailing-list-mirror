From: Junio C Hamano <gitster@pobox.com>
Subject: Re: init --shared=0666 isn't
Date: Tue, 09 Mar 2010 15:51:38 -0800
Message-ID: <7vy6i1uk8l.fsf@alter.siamese.dyndns.org>
References: <loom.20100309T224207-485@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Wed Mar 10 00:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np9DO-0002Zb-HB
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 00:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab0CIXvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 18:51:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab0CIXvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 18:51:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39F9DA08BD;
	Tue,  9 Mar 2010 18:51:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k4iWq2pG67sPMkDkag1rc4ZkKAA=; b=FDrzeH
	dWIxAUJsmmlM6hinxrBBi1EfnsLy0Cti3nZYBdwkdo8kIVliL8WBi3qxLK6VBwJK
	1YVDgoLo7pakj42OxG3teJkKhSh/R8nzfi7J/rzzRf81glRG0+gIQH3Gq2p09S5B
	8t31U0Po9OOizKHnukju4zkHVZhv+TvY5p9Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DTqis6HZOVJyXZ4F+XW1vd7tg6P8tqZY
	A+oKFouFSEHOJjpauZBK8IBmIcbyc92QMUxJVVFWrBdBIPsurlHFuVc5y/4iCUte
	TqmXnJTD+yJDZr1n9bmhT6XAkiS9xMqhb5kCDKZ4ZLMQP5NIZ7FGr170MjsVRvNQ
	IaAznwZkYKY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C516A08B6;
	Tue,  9 Mar 2010 18:51:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E3A0A08B5; Tue,  9 Mar
 2010 18:51:40 -0500 (EST)
In-Reply-To: <loom.20100309T224207-485@post.gmane.org> (Steve Folly's message
 of "Tue\, 9 Mar 2010 22\:31\:56 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B71C53C8-2BD6-11DF-8075-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141857>

Steve Folly <steve@spfweb.co.uk> writes:

> $ git --git-dir=/tmp/shared.git fetch origin
>
> error: cannot open /tmp/shared.git/FETCH_HEAD: Permission denied
>
> FETCH_HEAD is owned by the original user, with 0644 permissions,

The shared repository support was [*1*] designed to help people setting up
a "shared" repository like CVS/SVN, a central place people meet and
exchange their histories by pushing into it and fetching from it.  It was
never designed to be used with a repository with a working tree, hence it
was never designed to be used in repositories you would run "git pull" or
"git merge" in.

However, it is not implausible for a sane workflow that you have to fetch
into a central meeting place.  You might be setting up a shared repository
that also serves as a redistribution center for an external source, and in
such a set-up, you would

 (1) clone/fetch from external "upstream";
 (2) allow people to fetch from it;
 (3) allow people to push into it.

So in that sense, allowing "git fetch" in such a shared central meeting
place is not something we would want to actively forbid.  But I thought we
unlinked existing FETCH_HEAD and then opened to create it anew, so I am a
bit puzzled why it matters who owns it and who can write into it.

    ... goes and looks ...

Ah, truncate_fetch_head() just opens it without unlinking.  Probably a
better fix might be to unlink and create the file, like the attached patch
does, instead of running adjust_shared_perm().

> But, I wonder if there are other files written that will need fixing
> also - ORIG_HEAD, MERGE_HEAD?

These are created by "merge" and "reset", so it shouldn't matter.

By the way, the same applies to files in the working tree.  We never call
adjust_shared_perm() when creating them, and I do not think this is likely
to change.


[Footnote]

*1* Notice the past tense---this is merely a statement of historical fact
to help you understand _why_ the current system behaves that way and the
conclusion does not necessarily have to be "hence it must remain that
way".



diff --git a/builtin-fetch.c b/builtin-fetch.c
index b6c5b34..d73fa19 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -654,8 +654,11 @@ static void check_not_current_branch(struct ref *ref_map)
 static int truncate_fetch_head(void)
 {
 	char *filename = git_path("FETCH_HEAD");
-	FILE *fp = fopen(filename, "w");
+	FILE *fp;
 
+	if (unlink(filename) && errno != ENOENT)
+		return error("cannot unlink %s\n", filename);
+	fp = fopen(filename, "w");
 	if (!fp)
 		return error("cannot open %s: %s\n", filename, strerror(errno));
 	fclose(fp);
