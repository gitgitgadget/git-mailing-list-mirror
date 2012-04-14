From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Sat, 14 Apr 2012 22:09:39 +0200
Message-ID: <1472353.TRfidGPc01@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <2104868.dCxFQtJHdU@flomedio> <4F875785.6040103@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 22:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ9Po-0000B7-82
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 22:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865Ab2DNURn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 16:17:43 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:25914 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab2DNURm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 16:17:42 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q3EKH8q2018515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2012 22:17:09 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <4F875785.6040103@pileofstuff.org>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195515>

Hi!

Thanks for your explainations.

On Thursday 12 April 2012 23:30:29 Andrew Sayers wrote:
> On 12/04/12 16:28, Florian Achleitner wrote:
> > I'm not sure if storing this in a seperate directory tree makes sense,
> > mostly looking at performance. All these files will only contain some
> > bytes, I guess. Andrew, why did you choose JSON?
> 
> JSON has become my default storage format in recent years, so it seemed
> like the natural thing to use for a format I wanted to chuck in and get
> on with my work :)
> 
> JSON is my default format because it's reasonably space-efficient,
> human-readable, widely supported and can represent everything I care
> about except recursive data structures (which I didn't need for this
> job).  You can do cleverer things if you don't mind being
> language-specific (e.g. Perl's "Storable" module supports recursive data
> structures but can't be used with other languages) or if you don't mind
> needing special tools (e.g. git's index is highly efficient but can't be
> debugged with `less`).  I've found you won't go far wrong if you start
> with JSON and pick something else when the requirements become more obvious.
> 
> I gzipped the file because JSON isn't *that* space-efficient, and
> because very large repositories are likely to produce enough JSON that
> people will notice.  I found that gzipping the file significantly
> reduced its size without having too much effect on run time.
> 
> I've attached a sample file representing the first few commits from the
> GNU R repository.  The problem I referred to obliquely before isn't with
> JSON, but with gzip - how would you add more revisions to the end of the
> file without gunzipping it, adding one line, then gzipping it again?
> One very nice feature of a directory structure is that you could store
> it in git and get all that stuff for free.
> 
> To be clear, I'm not pushing any particular solution to this problem,
> just offering some anecdotal evidence.  I'm pretty sure that SVN branch
> export is an I/O bound problem - David Barr has said much the same about
> svn-fe, but I was surprised to see it was still the bottleneck with a
> problem that stripped out almost all the data from the dump and pushed
> it through not-particularly-optimised Perl.  Having said that, the
> initial import problem (potentially hundreds of thousands of revisions
> needing manual attention) doesn't necessarily want the same solution as
> update (tens of revisions that can almost always be read automatically).

JSON seems to be a good initial choice..

> 
> >>  . tracing history past branch creation events, using the now-saved
> >>  
> >>    copyfrom information.
> >>  
> >>  . tracing second-parent history using svn:mergeinfo properties.
> > 
> > This is about detection when to create a git merge-commit, right?
> 
> Yes - SVN has always stored metadata about where a directory was copied
> from (unlike git, which prefers to detect it automatically), and since
> version 1.0.5, SVN has added "svn:mergeinfo" metadata to files and
> directories specifying which revisions of which other files or
> directories have been cherry-picked in to them.
> 
> If you know a directory is a branch, "copyfrom" metadata is a very
> useful signal for detecting branches created from it.  Unfortunately,
> "svn:mergeinfo" is not as useful - aside from anything else, older
> repositories often exhibit a period where there's no metadata at all,
> then a gradual migration through SVN's early experiments with merge
> tracking (like svnmerge.py), before everyone gradually standardises on
> svn:mergeinfo and leaves the other tools behind.  Oh, and the interface
> doesn't tell you about unmerged revisions, so if anybody ever forgets to
> merge a revision then you'll probably never notice.

This doesn't look very straight forward. In the svn docs they say there is a 
command that outputs which changesets are eligible to merge.
http://svnbook.red-
bean.com/en/1.7/svn.branchmerge.basicmerging.html#svn.branchmerge.basicmerging.mergeinfo

But I don't know if that helps.
>
> I'm planning to tackle this stuff in the work I'm doing, but I expect
> people will be reporting edge cases until the day the last SVN
> repository shuts down.  You shouldn't need to worry about it much on the
> git side of SBL, which is probably best for your sanity ;)

:)

> 
> 	- Andrew
