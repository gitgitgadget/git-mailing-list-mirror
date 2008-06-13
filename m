From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sat, 14 Jun 2008 01:33:03 +0200
Message-ID: <485303AF.2080207@jaeger.mine.nu>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>  <20080611213648.GA13362@glandium.org>  <alpine.DEB.1.00.0806112242370.1783@racer>  <20080611230344.GD19474@sigill.intra.peff.net>  <alpine.LFD.1.10.0806111918300.23110@xanadu.home>  <loom.20080612T042942-698@post.gmane.org>  <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>  <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>  <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com>  <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Eric Raible <raible@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:41:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ItV-0003jX-8o
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 01:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417AbYFMXjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 19:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756390AbYFMXjv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 19:39:51 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:58148 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756341AbYFMXju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 19:39:50 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jun 2008 19:39:49 EDT
Received: (qmail 26790 invoked from network); 13 Jun 2008 23:33:06 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 13 Jun 2008 23:33:06 -0000
Received: (qmail 31582 invoked from network); 13 Jun 2008 23:33:04 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 13 Jun 2008 23:33:04 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <alpine.DEB.1.00.0806132239490.6439@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84954>

Johannes Schindelin wrote:
> You cannot be serious about not wanting to lose the changes when you keep 
> them in _one_ _single_ repository anyway.
>
> And you cannot be serious about not wanting to lose the changes when you 
> forget about them, for months, even.
>
> So you are making my point for me.
>   

Maybe I should describe my way of using Git?:

- I'm (amongst other things) using Git for keeping my own codebase for 
server maintenance scripts etc, which I then casually replicate between 
my servers through Git's networking and merging mechanisms. When I need 
a new feature, I'm coding it on the particular server where I need it 
and commit it there (I'm even using separate email adresses on every 
server so that I can track back on which server I wrote a particular 
feature).

- every now and then, I'm being interrupted when I'm coding something 
(and will not be able to continue on it for days, weeks or months); when 
I return to the repo for something completely different, there's an 
uncommitted file or two or more (all of which might not even work), and 
before there was git-stash I would sometimes just let those stay around 
uncommitted in the working tree; this was a bit of a hassle since I 
could for example not use "git commit -a", would IIRC have problems 
merging changes coming from another repo into those files, and once more 
than one case of unfinished work accumulated, I could no longer tell 
what belonged together; I didn't want it to commit to branches because 
that didn't seem like a good fit to me (more on that below). Then when 
git-stash came around, I first thought, "what's *that*, Git has branches 
already?", but then I realized that it would be a perfect fit for 
handling those unfinished uncommitted things.
   So note that my use case is putting away work which was not finished 
(and usually by accident, i.e. I didn't have the time to choose a 
sensible interruption point and think of a commit message--I'll actually 
usually run "git stash save" not upon interruption, but later when I 
want to do other operations in the same repo), to hopefully be picked up 
again some (maybe long) time later. (I guess the use case it was 
designed for was putting temporarily away intermediate stages of 
conflicting merges and such stuff, i.e. for working as maintainer and 
not coder?)

- I do backups of the servers. So I don't expect loosing my work even if 
it's only being stored on one server.

- But I was not aware of the expiry policy (missing clarity in the man 
page). So I think I may actually *have* lost some such work already. 
Probably not a big deal, but a bit of a nuisance nonetheless (I wouldn't 
continue using git-stash(*)).

You said in a previous mail "If you need something from the stash a day 
after stashing it, you have a
serious problem with understanding what branches are for." I've now 
spent a bit of thinking about how to use branches easily for that; 
should git stash keep the expiry behaviour, I'll need an easy way of 
dealing with those uncommitted things; basically git stash onto a 
branch. Since I want it to use a default commit message, and when 
applying it I want the WIP commit undone, I basically want all of the 
same functionality but using a branch as storage instead. Now, what 
would be the name of the branch? (Is this calling for discussion of 
hierarchical branch namespaces?). It would need to be such that it 
wouldn't accidentally interfere with WIP branches on other servers--it's 
two different works in progress, so using the same branch name would be 
wrong, unless the source prefix ("origin/" etc.) separates names well 
enough to not lead to accidents (I don't have enough experience in this 
area; when I'm on branch foo, would "git pull" merge another server's 
foo branch into the current wip branch? etc.).

((*)BTW regarding the comment from Jeff King about the comparison with 
vim's yank buffer and "bounding by time rather than by number of 
stashes": yes, why not bound the number of stashes instead? That would 
also work like history in bash or other tools which limit it by number 
of entries. But I guess the "preference for forgetting" is different for 
everyone. Anyway, in my above use case I'm not sure I want the machine 
make things forgotten for me; would it reduce my work by just not 
reminding me of undone work? Should I let HAL (a fictional intelligent 
computer) decide that I've got too much to do and he should decide I 
should forget about a few things every now and then? I don't have data 
at hand whether that would work and be beneficial for me; it tends to 
upset me when I cannot find info again I know has been somewhere--HAL 
can't really tell what *I* will forget, after all; I'll just feel like a 
looser when it happens. Would another analogy be: shouldn't Git drop 
history entries after, say, three years, since nobody should care about 
old stuff anymore by then?)

Maybe, if the list of stashes really grows unbounded for some people, 
there should be a tool to display stashes in the tree, instead of only 
listing them in linear form? i.e. gitk would show the stashes kind of 
like branches; of course there's also a linear list of branches--so 
maybe stashes *should* be branches but in a different namespace (a 
sub-local namespace), hence my thought above about hierarchical 
namespaces. To sum it all up: using branches makes sense to me, but the 
features that "git stash" offers (separated 'namespace' from normal 
branches, and the automatic "git reset HEAD^" for removing the WIP 
commit) are missing there yet.

Christian.
