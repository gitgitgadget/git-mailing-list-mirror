From: Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 3/3] Windows: teach getenv to do a case-sensitive search
Date: Wed, 5 Oct 2011 16:21:14 +0000 (UTC)
Message-ID: <loom.20111005T175934-633@post.gmane.org>
References: <4DEC7A65.7020207@viscovery.net> <4DEC7CDD.10403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 18:21:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBUDu-0007Xb-2x
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 18:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934853Ab1JEQV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 12:21:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:60433 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934476Ab1JEQV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 12:21:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RBUDn-0007UR-4m
	for git@vger.kernel.org; Wed, 05 Oct 2011 18:21:27 +0200
Received: from ns.dcon.de ([77.244.111.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 18:21:26 +0200
Received: from blees by ns.dcon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 18:21:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.244.111.149 (Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182857>

Hmm...this looks like a pretty fragile solution to me. Wouldn't it be simpler
and safer to just fix the conflicting variables, instead of inventing entirely
new environment semantics for Windows?

I looked at the eval_gettext occurences, and only found '$path' in
git-submodule.sh to obviously conflict with existing environment variables. So
the straightforward solution IMO would be to fix the variable in that script.

Small solution (only affects gettext): in git-submodule.sh, replace all
'eval_gettext...$path' with 'modulepath=$path eval_gettext...$modulepath'

Big solution (enables git-submodule-foreach scripts on Windows, but is a
breaking change for existing foreach scripts on Unix): in git-submodule.sh,
t/t7407-submodule-foreach.sh, Documentation/git-submodule.txt, replace all
'$path' with '$modulepath' (also a few 'path=...' and 'while read...path')


Just a few failure scenarios that come to mind with the current solution:
- Given environment variables "Path" and "path", the 'case-sensitive first'
approach works fine for 'getenv("path")', but 'getenv("PATH")' still has a 50%
chance of failure.
- The other environment functions have not been changed to reflect the
'case-sensitive first' logic: setenv("path"...) and setenv("PATH"...) both have
a chance of overwriting the wrong entry, same for putenv.
- Windows applications generally don't support case-sensitive environment
variables, e.g. all MSYS and Cygwin programs convert environment variable names
to upper case on startup, eliminating duplicates in the process. With git.exe
beeing the only case-sensitive tool, any change to git-sh-i18n.sh (e.g.
replacing git-envsubst with a real gettext-envsubst) is likely to break again.
- As you already mentioned, Windows doesn't support case-sensitive environment
variable names, MSDN is pretty clear on that. Expressly violating this
documentation may cease to work with any new Windows version or patch.

Cheers,
Karsten
