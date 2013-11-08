From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: most of the time we have good leading directories
Date: Thu, 07 Nov 2013 16:30:14 -0800
Message-ID: <xmqqy54zohux.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 08 01:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeZxx-0004YF-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 01:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3KHAaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 19:30:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584Ab3KHAaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 19:30:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3788550A0D;
	Thu,  7 Nov 2013 19:30:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	DryWRRgsPmvlH2JhT3EAC4cnX8=; b=UYk5SiVIfXQid8ByjhNV94JBBp00cb0BK
	w2tLdy19bkrwizx+6/X//WUKi3jjxHiqy+/R5BE9z7S5LlLHPp2ndc9iFjM66mRq
	gf36XiXbuk4QQmZ9vxlYy8gTcT14tc0jfnLvcXdvxkIDpauiI8K+Ovs5FlfxLXWC
	HyuhgKY3Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VoW
	dgtHW2dySIrznJDaubzfz0y6H5JKHRVUOD/9Z9dTl9yctyAOY5B06j5JfJ8EbiMh
	mgeotVtkiSYwo5tTI1QB8yjIPGc+HuZ4X0H8XOZMhaMTq0oCM5y8itgqA+0996jd
	qF07vNQND/jBIX9FW3Ri5lEjQztwsu0zhYTbOLhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BAA650A0C;
	Thu,  7 Nov 2013 19:30:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B71050A0A;
	Thu,  7 Nov 2013 19:30:17 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F13A014E-480C-11E3-8E9C-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237445>

When "git checkout" wants to create a path, e.g. a/b/c/d/e, after
seeing if the entire thing already exists (in which case we check if
that is up-to-date and do not bother to check it out, or we unlink
and recreate it), we validate that the leading directory path is
without funny symlinks by seeing a/, a/b/, a/b/c/ and then a/b/c/d/
are all without funny symlinks, by calling has_dirs_only_path() in
this order.

When we are checking out many files (imagine: initial checkout),
however, it is likely that an earlier checkout would have already
made sure that the leading directory a/b/c/d/ is in good order; by
first checking the whole path a/b/c/d/ first, we can often bypass
calls to has_dirs_only_path() for leading part.

This cuts down the number of calls to has_dirs_only_path() for
checking out Linux kernel sources afresh from 190k down to 98k.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just a random experimental change I was playing with today,
   looking for low hanging fruits before having to thread the entire
   checkout codepath.

 entry.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 7b7aa81..e2c0ac6 100644
--- a/entry.c
+++ b/entry.c
@@ -6,9 +6,17 @@
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
 {
-	char *buf = xmalloc(path_len + 1);
-	int len = 0;
+	char *buf;
+	int len;
+
+	for (len = path_len - 1; 0 <= len; len--)
+		if (path[len] == '/')
+			break;
+	if (has_dirs_only_path(path, len, state->base_dir_len))
+		return; /* ok, we have the whole leading directory */
 
+	buf = xmalloc(path_len + 1);
+	len = 0;
 	while (len < path_len) {
 		do {
 			buf[len] = path[len];
