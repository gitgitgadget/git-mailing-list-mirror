From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [RFC] "Remote helper for Subversion" project
Date: Sun, 04 Mar 2012 13:36:41 +0000
Message-ID: <4F536FE9.1050000@pileofstuff.org>
References: <1330777646-28381-1-git-send-email-davidbarr@google.com>	<CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com>	<20120304075424.GI14725@burratino> <CAFfmPPPs0FRbT-i+ZwBLNSca330Eo7thjNxDt3hJf0yUATthtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 16:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4DUA-00079v-8m
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 16:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab2CDPf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 10:35:57 -0500
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:48205 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511Ab2CDPf4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 10:35:56 -0500
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120304133645.MATC14668.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sun, 4 Mar 2012 13:36:45 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120304133645.KFZA23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sun, 4 Mar 2012 13:36:45 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAFfmPPPs0FRbT-i+ZwBLNSca330Eo7thjNxDt3hJf0yUATthtQ@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=YrhZU85TnncA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=TSbVqHtbAAAA:8 a=NEAV23lmAAAA:8 a=-AnQz9JOAAAA:8 a=-xmi1OVxAAAA:8 a=eNcD7ojaAAAA:8 a=1U_43K6y99R-t97Ld1cA:9 a=-hlDDWHv_VOfI2XT5z4A:7 a=wPNLvfGTeEIA:10 a=UU5_C3s6GftthX9h:21 a=UdCLglNcVWrWSbcR:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192163>

Hi guys,

I made a few little git contributions a couple of years back, before
being swallowed up by my old job.  I've become quite interested in
svn->git translation since starting a new job, but I'm delurking earlier
than planned so please bear with me as all I have right now is an
interesting proof of concept and the possibility of some free time some
day.  If things go well, I hope to help out with the
branching-and-merging part of the problem, so I'll describe what I've
done and how it might affect SoC projects.  Apologies in advance for
hijacking the thread :)

I mentioned proof-of-concept code for the work I've done - I'd like to
get confirmation from my new employer before putting it all online, so
hopefully I can make it available in a few days.

While researching the problem, I found Stephen Bash's original
proposal[1] and snerp-vortex[2] quite inspiring, but wasn't able to find
any details on SoC-related work in the branching-and-merging department
- hopefully the following isn't just a retread of ideas developed since
then.  I've concentrated on importing from SVN so far, but have kept an
eye on update and half an eye on bi-direction in the hopes of being
useful there some day.

It seems to me the "svn export" and "git import" steps make most sense
as two unrelated projects.  Snerp-vortex and Stephen's scripts both cut
the history import problem at that point, as do svn-fe/git-fast-import
with code import.  Exporting SVN history is a messy and sometimes
project-specific job, so allowing a project to concentrate on that part
makes it possible for SVN experts to use all their skills without having
to learn git plumbing before they make their first commit (much respect
to Stephen for managing that feat BTW).


I've written a proof-of-concept history converter that can be split into
three parts: a format for describing SVN history; a large, often messy
Perl program that writes files in that format; and a small Perl program
that reads the format and translates it into git.  With hindsight, Perl
is the right language for the SVN exporter, but the git importer would
have been better written in C.


Personally, I think SVN export will always need a strong manual
component to get the best results, so I've put quite a bit of work into
designing a good SVN history format.  Like git-fast-import, it's an
ASCII format designed both for human and machine consumption:

In r1, create branch "trunk"
In r10, create branch "branches/foo" as "foo" from "trunk" r9
In r12, create tag "tags/version1" as "version1" from "trunk" r11
In r12, deactivate "tags/version1"
# blank lines and lines beginning with a '#' are ignored
In r15, merge "branches/foo" r14 into "trunk"
In r15, delete "branches/foo"

The above has been designed as an abstract representation of SVN
history, with as little git-specific content as possible.  This turns
out to make the problem a bit easier to think about, a bit easier to
implement, and potentially useful to other DVCSs some day.  I wanted to
enable svn-merge2git[3]-style extraction of merge info from logs, but
found that even a message as clear as "merge r123 from trunk" could mean
"cherry-pick revision 123", "merge everything up to revision 123",
"merge everything up to the last revision that touched trunk before
123", "merge everything up to 132", or any number of other things.  As
such, the format is designed to allow copious comments and ease of
bulk-editing with regexps and a powerful editor.

The format feels relatively complete to me, and in any case not a good
candidate for an SoC project because it's all about experience and
nothing to do with raw talent.


Once the format is defined, git import is fairly straightforward.
Proof-of-concept code to follow, but it's really just a wrapper around
git-commit-tree, git-mktag etc.  I wrote this in Perl thinking it would
relate somehow to git-svn, but eventually realised it didn't and that a
few hundred calls to (plumbing) processes per second isn't so good for
performance.  The only interesting part of the problem is how to tackle
SVN tags.  I went for an ambitious approach, making normal tags where
possible and downgrading them to lightweight tags when necessary.  This
does involve managing something that is effectively a branch in
refs/tags/, but what else is an SVN tag but a branch in the wrong namespace?

I'm afraid I don't know enough about SoC to say whether rewriting git
import in C would make a good project - on the one hand, it's a smallish
bit of work that would make a student learn a lot of good git code, on
the other hand it would mostly just involve fixing up a bit of ugly Perl
with little chance to show any creativity.


SVN export is much more complicated, and has taken most of my time.
Although there's no way to tell automatically which directories are
branches, I realised you can detect trunks automatically about 90% of
the time by looking for where files/directories are first created, and
can detect non-trunk branches at least 99% of the time once you know the
trunks.  Trunk detection is normally just a convenience, but can be a
lifesaver when importing from a sufficiently messy repository.  There's
a lot you can do with merge detection, but between svn:mergeinfo,
svnmerge.py[4], svk[5] and log messages I realise I've only scratched
the surface.  In many ways, this is a classic Perl problem - take a
bunch of messy textual input, string it all together and make some neat
textual output.  The code I've got right now seems fine for anything up
to about 20,000 commits, but eats way too much memory for huge repos.
Depending on how much time I get, I might have tackled that problem by
the time I put this code online.

Assuming I have enough time to work on SVN export, I would be loathed to
put it on anyone else in the near future.  I could see endless
optimisations being spun off once the code is mature, but right now it's
an idiosyncratic collection of untested mostly-working bits that need
serious attention before I'd be happy warping a young mind on it.


I hope this information dump explains where I am and how I can help.  As
I say, I can't yet promise how much (if any) time I'll get to work on
this in future, but I hope to help with the history translation process
if circumstances allow.  More importantly to this thread, I hope this
gives some ideas about SoC projects and places (not) to put attention.

	- Andrew Sayers

[1] http://comments.gmane.org/gmane.comp.version-control.git/158940
[2] https://github.com/rcaputo/snerp-vortex
[3] http://repo.or.cz/w/svn-merge2git.git
[4] http://www.orcaware.com/svn/wiki/Svnmerge.py
[5] http://search.cpan.org/dist/SVK/
