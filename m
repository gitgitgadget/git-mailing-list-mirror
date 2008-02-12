From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] daemon: Set up PATH properly on startup.
Date: Tue, 12 Feb 2008 09:31:05 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnfr2pqp.gs1.mdw@metalzone.distorted.org.uk>
References: <1202555873-8099-1-git-send-email-mdw@distorted.org.uk> <20080210200027.169BD5B0E7@dx.sixt.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOras-0007H5-Rv
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 10:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbYBLJhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 04:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757709AbYBLJhu
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 04:37:50 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:55277 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758354AbYBLJht (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 04:37:49 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2008 04:37:48 EST
Received: (qmail 25066 invoked by uid 110); 12 Feb 2008 09:31:06 -0000
Received: (qmail 25050 invoked by uid 9); 12 Feb 2008 09:31:05 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1202808665 25048 172.29.199.2 (12 Feb 2008 09:31:05 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Tue, 12 Feb 2008 09:31:05 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73646>

Johannes Sixt <johannes.sixt@telecom.at> wrote:

> There are 2 reason, *not* to do this:
>
> 1. It's not needed. You can use
>
>     /usr/local/bin/git --exec-path=/usr/local/bin daemon --inetd ...
>
> to inject the exec-path.

Don't need the `exec-path': git knows the right one already.  So this is
entirely equivalent to my suggestion, except that the user has to jump
through this stupid hoop.

Besides, I don't want to run `git' from inetd -- it makes distinguishing
things in /etc/hosts.deny harder.  Unless I write wrapper scripts or make
symlinks for everything, I suppose, but doesn't it seem mad to invent
wrapper scripts to distinguish between things which are already distinct
but glommed together for some strange reason.

> 2. Security. Those inetds launder the environment for a reason. Assume inetd
> sets PATH=/usr/bin:/bin and git-daemon is installed
> as /usr/sbin/git-daemon. With your patch now all hooks run with the path
> set to /usr/sbin:/usr/bin:/bin.

Yes, of course.  Silly me.  It's much better that the service fail to
work at all than that it have something strange like /usr/local/bin on
its PATH.

Besides, the only things git-daemon will actually run are
git-upload-pack, upload-archive and receive-pack. 

  * git-upload-pack in turn runs git-pack-objects, which is a builtin
    and therefore runs setup_path in main.  Anything that does will
    therefore certainly have the same evil on its PATH as would have
    been inserted by my patch -- though I don't think it actually execs
    anything else.

  * git-upload-archive is another builtin, so the same applies; again, I
    don't think it actually execs anything else.

  * git-receive-pack is not something you enable if you care about
    security anyway.

Besides, if there /are/ scripts and so on run by git-daemon, then
they'll be hook scripts, and will also fail if the Git tools aren't on
the PATH.

Your argument, if I might stoop to caricature, seems to be `No, we
mustn't have git-daemon set up the path itself -- it might actually
/work/.'

-- [mdw]
