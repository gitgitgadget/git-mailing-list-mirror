From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Make sure objects/pack exists before creating a new
 pack
Date: Thu, 26 Feb 2009 10:19:59 +0100
Message-ID: <49A65EBF.10307@viscovery.net>
References: <49A428B7.4000003@spiralti.com> <7v7i3fivx2.fsf@gitster.siamese.dyndns.org> <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 10:21:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LccQy-0002mM-LG
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbZBZJUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbZBZJUI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:20:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18745 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbZBZJUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 04:20:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LccPQ-0004Nn-7D; Thu, 26 Feb 2009 10:20:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C04BD4FB; Thu, 26 Feb 2009 10:19:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111543>

Junio C Hamano schrieb:
> @@ -795,22 +794,24 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  
>  	if (keep_msg) {
>  		int keep_fd, keep_msg_len = strlen(keep_msg);
> -		if (!keep_name) {
> -			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
> -				 get_object_directory(), sha1_to_hex(sha1));
> -			keep_name = name;

You should not have removed this line...

> -		}
> -		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
> +
> +		if (!keep_name)
> +			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
> +		else
> +			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
> +
>  		if (keep_fd < 0) {
>  			if (errno != EEXIST)
> -				die("cannot write keep file");
> +				die("cannot write keep file '%s' (%s)",
> +				    keep_name, strerror(errno));

... we need keep_name for this error message.

Warning: I did not test the failure path; but I made sure that these
tests pass on Windows:

cd t && make *fetch* *pack* *index* *pull*

-- snip --
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] index-pack: Set keep_name if a new keep file was allocated

6e180cdc (Make sure objects/pack exists before creating a new pack,
2009-02-25) simplified the code in this area, but it also extended an
error message to include the file name that caused the error. However,
one code path did not set file name correctly.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 index-pack.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 7fee872..93a09c6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -794,9 +794,10 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (keep_msg) {
 		int keep_fd, keep_msg_len = strlen(keep_msg);

-		if (!keep_name)
+		if (!keep_name) {
 			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
-		else
+			keep_name = name;
+		} else
 			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);

 		if (keep_fd < 0) {
-- 
1.6.2.rc2.1005.gb0117
