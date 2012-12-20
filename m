From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools/p4merge: Honor $TMPDIR for the /dev/null
 placeholder
Date: Wed, 19 Dec 2012 23:07:53 -0800
Message-ID: <7v1uel6w1i.fsf@alter.siamese.dyndns.org>
References: <1355978754-7041-1-git-send-email-davvid@gmail.com>
 <7v623x6xvv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 08:08:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlaF3-0001Ih-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 08:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab2LTHIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 02:08:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab2LTHID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 02:08:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5AD09BD0;
	Thu, 20 Dec 2012 02:08:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6F4ecnVn9s19FY07pVf5tqxUnc=; b=I3imEZ
	wggjHih7TiE7I+HxB3IKuBg89w+Ykt3tfrYY9lO2zqVJfvYDJzV2OIu+xyAb9KSx
	N9Ml8bukwL2o8RulRQAGqI82Iwys4CH6Ck3y0xmUCNfPZxtgIin/xJt0NxO0vErG
	hVNfG1Eyzrrl8m9471BB3RfnacLWQ6mT2a64s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hsou+2MUVDRazFs+eBuHDaxKvokZGWFq
	t4yOe8sEms+CfaqPKglWIqf+MADA0wyJHMiiuSCEaU6BmIE/c1JkhnBiRbE2Yppq
	AtVUyM+zpuxmY1X1ql/gi//9Ggg6uSX36PFBsGeUrfsp8WApcjYRhRN4TXkpa+8k
	PdlzpsIhH/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF6F89BCF;
	Thu, 20 Dec 2012 02:08:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE79F9BCD; Thu, 20 Dec 2012
 02:08:00 -0500 (EST)
In-Reply-To: <7v623x6xvv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 19 Dec 2012 22:28:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD74E722-4A73-11E2-A35F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211883>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> Use mktemp to create the /dev/null placeholder for p4merge.
>> This keeps it out of the current directory.
>>
>> Reported-by: Jeremy Morton <admin@game-point.net>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> I consider this a final finishing touch on a new 1.8.1 feature,
>> so hopefully we can get this in before 1.8.1.
>
> Does everybody have mktemp(1), which is not even in POSIX.1?
>
> I'm a bit hesitant to apply this to the upcoming release without
> cooking it in 'next' for sufficiently long time to give it a chance
> to be tried by wider audience.

One approach may be to do something like this as a preparation step
(current callers of unpack-file may want to do their temporary work
in TMPDIR as well), and then use

	git unpack-file -t e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

to create your empty temporary file.

 Documentation/git-unpack-file.txt | 10 +++++++---
 builtin/unpack-file.c             | 28 +++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index e9f148a..56af328 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -10,16 +10,20 @@ git-unpack-file - Creates a temporary file with a blob's contents
 SYNOPSIS
 --------
 [verse]
-'git unpack-file' <blob>
+'git unpack-file' [-t] <blob>
 
 DESCRIPTION
 -----------
 Creates a file holding the contents of the blob specified by sha1. It
-returns the name of the temporary file in the following format:
-	.merge_file_XXXXX
+returns the name of the temporary file (by default `.merge_file_XXXXX`).
+
 
 OPTIONS
 -------
+-t::
+	The temporary file is created in `$TMPDIR` directory,
+	instead of the current directory.
+
 <blob>::
 	Must be a blob id
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 1920029..de1f845 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,8 +1,9 @@
 #include "builtin.h"
 
-static char *create_temp_file(unsigned char *sha1)
+static char *create_temp_file(unsigned char *sha1, int in_tempdir)
 {
-	static char path[50];
+	static char path[1024];
+	static const char template[] = ".merge_file_XXXXXX";
 	void *buf;
 	enum object_type type;
 	unsigned long size;
@@ -12,8 +13,12 @@ static char *create_temp_file(unsigned char *sha1)
 	if (!buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", sha1_to_hex(sha1));
 
-	strcpy(path, ".merge_file_XXXXXX");
-	fd = xmkstemp(path);
+	if (in_tempdir) {
+		fd = git_mkstemp(path, sizeof(path) - 1, template);
+	} else {
+		strcpy(path, template);
+		fd = xmkstemp(path);
+	}
 	if (write_in_full(fd, buf, size) != size)
 		die_errno("unable to write temp-file");
 	close(fd);
@@ -23,14 +28,23 @@ static char *create_temp_file(unsigned char *sha1)
 int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
+	int in_tempdir = 0;
+
+	if (argc < 2 || 3 < argc || !strcmp(argv[1], "-h"))
+		usage("git unpack-file [-t] <sha1>");
+	if (argc == 3) {
+		if (strcmp(argv[1], "-t"))
+			usage("git unpack-file [-t] <sha1>");
+		in_tempdir = 1;
+		argc--;
+		argv++;
+	}
 
-	if (argc != 2 || !strcmp(argv[1], "-h"))
-		usage("git unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
 	git_config(git_default_config, NULL);
 
-	puts(create_temp_file(sha1));
+	puts(create_temp_file(sha1, in_tempdir));
 	return 0;
 }
