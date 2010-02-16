From: Jeff King <peff@peff.net>
Subject: Re: Fatal error running status in new repo
Date: Tue, 16 Feb 2010 02:21:54 -0500
Message-ID: <20100216072154.GF2169@coredump.intra.peff.net>
References: <20100216041945.GB10296@vfb-9.home>
 <20100216060528.GB2169@coredump.intra.peff.net>
 <20100216062422.GC10296@vfb-9.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ping Yin <pkufranky@gmail.com>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:22:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHkv-0000f6-3x
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635Ab0BPHVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:21:55 -0500
Received: from peff.net ([208.65.91.99]:41068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932624Ab0BPHVz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 02:21:55 -0500
Received: (qmail 30232 invoked by uid 107); 16 Feb 2010 07:22:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 02:22:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 02:21:54 -0500
Content-Disposition: inline
In-Reply-To: <20100216062422.GC10296@vfb-9.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140079>

On Mon, Feb 15, 2010 at 10:24:22PM -0800, Jacob Helwig wrote:

[in an empty repo]
> $ GIT_TRACE=1 git status
> trace: built-in: git 'status'
> # On branch master
> #
> # Initial commit
> #
[...]
> trace: run_command: 'git-submodule' 'summary' '--cached' '--for-status' '--summary-limit' '-1' 'HEAD'
[...]
> trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD^0'
> warning: ignoring dangling symref HEAD.
[...]
> trace: built-in: git 'diff-index' '--cached' '--raw' 'HEAD' '--' 'HEAD'
> fatal: bad revision 'HEAD'

The patch I just posted elsewhere in the thread fixes the "ignoring
dangling symref" message. The "bad revision 'HEAD'" comes from
diff-index. But as you can see, that diff-index invocation is somewhat
bogus.

It looks like this code (git-submodule.sh:556-562):

        if rev=$(git rev-parse -q --verify "$1^0")
        then
                head=$rev
                shift
        else
                head=HEAD
        fi

is meant to guess whether the argument is a revision or a file limiter,
and if the latter, assume HEAD was meant. Which obviously breaks down
when the argument is HEAD and it is invalid. The patch below seems to
fix it for me, but I have no idea if I am breaking something else.

Can somebody more clueful about the submodule script take a look?

-Peff

---
diff --git a/git-submodule.sh b/git-submodule.sh
index 664f217..4332992 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -555,10 +555,12 @@ cmd_summary() {
 
 	if rev=$(git rev-parse -q --verify "$1^0")
 	then
 		head=$rev
 		shift
+	elif test "$1" = "HEAD"; then
+		return
 	else
 		head=HEAD
 	fi
 
 	if [ -n "$files" ]
