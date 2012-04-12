From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Thu, 12 Apr 2012 23:30:29 +0100
Message-ID: <4F875785.6040103@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <1421035.yALBSXSHGd@flomedio> <20120410171707.GA3869@burratino> <2104868.dCxFQtJHdU@flomedio>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020804000006040004090900"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SISXI-0005J9-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966129Ab2DLWaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 18:30:35 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:56415 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934122Ab2DLWae (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 18:30:34 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120412223031.XWG21612.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Thu, 12 Apr 2012 23:30:31 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120412223031.NOZE10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Thu, 12 Apr 2012 23:30:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <2104868.dCxFQtJHdU@flomedio>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=wVYgX4KXCLqryI94o4kA:9 a=wUYLoN3IvtFFUWipJnQA:7 a=wPNLvfGTeEIA:10 a=jOk0DZ8q_hChQtb2f9oA:9 a=49ladYHvHUoA:10 a=mpd-woop7mMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195380>

This is a multi-part message in MIME format.
--------------020804000006040004090900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/04/12 16:28, Florian Achleitner wrote:
> 
> I'm not sure if storing this in a seperate directory tree makes sense, mostly 
> looking at performance. All these files will only contain some bytes, I guess.
> Andrew, why did you choose JSON?
> 

JSON has become my default storage format in recent years, so it seemed
like the natural thing to use for a format I wanted to chuck in and get
on with my work :)

JSON is my default format because it's reasonably space-efficient,
human-readable, widely supported and can represent everything I care
about except recursive data structures (which I didn't need for this
job).  You can do cleverer things if you don't mind being
language-specific (e.g. Perl's "Storable" module supports recursive data
structures but can't be used with other languages) or if you don't mind
needing special tools (e.g. git's index is highly efficient but can't be
debugged with `less`).  I've found you won't go far wrong if you start
with JSON and pick something else when the requirements become more obvious.

I gzipped the file because JSON isn't *that* space-efficient, and
because very large repositories are likely to produce enough JSON that
people will notice.  I found that gzipping the file significantly
reduced its size without having too much effect on run time.

I've attached a sample file representing the first few commits from the
GNU R repository.  The problem I referred to obliquely before isn't with
JSON, but with gzip - how would you add more revisions to the end of the
file without gunzipping it, adding one line, then gzipping it again?
One very nice feature of a directory structure is that you could store
it in git and get all that stuff for free.

To be clear, I'm not pushing any particular solution to this problem,
just offering some anecdotal evidence.  I'm pretty sure that SVN branch
export is an I/O bound problem - David Barr has said much the same about
svn-fe, but I was surprised to see it was still the bottleneck with a
problem that stripped out almost all the data from the dump and pushed
it through not-particularly-optimised Perl.  Having said that, the
initial import problem (potentially hundreds of thousands of revisions
needing manual attention) doesn't necessarily want the same solution as
update (tens of revisions that can almost always be read automatically).

>>  . tracing history past branch creation events, using the now-saved
>>    copyfrom information.
>>
>>  . tracing second-parent history using svn:mergeinfo properties.
> 
> This is about detection when to create a git merge-commit, right?

Yes - SVN has always stored metadata about where a directory was copied
from (unlike git, which prefers to detect it automatically), and since
version 1.0.5, SVN has added "svn:mergeinfo" metadata to files and
directories specifying which revisions of which other files or
directories have been cherry-picked in to them.

If you know a directory is a branch, "copyfrom" metadata is a very
useful signal for detecting branches created from it.  Unfortunately,
"svn:mergeinfo" is not as useful - aside from anything else, older
repositories often exhibit a period where there's no metadata at all,
then a gradual migration through SVN's early experiments with merge
tracking (like svnmerge.py), before everyone gradually standardises on
svn:mergeinfo and leaves the other tools behind.  Oh, and the interface
doesn't tell you about unmerged revisions, so if anybody ever forgets to
merge a revision then you'll probably never notice.

I'm planning to tackle this stuff in the work I'm doing, but I expect
people will be reporting edge cases until the day the last SVN
repository shuts down.  You shouldn't need to worry about it much on the
git side of SBL, which is probably best for your sanity ;)

	- Andrew

--------------020804000006040004090900
Content-Type: application/x-gzip;
 name="repo.json.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="repo.json.gz"

H4sIAA1Jh08AA72TzW/bIBjG7/sr0HtJKzmJwR+1o2nSjrvstNtWVRRwjILBApw2m/K/j8Ry
NWeqY3VTb3y88P6e5wGWEVJmgi6zglfLOMHxsiQ5XXKcxwSXaVqk+MMvoJ2vjYUN3GiD+skt
RMCpF7DBmJCiTAjJV2ka4wiU2cJGd0pF0Ai7FVJX5kFJLRxs4gi04afR9/sIrNhLJ40ON8dw
vNaoTAnO8jwfWsBX8YSsaI2T3tgDklp6SZX8KTh6PCC2d8Tt9QqmMUJTzoOKCHZShwFwacOR
lvo6TB4t1awOhcdoutDT7Ywi2+kdHMfK8Vh5y18X/KVXiIbTP/RscZVU5xUIWOJ5VftGwf0L
Zb875lxfgpI3RPStlg4x0zTSoyfqUEN1V1HmOzsKCXmDmBXhDtQ7jhaWi71Qi/nxMdMeKmua
h5HZf6wHKWcV00mv+8aX4pOrKZFBs/PU+q69Gs64QTrfXfJ2d8MzRYsz4D84e2nVXx6nr3h8
+iTrc/dLe7Npe+9Kkg2iP3OOuHRMURnwZ3yB//D082m8IsmTAc8fWvM+UHfTUCUuiwGqks/o
o2g+oRuqOfLC+dPjMiFEtjOdv30f4CIA/waa4nnucgYAAA==
--------------020804000006040004090900--
