From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Make sure objects/pack exists before creating a new
 	pack
Date: Thu, 26 Feb 2009 16:31:52 +0100
Message-ID: <49A6B5E8.8040306@viscovery.net>
References: <49A428B7.4000003@spiralti.com>	 <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>	 <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>	 <49A65EBF.10307@viscovery.net> <e2b179460902260319je8ce6c6qc028d260b9d35b7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LciF2-0005Wy-QB
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 16:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbZBZPcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 10:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbZBZPcM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 10:32:12 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62786 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbZBZPcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 10:32:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LciDJ-0003os-At; Thu, 26 Feb 2009 16:32:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1625D4FB; Thu, 26 Feb 2009 16:31:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <e2b179460902260319je8ce6c6qc028d260b9d35b7c@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111574>

Mike Ralphson schrieb:
> 2009/2/26 Johannes Sixt <j.sixt@viscovery.net>
>> Junio C Hamano schrieb:
>>> @@ -795,22 +794,24 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>>>
>>>       if (keep_msg) {
>>>               int keep_fd, keep_msg_len = strlen(keep_msg);
>>> -             if (!keep_name) {
>>> -                     snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
>>> -                              get_object_directory(), sha1_to_hex(sha1));
>>> -                     keep_name = name;
>> You should not have removed this line...
> 
> Even with j6t's patch, I'm seeing failures in t5300--pack-object.sh on AIX 5.3
> 
> * FAIL 15: survive missing objects/pack directory
> fatal: Unable to create temporary file (): No such file or directory

I can confirm this. Your patch is good. I wrapped it up:

-- snip --
From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: [PATCH] Fix odb_mkstemp() on AIX

The AIX mkstemp() modifies its template parameter to an empty string if
the call fails.  The existing code had already recomputed the template,
but too late to be good.

See also 6ff6af62, which fixed this problem in a different spot.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 wrapper.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index b07cdf2..d8efb13 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -268,9 +268,10 @@ int odb_mkstemp(char *template, size_t limit,
 		return fd;

 	/* slow path */
-	safe_create_leading_directories(template);
+	/* some mkstemp implementations erase template on failure */
 	snprintf(template, limit, "%s/%s",
 		 get_object_directory(), pattern);
+	safe_create_leading_directories(template);
 	return xmkstemp(template);
 }

-- 
1.6.1.rc1.5.gf691f
