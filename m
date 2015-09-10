From: Sergiy Barlabanov <contact@sergiy-barlabanov.de>
Subject: Bug in handling $ character in GIT SVN
Date: Thu, 10 Sep 2015 17:22:24 +0200
Message-ID: <753DB529-B81D-45A4-B339-03E0FCE4DCE2@sergiy-barlabanov.de>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za471-0006SX-Op
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbIJPuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:50:07 -0400
Received: from www89.your-server.de ([213.133.104.89]:49642 "EHLO
	www89.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbIJPuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 11:50:06 -0400
X-Greylist: delayed 1638 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2015 11:50:05 EDT
Received: from [84.155.131.132] (helo=[192.168.178.33])
	by www89.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <contact@sergiy-barlabanov.de>)
	id 1Za3gU-0000wu-E4
	for git@vger.kernel.org; Thu, 10 Sep 2015 17:22:46 +0200
X-Mailer: Apple Mail (2.1510)
X-Authenticated-Sender: contact@sergiy-barlabanov.de
X-Virus-Scanned: Clear (ClamAV 0.98.7/20899/Thu Sep 10 14:36:44 2015)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277594>

Hi,

I was redirected here from Git-users list (https://groups.google.com/forum/#!topic/git-users/mftroAtEfvE).

We have recently a problem my dcommiting renamed files containing $ character in their names. GIT SVN crashed with the error:

Assertion failed: (svn_uri_is_canonical(child_uri, NULL)), function uri_skip_ancestor, file /SourceCache/subversion/subversion-62/subversion/subversion/libsvn_subr/dirent_uri.c, line 1519.
error: git-svn died of signal 6

Environment was Mac OS X 10.8.5, Git version 1.8.5.2, SVN version 1.7.10.

After having googled a little bit I found out that the error was in Editor.pm script in the way how it handles special characters. There was a patch fixing the problem (see http://git.661346.n2.nabble.com/PATCH-git-svn-do-not-escape-certain-characters-in-paths-td7575413.html). But the patch does not seem to be consistent. It does not work if a file name contains $. Having looked at the source file (https://github.com/git/git/blob/master/perl/Git/SVN/Editor.pm) and played with the local copy of Editor.pm I found out that $ sign must be escaped in the perl regex expression used in Editor.pm:148. Otherwise $ is not caught by the expression and get replaced with %24 which is not accepted by the SVN client.

Seems to be bug and it should be still present because $ sign is still unescaped in the latest master of GIT - see https://github.com/git/git/blob/master/perl/Git/SVN/Editor.pm:148.

Best regards,
Sergiy