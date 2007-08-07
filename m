From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 18:28:53 -0700
Message-ID: <7vhcnc9lpm.fsf@assigned-by-dhcp.cox.net>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
	<11864401942772-git-send-email-mdl123@verizon.net>
	<Pine.LNX.4.64.0708062349460.14781@racer.site>
	<7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 03:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIDsY-0007Gb-2u
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 03:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbXHGB2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 21:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXHGB2z
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 21:28:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55409 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbXHGB2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 21:28:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807012855.BLLR26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 6 Aug 2007 21:28:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YpUt1X00F1kojtg0000000; Mon, 06 Aug 2007 21:28:54 -0400
In-Reply-To: <46B7B10F.4060402@gmail.com> (Mark Levedahl's message of "Mon, 06
	Aug 2007 19:38:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55194>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>> Yes.  And 00d8c51 obviously "works for me", so there is
>> something different between what Mark and I are doing.  I cannot
>> tell what it is.
>>
> GZ=1 make quick-install-doc
>
> ...fails because git-ls-tree is called when cwd=$mandir which is
> nowhere under or related to $GIT_DIR.

Oops.  I am blind.  That's right.  That command does a chdir on
its own.

How does this sound?

---
diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index 07d227f..bc170f0 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -24,10 +24,10 @@ git read-tree $head
 git checkout-index -a -f --prefix="$mandir"/
 
 if test -n "$GZ"; then
-	cd "$mandir"
-	for i in `git ls-tree -r --name-only $head`
+	git ls-tree -r --name-only $head |
+	while read path
 	do
-		gzip < $i > $i.gz && rm $i
+		gzip "$mandir/$path"
 	done
 fi
 rm -f "$GIT_INDEX_FILE"
