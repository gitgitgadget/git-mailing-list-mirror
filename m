From: "Tom Preston-Werner" <tom@github.com>
Subject: [PATCH] connect.c: add a way for git-daemon to pass an error back to client
Date: Fri, 31 Oct 2008 18:59:46 -0700
Message-ID: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 03:02:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5oy-0003T6-L0
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 03:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYKAB7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYKAB7t
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:59:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:25103 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYKAB7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:59:48 -0400
Received: by ey-out-2122.google.com with SMTP id 6so575639eyi.37
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 18:59:46 -0700 (PDT)
Received: by 10.210.46.4 with SMTP id t4mr14267344ebt.166.1225504786670;
        Fri, 31 Oct 2008 18:59:46 -0700 (PDT)
Received: by 10.210.117.11 with HTTP; Fri, 31 Oct 2008 18:59:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99709>

The current behavior of git-daemon is to simply close the connection on
any error condition. This leaves the client without any information as
to the cause of the failed fetch/push/etc.

This patch allows get_remote_heads to accept a line prefixed with "ERR"
that it can display to the user in an informative fashion. Once clients
can understand this ERR line, git-daemon can be made to properly report
"repository not found", "permission denied", or other errors.

Example

S: ERR No matching repository.
C: fatal: remote error: No matching repository.

Signed-off-by: Tom Preston-Werner <tom@github.com>
---
 connect.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 0c50d0a..3af91d6 100644
--- a/connect.c
+++ b/connect.c
@@ -70,6 +70,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		if (buffer[len-1] == '\n')
 			buffer[--len] = 0;

+		if (len > 4 && !memcmp("ERR", buffer, 3))
+			die("remote error: %s", buffer + 4);
+
 		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] != ' ')
 			die("protocol error: expected sha/ref, got '%s'", buffer);
 		name = buffer + 41;
-- 
1.6.0.2
