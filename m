From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Allowing override of the default "origin" nickname
Date: Thu, 10 Jan 2008 22:29:45 -0500
Message-ID: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 11 04:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDAb9-0004bC-85
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 04:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYAKD3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 22:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYAKD3y
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 22:29:54 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:3059 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751613AbYAKD3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 22:29:54 -0500
Received: by hs-out-2122.google.com with SMTP id 54so862397hsz.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 19:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=WUGz/dqAsfbFb7syMWinwSoAAQlqW2y3QsMOHQbte/0=;
        b=lW1EvPUbFThjFsAEKFI6J65NK9CyHiZca16Kd8lZSVAlNcfsf1tHv9VgVQnEmYGZUus2ncepzg6Xp0FrdrJUuVVjASFLotNE0s2VWFhAMtLoNn7I3VCjKmC+7FljegGox1LBUeW8f3EkkFMVosIt6a7foCw79lhWDEeFzM2SSqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eOqJu80aDTi8cbm1qMZTCoTqVqPFYzfD3gqc2dS/a07dvy5iD6rWUeSbRT8X+pjhfxK0HXCJ2jfofDMjNz72SGIsQ18hvUKILRh1/gBkCvP1c2BrrGv3RssClGSmibWEb6l+PQYko2Op/Xd/TrCyBLRk9g3BQBcNlNwP2CNJdtM=
Received: by 10.150.58.5 with SMTP id g5mr1125172yba.20.1200022192991;
        Thu, 10 Jan 2008 19:29:52 -0800 (PST)
Received: from localhost.localdomain ( [71.163.17.196])
        by mx.google.com with ESMTPS id h8sm4363197wxd.39.2008.01.10.19.29.51
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 19:29:51 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.99.g3ef7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70117>

git's current support for remote nicknames other than
"origin" is restricted to tracking branches where
branch.<name>.remote is defined. This does not work on
detached heads, and thus does not work for managed
submodules as those are kept on detached heads. When working
with submodules, the remote must be called "origin."

As my project is distributed across multiple domains with
many firewalls and airgaps such that no single server is
available to all, we really need to use nicknames to refer
to different servers, and we need that to work well with
submodules.

So, this patch series:
1) defines a new "remotes.default" config variable per
repository to be the default remote used if no
branch.<name>.remote is found.

2) teaches clone to set remotes.default according to
the user's command (via -o).

3) teaches remote rm to unset remotes.default if deleting
that remote.

4) teaches git-submodule to propoagate the parent's default
branch to submoules during "init", IFF those modules are
defined using relative urls. (Modules using absolute urls
are likely from a different server, so this inheritence is
not likely the right thing in that case.)


This is working well for me, allowing

        git clone -o myserver <url> project
        cd project
        git submodule init
        git submoule update

to work as expected, with all submodules pointing to
"myserver" rather than "origin" and updating correctly despite
being on detached heads.

Mark Levedahl
