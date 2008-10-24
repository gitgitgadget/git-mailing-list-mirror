From: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
Subject: Problem with Git.pm bidi_pipe methods
Date: Fri, 24 Oct 2008 02:14:46 +0200
Message-ID: <20081024001446.GE17717@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 02:50:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtAsK-00030c-T1
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 02:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbYJXAsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 20:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbYJXAsr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 20:48:47 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:57517 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbYJXAsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 20:48:46 -0400
X-Greylist: delayed 2036 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Oct 2008 20:48:46 EDT
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1KtAHR-00048E-7S
	for git@vger.kernel.org; Fri, 24 Oct 2008 02:11:53 +0200
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1KtAKE-0007i6-8X
	for git@vger.kernel.org; Fri, 24 Oct 2008 02:14:46 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98995>

Hi,

To be able to call commit-tree from a Perl program, I had to use
command_bidi_pipe() to pass the message on standard input, and get the
new commit id on standard output. The only problem I have is that the
method doesn't work (or at least, doesn't work like the other
command_... methods).

    sub command_bidi_pipe {
        my ($pid, $in, $out);
        $pid = open2($in, $out, 'git', @_);
        return ($pid, $in, $out, join(' ', @_));
    }

First, it calls git in the current working dir, when all the other
command_... methods do the appropriate chdir depending on the Git object.

Second, it can't be used as a method, since $self is not removed from @_
before calling open2, leading to errors such as this one:

    git: 'Git=HASH(0x82f898c)' is not a git-command. See 'git --help'.

Third, no access is given to STDERR (open3 may help).

I'm very sorry to complain without proposing a patch.

I think solving the current directory problem is probably going to be
difficult with open2/open3, since open2 does the fork+exec, whereas Git.pm
handles the fork+chdir+exec itself for the other command_...  methods.
And so there is no room to chdir when calling open2.

-- 
 Philippe Bruhat (BooK)

 Treat those you outrank well... you never know when they will outrank you.
                                                 (Moral from Groo #7 (Image))
