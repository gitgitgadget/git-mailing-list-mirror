From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Fri, 01 Jun 2012 12:22:01 -0700
Message-ID: <7vvcja25ye.fsf@alter.siamese.dyndns.org>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
 <20120601093757.GE32340@sigill.intra.peff.net>
 <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
 <7vipfa3n0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Buchner <bilderbuchi@phononoia.at>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaXQK-0007QJ-9S
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 21:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab2FATWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 15:22:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab2FATWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 15:22:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE87886A6;
	Fri,  1 Jun 2012 15:22:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kRKenhGgppJyjPvr4CBEM8VG8i8=; b=fxcy6v
	EgD25GHIwNEjLH4ckLaR1zgxva78CO1s1Vr3nf72QbH+AZoofk7CPRzKS9tWuRfa
	8B8c9i530QdG+fFY3DBwXoLUEpSdY7pXjVU0La0SsXbJdxiQdWCq5d1Xw0wwTatI
	Hf7iv/k5mVQjKsNCdaUTfAnzql27vG62LpTWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fp/mCL16DmPsqWvY78KSzf4vNJBlKqB9
	5qlG8dV2ZqInzjfsonvK6aeP2vXIjMHxUljtp8iwulKFhuKDp6mw+3djaW2yO2Du
	Tx+1XEUddggqp4CxrvmDhA296wgbzH4PUvRlyoYTAMn/KMKn4HqF50N45Jid8xe+
	6uCVQ6vBXdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E562786A5;
	Fri,  1 Jun 2012 15:22:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4318086A3; Fri,  1 Jun 2012
 15:22:03 -0400 (EDT)
In-Reply-To: <7vipfa3n0v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Jun 2012 11:28:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 115981C4-AC1F-11E1-BC11-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199015>

Junio C Hamano <gitster@pobox.com> writes:

> A naive and unoptimized implementation may look like this patch.
>
> The "path_exclude_check" structure can be enhanced to record the
> leading directory it has last checked to be known to be excluded so
> that path_excluded() can check if the ce->name[] is still inside
> that directory and return true early, but I'll leave it as an
> exercise for interested readers while I look at other topics for the
> upcoming release.

And an obvious and simple optimization would look like this.

We can keep the shallowest of the excluded directory (i.e. where a
traversing caller would have stopped recursing) in check->path, and
keep returning "Yes, it is excluded" as long as the path is inside
that directory.

 builtin/ls-files.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1385852..5beada0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -218,11 +218,25 @@ static void path_exclude_check_clear(struct path_exclude_check *check)
 	strbuf_release(&check->path);
 }
 
+/*
+ * Is the ce->name excluded?  This is for a caller like show_files() that
+ * do not honor directory hierarchy and iterate through paths that are
+ * possibly in an ignored directory.
+ *
+ * A path to a directory known to be excluded is left in check->path to
+ * optimize for repeated checks for files in the same excluded directory.
+ */
 static int path_excluded(struct path_exclude_check *check, struct cache_entry *ce)
 {
 	int i, dtype;
 	struct strbuf *path = &check->path;
 
+	if (path->len &&
+	    path->len <= ce_namelen(ce) &&
+	    !memcmp(ce->name, path->buf, path->len) &&
+	    (!ce->name[path->len] || ce->name[path->len] == '/'))
+		return 1;
+
 	strbuf_setlen(path, 0);
 	for (i = 0; ce->name[i]; i++) {
 		int ch = ce->name[i];
@@ -234,6 +248,10 @@ static int path_excluded(struct path_exclude_check *check, struct cache_entry *c
 		}
 		strbuf_addch(path, ch);
 	}
+
+	/* An entry in the index; cannot be a directory with subentries */
+	strbuf_setlen(path, 0);
+
 	dtype = ce_to_dtype(ce);
 	return excluded(check->dir, ce->name, &dtype);
 }
