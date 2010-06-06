From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH] bash completion: Support "unpushed commits" warnings
 in __git_ps1
Date: Sun, 06 Jun 2010 21:49:03 +0100
Message-ID: <4C0C09BF.4070503@pileofstuff.org>
References: <4C0AE640.3040503@pileofstuff.org> <201006062014.59386.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 06 22:49:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLMmV-0000Q1-4F
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 22:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab0FFUtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 16:49:08 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:46292 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752072Ab0FFUtH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 16:49:07 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100606204906.YIWM3075.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sun, 6 Jun 2010 21:49:06 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100606204905.ZMOD1598.aamtaout03-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sun, 6 Jun 2010 21:49:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <201006062014.59386.trast@student.ethz.ch>
X-Cloudmark-Analysis: v=1.1 cv=W3tOLUehizD4qj6VhtReFuw5MKb8d+XqjIxlDsIazEA= c=1 sm=0 a=jbOMyiAj6TwA:10 a=yQWWgrYGNuUA:10 a=8nJEP1OIZ-IA:10 a=c9vwdAxW17_VmMjYZh0A:9 a=1i3J3LqiGvyvQuq9XbtaxZABM_gA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148542>

On 06/06/10 19:14, Thomas Rast wrote:
> 
> At least the svn/git setting should definitely be configurable through
> git-config, so that it becomes per-repo configurable.  Also, you could
> try to trigger the svn mode by default if a svn-remote.svn.url exists.
> 

I'm not averse to adding a config setting, or to exploring the
"--no-metadata" case.  I am concerned about the strict time constraints
for code called in a command prompt though.  For instance, calling
git-svn could easily make your prompt take over half a second to respond
because of all the Perl you'd have to compile.  I'd also want a few
real-world use cases and a nod from Shawn before diverging any further
from the existing GIT_PS1_FOO= convention.

Having said all that, I'm quite happy to resubmit with
GIT_PS1_SHOWUNPUSHED=svn treated like GIT_PS1_SHOWUNPUSHED=1 when
$GIT_DIR/svn doesn't exist.

> How about starting with
> 
>   git log -1 --first-parent --grep="^git-svn-id: $remote_branch"
> 
> which should be faster and is also closer to the truth.  It still
> doesn't work if the repo was cloned with --no-metadata.  Doing it
> right probably would require a new informational command in git-svn
> that reports the branch name.

Good idea about "-1" and "--grep", but multi-parent commits aren't
compatible with SVN, so I don't see how "--first-parent" is useful here?
 In fact I'm tempted to look for merge commits and print a big warning
when one is found.

I don't see how to actually split out the branch name without calling
sed or using one of the disallowed ${} constructs.  So I compared the
following commands on my PC (2.1 GHz dual-core Athlon) using a
repository with 100 empty commits between HEAD and a git-svn-id:

time git log | \
	sed -ne "/^    git-svn-id: / { s/^    git-svn-id: "\
	"$remote_branch\/\([^@]*\).*/\1/p ; q }"

time git log -1 --grep="^git-svn-id: $remote_branch" | \
	sed -ne "s/^    git-svn-id: $remote_branch\/\([^@]*\).*/\1/p"

The former averaged about 0.017 seconds, whereas the latter averaged
about 0.015.  So when I resubmit this patch, I'll include your version
if merge commits are somehow useful to SVNers, or a merge warning otherwise.

Incidentally, a quick bit of etiquette - would you rather I submitted an
RFC patch or two with these changes, or wait until the discussion has
reached a more stable point?

	- Andrew
