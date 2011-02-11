From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Teach git-p4 to ignore case in perforce filenames if
 configured.
Date: Fri, 11 Feb 2011 07:22:53 -0500
Message-ID: <20110211122253.GA14662@mew.padd.com>
References: <1297163499-18776-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 13:23:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pns1g-00083y-5R
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 13:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab1BKMW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 07:22:57 -0500
Received: from honk.padd.com ([74.3.171.149]:55800 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567Ab1BKMW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 07:22:56 -0500
Received: from mew.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 91AEDBC;
	Fri, 11 Feb 2011 04:22:55 -0800 (PST)
Received: by mew.padd.com (Postfix, from userid 7770)
	id 60A922138F; Fri, 11 Feb 2011 07:22:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1297163499-18776-1-git-send-email-torarvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166555>

torarvid@gmail.com wrote on Tue, 08 Feb 2011 12:11 +0100:
> When files are added to perforce, the path to that file has whichever case
> configuration that exists on the machine of the user who added the file.
> What does that mean? It means that when Alice adds a file
> 
> //depot/DirA/FileA.txt
> 
> ... and Bob adds:
> 
> //depot/dirA/FileB.txt
> 
> ... we may or may not get a problem. If a user sets the config variable
> git-p4.ignorecase to "true", we will consider //depot/DirA and //depot/dirA
> to be the same directory.

That's horrid.  Seriously?  A and B can both generate mixed-case
paths, but with a different mix?

If it's all just cast to lower, does it make sense to use
core.ignorecase for this?

> ---
>  contrib/fast-import/git-p4     |   22 ++++++++++++++--------
>  contrib/fast-import/git-p4.txt |   12 ++++++++++++
>  2 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..ca3cea0 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -452,6 +452,12 @@ def p4ChangesForPaths(depotPaths, changeRange):
>      changelist.sort()
>      return changelist
>  
> +def p4PathStartsWith(path, prefix):
> +    ignorecase = gitConfig("git-p4.ignorecase").lower()
> +    if ignorecase in ["true", "yes", "1"]:
> +        return path.lower().startswith(prefix.lower())
> +    return path.startswith(prefix)

git config --bool will always return "true" or "false" (or "").
I think we should start looking for "true" that rather than
checking for all four possible versions of true (+ "on").

Can you put a comment in this function explaining the mixed-case
problem?  When reading the code, it's easier than searching
through the doc to learn about it.

Rest of patch looks fine.

		-- Pete
