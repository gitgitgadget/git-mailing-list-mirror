From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull - strange (copy/rename) messages ?!
Date: Tue, 01 Nov 2005 16:35:31 -0800
Message-ID: <7v8xw751kc.fsf@assigned-by-dhcp.cox.net>
References: <43678C73.1080601@excelsior-online.org>
	<Pine.LNX.4.64.0511010801370.27915@g5.osdl.org>
	<7vbr149sbs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511011646070.25300@iabervon.org>
	<7vu0ew6jf3.fsf@assigned-by-dhcp.cox.net>
	<20051101233647.GC1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:36:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6bI-00042m-BX
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbVKBAfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbVKBAfd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:35:33 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60628 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751482AbVKBAfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:35:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102003449.WOGP776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 19:34:49 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051101233647.GC1431@pasky.or.cz> (Petr Baudis's message of
	"Wed, 2 Nov 2005 00:36:47 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10981>

Petr Baudis <pasky@suse.cz> writes:

> In case of my proposal, you get the mv and cp as usual, since there are
> no multiple rename candidates for A.

I think showing things the Pasky way may be the easiest to
understand for this particular case and for the simplest case.
The original one would become something like this:

copy Graphics/{PaletteGroups.cs => PaletteCategories.cs} (80%)
copy Graphics/PaletteGroups.cs => Plot/Dialogs/Dialog.cs (75%)
...
copy Graphics/PaletteGroups.cs => Runtime/Scripting/Script.cs (75%)
copy Graphics/PaletteGroups.cs => Runtime/Scripting/ScriptLibrary.cs (64%)
delete Graphics/PaletteGroups.cs

That is, if you are interested in Plot/Dialogs/Dialog.cs, you
know where it came from.  If you are interested in
Graphics/PaletteGroups.cs, you can tell it disappeared.

That is, you need to look at only one line to know what funny
things happened to one path.

However, I suspect that this requires moderate amount of surgery
on the diff output routine (the last stage).  I have a feeling
that git-apply may also need to be told about it when applying
such a patch.

The biggest drawback doing things the Pasky way would be that
the textual diff would need to contain the whole file removal of
Graphics/PaletteGroups.cs.  Do we want to bloat the output for
this?  I personally do not think it is worth it.

We could cheat by only changing the git-apply --summary side, to
implement either Pasky or Daniel proposal, but that would make
output from 'git-diff -p | git-apply --summary' and 'git-diff -r
--name-status -r' inconsistent, which I'd rather avoid.

I think all three (i.e. current, Pasky, Daniel) logically make
sense, and it is to a certain degree just a matter of personal
taste.  Let's try doing nothing for now and see if people get
used to it ;-).
