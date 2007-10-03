From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: git-cvsserver commit trouble (unexpected end of file in client)
Date: Wed, 3 Oct 2007 15:13:44 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710031513.44446.wielemak@science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 15:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id48Y-0004l9-7t
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 15:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbXJCNT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 09:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbXJCNT2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 09:19:28 -0400
Received: from imap.science.uva.nl ([146.50.4.51]:54783 "EHLO
	imap.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbXJCNT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 09:19:27 -0400
Received: from gollem.science.uva.nl [146.50.26.20]
          by imap.science.uva.nl with ESMTP (sendmail 8.13.8/config 11.38).
          id l93DJPMP020115; Wed, 3 Oct 2007 15:19:25 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
User-Agent: KMail/1.9.5
In-Reply-To: <200710031348.50800.wielemak@science.uva.nl>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59836>

On Wednesday 03 October 2007 13:48, Jan Wielemaker wrote:
> Hi,
>
> I'm pretty new to GIT. I quickly convinced our project to move to GIT,
> except for one guy that wants to do Windows and CVS :-( I setup a test
> and the checkout works just fine, but commit from cvs doesn't work. The
> details:
>
> 	* Server: git version 1.5.3.1 compiled on SuSE 10.2, 64-bits
> 	* Client, both SuSE CVS 1.12.12 and the current WinCVS cvs.exe,
> 	so it appears irrelevant.
>
> I created a test repository from a papers directory using the sequence
> beloe. (P.s. isn't there a more elegant way to get to a bare shared repo
> from a set of files? I tried (mkdir papers.git && cd papers.git && git
> --bare init --shared=all), but I can't clone an empty bare repository
> (doesn't create anything), so I can't add to it).
>
> 	% cd ~/tmp/papers
> 	% git-init
> 	% git-add .
> 	% git-commit
> 	% cd /home/git
> 	% git-clone --bare --no-hardlinks ~/tmp/papers/ papers.git
> 	% cd papers.git
> 	% git-config core.sharedrepository all
> 	% chmod g+ws `find . -type d`
> 	% chmod g+w `find . -type f`
>
> Anyway, appears to work fine with GIT to clone, pull and push.  Using
> CVS over SSH, I can checkout this just fine, creating HEAD.  Now I change
> a file and run "cvs commit" to get:
>
> gollem (2006) 11_> cvs commit -m "test"
> cvs [commit aborted]: end of file from server (consult above messages if
> any)

I start to get a clue.  Adding a line

	$log->info("Heads: " . `git show-ref --heads`);

I see this in the log:

	2007-10-03 14:13:44 : INFO  - Heads: 0b7b372d525a4fe7f662996fec9cd11b1038a6be 
refs/heads/master

Thus, I though I created the repository the wrong way.  Tried again,
following the recipy of 
http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html:

$ mkdir /pub/my-repo.git
$ cd /pub/my-repo.git
$ git --bare init --shared
$ git --bare fetch /home/alice/myproject master:master

Checked out freshly using CVS. No problem. But committing a change,
nothing changed :-( The log output is exactly the same, showing only
refs/heads/master. I'm starting to suspect git-cvsserver afterall, but
the docs suggests it is operational for quite a while. Could someone
give me a clue on what am I missed?

	Thanks --- Jan 

> I enabled logging and added a few statements to git-cvsserver (line 1203)
>
>     $log->info("Start git show-ref -s refs/heads/$state->{module}");
>     # Remember where the head was at the beginning.
>     my $parenthash = `git show-ref -s refs/heads/$state->{module}`;
>     $log->info("parenthash = $parenthash");
>     chomp $parenthash;
>     if ($parenthash !~ /^[0-9a-f]{40}$/) {
>             $log->warn("error 1 pserver cannot find the current HEAD of
> module");
>             exit;
>     }
>
> Then I get this log output:
>
> ================================================================
> 2007-10-03 12:25:16 : DEBUG - Temporary directory is '/tmp/XwYVFFqjyd'
> 2007-10-03 12:25:16 : DEBUG - req_Root : /home/git/papers.git
> 2007-10-03 12:25:16 : DEBUG - req_Validresponses : ok error Valid-requests
> Referrer Redirect Checked-in New-entry Checksum Co
> py-file Updated Created Update-existing Merged Patched Rcs-diff Mode
> Mod-time Removed Remove-entry Set-static-directory Clear
> -static-directory Set-sticky Clear-sticky Edit-file Template Clear-template
> Notified Module-expansion Wrapper-rcsOption M Mbi
> nary E F MT
> 2007-10-03 12:25:16 : DEBUG - req_validrequests
> 2007-10-03 12:25:16 : DEBUG - SEND : Valid-requests remove add status Entry
> watchers ci tag log co Modified Questionable admi
> n Root history valid-requests Global_option Argumentx annotate
> Valid-responses Unchanged Directory rlog Argument expand-modul
> es diff editors update
> 2007-10-03 12:25:16 : DEBUG - SEND : ok
> 2007-10-03 12:25:16 : DEBUG - req_Globaloption : -q
> 2007-10-03 12:25:16 : DEBUG - Argument : -m
> 2007-10-03 12:25:16 : DEBUG - Argument : test
> 2007-10-03 12:25:16 : DEBUG - Argument : --
> 2007-10-03 12:25:16 : INFO  - Setting prepend to '2006/'
> 2007-10-03 12:25:16 : DEBUG - Prepending '2006/' to state|directory
> 2007-10-03 12:25:16 : DEBUG - req_Directory : localdir=.
> repository=/home/git/papers.git/HEAD/2006 path=2006/ directory=2006/
>  module=HEAD
> 2007-10-03 12:25:16 : INFO  - Received entry line '/README.txt/1.1///'
> => '2006/README.txt'
> 2007-10-03 12:25:16 : DEBUG - Argument : README.txt
> 2007-10-03 12:25:16 : INFO  - req_ci : [NULL]
> 2007-10-03 12:25:16 : INFO  - Lockless commit start, basing commit
> on '/tmp/XwYVFFqjyd/ud4uGbbUJg', index file is '/tmp/XwYVF
> Fqjyd/3FeXMladmb'
> 2007-10-03 12:25:16 : INFO  - Start git show-ref -s refs/heads/HEAD
> 2007-10-03 12:25:16 : INFO  - parenthash =
> 2007-10-03 12:25:16 : WARN  - error 1 pserver cannot find the current HEAD
> of module
> ================================================================
>
> I don't like the req_ci : [NULL] very much, and the last 3 lines clearly
> shows a problem.  I checked
> the latest git repository of git. There is no change to git-cvsserver.perl.
>
> I'm still a bit too newbie to (and not much of a Perl programmer).  Does
> anyone has a clue?  Do I have
> the wrong version for something?  Did I setup the repository wrongly?
>
> 	Thanks --- Jan
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
