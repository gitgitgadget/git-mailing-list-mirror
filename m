From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Mon, 24 Dec 2012 08:36:49 -0500
Message-ID: <20121224133649.GA1400@padd.com>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 14:37:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn8DQ-0008So-7y
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 14:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab2LXNgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 08:36:54 -0500
Received: from honk.padd.com ([74.3.171.149]:49078 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552Ab2LXNgx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 08:36:53 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 36AC95B17;
	Mon, 24 Dec 2012 05:36:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BDF542275F; Mon, 24 Dec 2012 08:36:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121220141855.05DAA44105@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212108>

esr@thyrsus.com wrote on Thu, 20 Dec 2012 09:13 -0500:
> diff --git a/git-p4.py b/git-p4.py
> index 551aec9..ec060b4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -12,6 +12,11 @@ import optparse, sys, os, marshal, subprocess, shelve
>  import tempfile, getopt, os.path, time, platform
>  import re, shutil
>  
> +if sys.hexversion < 0x02040000:
> +    # The limiter is the subprocess module
> +    sys.stderr.write("git-p4.py: requires Python 2.4 or later.")
> +    sys.exit(1)
> +
>  verbose = False

If 2.3 does not have the subprocess module, this script will fail
at the import, and not run your version test.

All the uses of sys.stderr.write() should probably include a
newline.  Presumably you used write instead of print to avoid
2to3 differences.

The name of this particular script, as users would type it, is
"git p4"; no dash and no ".py".

Many of your changes have these three problems; I just picked on
my favorite one.

> diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> index 5f3ebd2..22d2eb6 100644
> --- a/git-remote-testgit.py
> +++ b/git-remote-testgit.py
> @@ -31,6 +31,11 @@ from git_remote_helpers.git.exporter import GitExporter
>  from git_remote_helpers.git.importer import GitImporter
>  from git_remote_helpers.git.non_local import NonLocalGit
>  
> +if sys.hexversion < 0x01050200:
> +    # os.makedirs() is the limiter
> +    sys.stderr.write("git-remote-testgit.py: requires Python 1.5.2 or later.")
> +    sys.exit(1)
> +

This one, though, is a bit of a lie because git_remote_helpers
needs 2.4, and you add that version enforcement in the library.

I assume what you're trying to do here is to make the
version-related failures more explicit, rather than have users
parse an ImportError traceback, e.g.  That seems somewhat useful
for people with ancient installs.

But what about the high-end of the version range?  I'm pretty
sure most of these scripts will throw syntax errors on >= 3.0,
how should we catch that before users see it?

		-- Pete
