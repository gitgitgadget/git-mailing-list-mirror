From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected
 transfer.
Date: Thu, 15 Feb 2007 01:07:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 01:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHUAt-0001Ct-Iq
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 01:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbXBOAHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 19:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbXBOAHx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 19:07:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:58024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932256AbXBOAHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 19:07:25 -0500
Received: (qmail invoked by alias); 15 Feb 2007 00:07:23 -0000
X-Provags-ID: V01U2FsdGVkX18RL598lpkRI02ltdre+WnZxAm9SOlYUxkeweKWKT
	rlVA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D398F9.6070205@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39777>

Hi,

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > This is not necessary. You should do this instead:
> > 
> > 	. git-sh-setup
> >   
> I debated that, it seemed a wash but can do.

It makes things easier, doesn't it?

> > Throughout git, we seem to do both "--output=<bla>" _and_ "--output <bla>"
> > forms, or just the latter.
> >   
> Patches gratefully accepted for that. This exceeds my skills in bash: I can
> do that in python, C, or other languages, but in bash I am working through a
> list that is a part of $* an arg at a time with no ability to look at the
> next, which is what this needs. Unless of course bash arrays are part of
> portable shell (not sure on that).

Ah, I just realized that you do not shift. This is wrong. For example,

	git bundle --output=a1 a..b

would pass "--output=a1 a..b" to git-rev-parse. While you say 
"--revs-only", this would work, but so would "these are no refs". You lose 
valuable information that way (namely invalid parameters). The standard 
shell way is nicely visible in git-tag.sh (see the while loop). It is 
basically

while case "$#" in 0) break ;; esac
do
	case "$1" in
	--output)
		# handle $1 (and check that you can write to it).
		;;
	-*)
		usage
		;;
	*)
		break
	esac
done

> > > +git-show-ref $refs > .gitBundleReferences
> > >     
> > 
> > Would it not be better to say explicitely which refs are expected to be
> > present already (they start with "^" in the output of `git-rev-parse`, but
> > you would need to do a bit more work, since you cannot just take the
> > symbolic names).
> > 
> > Some general remarks:
> > 
> > It would be so much nicer if you worked without temporary files (you 
> > could do that by starting the file with the refs, then have an empty 
> > line, and then just pipe the pack after that).
> >   
> Originally, this was in python with zip file built in memory (no 
> temporaries). Sticking to portable shell makes many easy things really 
> hard.

Not if you just pipe the two parts (refs & pack) into the output. Piping 
also allows for "--output -" meaning stdout...

> > IMHO reliance on $(git fsck | grep ^missing) is not good. The file 
> > check might take very, very long, or use much memory. And you _can_ do 
> > better [*1*].
>   
> Good idea, but I think it is simpler to just keep the ^... output from
> git-rev-parse and check that those exist. What you suggest below seems to
> presume all bases are themselves references, which is not the case when
> doing, for example, master~10..master.

Not at all. I meant to verify that these _hashes_ exist as commits. Not 
necessarily refs.

> > Also, your use of shallow is incorrect. If the boundary commits are 
> > present, you might just leave them as-are, but if they are not 
> > present, you have to mark them as shallow. Otherwise, you end up with 
> > a corrupt (not shallow) repository.
> >   
> I have to say I do not understand what "mark them as shallow" means: can 
> you please enlighten me further?

We have shallow clones. This means that you can mark commits as "fake 
root" commits, i.e. even if they have parents, they are treated as if they 
had no parents. You do this by adding the hashes of the shallow commits to 
.git/shallow. For a short description, search for "shallow" in 
Documentation/glossary.txt.

Ciao,
Dscho
