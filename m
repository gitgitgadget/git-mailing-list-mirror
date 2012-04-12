From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Thu, 12 Apr 2012 17:28:03 +0200
Message-ID: <2104868.dCxFQtJHdU@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <1421035.yALBSXSHGd@flomedio> <20120410171707.GA3869@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SILwn-0007tS-2j
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454Ab2DLP22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:28:28 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:53546 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965273Ab2DLP20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:28:26 -0400
Received: from flomedio.localnet (93-82-159-250.adsl.highway.telekom.at [93.82.159.250])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id q3CFS2Su007261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Apr 2012 17:28:02 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20120410171707.GA3869@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195335>

Hi!

Let's discuss the details as suggested by Jonathan! I will collect them in the 
wiki, leading to a more elaborated project plan at the end.
It's rather hard to keep an overview over all the issues and pitfalls that may 
exist, and over all the existing discussions, and whether there was an 
solution or the issue is still unsolved.
So I want to create some collection of information with your support.

On Tuesday 10 April 2012 12:17:07 Jonathan Nieder wrote:
> Given the goal described here of an import with support for
> automatically detecting branches, here are some rough steps I imagine
> would be involved:
> 
>  . baseline: remote helper in C
> 
>  . option to import starting with a particular numbered revision.
>    This would be good practice for seeing how options passed to
>    "git clone -c" can be read from the config file.

Really -c? My installed git doesn't have that switch. Should it pass arguments 
to the remote-helper?

> 
>  . option or URL schema to import a single project from a large
>    Subversion repository that houses several projects.  This would
>    already be useful in practice since importing the entire Apache
>    Software Foundation repository takes a while which is a waste
>    when one only wants the history of the Subversion project.
> 
>    How should the importer handle Subversion copy commands that
>    refer to other projects in this case?

Jonathan tried that, it's handled by svnrdump nicely.

> 
>  . automatically detecting trunk when importing a project with the
>    standard layout.  The trunk usually is not branched from elsewhere
>    so this does not require copyfrom info.  Some design questions
>    come up here: should the remote helper import the entire project
>    tree, too?  (I think "yes", since copy commands that copy from
>    other branches are very common and that would ensure the relevant
>    info is available to git.)  What should the mapping of git commit
>    names to Subversion revision numbers that is stored in notes say
>    in this case?

What does it mean, "import the entire project tree"? Importing other 
directories than "trunk"?
About the mapping of git commits to svn refs .. I've seen the thread about the 
marks-to-notes converter.
But can somebody please explain what it's for? There is this mark file 
mentioned in the git-fast-import help page ..

Do we create two commits from one revision if it's some special case, like 
modifying two branches at once?

> 
>  . detecting trunk and branches and exposing them as different remote
>    branches.  This is a small step that just involves understanding
>    how remote helpers expose branches.
> 
>  . storing path properties and copyfrom information in the commits
>    produced by the vcs-svn/ library.  How should these be stored?
>    For example, there could be a parallel directory structure
>    in the tree:
> 
>         foo/
>                 bar.c
>         baz/
>                 qux.c
>         .properties/
>                 foo.properties
>                 foo/
>                         bar.c.properties
>                 baz/
>                         qux.c.properties
> 
>    with properites for <path> stored at .properties/<path>.properties.
>    This strawman scheme doesn't work if the repository being imported
>    has any paths ending with ".properties", though.  Ideas?

This includes collecting which metadata we actually need to store? We could 
probably collect a list of important svn properties.

Is there a general policy how to store additional metadata for git's helpers? 
I guess it would live somewhere in the .git dir. (.git/info/ ?)
Dmitry mentioned the case where a git repository that fetched from svn is 
cloned, and the cloned repo should be able to fetch from svn too. Is there an 
exisiting concept about metadata in this case?

I'm not sure if storing this in a seperate directory tree makes sense, mostly 
looking at performance. All these files will only contain some bytes, I guess.
Andrew, why did you choose JSON?

> 
>  . tracing history past branch creation events, using the now-saved
>    copyfrom information.
> 
>  . tracing second-parent history using svn:mergeinfo properties.

This is about detection when to create a git merge-commit, right?

> 
> In other words, in the above list the strategy is:

.. still to come..

Florian
