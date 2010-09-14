From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disallow branch names that start with a hyphen
Date: Tue, 14 Sep 2010 13:09:20 -0700
Message-ID: <7vtyls6qa7.fsf@alter.siamese.dyndns.org>
References: <20100822140801.GA6574@localhost>
 <7vsk262vla.fsf@alter.siamese.dyndns.org> <20100823043701.GA11822@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 14 22:09:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovbow-0000qS-Ai
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 22:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab0INUJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 16:09:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0INUJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 16:09:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D13FFD62D1;
	Tue, 14 Sep 2010 16:09:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9WdxdXppF4L16l0SKfXmlluSDU=; b=NCK1Pf
	yiVeIIS4cqy11E4IFeYNdr+8+MIWhSigUJwd1Q4MqvKtYk3TBks5Iq6/cOltQQMg
	e9ewKMQXpFIp8+FLk/vr7pFgBjhA4EeqCnX2zYX5BQ/2BHWj+rRGFEMleWhLKEp5
	rVT1zYIn9WPbvoJJqnv1KsgQSE3J3AOjToMuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=luFbgBlYM4xPUi+oRexSvDMQmbAHUzrJ
	CjNOkdxlPnVosZKAKBnqmWiYo37KSVBx0HNJcYVBiSnjf6ivi2R1tgXYOurcxC2y
	nWk/XwWACHJFMVmoDxeBsO9J/w2Po5ucqPAS9qPTKVzyhQYC4Zn7BIQY9sJHbD5F
	gJi7zUcRKrQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97F90D62CE;
	Tue, 14 Sep 2010 16:09:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B239FD62C9; Tue, 14 Sep
 2010 16:09:22 -0400 (EDT)
In-Reply-To: <20100823043701.GA11822@localhost> (Clemens Buchacher's message
 of "Mon\, 23 Aug 2010 06\:37\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F97FDF42-C03B-11DF-9AB0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156207>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sun, Aug 22, 2010 at 02:20:17PM -0700, Junio C Hamano wrote:
>> 
>> forbid "checkout -b" and "branch" from creating such a branch.
>
> Sounds good to me. I will have limited access to email this week.
> I'll revisit this when I am back.

Heh, it turns out that we have a perfect place to hook this into.

-- >8 --
Subject: disallow branch names that start with a hyphen

The current command line parser overly lax in places and allows a branch
whose name begins with a hyphen e.g. "-foo" to be created, but the
parseopt infrastructure in general do not like to parse anything that
begin with a dash as a short-hand refname.  "git checkout -foo" won't
work, nor "git branch -d -foo" (even though "git branch -d -- -foo" works,
it does so by mistake; we should not be taking anything but pathspecs
after double-dash).

All the codepath that creates a new branch ref, including the destination
of "branch -m src dst", use strbuf_check_branch_ref() to validate if the
given name is suitable as a branch name.  Tighten it to disallow such a
name.

You can still get rid of historical mistake with

  $ git update-ref -d refs/heads/-foo

and third-party Porcelains are free to keep using update-ref to create
refs with path component that begins with "-".

Issue originally raised by Clemens Buchacher.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

diff --git a/strbuf.c b/strbuf.c
index bc3a080..65b4cf4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -399,6 +399,8 @@ int strbuf_branchname(struct strbuf *sb, const char *name)
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
 	strbuf_branchname(sb, name);
+	if (name[0] == '-')
+		return CHECK_REF_FORMAT_ERROR;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_ref_format(sb->buf);
 }
