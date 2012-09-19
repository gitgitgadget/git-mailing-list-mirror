From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] grep.c: Fix some sparse warnings
Date: Wed, 19 Sep 2012 19:04:57 +0100
Message-ID: <505A0949.4090006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:10:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPfI-0002Rg-2x
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984Ab2ISTKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:10:22 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:33425 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932969Ab2ISTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:10:18 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id F274940027C;
	Wed, 19 Sep 2012 20:10:16 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 4E44A40024D;	Wed, 19 Sep 2012 20:10:16 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Wed, 19 Sep 2012 20:10:15 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205979>


In particular, sparse complains as follows:

        SP grep.c
    grep.c:1472:5: warning: symbol 'grep_source_load' was not \
        declared. Should it be static?
    grep.c:1500:5: warning: symbol 'grep_source_is_binary' was not \
        declared. Should it be static?

These warnings actually illustrate a known bug in sparse. The forward
declarations of these functions (on lines 6-7) include the static
modifier. These forward declarations convey the file scope property to
the later function definitions. Note that the function definition does
not have to include the static modifier for this to take effect.

In order to suppress the warnings, we simply include the (redundant)
static modifier in the function definitions. Note that repeating the
modifier, while not needed by the definition of C, does make it clear
to the human reader, at the point of definition, that the symbol has
file scope.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index c7f8a47..898be6e 100644
--- a/grep.c
+++ b/grep.c
@@ -1469,7 +1469,7 @@ static int grep_source_load_file(struct grep_source *gs)
 	return 0;
 }
 
-int grep_source_load(struct grep_source *gs)
+static int grep_source_load(struct grep_source *gs)
 {
 	if (gs->buf)
 		return 0;
@@ -1497,7 +1497,7 @@ void grep_source_load_driver(struct grep_source *gs)
 	grep_attr_unlock();
 }
 
-int grep_source_is_binary(struct grep_source *gs)
+static int grep_source_is_binary(struct grep_source *gs)
 {
 	grep_source_load_driver(gs);
 	if (gs->driver->binary != -1)
-- 
1.7.12
