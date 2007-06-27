From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 15:02:21 +0200
Message-ID: <87r6nxo8iq.fsf_-_@rho.meyering.net>
References: <87wsxpobf0.fsf@rho.meyering.net>
	<81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 15:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3XA8-00017e-Ty
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758625AbXF0NCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758441AbXF0NCX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:02:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:54143 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756072AbXF0NCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:02:22 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C30735A1EC;
	Wed, 27 Jun 2007 15:02:21 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id AB72D2A226; Wed, 27 Jun 2007 15:02:21 +0200 (CEST)
In-Reply-To: <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com> (Alex Riesen's message of "Wed\, 27 Jun 2007 14\:48\:52 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51037>

"Alex Riesen" <raa.lkml@gmail.com> wrote:
> On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
>> Without this, if you ever run out of file descriptors, dup will
>> fail (silently), fdopen will return NULL, and fprintf will
>> try to dereference NULL (i.e., usually segfault).
>
> But if you check the result of fdopen for NULL instead
> you'll cover the dup failure _and_ out-of-memory in one
> go. You'll loose the errno (probably), but you don't seem
> to use it here anyway.

Good catch.  Thanks!
I didn't see that fdopen could fail with ENOMEM.
That'll teach me to trust the man page.  I see POSIX does mention it.

Here's a better patch:

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-log.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 073a2a1..7b0d6f4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -588,8 +588,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (ignore_if_in_upstream)
 		get_patch_ids(&rev, &ids, prefix);

-	if (!use_stdout)
-		realstdout = fdopen(dup(1), "w");
+	if (!use_stdout) {
+		int fd = dup(1);
+		if (fd < 0 || (realstdout = fdopen(fd, "w")) == NULL)
+			die("failed to duplicate standard output: %s",
+			    strerror(errno));
+	}

 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
