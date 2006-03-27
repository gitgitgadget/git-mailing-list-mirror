From: Paul Jakma <paul@clubi.ie>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 07:00:45 +0100 (IST)
Message-ID: <Pine.LNX.4.64.0603270642090.5276@sheen.jakma.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e05354$cc9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 08:01:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNkn3-0002Yy-Vd
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 08:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWC0GBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 01:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWC0GBS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 01:01:18 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:24714 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1750731AbWC0GBR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 01:01:17 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1+AbGimPNZpykXEDWw3jJdw0xPhONkQ1Qo@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.6/8.13.1) with ESMTP id k2R60jTl010540;
	Mon, 27 Mar 2006 07:00:58 +0100
X-X-Sender: paul@sheen.jakma.org
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e05354$cc9$1@sea.gmane.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18072>

On Sun, 26 Mar 2006, Jakub Narebski wrote:

> I think one of the better ideas/suggestions about *recording* filenames was
> in the "impure renames / history tracking" thread
> http://marc.theaimsgroup.com/?l=git&m=114122175216489&w=2
> <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>

For the record, the responses I received were educational ;). 
Sufficiently so I no longer think renames should be recorded. At 
least, definitely not as renames.

I now grok the reasoning for doing it by 'similarity' - it is indeed 
a *much* more useful concept. (E.g. the 'pickaxe' idea people keep 
alluding though sounds amazingly useful).

So the question really is what, if any, weaknesses does the current 
similarity estimation have, and how to solve them. I can think of two 
weaknesses:

1. the similarity algorithms can be expensive potentially, and they
    essentially get run a lot with the same inputs, to produce the
    same results - over and over as one works with a git repo. (there
    was a thread a while ago on this I think).

2. Some 'similarities' are just not deducible by current software
    state of the art. E.g. where some code is rewritten in another
    language:

 	foo.X -> foo.Y

    The high-level algorithms may remain the exact same, but the code
    may be unrecognisable as similar except to a human. However,
    tracking history back across this rewrite probably would still be
    valuable to the human.

So I think what /might/ be interesting is to have a 'similarity 
cache', which would help 1, and to allow for manual injection of such 
hints (into a seperate and stronger cache most likely) - which would 
help 2.

Something to record the following information:

(tree1,tree2)[1]:
 	Id1 <-> Id1'
 	.
 	.
 	.
 	Idn <-> Idn'

That would allow:

1. Performance repercussions of similarity estimation to be one-time,
    cached there-after. (throw-away information, if a better
    similarity estimation heuristic comes along, you can rebuild this
    cache)

2. The user to inject their own 'hints' into similarity estimation,
    particularly for cases that just aren't obvious and probably never
    will be to software estimators (e.g. the rewrite cases), but where
    the user sees value in being able to follow back the history.

Avoids:

- encoding anything permanently into the repository (which was
   something I was thinking of, and others before me apparently, but
   which I now accept would be an awful idea ;) ).

1. I'm not sure if it should be indexed by (commit ID) or
    (tree1,tree2) tuple. ??

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Men take only their needs into consideration -- never their abilities.
 		-- Napoleon Bonaparte
