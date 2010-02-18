From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/3] git-gui: =?utf-8?Q?Don?=
	=?utf-8?B?4oCZdA==?= trigger garbage collection warning so easily
Date: Thu, 18 Feb 2010 08:34:32 -0600
Message-ID: <20100218143431.GA30486@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Brown <broonie@sirena.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 15:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni7Sn-0004Wm-Pu
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 15:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab0BROei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 09:34:38 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:38443 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063Ab0BROeg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 09:34:36 -0500
Received: by yxe38 with SMTP id 38so6430015yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GzVTJdKyZ9oe07/23ry+2HSqNUQwPyIN2r6XJ8afDPs=;
        b=lfBPuzbXArMZGuecyuDtwFfWpIV3Bki1iDAvC6Z6zzyIe8kNkkOsFBrvvqlFT0wP4E
         78cDsB78nrmNvuPk0/Z3cED4J42kaGMhZXYvD+xs3S94mE+Bx1ddzK6ja/R8TWemyndz
         4lxtmhfdCcWOul6KZ+U2MZ2GDMy6I+Goi6rb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=HonNGgzvlq+/MNmphYtMXapdZzlRFfZSKsUoE1HkLXa0IVMxmGasQ5gIND3LA/Sb3C
         6UDDQGBb32p0CTBUS53xpeStndYjhVNdOYmX0h4PvGNADWaUtbhNS6HGi/XXSJhZGwoA
         dBy4lG3vfJNwth/z+1PdUDx+MKd2RTGmfgmYo=
Received: by 10.101.137.32 with SMTP id p32mr9507625ann.67.1266503671122;
        Thu, 18 Feb 2010 06:34:31 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm3678293yxb.43.2010.02.18.06.34.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 06:34:30 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140339>

Using git gui from a repository tracking (for example) linux-next,
there are almost always enough loose objects to trigger the garbage
collection warning.  The default threshold for this warning is much
more sensitive than the "as many objects as were in v0.99" rule that
the command-line tools use, and the result might be considered even
more invasive because the user has to hit yes before it starts
packing, and it packs more thoroughly than the default gc --auto
settings would.

Moreover, in repositories with many loose objects not referenced only
by the reflog (like linux-next), the gc does not do any good.  Taken
together, these things mean that every time a person runs git gui,
they get a message asking them to forfeit a long period of time to
accomplish nothing.

This problem was reported by Mark Brown at <http://bugs.debian.org/4976=
87>.
My first thought was to add a =E2=80=9Cdon=E2=80=99t ask me again=E2=80=
=9D check box to the
dialog suggesting repacking, but my Tk fu is not up to it. :(

The next best thing would be to make =E2=80=98git gui=E2=80=99 use gc -=
-auto itself.
I wonder:

 - Could git gui use git gc?  I understand from commit bc7452f that
   the output of git gc might not be stable enough for git gui to rely
   on, but why not add a --porcelain option whose output is?

 - Should git gui run git gc --auto without asking for permission?
   This is what the command line tools already do; with a GUI one
   could further provide a button to cancel the gc without closing
   the GUI.

This series does the simplest thing I could figure out how to
implement: it builds in the heuristic for counting loose objects from
builtin-gc.c into git-gui (so it will respect the gc.auto
configuration and by default will trigger much less often) and if that
heuristic is satisfied, runs gc --auto.

Advice?  Am I on the right track here?  Any advice for specifying an
interface for a --porcelain option to do this the right way?

Jonathan Nieder (3):
  git-gui: factor out too_many_loose_objects routine from hint_gc
  git-gui: Do not hold the user hostage with a full gc at startup
  git-gui: Do not suggest a gc if gc --auto would not do it

 lib/database.tcl |   40 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 35 insertions(+), 5 deletions(-)
