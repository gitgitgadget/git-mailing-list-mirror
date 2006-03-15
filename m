From: Paul Jakma <paul@clubi.ie>
Subject: Re: seperate commits for objects already updated in index?
Date: Wed, 15 Mar 2006 13:28:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603151312030.5276@sheen.jakma.org>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
 <Pine.LNX.4.64.0603140856120.3618@g5.osdl.org> <Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
 <Pine.LNX.4.64.0603140915290.3618@g5.osdl.org> <7vwtewk2jp.fsf@assigned-by-dhcp.cox.net>
 <7vy7zcie5c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 14:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJW5w-0006kH-3v
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 14:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCONam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 08:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWCONam
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 08:30:42 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:32912 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S932092AbWCONal
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 08:30:41 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX186tW4bKw+GnsaH0tH5SDQGn67zbHjOecs@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2FDSlJ6010775;
	Wed, 15 Mar 2006 13:29:00 GMT
X-X-Sender: paul@sheen.jakma.org
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7zcie5c.fsf@assigned-by-dhcp.cox.net>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17608>

On Tue, 14 Mar 2006, Junio C Hamano wrote:

<snip - interesting, thanks>

> It might be better to further check if the working tree file is the 
> same as the index, and to allow a commit in such a case.

That would be a nice improvement.

> The intent of rule #2 is to prevent this from happening:
>
> 	$ edit A B
>        $ git update-index A B
>        $ edit B again
>        $ git commit -o B

> When this happens, the real index will have _old_ contents of B 
> that never was committed, and does not match what is in the index. 
> But after the commit, we will match the real index to what was 
> committed, so we will _lose_ the index entry for B before the 
> second edit you explicitly told git to remember by saying 
> 'update-index'.

That would indeed be annoying, and I'd obviously prefer to have to 
run 'git reset' than have the above happen!

However, I'd have expected that any porcelain command would 
synchronise index with HEAD after a commit. See below for my (still 
newbie-ish ;) ) user-level mental model of git.

> On the other hand, in your original sequence:
>
> 	$ edit A B
>        $ git update-index A B
>        $ git commit -o B
>
> B being committed would be different between HEAD and index, but 
> that is what we are going to commit anyway, so after this commit, B 
> will be in sync with the updated HEAD.

Right. So if the file in the index and working tree are the same 
(hey, i just ran update-index after all), then that check could be 
loosened. The only thing the commit can do is bring the /3rd/ piece 
of the puzzle (HEAD) in sync :).

> To put it in another way, "commit -o" is a short-hand for people 
> who do not want to run update-index themselves (IOW, people who 
> just want to use git without worrying about the index file).  If 
> you use update-index to mark "this is what I want to commit" 
> yourself, you should do so consistently.  If you are not ready to 
> commit A but you want to commit B, do not mark both of them and 
> expect "commit -o" to do magic fixups.

I guess my problem here is that I consider the index to be a 'weak' 
cache.

I like to use it for intermediate way-points or "weak commits", 
however if I commit to HEAD I /really/ want what (I consider to be) 
the two /strong/ sources of file information (HEAD and working file) 
to be synchronised, and the 'weak' cache updated then to match.

I wasn't expecting the 'weak' cache of the index to prevent me 
synchronising my 'strong' sources (HEAD and working file). I was 
expecting the 'weak' cache to be updated to the 'strong' ones.

If I want to synchronise this 'weak' cache, I'll do so explicitely 
(though, there isn't a user-obvious distinction in commands for this, 
there's no obvious "git-commit-index"). Maybe part of the problem 
here is that git-commit tries to hide the index/working-tree/HEAD 
distinction? I don't know.

Anyway, if git-commit can lift "Rule 2" where file in working tree 
and index match, that'd be great - but I can easily live with 
git-reset till then. ;)

Thanks for the informative email!

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
A violent man will die a violent death.
 		-- Lao Tsu
