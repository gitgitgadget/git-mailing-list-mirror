X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 16:33:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011621380.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612012355.03493.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org> <200612020114.42858.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 00:35:23 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612020114.42858.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32996>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqIpt-0006kJ-9D for gcvg-git@gmane.org; Sat, 02 Dec
 2006 01:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162306AbWLBAeL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 19:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162388AbWLBAeL
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 19:34:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:2272 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162306AbWLBAeJ (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 19:34:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB20XrjQ020322
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 16:33:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB20Xqt8001395; Fri, 1 Dec
 2006 16:33:52 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Josef Weidendorfer wrote:
> > 
> > The current commit within the supermodule would be _totally_ invisible to 
> > the submodule.
> 
> Of course.
> 
> Yet, you need some name to store meta information of submodules
> into some config file of the supermodule, like whether you want to have
> it checked out (see below).

Yes, you do need to have a list of submodules somewhere, and you'd need to 
maintain that separately. One of the results of having the submodules be 
independent from the supermodule is that it's not all "automatically 
integrated", and thus the supermodule does end up having to have things 
like that maintained separately. 

And yes, if you screw that up, you wouldn't be able to fetch submodules 
properly etc, even if you see the supermodule, and yes, this sounds more 
like the CVS "Entries" kind of file that is more "tacked on" than really 
deeply integrated. But I think the separation is _more_ than worth the 
fact that you can see things being separate.

In fact, I'm very much arguing for keeping things as separate as possible, 
while just integrating to the smallest possible degree (just _barely_ 
enough that you can do things like "git clone" and it will fetch multiple 
repositories and put them all in the right places, and "git diff" and 
friends will do reasonably sane things).

Keep it simple, stupid. 

> >  - "git clone" by default will fetch and check out all submodules (and 
> >    obviously they have to be described some way outside of the object 
> >    database, just so that you don't have to parse the _whole_ history of 
> >    the _whole_ supermodule just to find all possible submodules. So the 
> >    supermodule _will_ need some "list of submodules and where to get them" 
> >    in a config file or other).
> 
> Exactly. And in this list, you have to specify names.

Yes. 

> The thing I wanted to discuss is whether such names would need to be globally
> unique in the project containing submodles, or not.

My preference would be for it to be "local", just because (as I 
mentioned), with mirroring etc, it might well be that you want to fetch 
things from the _closest_ repository. That's really not a global decision, 
it's a local one.

> If yes, it IMHO makes a lot of sense to introduce "submodule objects" which contain
> these submodule names, and which are used as pointers to submodule commits in
> supermodule trees.

You could do it that way, and then it would be global. It would work, and 
in many ways it would probably be "simpler" on a supermodule level.

The advantage of a global namespace is that you can much more easily 
update it - "git fetch" will just fetch the new file(s) that describe the 
subprojects very naturally if they are all global. Putting them in a local 
.git/config file has it's advantages (see above), but it also makes it 
very hard to version them, and to update the list - it would have to 
become manual.

There are possibly combinations of the two approaches: have a "global 
namespace" that describes the canonical place to get the subprojects, but 
have some way to add local "translation" of the canonical names into 
locally preferred versions (eg you could just have a way to say "this is 
the local mirror for that global canonical place")

Maybe that would work?

