From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 11:57:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
 <7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 20:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBG9l-0000T2-Nw
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 20:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbXA1T5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 14:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbXA1T5i
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 14:57:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36140 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932789AbXA1T5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 14:57:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0SJvY1m000737
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Jan 2007 11:57:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0SJvXbM002266;
	Sun, 28 Jan 2007 11:57:34 -0800
In-Reply-To: <7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38043>



On Sun, 28 Jan 2007, Junio C Hamano wrote:
> 
> Do you mean the perl-Gtk one by Jeff King?

Sorry, yeah, I'm just confused.

Where are my meds again?

> I was hoping to take a look at Shawn's git-gui and also perhaps
> looking into adding blame --incremental support to gitk myself
> when I have time, but unfortunately my day-job deadline is
> spilling into this weekend.

I think the nice thing about the new "git-blame --incremental" is that it 
allows people who really don't know (or care) anything at all about git 
internals to do the viewer. So you shouldn't need to care.

So I don't think you should do it, we should encourage others (who may not 
be comfy with writing hard-core C that touches subtle internal git issues) 
to just do it.

One thing I looked at, which *should* be easy to do inside "git-blame", is 
to make the case where you do *not* give a head to start with, default to 
"current working tree" instead of HEAD.

For example, say that I have changes in my working tree, and I do

	git blame-viewer <filename-that-is-dirty>

I think it would be nice if the *dirty* lines would actually get blamed to 
a fake commit (SHA-1 "00000000..") that is the "current working tree. 
Right now, it always starts from HEAD:filename, which may be how CVS/SVN 
annotate and friends work, but I actually think we could do better.

If you really want the annotation for the _committed_ state, you can 
always just say so explicitly:

	git blame-viewer HEAD <filename-that-may-be-dirty-but-who-cares>

No?

But for the actual viewer parts, which don't need internal git knowledge, 
let's just document the blame format, so that others can do it:

The new format is fairly easy to parse: each blame entry is always

 - starts with a line of

	<40-byte hex sha1> <sourceline> <resultline> <num_lines>

 - the first time that commit shows up in the stream, it has various
   other information about it printed out with a one-word tag at the 
   beginning of each line about that "extended commit info" (author, 
   email, committer, dates, summary etc)

 - each entry is _always_ finished by a

	"filename" <whitespace-quoted-filename-goes-here>

and thus it's really quite easy to parse for some line- and word-oriented 
parser (which should be quite natural for most scripting languages).

NOTE! For people who do parsing: to make it more robust, just ignore any 
lines in between the first and last one ("<sha1>" and "filename" lines) 
where you don't recognize the tag-words (or care about that particular 
one) at the beginning of the "extended information" lines. That way, if 
there is ever added information (like the commit encoding or extended 
commit commentary), a blame viewer won't ever care.

		Linus
