From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 10:52:11 -0700
Message-ID: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 19:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwGcK-0002nm-5h
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 19:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab2GaRwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 13:52:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab2GaRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 13:52:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D031D7030;
	Tue, 31 Jul 2012 13:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	I5YYaKu4yG4qeF+DEgw+e4TCNM=; b=lY51QKmu3O1JmdUK4WhzJN0lpqd9XaM2j
	5AIqx0yBi7subdXUDHMs55yjZ6dJpJBq3LGH+oBZdJ24oJnA378PB2CYgudCumyL
	y8RJnvyxvciv3bTQfqx6Qc73rax54EHDk84o5rj1gIVoM9NEcPhdfeOQX/F+Ily2
	YfBdqFay6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=olRv42ci5aEl1sQuVhcKeoPS3kUbl/NEaJqyxIsQumG4l7wnWXi9JoU+
	0WSBUv+S08/Xb8ha+M1HJzWwb48Q8CoJhbdImtxzRe5mOQrIJc+K88aL/pf928/e
	WzNrNLDbWOE+k0EhvezyjD3LjmPbnDzTpQPWTG1vrH7VfgzeQsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1B0702F;
	Tue, 31 Jul 2012 13:52:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A1CC702D; Tue, 31 Jul 2012
 13:52:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 754D82D2-DB38-11E1-8E90-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202662>

In practice, the majority of paths do not have any utf8 character
that needs the canonicalization.  Lazily call iconv_open() and
iconv_close() to avoid unnecessary overhead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is not even compile tested, so it needs testing and
   benchmarking, as I do not even know how costly the calls to
   open/close are when we do not have to call iconv() itself.

   This was brought up by Linus (Cc'ed) in http://goo.gl/INWVc

 compat/precompose_utf8.c | 24 ++++++++++++++++++------
 compat/precompose_utf8.h |  1 +
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index d40d1b3..63ce89f 100644
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
+	if (i < argc)
+		return;
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
+		prec_dir->iconv_opened = 0;
 		errno = ret_errno;
 	}
 
@@ -136,6 +142,11 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_type = res->d_type;
 
 		if ((precomposed_unicode == 1) && has_utf8(res->d_name, (size_t)-1, NULL)) {
+			if (!prec_dir->iconv_opened) {
+				prec_dir->ic_precompose =
+					iconv_open(repo_encoding, path_encoding);
+				prec_dir->iconv_opened = 1;
+			}
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
@@ -181,7 +192,8 @@ int precompose_utf8_closedir(PREC_DIR *prec_dir)
 	int ret_errno;
 	ret_value = closedir(prec_dir->dirp);
 	ret_errno = errno;
-	if (prec_dir->ic_precompose != (iconv_t)-1)
+	if (prec->dir->iconv_opened &&
+	    (prec_dir->ic_precompose != (iconv_t)-1))
 		iconv_close(prec_dir->ic_precompose);
 	free(prec_dir->dirent_nfc);
 	free(prec_dir);
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..8de485e 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -22,6 +22,7 @@ typedef struct dirent_prec_psx {
 
 typedef struct {
 	iconv_t ic_precompose;
+	int iconv_opened;
 	DIR *dirp;
 	struct dirent_prec_psx *dirent_nfc;
 } PREC_DIR;
-- 
1.7.12.rc1.43.g3fa3e7e
