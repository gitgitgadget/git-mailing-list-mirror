From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC remote-svn
Date: Mon, 23 Jul 2012 11:42:17 +0200
Message-ID: <2948040.5ceLh0WG3L@flomedio>
References: <4514544.Xip1OCQ7Uj@flomedio> <20120722214333.GB680@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:28:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StFsb-0006Ry-LI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 12:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab2GWK2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 06:28:39 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:38552 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab2GWK2i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 06:28:38 -0400
X-Greylist: delayed 2766 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2012 06:28:37 EDT
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q6N9gILQ002681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 11:42:18 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120722214333.GB680@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201927>

On Sunday 22 July 2012 16:43:33 Jonathan Nieder wrote:
> Hi,
> 
> Florian Achleitner wrote:
> > After several mailing iterations, showing me that I was wrong, I found
> > what
> > the right point is, namely that the remote helper writes references to a
> > really private dir in refs/<remote name>/, it doesn't touch anything else,
> > and by advertising the 'refspec' capability, git-fetch knows where the
> > private refs are and updates non-private references according to the
> > fetch refspec in some post-processing in store_updated_refs.
> 
> Right, that's fine.  And you did a fine job of navigating the existing
> documentation (which could be improved, hint hint).
> 
> What I am more concerned about is that you had code you sent a while
> ago for review, that this would have been obvious to David, Ram,
> Dmitry, or me if we had seen it, and yet none of us gave you that
> help.  We are failing at _our_ job of giving you prompt advice and
> instead you have had to work on your own.
> 
> Isn't it likely that there are multiple other bugs like that which
> still haven't been fixed?
> 
> That's why I think we need to get into a habit of giving and getting
> feedback quickly and incrementally improving work.  Soon, before the
> summer ends.
> 
> [...]
> 
> >> [23:01:10] <jrnieder> and it should not be named remote-svn, since we
> > 
> > haven't pinned down details about the svn:: conversion yet.  That's why
> > Dmitry's was called git-remote-svn-alpha)
> > 
> > Ok. Why is that important? I think if it's not called remote-svn git
> > doesn't fid it as a helper for the 'svn' protocol.
> 
> It finds it as a helper for the 'svn-alpha' protocol instead.
> 
> The point is that when I perform the following steps:
> 
> 	git clone svn://path/to/remote/repo
> 
> 	... wait a day, update git
> 
> 	cd repo
> 	git pull
> 
> nobody would expect the result to be a non-fast-forward update caused
> by the details of svn-to-git conversion changing.  Using a name like
> testsvn or svn-alpha would help in managing expectations --- the
> remote helper is meant for experimentation for now and not meant to be
> something people can rely on for collaboration.

Ok, that makes sense. Renaming is easily done!

> 
> > I wrote a small simulation script in python that mimics svnrdumps
> > behaviour by replaying an existing svn dump file from a start rev up to
> > an end rev to test incremental imports. I use it together with a little
> > testrepo shell script. Will need to bring that into t/ later, after
> > figuring out how the test framework works. As it's not finished it's not
> > published.
> 
> Sounds neat --- how can one try it out?

I'll send a patch ...

> 
> > Incremental import:
> > By reading the latest svn revision number from a note attached to the
> > private master ref, it starts future imports from the next svn revision.
> > That basically works well.
> > It doesn't reuse mark files. What's the point of reusing them? Dmitry's
> > svn- alpha did that.
> > All I need to know is the revision to start from and the branch i want to
> > add commits to, right? It now simply reads that from the note.
> 
> The marks are used to handle copyfrom operations referring to older
> revisions.  Are you sure you want to abandon them?  Can you explain a
> little more about your plan?

Ok, that makes sense. I didn't need the marks for incremental import. But to 
evaluate the copyfrom props we need some revision->sha1 mapping.
I just added the options to save and import marks to fast-import's command 
line. 
If the file is missing, it will need to be generated from the notes, or the 
whole history will be reimported.

But when I fetch from a git repo that imported from svn, the notes are not 
fetched automatically. In this case I currently loose marks and notes.
What can I do?

Florian
