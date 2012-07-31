From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 11:37:22 -0700
Message-ID: <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwHK1-00013H-EL
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab2GaSh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:37:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52636 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab2GaSh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:37:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B937D2D;
	Tue, 31 Jul 2012 14:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=liGoF5mX+gJh4APSFOf5KjfBVgU=; b=QCntA9
	AuzRkuk/Pdfdee7BhLez9E1kLXU3li9apPYXpvMM7N4hp42gG7KnKMURLvOTts2l
	9jQZk2HJEQ5g/5lqr89w36ZRmltUXJBYEHRd97joDWBXNlVWFYzmobZ9Fl/u/CTL
	NT1c8NOIvH+ZSxVzgexR/SJoYdR6QxlEarTnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BPO89BnKo5xjeE9hjPD3vffMrJ4M0cn4
	w8dLi6c6oo7o4jC7YlFNrAIm5Fwsj8SvKL/9fTCwyn4LM4xMbsk6p/gosjJLaCsH
	vDa9DkW4hAF4K620HDKSf5nGjeQJRn3pVbkTY+Zv3LKhQYn6cNqvLQkJauPEK6ac
	1FRCCKdJaIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 915647D2C;
	Tue, 31 Jul 2012 14:37:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D511E7D2A; Tue, 31 Jul 2012
 14:37:23 -0400 (EDT)
In-Reply-To: <7vk3xjked0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 31 Jul 2012 10:52:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C515B266-DB3E-11E1-8B31-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202668>

In practice, the majority of paths do not have utf8 that needs
the canonicalization. Lazily call iconv_open()/iconv_close() to
avoid unnecessary overhead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ralf Thielow <ralf.thielow@gmail.com>
Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 * This is not even compile tested, so it needs testing and
   benchmarking, as I do not even know how costly the calls to
   open/close are when we do not have to call iconv() itself.

   This reroll corrects an obvious thinko pointed out by Ralf, and
   gets rid of an extra iconv_opened field added unnecessarily in
   the previous round.

   This was brought up by Linus in http://goo.gl/INWVc

 compat/precompose_utf8.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index d40d1b3..79b5528 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -67,7 +67,7 @@ void probe_utf8_pathname_composition(char *path, int len)
 
 void precompose_argv(int argc, const char **argv)
 {
-	int i = 0;
+	int i;
 	const char *oldarg;
 	char *newarg;
 	iconv_t ic_precompose;
@@ -75,11 +75,19 @@ void precompose_argv(int argc, const char **argv)
 	if (precomposed_unicode != 1)
 		return;
 
+	/* Avoid iconv_open()/iconv_close() if there is nothing to convert */
+	for (i = 0; i < argc; i++) {
+		if (has_utf8(argv[i], (size_t)-1, NULL))
+			break;
+	}
+	if (argc <= i)
+		return; /* no utf8 found */
+
 	ic_precompose = iconv_open(repo_encoding, path_encoding);
 	if (ic_precompose == (iconv_t) -1)
 		return;
 
-	while (i < argc) {
+	for (i = 0; i < argc; i++) {
 		size_t namelen;
 		oldarg = argv[i];
 		if (has_utf8(oldarg, (size_t)-1, &namelen)) {
@@ -87,7 +95,6 @@ void precompose_argv(int argc, const char **argv)
 			if (newarg)
 				argv[i] = newarg;
 		}
-		i++;
 	}
 	iconv_close(ic_precompose);
 }
@@ -106,8 +113,7 @@ PREC_DIR *precompose_utf8_opendir(const char *dirname)
 		return NULL;
 	} else {
 		int ret_errno = errno;
-		prec_dir->ic_precompose = iconv_open(repo_encoding, path_encoding);
-		/* if iconv_open() fails, die() in readdir() if needed */
+		prec_dir->ic_precompose = (iconv_t)-1;
 		errno = ret_errno;
 	}
 
@@ -136,6 +142,9 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_type = res->d_type;
 
 		if ((precomposed_unicode == 1) && has_utf8(res->d_name, (size_t)-1, NULL)) {
+			if (prec_dir->ic_precompose == (iconv_t)-1)
+				prec_dir->ic_precompose =
+					iconv_open(repo_encoding, path_encoding);
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
-- 
1.7.12.rc1.43.g3fa3e7e
