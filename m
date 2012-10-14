From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] Re: [PATCH] config: warn on inaccessible files
Date: Sat, 13 Oct 2012 17:02:10 -0700
Message-ID: <20121014000210.GA19094@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 02:02:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNBfS-00080P-TM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 02:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab2JNACX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 20:02:23 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:37565 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab2JNACW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 20:02:22 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1942535dak.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 17:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=9HyXYVk3diW0eIGTW/kJzEyXD60VfBJL3bnW5Vag0WM=;
        b=SbivEYkyL0LNOkTngDq/wzfcEgVBjDp+UzAaKGU/k4qRqg9QHQKeZ9YwGY0ZTEdXzL
         Acb+IL/wT9kSKiLmIXIUTRwre9/7viUlWpXoeskUB14XadWAm1ssrdLCV2D/eHNFwT0I
         bw5RGJtnjbesEqLDnZMPdUYxmWJbe3kCmE7r47vdMY7Z1I9uyYH2OwNK2pCHh9wCovsH
         uKKfHYow7clMLfe/59bSOz50s4WTN6DZxQ6CqoIOY7Zi3xkGA+N+XPx7UNSYHmMBKo5v
         qJYtmXZ9pOtcq31aC0t5jtQ4LOCQrzYsY55j6qKOw8CXBmPc9GQgTuh1qv6ShNpOVjpq
         56zA==
Received: by 10.66.87.66 with SMTP id v2mr21913166paz.71.1350172942534;
        Sat, 13 Oct 2012 17:02:22 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id vw4sm6657884pbc.26.2012.10.13.17.02.21
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 17:02:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207585>

Hi Jeff,

In August, Jeff King wrote:

> Before reading a config file, we check "!access(path, R_OK)"
> to make sure that the file exists and is readable. If it's
> not, then we silently ignore it.

git became noisy:

 $ git fetch --all
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 Fetching origin
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 Fetching charon
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 [...]

On this machine, ~/.config/git has been a regular file for a while,
with ~/.gitconfig a symlink to it.  Probably ENOTDIR should be ignored
just like ENOENT is.  Except for the noise, the behavior is fine, but
something still feels wrong.  

When ~/.gitconfig is unreadable (EPERM), the messages are a symptom of
an older issue: the config file is being ignored.  Shouldn't git error
out instead so the permissions can be fixed?  E.g., if the sysadmin
has set "[branch] autoSetupRebase" to true in /etc/gitconfig and I
have set it to false in my own ~/.gitconfig, I'd rather see git error
out because ~/.gitconfig has become unreadable in a chmod gone wrong
than have a branch set up with the wrong settings and have to learn to
fix it up myself.

In other words, how about something like this?

Jonathan Nieder (2):
  config, gitignore: failure to access with ENOTDIR is ok
  config: treat user and xdg config permission problems as errors

 config.c          |  4 ++--
 git-compat-util.h |  6 +++++-
 wrapper.c         | 10 +++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)
