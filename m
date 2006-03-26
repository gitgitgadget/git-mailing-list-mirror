From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 14:22:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603261415390.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
 <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz>
 <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz>
 <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 00:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNddV-0002UA-7a
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 00:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWCZWWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 17:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCZWWQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 17:22:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWCZWWP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 17:22:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QMM5DZ006326
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 14:22:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QMM40Q020199;
	Sun, 26 Mar 2006 14:22:04 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060326191445.GQ18185@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18061>



On Sun, 26 Mar 2006, Petr Baudis wrote:
> 
> My current target is to support this tree (letters are filenames,
> numbers are commit ids; I'll translate any git output to those digits):
> 
>     2    4
>     b -- d
> 1 /        \ 6
> a            d
>   \ 3    5 /
>     c -- d

Yeah, the problem with this is that you need to track separate names 
across separate points. However:

> Curiously, git-rev-list does something totally strange when trying to
> list per-file history at this point:
> 
> 	$ git-rev-list HEAD -- d
> 	4
> 
> Huh? (It should list 6, 5, 4 instead.)

What it does is list the points where file "d" _changed_.

"d" did not change in 6 - it had a parent commit (4) where "d" had the 
same contents (in fact, it likely had _two_ parents where it had the same 
contents, but git will pick the first one). So commit "6" is 
uninteresting, and commit "5" will never even be looked at, since we 
decided that the history of "d" comes from the first parent with the same 
contents.

So then it lists "4", because file "d" really did change in that commit 
(it went away).

Now you need to look at "4" and find the rename (which gives you 2) and 
then from there you do rename detection and get (1), and as a result your 
change history should end up being

 (1)a -> (2)b -> (4)d (-> 6(d) which was your start point)

which is correct (now, there are other histories _too_ that get us to the 
same point, but the one you found this way was _a_ history).

> I worked it around by recording a change in d in the merge 6:
> 
> 	http://pasky.or.cz/~xpasky/renametree2.git/
> 
> 	$ git-rev-list --parents --remove-empty HEAD -- d
> 	6 4 5
> 	5
> 	4
> 
> Which is the expected output.

No, it's the expected output just because you expected merges to always 
show up. Merges get ignored if any of the parents have the same content 
already.

		Linus
