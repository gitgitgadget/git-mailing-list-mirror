From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git-cvsserver & push/commit atomically
Date: Mon, 13 Feb 2006 12:50:47 +1300
Message-ID: <46a038f90602121550v4f487edfs788885a78c1b167@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 13 00:51:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8QzV-0007WC-UK
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 00:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWBLXuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWBLXuu
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 18:50:50 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:5020 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751056AbWBLXuu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 18:50:50 -0500
Received: by wproxy.gmail.com with SMTP id i21so736834wra
        for <git@vger.kernel.org>; Sun, 12 Feb 2006 15:50:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dcp03SnidevbucbmRiiE3pIXV0AKaM5wWh9Gv/E32utV4ogJ4/fIigPV+E1pehcZaXT8U2cC2o/f7YRuoMST4WwTq0jO7y31t5f/jDRqalqCyptVcytmbEoU4GH5jUmZc0kP8y04obt4jJF4SJ40Ox2cPnIKgUrfxnSXUnH9AJk=
Received: by 10.54.84.17 with SMTP id h17mr1618900wrb;
        Sun, 12 Feb 2006 15:50:47 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Sun, 12 Feb 2006 15:50:47 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>, martyn@catalyst.net.nz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16027>

I am trying to figure out a safe way to lock the git repo to prevent
clients pushing to it while someone else (via git-cvsserver.pl) is
manipulating it. Push and commit are *mostly* transactional it seems,
but I'm not 100% clear on how the head update gets updated safely.

Ahhhh. Hmmm. Reading git-receive-pack.c update(), it seems that we
have to mimic that behaviour in Perl. The semantics are a bit weird
for me -- not used to safe C open()s. From what I read, it looks like
it

 - precondition: all the relevant objects are already in the repo
 - reads old sha1
 - creates repo.git/refs/<headname>.lock file with new sha1
 - compares old and current head
 - runs update hooks
 - renames repo.git/refs/<headname>.lock into repo.git/refs/<headname>

So it is mostly race-safe, except for the window while we are running
update hooks. Only a misbehaving implementation that doesn't fail on
the creation of repo.git/refs/<headname>.lock  would affect us there,
though. Would locking repo.git/refs/<headname> make sense?

git-cvsserver commits are likely to be slow (not only likely, they
_are_ slow right now), so we need a way to block other clients for a
relatively long time.

cheers,


martin
