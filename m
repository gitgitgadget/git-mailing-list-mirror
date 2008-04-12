From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] Make core.sharedRepository more generic
Date: Sat, 12 Apr 2008 21:15:03 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-04-12-21-15-04+trackit+sam@rfc1149.net>
References: <20080412185105.GA14331@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sat Apr 12 21:16:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JklCj-0001t0-QV
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 21:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYDLTPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 15:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYDLTPP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 15:15:15 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:59111 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbYDLTPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 15:15:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 3FA3EE2986;
	Sat, 12 Apr 2008 21:15:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zh5IzgpQ-5-F; Sat, 12 Apr 2008 21:15:05 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 8340DE17E4;
	Sat, 12 Apr 2008 21:15:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 969F8C408D;
	Sat, 12 Apr 2008 21:15:04 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k103WWX51vY9; Sat, 12 Apr 2008 21:15:04 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 6440EC40B9; Sat, 12 Apr 2008 21:15:04 +0200 (CEST)
In-Reply-To: <20080412185105.GA14331@zakalwe.fi> (Heikki Orsila's message of "Sat\, 12 Apr 2008 21\:51\:05 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79377>

The use of named constants vs. literals seem inconsistent in your
patch, compare

| +               mode = (mode & ~0777) | shared_repository;

to

| +               mode |= (shared_repository & 0600) ? S_IXUSR : 0;
| +               mode |= (shared_repository & 0060) ? S_IXGRP : 0;
| +               mode |= (shared_repository & 0006) ? S_IXOTH : 0;

I first thought that you were using literals with "shared_repository"
and named constants with mode but the first line I quoted shows that
this is not the case.

Btw, aren't those last three lines better replaced by

  /* Copy read bits to execute bits */
  mode |= (shared_repository & 0444) >> 2;

I don't see where you deal with executable files.

Also, wouldn't it be more consistent to use a negative value to
--shared, that is a umask-compatible one, rather than a positive value
which needs to be tweaked for directories and executable files? You
would only have to "&" 0666 or 0777 with "~perms" to get the right
permissions.

--shared=0007 would be equivalent to PERM_GROUP, --shared=0027 to
group-readable-but-not-writable, and --shared=0002 to PERM_EVERYBODY.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
