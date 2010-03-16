From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5505-remote.29 not working correctly
Date: Mon, 15 Mar 2010 20:26:15 -0700
Message-ID: <7vwrxdueug.fsf@alter.siamese.dyndns.org>
References: <OGVB8d37MB-s4H3VOECmd2htUvpq3B4NginojN-XskLyvHmnbfGA4Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 16 04:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrNQL-00016g-IN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 04:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937407Ab0CPD0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 23:26:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab0CPD0X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 23:26:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EFDCA17CA;
	Mon, 15 Mar 2010 23:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+Okxkmsc4nEY9AZiCfq8SP760Q=; b=ciCiX5
	3igBwLQ6qMAS/Yr89B0Y0jQYSUVd7rcZ88tzpVdUX0kAZXCAbc2DHYzN4df+ODnv
	kxWehL82RTEekXqMampJliamBhFTScrmRb2RKTUwBO0pcfkLAXGSgJuhPzCFsOF+
	F6LywDzhA5yJz3LH2IFn7p3cX3m+wttOwHiYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8an0OmIAMlp9CuARbNf+f0cb8abHXzi
	yzq+9GO5vllqfxA3J3JY6IWOAXppLAIZY8cRsa7IfXMxaq9lp+WdXoA7sz9TdPF9
	3gJO/uiTKx0n6okPcKOs5APzHe+3FdJA1ZN97QE7iCaWLaKQ3sVAe0L+drRZAcJQ
	apDcsm1EJZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B61EA17C9;
	Mon, 15 Mar 2010 23:26:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89910A17C6; Mon, 15 Mar
 2010 23:26:16 -0400 (EDT)
In-Reply-To: <OGVB8d37MB-s4H3VOECmd2htUvpq3B4NginojN-XskLyvHmnbfGA4Q@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 15 Mar 2010 20\:12\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFE27DA6-30AB-11DF-8191-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142294>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> The test titled 'remote prune to cause a dangling symref' is
> not linked together with &&'s.  When the &&'s are added, it
> does not complete successfully.

Hmm, it looks like f8948e2 (remote prune: warn dangling symrefs,
2009-02-08) is internally inconsistent.  This is a fix directly on top of
that commit.

I haven't tried merging the result to a more recent codebase, though.

-- >8 --
Subject: [PATCH] warn_dangling_symref(): send the warning to standard error stream

Brandon Casey noticed tht t5505 had accidentally broken its && chain,
hiding inconsistency between the code that writes the warning to the
standard output and the test that expects to see the warning on the
standard error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-remote.c  |    2 +-
 refs.c            |    7 ++++---
 refs.h            |    2 +-
 t/t5505-remote.sh |    2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ac69d37..e67221d 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -789,7 +789,7 @@ static int prune(int argc, const char **argv)
 
 			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
 			       abbrev_ref(refname, "refs/remotes/"));
-			warn_dangling_symref(dangling_msg, refname);
+			warn_dangling_symref(stderr, dangling_msg, refname);
 		}
 
 		/* NEEDSWORK: free remote */
diff --git a/refs.c b/refs.c
index 6eb5f53..a0e7da7 100644
--- a/refs.c
+++ b/refs.c
@@ -286,6 +286,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 }
 
 struct warn_if_dangling_data {
+	FILE *fp;
 	const char *refname;
 	const char *msg_fmt;
 };
@@ -304,13 +305,13 @@ static int warn_if_dangling_symref(const char *refname, const unsigned char *sha
 	if (!resolves_to || strcmp(resolves_to, d->refname))
 		return 0;
 
-	printf(d->msg_fmt, refname);
+	fprintf(d->fp, d->msg_fmt, refname);
 	return 0;
 }
 
-void warn_dangling_symref(const char *msg_fmt, const char *refname)
+void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 {
-	struct warn_if_dangling_data data = { refname, msg_fmt };
+	struct warn_if_dangling_data data = { fp, refname, msg_fmt };
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
diff --git a/refs.h b/refs.h
index 29bdcec..64a8e62 100644
--- a/refs.h
+++ b/refs.h
@@ -27,7 +27,7 @@ extern int for_each_remote_ref(each_ref_fn, void *);
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
 
-extern void warn_dangling_symref(const char *msg_fmt, const char *refname);
+extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2067dc5..2cad416 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -415,7 +415,7 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	) 2>err &&
 	grep "has become dangling" err &&
 
-	: And the dangling symref will not cause other annoying errors
+	: And the dangling symref will not cause other annoying errors &&
 	(
 		cd seven &&
 		git branch -a
-- 
1.7.0.2.445.g0ae494
