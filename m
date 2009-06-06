From: "A. Christine Spang" <spang@MIT.EDU>
Subject: [BUG] git config --rename-section and variable replacement can lose config data
Date: Sat, 6 Jun 2009 04:52:12 -0400
Message-ID: <20090606085212.GA17461@how-about-a-nice-game-of-chess.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 10:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrdb-0004ms-Hy
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbZFFIwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbZFFIwS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:52:18 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:40261 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860AbZFFIwR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 04:52:17 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n568qDno019884
	for <git@vger.kernel.org>; Sat, 6 Jun 2009 04:52:14 -0400 (EDT)
Received: from how-about-a-nice-game-of-chess.mit.edu (HOW-ABOUT-A-NICE-GAME-OF-CHESS.MIT.EDU [18.152.0.130])
	(authenticated bits=56)
        (User authenticated as spang@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n568qCdm015863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 6 Jun 2009 04:52:13 -0400 (EDT)
Received: (from spang@localhost) by how-about-a-nice-game-of-chess.mit.edu (8.12.9.20060308)
	id n568qCqE017578; Sat, 6 Jun 2009 04:52:12 -0400
Content-Disposition: inline
X-GPG-Key-Server: pgp.mit.edu
User-Agent: Mutt/1.5.12-2006-07-14
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120905>

Hi,

While working on a Perl module that parses git-style config files I noticed
the following bug while replicating the --rename-section functionality:

spang@loki:~/tmp> cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
        [valid] foo = bar
    hello = world
spang@loki:~/tmp> git config --get valid.foo
bar
spang@loki:~/tmp> git config --rename-section valid lost-data
spang@loki:~/tmp> cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[lost-data]
    hello = world

As you can see, --rename-section just replaces the entire line
containing the section header that is being renamed, and if there is a
config variable (or a comment, for that matter) following the section
header on the same line (which is valid according to the config format
documentation and the test suite), it is lost.

On further investigation, git config also blows away comments at the end
of the line when replacing variable values, e.g.:

spang@loki:~/tmp> cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[test]
    foo = bar ; a comment
spang@loki:~/tmp> git config test.foo baz
spang@loki:~/tmp> cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[test]
    foo = baz

IMHO, it would be saner to, when a section header or variable value is to be
replaced, just replace the substring of the line in question that needs
replacing, rather than writing whole new lines and having to check if there is
a variable and/or a comment following the data that is being replaced and then
writing those to new lines as well. (Where would the comment be moved to?)

I'm using git v1.6.3.1, but I've looked at the code and the bug is still
present in HEAD.

cheers,
Christine
