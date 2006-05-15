From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "--summary" option to git diff.
Date: Sun, 14 May 2006 19:34:33 -0700
Message-ID: <7v7j4oxbgm.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP0770FC4238970CB812C192AEA20@CEZ.ICE>
	<7v3bfcno2b.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP02640E2C9813E4DA1E778BAEA30@CEZ.ICE>
	<Pine.LNX.4.64.0605141848080.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon May 15 04:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSut-0002p2-8w
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWEOCef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWEOCef
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:34:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23275 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751397AbWEOCef (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 22:34:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515023434.QRJA19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 22:34:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605141848080.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 14 May 2006 18:51:26 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20011>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 14 May 2006, Sean wrote:
>> 
>> What's a bit more worrying is that:
>> 
>> $ PAGER= ./git whatchanged -B -C --stat --no-merges --diff-filter=RC
>> 
>> Causes the same problem on the current (1.3.2) release branch without any
>> other patches applied at all.

And the culprit was _me_ X-<.  *BLUSH*


-- >8 --

diff --git a/diff.c b/diff.c
index 7a7b839..2d72673 100644
--- a/diff.c
+++ b/diff.c
@@ -232,11 +232,16 @@ static char *pprint_rename(const char *a
 	 * name-a => name-b
 	 */
 	if (pfx_length + sfx_length) {
+		int a_len = len_a - pfx_length - sfx_length;
+		int b_len = len_b - pfx_length - sfx_length;
+		if (a_len < 0) a_len = 0;
+		if (b_len < 0) b_len = 0;
+
 		name = xmalloc(len_a + len_b - pfx_length - sfx_length + 7);
 		sprintf(name, "%.*s{%.*s => %.*s}%s",
 			pfx_length, a,
-			len_a - pfx_length - sfx_length, a + pfx_length,
-			len_b - pfx_length - sfx_length, b + pfx_length,
+			a_len, a + pfx_length,
+			b_len, b + pfx_length,
 			a + len_a - sfx_length);
 	}
 	else {
