X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 14:32:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612031421030.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <200612012355.03493.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org> <20061130170625.GH18810@admingilde.org>
 <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
 <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
 <20061203221630.GA940MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 22:32:50 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>, sf <sf@b-i-t.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061203221630.GA940MdfPADPa@greensroom.kotnet.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33146>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqzt7-0006DA-Hz for gcvg-git@gmane.org; Sun, 03 Dec
 2006 23:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759918AbWLCWcm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 17:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759919AbWLCWcm
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 17:32:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35753 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1759918AbWLCWcl (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 17:32:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3MW3jQ005931
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 14:32:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3MW2bg031577; Sun, 3 Dec
 2006 14:32:03 -0800
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Sven Verdoolaege wrote:
> 
> On Fri, Dec 01, 2006 at 03:30:32PM -0800, Linus Torvalds wrote:
> > The only thing that a submodule must NOT be allowed to do on its own is 
> > pruning (and it's distant cousin "git repack -d").
> 
> How are you going to enforce this if the submodule isn't supposed
> to know that it is being used as a submodule ?

Note that there's actually two "submodules":

 - there's the submodule "project" itself.

   This one must be totally unaware of the supermodule, because this one 
   might be cloned and copied _independently_ of the supermodule.

 - there's the PARTICULAR CHECKED-OUT COPY of the submodule that is 
   actually checked out in a supermodule.

   This is just a specific _instance_ of the particular submodule.

So a particular instance of a submodule might be "aware" of the fact that 
it's a submodule of a supermodule. For example, the "awareness" migth be 
as simple as just a magic flag file inside it's .git/ directory. And that 
awareness would be what simply disabled pruning or "repack -d" within that 
particular instance.

But this magic flag doesn't affect the bigger-picture git repository. It's 
a _private_ flag. So it doesn't affect the git part, any more than it 
really affects the git repository that you may have a

	[user]
		name = Myname
		email = myemail

in your .git/config file.

See? You can have private data in a git repository, but that doesn't mean 
that it's visible as _repository_ data. But it can still affect how git 
commands act (eg the "user" definitions above will affect the default user 
information that "git commit" uses, of course, without actually affecting 
the git archive in any other way)

> How is one of the supermodules going to know what references from other
> supermodules containing the submodule point into the submodule ?

Why would it care? They are other supermodules. It doesn't matter, the 
same way it doesn't matter that _my_ "git" tree may not have all the same 
references that _your_ "git" repo has. If I want to get the same 
references, I'd need to fetch them from you, and at that point, I'd need 
to get all the objects that are pointed to by those refs too. But only on 
"git fetch" do you actually start caring.

