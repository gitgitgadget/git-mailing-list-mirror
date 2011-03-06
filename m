From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 00/12] vcs-svn: incremental import
Date: Sun, 6 Mar 2011 16:54:40 -0600
Message-ID: <20110306225419.GA24327@elie>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 23:54:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMqk-0001lM-65
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1CFWys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:54:48 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62238 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1CFWyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:54:47 -0500
Received: by ywj3 with SMTP id 3so1413879ywj.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MjXZzlSfxFuEUuQeVhVIP++Z9oO44Ehi8DRhPkui4AE=;
        b=mUiNufrEdDskfXnXzhhJCtjOtl+ChXI8TwD2KxUJlmk1zff0O1frUU9nQcZbe/w4d3
         ZbF7nO2S9Q6+Z7g+ffTHxij3jKW7BnfqZzG0mGIwYuSQ4CkNy6MJva6ysMf5NvkgbjAx
         JgB7vRPJKbMXQdxHN307kWyRlGmRkoGfVr0/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a/qowI+IgVws+TQ8raFh8CNTA+FEMkrk1eg88kf/FiNSc6LjvcFWgk2PCdnsAEYi7a
         BqRmaDzk6biUePX2C20x0vtdWCy5aIL2+35BEMID+jY4haQ/1G+VXwoi1CvnzE3klikD
         f5bxyVhZW0dtCpCz07tvffL4i15K72dvuzItg=
Received: by 10.151.27.18 with SMTP id e18mr4042086ybj.31.1299452086253;
        Sun, 06 Mar 2011 14:54:46 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id r18sm1293225yba.23.2011.03.06.14.54.44
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 14:54:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168546>

Hi again,

Jonathan Nieder wrote:

> Using David's "ls" command we can eliminate the in-memory repo_tree
> and rely on the target repository for information about old revs.

Here's a reroll.  Aside from the aspects already mentioned (which
avoid a dependency on the mostly orthogonal topic of support for text
deltas), the original patch #10 has been split into smaller, more
easily digestible pieces.

Most of the credit for this incarnation of the series belongs to
David, who heroically streamlined it and untangled it from other
topics.

Patch 1 changes the mark numbers for blobs to be ridiculously high,
to make room for memorable commit marks (:1 for r1, :2 for r2, etc).
Patch 2 brings those commit marks into existence, as mentioned before.

Patches 3-5 simplify the repo-tree API somewhat.  They are somewhat
minimal; patches on top of this series offering further simplification
would be very welcome.

Patch 6 is a bit sneaky.  We want svn-fe's output to change from

	<import blob>
	<import blob>
	...
	<import blob>
	<import commit, using blobs>

to

	<commit header>
	M 100644 inline one/path
	<import blob>
	M 100644 inline another/path
	...
	<commit footer (progress update)>

since the latter allows svn-fe to maintain much less state.  But
that's a big change, so patch 6 introduces a stepping stone on the way
there:

	<comment that will become commit header>
	<import blob>
	...
	<import commit; this will become the commit footer>

That paves the way for patches 7-11, which teach svn-fe to rely
on the fast-import backend for information about previously
imported blobs, at long last.

The visible effects should be:

 - svn-fe _requires_ a backchannel from the fast-import
   backend now.  You can't do

	svn-fe <dump >stream &&
	fast-import <stream

   in two steps any more.

 - Given one dump that picks up where another left off, svn-fe
   can continue the import.  Use

	git fast-import --relative-marks \
		--import-marks-if-exists=svn-revs \
		--export-marks=svn-revs \
		--cat-blob-fd=3 3>backchannel

   for both imports.

I'm not happy about the loss of usability but I'm happy about the gain
in functionality.  A good next step might be to build a simple remote
helper to make this comfortable to use.

Thoughts?  Improvements?  Complaints?  Despite the deficiencies just
mentioned I'm tempted to push this out soon.  Feedback in either
direction would be welcome.

David Barr (3):
  vcs-svn: set up channel to read fast-import cat-blob response
  vcs-svn: quote paths correctly for ls command
  vcs-svn: use mark from previous import for parent commit

Jonathan Nieder (9):
  vcs-svn: use higher mark numbers for blobs
  vcs-svn: save marks for imported commits
  vcs-svn: introduce repo_read_path to check the content at a path
  vcs-svn: handle_node: use repo_read_path
  vcs-svn: simplify repo_modify_path and repo_copy
  vcs-svn: add a comment before each commit
  vcs-svn: allow input errors to be detected promptly
  vcs-svn: eliminate repo_tree structure
  vcs-svn: handle filenames with dq correctly

 contrib/svn-fe/svn-fe.txt |    6 +-
 t/t9010-svn-fe.sh         |  217 +++++++++++++++++++------
 vcs-svn/fast_export.c     |  145 +++++++++++++++--
 vcs-svn/fast_export.h     |   39 +++--
 vcs-svn/line_buffer.c     |    5 +
 vcs-svn/line_buffer.h     |    1 +
 vcs-svn/repo_tree.c       |  386 ++++++++-------------------------------------
 vcs-svn/repo_tree.h       |    5 +-
 vcs-svn/string_pool.c     |   13 ++-
 vcs-svn/string_pool.h     |    3 +-
 vcs-svn/svndump.c         |  106 +++++++++----
 11 files changed, 490 insertions(+), 436 deletions(-)
 rewrite vcs-svn/fast_export.h (75%)
 rewrite vcs-svn/repo_tree.c (96%)
