From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 16:07:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org> <20080420215700.GA18626@bit.office.eurotux.com> <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 01:08:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnie7-0006jc-TP
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 01:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYDTXHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbYDTXHp
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 19:07:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54716 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392AbYDTXHp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 19:07:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3KN7aVZ000316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Apr 2008 16:07:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3KN7au0018962;
	Sun, 20 Apr 2008 16:07:36 -0700
In-Reply-To: <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80001>



On Sun, 20 Apr 2008, Linus Torvalds wrote:
> 
> I do agree that actually actively removing stat calls requires a lot more 
> subtle interactions. We almost always *have* the stat information in the 
> index, but the problem with "git status ." is that we re-read the index so 
> many times (and then have to re-validate the stat info).

Actually, looking closer, one of the issues seems to be not just the fact 
that we throw out the index by re-reading it, but run_diff_files() does

		...
                if (ce_uptodate(ce))
                        continue;

                changed = check_work_tree_entity(ce, &st, symcache);
                if (changed) {
			...

where that "check_work_tree_entity()" check is very expensive for deep 
directory structures, because it ends up checking the stat() information 
fo every single directory leading up to it.

There's some bug there, because it really shouldn't do that.

This causes lstat() patterns like

	..
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean/15.6.4.2-2.js", {st_mode=S_IFREG|0664, st_size=3197, ...}) = 0
	lstat("JavaScriptCore", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	..

ie instead of doing just *one* lstat (on that file), it does six: the file 
itself, and the five directories leading up to it!

This is the *real* cause of WebKit having ~7 lstat's per file in the 
repository - if it wasn't for this braindamage, we'd have just three 
lstat's per file for "git status .".

What's really sad is how we do this for every file in a directory, so the 
pattern actually ends up looking like

	...
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean/15.6.4.1.js", {st_mode=S_IFREG|0664, st_size=2164, ...}) = 0
	lstat("JavaScriptCore", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean/15.6.4.2-1.js", {st_mode=S_IFREG|0664, st_size=5219, ...}) = 0
	lstat("JavaScriptCore", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean/15.6.4.2-2.js", {st_mode=S_IFREG|0664, st_size=3197, ...}) = 0
	lstat("JavaScriptCore", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	lstat("JavaScriptCore/tests/mozilla/ecma/Boolean", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
	...

ie for deep directories with lots of files in them, we end up doing an 
lstat() on all the directories leading up to that directory oevr and over 
and over again - for each file in that directory.

Oops.

We're supposed to have that "char *symcache" thing to not do that, but it 
doesn't actually work that way.

Junio, what was the logic for that whole "has_symlink_leading_path()" 
thing? I forget. Whatever, it's broken. 

		Linus
