From: Alex Stangl <alex@stangl.us>
Subject: error: core.autocrlf=input conflicts with core.eol=crlf
Date: Thu, 4 Dec 2014 23:42:05 -0600
Message-ID: <20141205054205.GA71681@scout.stangl.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 06:49:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwllc-00026S-Rh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 06:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbaLEFtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 00:49:19 -0500
Received: from stangl.us ([66.93.193.95]:29620 "EHLO stangl.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaLEFtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 00:49:19 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Dec 2014 00:49:18 EST
Received: from scout.stangl.us (localhost [127.0.0.1])
	by scout.stangl.us (Postfix) with ESMTP id 7D45822816
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 23:42:06 -0600 (CST)
X-Virus-Scanned: amavisd-new at stangl.us
Received: from stangl.us ([127.0.0.1])
	by scout.stangl.us (scout.stangl.us [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdieId7bP7CU for <git@vger.kernel.org>;
	Thu,  4 Dec 2014 23:42:05 -0600 (CST)
Received: by scout.stangl.us (Postfix, from userid 1001)
	id C5CB622812; Thu,  4 Dec 2014 23:42:05 -0600 (CST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260856>

Hi,

There seems to be problems with the checks in the git code for conflicts
between config values of core.autocrlf and core.eol. Because the various
config files are read in separate passes, and the conflict check happens
on the fly, it creates a situation where the order of the config file
entries matters. This seems like a bug or at least a POLA violation --
ordering of lines within a section of a config file is not usually
significant.

Example: User has core.autocrlf=input in his ~/.gitconfig. In his
project-level .git/config he wants to set core.autocrlf=false and
core.eol=crlf. If the core.autocrlf=false comes first, then all is
well and no conflict is reported. If the core.eol=crlf line comes
first, then at the time this line is getting parsed, core.autocrlf
is still set at "input" from ~/.gitconfig, and execution aborts:

error: core.autocrlf=input conflicts with core.eol=crlf

It seems like the conflict check should be made at the end of the
config file parsing, not on the fly. I was tempted to create a patch,
however I am unfamilar with the codebase, and didn't understand all
the places where the config file parsing is called, so I'm not sure
of the ramifications of any proposed change. A benefit of the current
approach is that it reports the line number where it aborted in the
config file. Trying to retain this and at the same time defer the
check until the end could get complicated.

Besides interaction between multiple levels of config files, the
same sort of ordering issue can arise in conjunction with command-line
config overrides.

Example: User has core.autocrlf=input in his project-level .git/config.
This command works fine:
$ git -c core.autocrlf=false -c core.eol=crlf status
This command blows up with conflict error:
$ git -c core.eol=crlf -c core.autocrlf=false status

I tested with git versions 1.9.3 and 2.1.0.

Alex
