From: greened@obbligato.org
Subject: [git-svn] Per-Branch Metadata
Date: Mon, 26 Mar 2012 09:54:18 -0500
Message-ID: <87pqbzct0l.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 16:58:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCBMu-0004tb-2G
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 16:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741Ab2CZO5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 10:57:54 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:36430 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932444Ab2CZO5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 10:57:53 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SC7da-000187-El
	for git@vger.kernel.org; Mon, 26 Mar 2012 05:58:58 -0500
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Hello All, As far as I know, git-svn metadata is global to
    the repository. That works well for common cases but begins to break down
    as soon as subtree merges (and maybe submodules) are involved. Here is the
    scheme I like to use: [...] 
 Content analysis details:   (1.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  2.4 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193916>

Hello All,

As far as I know, git-svn metadata is global to the repository.  That
works well for common cases but begins to break down as soon as subtree
merges (and maybe submodules) are involved.

Here is the scheme I like to use:

- Many components, each with its own repository mirrored from svn

- One "project" repository that aggregates the components with subtree
  merges (via git-subtree)

Typically I work on one or two components, making commits that I'd like
to dcommit back to svn.  Because svn metadata is global I can't keep
metadata for each component in the project repository.  Instead I have
to have this in my work area:

workarea
  project
  commit
    component1
    component2
    component3
    ...

That is, I have a separate checked-out copy of each individual
component.  Each of these repositories has the svn metadata for its
component.

Then when I'm ready to dcommit, I do something roughly like this in
the project repository:

- git subtree split --rejoin --branch=component1_commit
- git push <workarea/commit/component1> component1_commit
- cd workarea/commit/component1
- git svn fetch
- git checkout component1_commit
- git svn dcommit

What I'd rather do is this:

- git subtree split --rejoin --branch=component1_commit
- git checkout component1_commit
- git svn fetch    # Keep metadata separate in this branch for any other 
                   # metadata
- git svn dcommit

If we had metadata per branch I wouldn't have to keep around an entire
duplicate of all of the project source that only gets used as a vehicle
to dcommit.  I would simply create a branch for each component and
populate it with its svn metadata.

Has there been any discussion about this model of operation for git-svn?
I imagine it would be a rather large change.  I'd be willing to put some
time into implementing this if it sounds feasible.

Thanks!

                       -Dave
