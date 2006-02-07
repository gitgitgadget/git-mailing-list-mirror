From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am: "Patch fragment without a header"
Date: Mon, 06 Feb 2006 21:35:25 -0800
Message-ID: <7vfymv3f4y.fsf@assigned-by-dhcp.cox.net>
References: <43E80D23.4070007@zytor.com>
	<7vwtg73ld7.fsf@assigned-by-dhcp.cox.net> <43E814C2.6090104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 06:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6LVj-0003V3-ND
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 06:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWBGFf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 00:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWBGFf3
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 00:35:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49800 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750888AbWBGFf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 00:35:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207053533.DNEX25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 00:35:33 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43E814C2.6090104@zytor.com> (H. Peter Anvin's message of "Mon,
	06 Feb 2006 19:32:18 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15685>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Unfortunately git-mailinfo is in C, otherwise I'd have suggested using
> the Perl MIME-tools, which seems to have all this stuff in it.

Heh, spawn Perl for every message?  I'd be ****ed by Linus if I
did so ;-).

This should fix it and I'd appreciate if you try it on other
messages.

I tried it on the message you quoted with:

    git-mailinfo -u /var/tmp/msg /var/tmp/patch <./+hpa.eml >/var/tmp/info

The resulting 'msg' and 'info' looks reasonable utf8 and patch
was not corrupt.

-- >8 --
[PATCH] mailinfo: reset CTE after each multipart

If the first part uses quoted-printable to protect iso8859-1
name in the commit log, and the second part was plain ascii text
patchfile without even Content-Transfer-Encoding subheader, we
incorrectly tried to decode the patch as quoted printable.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/mailinfo.c b/mailinfo.c
index 0265a29..ff2d4d4 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -707,6 +707,9 @@ static void handle_multipart_body(void)
 		if (!len) {
 			if (handle_multipart_one_part() < 0)
 				return;
+			/* Reset per part headers */
+			transfer_encoding = TE_DONTCARE;
+			charset[0] = 0;
 		}
 		else
 			check_subheader_line(line, len);
