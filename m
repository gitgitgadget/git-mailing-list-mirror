From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am applies half of a patch
Date: Tue, 09 Jan 2007 02:52:31 -0800
Message-ID: <7vtzz0mpzk.fsf@assigned-by-dhcp.cox.net>
References: <45A36D6B.4010303@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 11:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Eaq-0006KM-IJ
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXAIKwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXAIKwd
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:52:33 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36579 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbXAIKwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:52:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109105232.OHPW20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 05:52:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8ysn1W00A1kojtg0000000; Tue, 09 Jan 2007 05:52:47 -0500
To: Jeff Garzik <jeff@garzik.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36350>

Jeff Garzik <jeff@garzik.org> writes:

> I ran
>
> 	git-am --signoff --utf8 /g/tmp/mbox
>
> on the attached file, to apply a patch to libata-dev.git#upstream, and
> it wound up only applying a portion of the patch:
>
>> [jgarzik@pretzel libata-dev]$ git-am --signoff --utf8 /g/tmp/mbox
>>
>> Applying 'Add pci class code for SATA AHCI'
>>
>> error: patch fragment without header at line 35: @@ -862,7 +862,7 @@
>> error: patch fragment without header at line 50: @@ -15,6 +15,8 @@
>> Wrote tree 5d6f3a93bea932c950ac880deca173dd3e84dfcc
>> Committed: 317b180bad43133027dc07455f1600f4e8a47d76
>
> It seems quite bad to apply a patch that git-am KNOWS is incomplete.

Quite true.

This turns out to be quite an old bug (dates back to May 2005).
I've scanned builtin-apply.c while coming up with this fix to
see if there other "detected but ignored" errors, but it appears
this is the only one.

Sorry for the trouble and thanks for the report.

-- >8 --
[PATCH] Do not ignore a detected patchfile brokenness.

find_header() function is used to read and parse the patchfile
and it detects errors in the patch, but one place ignored the
error and went ahead, which was quite bad.

Noticed by Jeff Garzik.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-apply.c b/builtin-apply.c
index 1c35837..918822b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -811,7 +811,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			error("patch fragment without header at line %d: %.*s", linenr, (int)len-1, line);
+			return error("patch fragment without header at line %d: %.*s", linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
