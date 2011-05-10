From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] checkout ":" is not giving any pathspec
Date: Mon,  9 May 2011 22:51:17 -0700
Message-ID: <1305006678-4051-9-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrO-0001Iw-RW
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab1EJFvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab1EJFvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB9625CA5;
	Tue, 10 May 2011 01:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bDeh
	norY7dMLiN1tkoH6miNO2+8=; b=xAEMbQz/5Pg0e3cbegcFpF6a0v8SfBmg/9Gr
	iHe9vtsjZr9NeplxjmuU/hFD6Ee/kPY80MJGHNQTUfAQPZYxR3gQk8ilu3Fwhvrr
	EmN7zYwesWahEiz6T6mOS1JAoGXRrrd5EjuIBUNyW2uHwd4vsjoB78ZvzSSkCufl
	ZWEALSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	NWrbxdJIiPB0I3wqbz/guYl5A5AnhAPUCGCjR+Urv4aoPYPD1sBpfbZeW5k0WWgq
	4lLAwCmhM7TeI6OSQWuMVVRSBIwoqpKgn8zn+4gearPQ5jSguNfkOjtcPoTeMPyD
	S+ov6U6EBAs1a9XzodxeTngJE3B6b2UDlD7nGi2zxMo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8C755CA0;
	Tue, 10 May 2011 01:53:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2682B5C9F; Tue, 10 May 2011
 01:53:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E31781EE-7AC9-11E0-A065-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173312>

"git cmd :" should be exactly the same as running "git cmd" from the
root level of the working tree.  Do not decide solely on the value of
argc (i.e. remaining parameters after options and revs are parsed),
but make sure we actually do have pathspec to switch operation modes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2bf02f2..fe46725 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -890,6 +890,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	char *conflict_style = NULL;
 	int patch_mode = 0;
 	int dwim_new_local_branch = 1;
+	const char **pathspec;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -1004,12 +1005,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.track == BRANCH_TRACK_UNSPECIFIED)
 		opts.track = git_branch_track;
 
-	if (argc) {
-		const char **pathspec = get_pathspec(prefix, argv);
-
-		if (!pathspec)
-			die("invalid path specification");
-
+	pathspec = get_pathspec(prefix, argv);
+	if (argc && pathspec) {
 		if (patch_mode)
 			return interactive_checkout(new.name, pathspec, &opts);
 
-- 
1.7.5.1.290.g1b565
