From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 2/2] git-svn: Configure a prompt callback for
 gnome_keyring.
Date: Tue, 18 Jun 2013 18:36:10 +0200
Message-ID: <20130618163609.GD10217@login.drsnuggles.stderr.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
 <1335468843-24653-1-git-send-email-matthijs@stdin.nl>
 <1335468843-24653-2-git-send-email-matthijs@stdin.nl>
 <20120427082840.GB7257@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoytb-00080h-QF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037Ab3FRQge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:36:34 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:37467 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab3FRQgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:36:17 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1Uoyt8-0006Z7-9X; Tue, 18 Jun 2013 18:36:11 +0200
Received: (nullmailer pid 25238 invoked by uid 1000);
	Tue, 18 Jun 2013 16:36:10 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Eric Wong <normalperson@yhbt.net>, Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>, Carsten Bormann <cabo@tzi.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120427082840.GB7257@dcvr.yhbt.net>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	0.0 FB_WORD1_END_DOLLAR    BODY: Looks like a word ending with a $
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228267>

Hi folks,

On Fri, Apr 27, 2012 at 08:28:40AM +0000, Eric Wong wrote:
> Matthijs Kooijman <matthijs@stdin.nl> wrote:
> > This allows git-svn to prompt for a keyring unlock password, when a
> > the needed gnome keyring is locked.
> > 
> > This requires changes in the subversion perl bindings which have been
> > committed to trunk (1241554 and some followup commits) and should be
> > available with the (as of yet unreleased) 1.8.0 release.
> 
> I'm a hesitant to use/depend on unreleased functionality in SVN.
> 
> Is there a chance the API could change before the release.  Also,
> what kind of tests do the SVN guys do on the Perl bindings + GNOME?
> I'm especially concerned since we just worked around segfault
> bugs in the other patch.
> 
> Can we put this on hold until somebody can test the 1.8.0 release?

After over a year, Subversion has finally started with 1.8.0 release
candidates. I've rebased this patch and succesfully tested it against
1.8.0-rc3.

I'll send the updated patch over as a reply to this mail.


As for testing, it took a bit of messing to get all the paths correct,
so I'll document what I did here.

I used a the 1.8.0-rc3 tarball and ran:

	subversion-1.8.0-rc3$ ./configure --prefix=/usr/local/svn
	subversion-1.8.0-rc3$ make all install
	subversion-1.8.0-rc3$ make swig-pl install-swig-pl PREFIX=/usr/local/svn

I took a git master checkout with the patch applied and ran:

	git$ make prefix=/usr/local/git all install

Then, inside some git-svn clone, I ran:

	$ PERL5LIB=/usr/local/svn/local/lib/perl/5.14.2/ LD_LIBRARY_PATH=/usr/local/svn/lib/  /usr/local/git/bin/git svn rebase
	Password for 'default' GNOME keyring:
	Current branch master is up to date.

When removing the PERL5LIB and LD_LIBRARY_PATH variables to run against
the system version of subversion (1.6.17 here), I get an authorization
failure as before:

	$ /usr/local/git/bin/git svn rebase
	Authorization failed: OPTIONS of 'http://svn.example.org': authorization failed: Could not authenticate to server: rejected Basic challenge (http://example.org) at /usr/local/git/share/perl/5.14.2/Git/SVN.pm line 717

Gr.

Matthijs
