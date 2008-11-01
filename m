From: "Tom Preston-Werner" <tom@github.com>
Subject: [PATCH v2] connect.c: add a way for git-daemon to pass an error back to client
Date: Sat, 1 Nov 2008 11:44:45 -0700
Message-ID: <b97024a40811011144s7f4bca47w1cc92b0975cecbc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 19:46:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwLUm-0002jr-Fz
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 19:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbYKASpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYKASpf
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 14:45:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:41319 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbYKASpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 14:45:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so752289nfc.21
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 11:44:46 -0700 (PDT)
Received: by 10.210.92.11 with SMTP id p11mr6323563ebb.134.1225565086017;
        Sat, 01 Nov 2008 11:44:46 -0700 (PDT)
Received: by 10.210.117.11 with HTTP; Sat, 1 Nov 2008 11:44:45 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99759>

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
Use prefixcmp instead of memcmp and test for "ERR " instead of "ERR"

 connect.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 0c50d0a..584e04c 100644
--- a/connect.c
+++ b/connect.c
@@ -70,6 +70,9 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		if (buffer[len-1] == '\n')
 			buffer[--len] = 0;

+		if (len > 4 && !prefixcmp(buffer, "ERR "))
+			die("remote error: %s", buffer + 4);
+
 		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] != ' ')
 			die("protocol error: expected sha/ref, got '%s'", buffer);
 		name = buffer + 41;
-- 
1.6.0.2
