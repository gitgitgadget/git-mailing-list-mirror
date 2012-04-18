From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 2/2] git p4: import/export of labels to/from p4
Date: Wed, 18 Apr 2012 07:34:22 -0400
Message-ID: <20120418113422.GB19994@padd.com>
References: <1334157684-31402-1-git-send-email-luke@diamand.org>
 <1334157684-31402-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKT9d-0007kr-6F
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 13:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab2DRLe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 07:34:27 -0400
Received: from honk.padd.com ([74.3.171.149]:35691 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab2DRLe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 07:34:26 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id B9E9520CE;
	Wed, 18 Apr 2012 04:34:25 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B12F05E917; Wed, 18 Apr 2012 07:34:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1334157684-31402-3-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195859>

luke@diamand.org wrote on Wed, 11 Apr 2012 17:21 +0200:
> The existing label import code looks at each commit being
> imported, and then checks for labels at that commit. This
> doesn't work in the real world though because it will drop
> labels applied on changelists that have already been imported,
> a common pattern.
> 
> This change adds a new --import-labels option. With this option,
> at the end of the sync, git p4 gets sets of labels in p4 and git,
> and then creates a git tag for each missing p4 label.
> 
> This means that tags created on older changelists are
> still imported.
> 
> Tags that could not be imported are added to an ignore
> list.
> 
> The same sets of git and p4 tags and labels can also be used to
> derive a list of git tags to export to p4. This is enabled with
> --export-labels in 'git p4 submit'.

This is a good approach.  Here's some late review comments.

> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt

> +git-p4.validLabelRegexp::
> +	Only p4 labels matching this regular expression will be imported. The
> +	default value is '[A-Z0-9_\-.]+$'.
> +

and

> +git-p4.validLabelRegexp::
> +	Only p4 labels matching this regular expression will be exported. The
> +	default value is '[A-Z0-9_\-.]+$'.

This one wants to be validTagRegexp.  Or you could combine them
both into one.  Why no small a-z characters?

> diff --git a/git-p4.py b/git-p4.py

> +            # Get the p4 commit this corresponds to
> +            changelist = None
> +            for l in read_pipe_lines(["git", "log", "--max-count=1", name]):
> +                match = commit_re.match(l)
> +                if match:
> +                    changelist = match.group(1)

We have extractLogMessageFromGitCommit and extractSettingsGitLog
to grep out the "git-p4.. change" tag.  They're not beautiful,
but we should reuse them, in case this mechanism of connecting
changes to commits ever changes.

> +            # Get the tag details.
> +            inHeader = True
> +            isAnnotated = False
> +            body = []
> +            for l in read_pipe_lines(["git", "cat-file", "-p", name]):
> +                l = l.strip()
> +                if inHeader:
> +                    if re.match(r'tag\s+', l):
> +                        isAnnotated = True
> +                    elif re.match(r'\s*$', l):
> +                        inHeader = False
> +                        continue
> +                else:
> +                    body.append(l)
> +
> +            if not isAnnotated:
> +                body = ["lightweight tag imported by git p4\n"]

The manual parsing, just to get the text in the tag (or ref),
seems a bit awkward.  I looked at "git show --pretty=format:%B"
as a way to get just the text, and "git cat-file -t ref" to get
the tag/ref difference.  But no easy replacement.

> +            if change.has_key('change'):
> +                # find the corresponding git commit; take the oldest commit
> +                changelist = int(change['change'])
> +                gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
> +                     "--reverse", ":/\[git-p4:.*change = %d\]" % changelist])
> +                if len(gitCommit) == 0:
> +                    print "could not find git commit for changelist %d" % changelist
> +                else:
> +                    gitCommit = gitCommit.strip()
> +                    commitFound = True
> +                    # Convert from p4 time format
> +                    try:
> +                        tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
> +                    except ValueError:
> +                        print "Could not convert label time %s" % labelDetail['Update']
> +                        tmwhen = 1
> +
> +                    when = int(time.mktime(tmwhen))
> +                    self.streamTag(stream, name, labelDetails, gitCommit, when)
> +                    if verbose:
> +                        print "p4 label %s mapped to git commit %s" % (name, gitCommit)

Nice, even the icky but required p4 time parsing.  We don't have
a common function to go from change -> commit yet.

>  class P4Rebase(Command):
>      def __init__(self):
>          Command.__init__(self)
> -        self.options = [ ]
> +        self.options = [
> +                optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
> +                optparse.make_option("--verbose", dest="verbose", action="store_true"),
> +        ]
> +        self.verbose = False
> +        self.importLabels = False
>          self.description = ("Fetches the latest revision from perforce and "
>                              + "rebases the current work (branch) against it")
> -        self.verbose = False

All commands should have a --verbose.  Could you move the
"--verbose" description in the man page up into "General
options"?  Since it means the same thing in all the commands,
roughly.

>      def run(self, args):
>          sync = P4Sync()
> +        sync.importLabels = self.importLabels
>          sync.run([])

But no "sync.verbose = self.verbose"?  I wonder if P4Rebase should
inherit from P4Sync, like Clone does.  But that is a bit obscure
to me already.  Probably these all want to be split out into a
bunch of functions; there isn't a lot of state tracking happening
in the classes, and only one instance of each per invocation.

> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> new file mode 100755
> index 0000000..85d6049
> --- /dev/null
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -0,0 +1,202 @@
> +#!/bin/sh
> +
> +test_description='git p4 label tests'

This whole set of tests can go it the existing t9804, right?  It
seems that the first few of these are duplicates of what is
already in there.

Nice test coverage, and you fixed the broken one in t9804.

		-- Pete
