From: Michael G Schwern <schwern@pobox.com>
Subject: Fix git-svn tests for SVN 1.7.5.
Date: Mon, 16 Jul 2012 17:53:06 -0700
Message-ID: <5004B772.3090806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: robbat2@gentoo.org
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 17 02:53:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqw2R-0004kL-NS
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 02:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab2GQAxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 20:53:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab2GQAxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 20:53:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFCF98DE3;
	Mon, 16 Jul 2012 20:53:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; s=sasl; bh=trZ+CXrzNh4tYRTXwGwq7wdtu
	Do=; b=RbXbx909dWfcTz9Ong5G4LRy4OvK0dH4bKyww0QvyroJ7IXpFbY/4Foqu
	ZGi3ZIePy2QTFvgZIpbRkJhO8Z+qgWaZESNSWXJ0fN88PB7i2WD+jDvqhG5OQgYK
	v1cniDvNECX5O/ubZrjdUPBQ2p/TmxvsdlLC21bU2+S2bFrxCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GH/dIO7uAW8MG3ApHM6
	PeU0yDBCrtC/jN/IHfB3Tr73QtY4J5bcqxCwdVu9Gv8DV1aSDf+f/Zf129ohht0K
	KdzebQoqXOoR61ukiSflj2Df97VDJodj1er2Nmik1ltM+GBaodnqFG1UW1oFgwUq
	wxSpKoWmP1PPPFJxEYhe029M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD1528DE2;
	Mon, 16 Jul 2012 20:53:12 -0400 (EDT)
Received: from windhund.ptp (unknown [173.240.241.170]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07E318DE1; Mon, 16 Jul
 2012 20:53:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: C8D7DD2A-CFA9-11E1-9E61-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201581>

Hi,

I've fixed the git-svn tests for SVN 1.7 and tested with SVN 1.7.5.  SVN 1.7
changed its expectations of path and URL formats and git-svn did not comply
with them.  The new code uses SVN's own canonicalization routines where
available.  This has been reported in several places...
https://bugs.gentoo.org/show_bug.cgi?id=418431
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678764
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=661094
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678137
https://trac.macports.org/ticket/32753

It also split the internal classes out of git-svn.perl and into their own
modules in perl/Git/ to make them easier to work on.  They compile alone, but
remain heavily intertwined with each other and git-svn.  I didn't want to go
very far down that rabbit hole.

This makes the tests pass, but I'm pretty sure plenty of canonicalization
problems remain untested.  Hopefully by attacking the problem at the root (ie.
in the Git::SVN and Git::SVN::Ra accessors) it will wipe out a range of problems.

t9100-git-svn-basic.sh tests 11-13 continue to fail for what look like
unrelated reasons to do with SVN and symlinks.

There's a lot of work in this change, so I felt it better to submit the
patches as a link to a git repository rather than attach a pile of patches.
Here is my repository, the work is in the fix-canonical branch.
https://github.com/schwern/git

Here's a summary of what was done.

* Changed git-svn's main canonicalization routines to use SVN's API.

* Replaced other ad-hoc canonicalization routines with git-svn's
  single routine.

* Moved all the Git:: classes inside git-svn into their own .pm files
  in perl/Git.  They compile, but don't do much more than that alone.
  They're still heavily dependent on git-svn.  It's a start.

* Added Git::SVN->url, Git::SVN->path and Git::SVN::Ra->url to replace
  code grabbing at hash keys.

* Made the above automatically canonicalize their path or url.

* Found some key locations which were not canonicalizing.

* Made the process of adding a new Perl module easier by having the
  Makefile.PL scan for .pm files.


-- 
Alligator sandwich, and make it snappy!
