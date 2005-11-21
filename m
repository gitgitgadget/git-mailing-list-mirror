From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 10:37:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>
References: <87hda61a80.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1699459003-1132598230=:13959"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 19:38:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeGXm-0004eC-Qr
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 19:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVKUShQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 13:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVKUShP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 13:37:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932414AbVKUShO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 13:37:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jALIbBnO001304
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 10:37:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jALIbAFX025607;
	Mon, 21 Nov 2005 10:37:11 -0800
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87hda61a80.fsf@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12466>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1699459003-1132598230=:13959
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 21 Nov 2005, Santi Béjar wrote:
> 
>         Is there any way to ask git to find pure renames or copies?

Not directly, but git sure makes it easy for you.

Do this:

	git-diff-tree -r old..new |
		grep '^:[^<tab>]*0000000000000000000000000000000000000000'

and you'll get all the information (that "<tab>" is obviously the tab 
character) you need to efficiently do it (or, if you want to just do one 
commit, just do "git-diff-tree -r cmit"). 

In the git tree, commit 0086e2c854e3af3209915e4ec2f933bcef400050 can act 
as a good example of this: the output of 

	git-diff-tree -r 0086e2c854e3af3209915e4ec2f933bcef400050

is

	0086e2c854e3af3209915e4ec2f933bcef400050
	:100644 100644 328b399f9fe6e2b668691ab359319f50561cd773 16a8af63f0523cec82faa23f29cee579ac224e82 M      .gitignore
	:100644 000000 a8cc5739d7851da3aeca2388d74eb92c464f1732 0000000000000000000000000000000000000000 D      Documentation/git-lost+found.txt
	:000000 100644 0000000000000000000000000000000000000000 03156f218bb41b955779207ec2e94120f958fc45 A      Documentation/git-lost-found.txt
	:100644 100644 a9d47c115c071694321d076af8a73a06ddd46875 1c32dd5be7156ae0e1142523fe50d84745964793 M      Documentation/git.txt
	:100644 100644 b75cb137875b3cdb8746d2e0135e6f2743e2046a 5b2eca897386e17021d2a8a052b0c2759df96447 M      Makefile
	:100755 000000 3892f52005d1e36676681806a87ef35dc0689f22 0000000000000000000000000000000000000000 D      git-lost+found.sh
	:000000 100755 0000000000000000000000000000000000000000 3892f52005d1e36676681806a87ef35dc0689f22 A      git-lost-found.sh

and then after the "grep", you have just

	:100644 000000 a8cc5739d7851da3aeca2388d74eb92c464f1732 0000000000000000000000000000000000000000 D      Documentation/git-lost+found.txt
	:000000 100644 0000000000000000000000000000000000000000 03156f218bb41b955779207ec2e94120f958fc45 A      Documentation/git-lost-found.txt
	:100755 000000 3892f52005d1e36676681806a87ef35dc0689f22 0000000000000000000000000000000000000000 D      git-lost+found.sh
	:000000 100755 0000000000000000000000000000000000000000 3892f52005d1e36676681806a87ef35dc0689f22 A      git-lost-found.sh

left, which shows you the new and the deleted files.

Then, look for renames: just match up a new file that has the same SHA1 as 
a deleted file, and you can see that the change from "git-lost+found.sh" 
to "git-lost-found.sh" was exactly such an exact rename, because they 
share the 3892f52005d1e36676681806a87ef35dc0689f22 SHA1.

After rename detection, look at any remaining new files (in the above 
example, only

	:000000 100644 0000000000000000000000000000000000000000 03156f218bb41b955779207ec2e94120f958fc45 A      Documentation/git-lost-found.txt

would be left), and try to match up the SHA1 of that file with the result 
of "git-ls-tree -r $old", ie something like

	git-ls-tree -r 0086e2c854e3af3209915e4ec2f933bcef400050^ |
		grep 03156f218bb41b955779207ec2e94120f958fc45

which in this case is empty (that new file wasn't an exact copy of any old 
file, it was a rename+edit, of course).

Very efficient, very simple, you can do it either with a small 
shell-script (using cut + sort + join + grep), or write a specialized tool 
around the git-diff-tree logic.

Of course, arguably "-M100" should really do this optimization for you. 
Junio?

			Linus
--21872808-1699459003-1132598230=:13959--
