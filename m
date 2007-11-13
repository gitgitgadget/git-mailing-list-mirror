From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: Integrating with hooks
Date: Tue, 13 Nov 2007 09:37:21 -0800
Message-ID: <20071113173721.GI25282@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 21:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is2aE-0007JW-0C
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759964AbXKMUla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759963AbXKMUla
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:41:30 -0500
Received: from que02.charter.net ([209.225.8.190]:61401 "EHLO
	que02.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422AbXKMUl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:41:29 -0500
Received: from aarprv02.charter.net ([10.20.200.72]) by mtao04.charter.net
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20071113173722.ZGWS23660.mtao04.charter.net@aarprv02.charter.net>
          for <git@vger.kernel.org>; Tue, 13 Nov 2007 12:37:22 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
          by aarprv02.charter.net with ESMTP
          id <20071113173722.OOAZ495.aarprv02.charter.net@penguin.codegnome.org>
          for <git@vger.kernel.org>; Tue, 13 Nov 2007 12:37:22 -0500
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id BD27237CA8; Tue, 13 Nov 2007 09:37:21 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Tue, 13 Nov 2007 09:37:21 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
X-Chzlrs: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64862>

I've created some bash functions which handle tagging some files with
revision information, but even after reading the git manual I'm not
really sure how to integrate them so that they remove revision expansion
before each check-in (to avoid cluttering the repository with keyword
substitutions), and add them back (with the current commit info) after
each commit.

These are the functions:

    # Show some kind of useful revision string, like the RCS $Id$ string. I
    # think commit hash, filename, hostname containing the repository, and
    # timestamp should be plenty of information to track down a given file.
    git-id () {
	for file in "$@"; do
	    _date=$(date +'%F %T %Z')
	    git log -1 \
		--pretty=format:"[%h] \"$file\" $(hostname -f) ($_date)" \
		"$file"
	done
    }
    # Replace the $Id$ keyword string in the file itself.
    git-export () {
	for file in "$@"; do
	    echo Modifying $file...
	    _id=$(git-id "$file")
	    sed -ri 's/\$(Id|Revision).*\$/$Id: '"$_id"' $/' "$file"
	done
    }
    # Clean the $Id$ keyword string to prevent cluttering the repository
    # with keyword-revision diffs when we check the file back in.
    git-unexport () {
	for file in "$@"; do
	    echo Resetting $file...
	    sed -ri 's/\$Id.*\$/$Id$/' "$file"
	done
    }

How do I hook this in the way I want so that it's handled automatically?

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
