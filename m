X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 08:31:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
References: <200611211341.48862.andyparkins@gmail.com>
 <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
 <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 16:36:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31999>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYbm-0008MU-Cg for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031113AbWKUQet (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031092AbWKUQet
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:34:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58317 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031073AbWKUQer (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:34:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kALGVVix012109
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 21
 Nov 2006 08:31:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kALGVUa1030715; Tue, 21 Nov
 2006 08:31:31 -0800
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org



On Tue, 21 Nov 2006, Peter Baumann wrote:
> 
> Why not make --root the default? I also stumbled over this behaviour and
> even asked on this list.

I suspect we should make the thing a config option, and default it to 
"on".

I personally do _not_ want to see the root commit, because for the kernel, 
it's a honking huge import that does not make sense as a "diff". It's not 
really a diff against anything, after all - it's an import.

That's really the reason why git defaults to not showing the root diff at 
all: exactly because for the kernel, the initial commit was state that 
"just came to be", and I found it both illogical and annoying to see it as 
a diff, since that commit really was a "black hole" where previous history 
just disappeared.

But if you have the _full_ history with a new project, "--root" by default 
probably makes tons of sense.

> And one less "wart" to clean, which another thread is all about. :-)

I really don't think it's a wart - see above - but it depends on the 
project.

There's also another reason for the root being special, which is purely 
git-internal: the root really has no parents at all, and the normal "git 
diff" is "diff against parents". So from a purely implementation 
standpoint, the "root" case is actually a special case, and for a while I 
was kind of wondering whether I should do what a lot of other SCM's seem 
to do, namely start out with an "empty root" when doing "git init-db".

git didn't end up doing that (and I'm personally pretty happy about it), 
but it was one of the things I was kind of thinking about: a "git import" 
kind of thing would have created an initial commit which was pre-populated 
with the thing to import, and a "git init-db" would have created an 
initial root commit that was empty.

That would have made the current "don't show the root diff" behaviour very 
natural (and you'd still have gotten the initial diff for a new project), 
but on the other hand, it would have had that annoying unnecessary "init" 
commit, and you'd _still_ have wanted to have something like "--root" in 
order to show the import commit as a patch (which you _sometimes_ want to 
do).

So having a config option would solve the problem, but what annoys me 
right now about the config options is that we really should have a 
graphical front-end to setting those things or something, because while 
_I_ don't have any issues with editing a ".git/config" file, I think we're 
getting to the point where a lot of our problems are really about "you can 
do it, but you have to know a lot about git to even know you can do it".

