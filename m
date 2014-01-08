From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH mm/mv-file-to-no-such-dir-with-slash] mv: let 'git mv file
 no-such-dir/' error out on Windows, too
Date: Wed, 08 Jan 2014 17:33:44 +0100
Message-ID: <52CD7DE8.6070101@kdbg.org>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Duy Nguyen <pclouds@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 08 17:55:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0wPn-0002mw-Es
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 17:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbaAHQzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 11:55:31 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47809 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755546AbaAHQza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 11:55:30 -0500
X-Greylist: delayed 1302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2014 11:55:30 EST
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 8BAD611956D
	for <git@vger.kernel.org>; Wed,  8 Jan 2014 17:33:58 +0100 (CET)
Received: from [192.168.0.207] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4EEE313005B;
	Wed,  8 Jan 2014 17:33:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240220>

The previous commit c57f628 (mv: let 'git mv file no-such-dir/' error out)
relies on that rename("src", "dst/") fails if directory dst does not
exist (note the trailing slash). This does not work as expected on Windows:
This rename() call is successful. Insert an explicit check for this case.

This changes the error message from

   $ git mv file no-such-dir/
   fatal: renaming 'file' failed: Not a directory

to

   $ git mv file no-such-dir/
   fatal: destination directory does not exist, source=file, destination=no-such-dir/

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin/mv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 08fbc03..21c46d1 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -214,6 +214,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			}
 		} else if (string_list_has_string(&src_for_dst, dst))
 			bad = _("multiple sources for the same target");
+		else if (is_dir_sep(dst[strlen(dst) - 1]))
+			bad = _("destination directory does not exist");
 		else
 			string_list_insert(&src_for_dst, dst);
 
-- 
1.8.5.2.1473.g6546919
