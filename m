From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: Bug: /usr/local/bin/git-daemon starts /usr/sbin/git-upload-pack?
Date: Thu, 10 Jul 2008 09:38:52 +0200
Message-ID: <200807100938.53189.J.Wielemaker@uva.nl>
References: <200807092220.10655.J.Wielemaker@uva.nl> <7vlk0a7obl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqnE-0004vl-T7
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYGJHlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYGJHlX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:41:23 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:4405 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbYGJHlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:41:22 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6A7crgj039301;
	Thu, 10 Jul 2008 09:38:54 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <7vlk0a7obl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87955>

Hi Junio,

On Wednesday 09 July 2008 23:14:06 Junio C Hamano wrote:
> Jan Wielemaker <J.Wielemaker@uva.nl> writes:
> > After upgrade to SuSE 11.0 I was forced to update GIT (changed libcurl).
> > I did (with some trickery) a pull of the latest git and built it using
> > make prefix=/usr/local ..., to find out that /usr/local/bin/git-daemon
> > starts /usr/sbin/git-upload-pack.
> >
> > After creating a symlink to /usr/local/bin/git-upload-pack all works fine
> > again, but I guess this is a mistake?
>
> I think this is a distro issue.
>
> Pre-1.6.0 git installs git-everything in $(bindir) and knows things are
> there.  Current 'master' we are preparing for 1.6.0 instead installs
> git-mostofthem in $(prefix)/libexec/git-core and git-someofthem in
> $(bindir); our executables know which binaries are installed in $(bindir)
> and which ones are installed in $(prefix)/libexec/git-core.
>
> The point is we never install $anywhere/sbin unless the person who is
> building explicitly does so (either by futzing the Makefile or giving
> bindir=$somewhere from the command line of "make").  The reason your
> /usr/local/bin/git-daemon (we do not know who compiled it and how) spawns
> something in /usr/sbin is not our doing.  Find out who configured it and
> why, and more importantly, what _other_ changes are made in the build and
> installation procedure to support that change in location.

If you read carefully you see some "I ..." :-)  Summarising to avoid all
confusion:

	* I had git installed in /usr/local/bin, this was git from git,
	close to 1.5.6.  The machine was running SuSE 10.2.
	* I installed SuSE 11.0, whiping /, but git remained as 
	/usr/local is on a seperate partition.
	* Git refused to run (dependency on libcurl.so.3; 11.0 ships with
	libcurl.so.4).
	* I copied libcurl.so.3 from backup into /usr/lib64, which at least
	made git run again.
	* Then I did 

		% git pull
		% git clean -x -f
		% make prefix=/usr/local all doc info 
		# make prefix=/usr/local install install-doc install-info
		
	* All went smooth, but clients to git:// complained that the other site
	hung up unexpectedly.
	* Ran git-daemon --verbose --export-all --user=git --port=4000 /some/path
	* Ran strace -f -p <pid>
	* Ran git clone git://localhost:4000/some/path to find it was trying to
	start /usr/sbin/git-upload-pack.

I understand bit changes are underway, so it might not be worthwhile to try 
and
get to the bottom of this.

	Cheers --- Jan
