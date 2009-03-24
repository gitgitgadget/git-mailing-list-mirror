From: Andreas Ericsson <ae@op5.se>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 09:59:46 +0100
Message-ID: <49C8A102.6090408@op5.se>
References: <49C7FAB3.7080301@brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2W5-000613-KL
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758199AbZCXI7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755741AbZCXI7y
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:59:54 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:3612 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757353AbZCXI7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:59:51 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Tue, 24 Mar 2009 01:58:10 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Tue, 24 Mar 2009 01:58:08 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49C7FAB3.7080301@brainfood.com>
X-OriginalArrivalTime: 24 Mar 2009 08:58:10.0471 (UTC) FILETIME=[A8259B70:01C9AC5E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114432>

Adam Heath wrote:
> We maintain a website in git.  This website has a bunch of backend
> server code, and a bunch of data files.  Alot of these files are full
> videos.
> 

First of all, I'm going to hint that you would be far better off
keeping the media files in a separate repository, linked in as a
submodule in git and with tweaked configuration settings with the
specific aim of handling huge files.

The basis of such a repository is probably the following config
settings, since media files very rarely compress enough to be
worth the effort, and their own compressed formats make them
very unsuitable delta candidates:
[pack]
   # disable delta-based packing
   depth = 1
   # disable compression
   compression = 0

[gc]
   # don't auto-pack, ever
   auto = 0
   # never automatically consolidate un-.keep'd packs
   autopacklimit = 0

You will have to manually repack this repository from time to
time, and it's almost certainly a good idea to mark the
resulting packs with .keep to avoid copying tons of data.
When packs are being created, objects can be copied from
existing packs, and send-pack will make use of that so that what
goes over the wire will simply be copied from the existing packs.

YMMV. If you do come up with settings that work fine for huge
repos made up of mostly media files, please share your findings.

> We use git, so that the distributed nature of website development can
> be supported.  Quite often, you'll have a production server, with
> online changes occurring(we support in-browser editting of content), a
> preview server, where large-scale code changes can be previewed, then
> a development server, one per programmer(or more).
> 
> Last friday, I was doing a checkin on the production server, and found
> 1.6G of new files.  git was quite able at committing that.  However,
> pushing was problematic.  I was pushing over ssh; so, a new ssh
> connection was open to the preview server.  After doing so, git tried
> to create a new pack file.  This took *ages*, and the ssh connection
> died.  So did git, when it finally got done with the new pack, and
> discovered the ssh connection was gone.
> 
> So, to work around that, I ran git gc.  When done, I discovered that
> git repacked the *entire* repository.  While not something I care for,
> I can understand that, and live with it.  It just took *hours* to do so.
> 

I'm not sure what, if any, magic "git gc" applies before spawning
"git repack", but running "git repack" directly would almost certainly
have produced an incremental pack. Perhaps we need to make gc less
magic.

> Then, what really annoys me, is that when I finally did the push, it
> tried sending the single 27G pack file, when the remote already had
> 25G of the repository in several different packs(the site was an
> hg->git conversion).  This part is just unacceptable.
> 

Agreed. I've never run across that problem, so I can only assume it
has something to do with many huge files being in the pack.

> So, here are my questions/observations:
> 
> 1: Handle the case of the ssh connection dying during git push(seems
> simple).
> 

Not necessarily all that simple (we do not want to touch the ssh
password if we can possibly avoid it, but the user shouldn't have
to type it more than once), but certainly doable. Easier would
probably be to recommend adding the proper SSH config variables,
as has been stated elsewhere.

> 2: Is there an option to tell git to *not* be so thorough when trying
> to find similiar files.  videos/doc/pdf/etc aren't always very
> deltafiable, so I'd be happy to just do full content compares.
> 

See above. I *think* you can also do this with git-attributes, but
I'm not sure. However, keeping the large media files in a sub-module
would nicely solve that problem anyway, and is probably a good idea
even with git-attributes support for pack delta- and compression
settings.

> 3: delta packs seem to be poorly done.  it seems that if one repo gets
> repacked completely, that the entire new pack gets sent, when the
> target has most of the objects already.
> 

This is certainly not the case for most repositories. I believe there's
something being triggered from repositories with many huge files though.

> 4: Are there any config options I can set to help in this?  There are
> tons of options, and some documentation as to what each one does, but
> no recommended practices type doc, that describes what should be done
> for different kinds of workflows.
> 

http://www.thousandparsec.net/~tim/media+git.pdf probably holds all the
relevant information when it comes to storing large media files with
git. I have not checked and have no inclination to do so.

> ps: Thank you for your time.  I hope that someone has answers for me.
> 

Answers aplenty, I hope. I have neither time nor interest in developing
this though, so the task of creating patches and/or documentation will
have to fall to someone else.

> pps: I'm not subscribed, please cc me.  If I need to be subscribed,
> I'll do so, if told.

Subscribing won't be necessary. The custom on git@vger is to always Cc
all who participate in the discussion, and only cull those who state
they're no longer interested in the topic.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
