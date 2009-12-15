From: David Antliff <david.antliff@gmail.com>
Subject: core.autocrlf & Cygwin - files incorrectly flagged as modified
Date: Tue, 15 Dec 2009 22:24:15 +0000 (UTC)
Message-ID: <loom.20091215T225528-115@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 23:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKfuN-0006y6-7k
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 23:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761392AbZLOWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 17:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761389AbZLOWaL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 17:30:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:42574 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760389AbZLOWaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 17:30:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NKfu8-0006ra-Gf
	for git@vger.kernel.org; Tue, 15 Dec 2009 23:30:05 +0100
Received: from 202-27-34-1.dia.global-gateway.net.nz ([202-27-34-1.dia.global-gateway.net.nz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 23:30:04 +0100
Received: from david.antliff by 202-27-34-1.dia.global-gateway.net.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 23:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.27.34.1 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135305>

I approached the Cygwin mailing list about this problem, and the package
maintainer suggested I ask here as well, in case someone can shed some light on
this.

I am using git-1.6.4.2 (as part of Cygwin-1.7 beta) and I've observed some
behaviour that seems wrong to me.

When we deployed git on Cygwin, we decided to set core.autocrlf=true, as many of
our users are working with DOS/Windows files (CRLF endings). Some users are
using Linux and working on the same code. I'm not actually sure why we chose to
use this setting - there's a lot of conflicting advice around. I think the final
decision was made so that kdiff3 would operate correctly. However we did go to
lengths to ensure that everyone is using the same configuration setting.

The problem is that sometimes, after a git-clone, the output of git-status and
git-diff shows entire files as being different. However these files have not
been modified by the user - only git has had a chance to change them (due to
autocrlf=true). But surely if git has converted the file automatically, it
should know that it has to compensate for this when comparing with the local
repository?

And I think it usually does this and almost all files behave properly. The
problem arises when the source-controlled file contains lines with trailing
whitespace. In this situation, git-diff clearly indicates a difference and this
blocks merges and checkouts.

I suspect what is happening is that the line conversion routine in git might be
stripping trailing whitespace, as well as converting the line endings. This
operation is not properly accounted for in the reverse direction, and the file
is flagged as modified.

The Cygwin git package maintainer has indicated that he thinks this might be a
bug: http://cygwin.com/ml/cygwin/2009-12/msg00466.html

Also, as cloned files are converted to DOS-line-endings, by default Cygwin's
bash cannot run any scripts as they have the wrong line endings. I have to set
the 'permanent' bash variable SHELLOPTS to include 'igncr' before bash scripts
can run. Perhaps this is wrong and git on Cygwin (with binary mounts) should be
converting to UNIX line endings instead?

At one point I tried switching off core.autocrlf for myself but this caused a
lot of conflicts due to mismatched line-endings. It seems to me that if we want
to switch to this, *everyone* has to do it at once.

I'd like to know whether this is a problem worthy of further investigation,
whether it should fall in the git or Cygwin camp, and whether I really ought to
be using autocrlf=true please.
