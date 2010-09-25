From: Jonathan Nieder <jrnieder@gmail.com>
Subject: svn-fe status
Date: Sat, 25 Sep 2010 00:19:26 -0500
Message-ID: <20100925051926.GA19804@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 07:22:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzNDR-0006Kl-99
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 07:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab0IYFWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 01:22:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40591 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0IYFWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 01:22:23 -0400
Received: by iwn5 with SMTP id 5so2953482iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NNLSWkJ3i74+t8FNHQxZ13BrGovLKPuhC1M/IVbKnSE=;
        b=DhVzBu/gtjGHed2cWC1EVXqpBamo1Q0ngdBLsFzqJHF4JOASQmLlKYLpQwjxtvhpar
         3XPiN1IhaYiyPfqACCLzQ3fl1pR4IbLFjUBW4RziWVsZ86DJxFL1OgApXPQMR2Dck94/
         xHd9w5yqgRSNQeixfyC9iDZFRQT7ES56YNIKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IW6WV6949mHrdjjPQFAd/CctOyLjhTIqyX5TPpLx0JOSkK1WKAVHjN+6hvR7eAfVwC
         eP+AcLl+P/VXmbzeXICIys2TPTBz9RamtE+aZTs6QUdqFHOM4ECCvWsmv5B9Ysps9A72
         ttORZ7MSyTU1o2Of2dAHZOlAnKjhWyjKPHlwg=
Received: by 10.231.157.205 with SMTP id c13mr5065147ibx.71.1285392142065;
        Fri, 24 Sep 2010 22:22:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm3166520ibe.11.2010.09.24.22.22.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 22:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157119>

Jonathan Nieder wrote:

> Tomorrow I would like to re-roll the fast-import experiment
> so the svn-fe that understands deltas can get more attention

but I did not get as far as I would like.  Interested parties can find
some very rough patches in the git repository at:
 git://repo.or.cz/git/jrn.git tp/svn-fe-wip

The top two patches are completely bogus.  No doubt some of the
earlier ones are, too, which is why I do not think they are ready for
review yet, except by extra curious people.

Now the features that would be most useful from fast-import become a
bit clearer.  Since a single svn revision can make multiple changes to
a file, the ability to read back the currently staged content for the
current revision would be helpful, like this:

  commit refs/remotes/origin/root
  mark :100
  committer localuser <localuser@machine.example.com>
  data <<END_MESSAGE
  
  from refs/remotes/origin/root^0
  M 100644 :72:"trunk/README" "branches/topic/README"
  cat "branches/topic/README"
  M 100755 inline branches/topic/README
  data <<END_FILE
  ... output from delta application goes here ...
  END_FILE
  ... etc ...

In other words, it would be nice to be able to

 1. use ':<mark>:<path>' references to retrieve data from a
    previous revision
 2. use 'cat <path>' references to retrieve data from the
    current revision.

By using these two features, I think we could eliminate the repo_tree
module completely.

David's and Ram's discussions and patches from the last two weeks (or
at least the part I have understood) have been very helpful.

David Barr (3):
      svndiff: Give caller responsibility for initializing line_buffer
      vcs-svn: Reduce memory allocation churn in move_window
      vcs-svn: extend svndump to parse version 3 format

Jonathan Nieder (14):
      Makefile: declare vcs-svn test dependencies
      line_buffer: Allow character-oriented input
      line_buffer: Let caller peek ahead to find stream end
      line_buffer: Add binary-safe read() function
      vcs-svn: Add svn delta parser
      svndiff: Handle truncated data in deltas
      svndiff: Handle truncated source file
      svndiff: Cap length of delta read
      Teach fast-import to print the id of each imported commit
      fast-import: Let importers retrieve the objects being written
      fast-import: Allow cat command with empty path
      fast-import: Allow cat requests at arbitrary points in stream
      [WIP] svn-fe: Use the --report-fd feature
      wip

Ramkumar Ramachandra (1):
      Add a sample user for the svndiff library

 Documentation/git-fast-import.txt |   49 ++++
 Makefile                          |   10 +-
 contrib/svn-fe/.gitignore         |    1 +
 contrib/svn-fe/Makefile           |   30 ++-
 contrib/svn-fe/svn-da.c           |   26 ++
 contrib/svn-fe/svn-da.txt         |   24 ++
 contrib/svn-fe/svn-fe.txt         |    6 +-
 fast-import.c                     |  147 ++++++++++-
 t/t9010-svn-fe.sh                 |   37 +++-
 t/t9010/newdata.diff0             |  Bin 0 -> 19392 bytes
 t/t9010/newdata.done              |  522 +++++++++++++++++++++++++++++++++++++
 t/t9010/src.diff0                 |  Bin 0 -> 74 bytes
 t/t9010/src.done                  |  522 +++++++++++++++++++++++++++++++++++++
 t/t9300-fast-import.sh            |  210 +++++++++++++++
 test-svn-fe.c                     |   38 +++-
 vcs-svn/LICENSE                   |    2 +
 vcs-svn/fast_export.c             |  158 +++++++++++-
 vcs-svn/fast_export.h             |   11 +-
 vcs-svn/line_buffer.c             |   24 ++
 vcs-svn/line_buffer.h             |    3 +
 vcs-svn/repo_tree.c               |    9 +-
 vcs-svn/svndiff.c                 |  477 +++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h                 |   11 +
 vcs-svn/svndump.c                 |   69 +++++-
 24 files changed, 2340 insertions(+), 46 deletions(-)
 create mode 100644 contrib/svn-fe/svn-da.c
 create mode 100644 contrib/svn-fe/svn-da.txt
 create mode 100644 t/t9010/blank.done
 create mode 100644 t/t9010/newdata.diff0
 create mode 100644 t/t9010/newdata.done
 create mode 100644 t/t9010/src.diff0
 create mode 100644 t/t9010/src.done
 create mode 100644 vcs-svn/svndiff.c
 create mode 100644 vcs-svn/svndiff.h
