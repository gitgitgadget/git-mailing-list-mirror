From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Existing utility to track compiled files in another sister
 repository, for rollouts
Date: Thu, 23 Aug 2012 18:28:09 +0200
Message-ID: <CACBZZX6SVSn17nfSarQC1qgz-TxcDDn5tvHb0BkyW9S8DcLY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 18:28:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4aGv-0000zw-KH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 18:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2HWQ2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 12:28:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52747 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab2HWQ2d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 12:28:33 -0400
Received: by obbuo13 with SMTP id uo13so2088033obb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=D9CRKs0qWWHpPsfCQTQHfRBjGnkCqFQRcM/m5Msgmpk=;
        b=EIa9/Pj8l6XFg239ZTSTMrNSv8npBu8qVJ+26jLPRxs+j1gkKKcxSc+LPaC9bJN43V
         5kg3Uj9+v2OOALXg6Ahcdg0aXJ0LCzbhtLS6gz17IkE7gkCtaxWljTYze23562YV8wXJ
         1SduCtu2QWVn3kCIIW8JvG8aAwkIJR6wGKpaE38r2T7Hy0bsd6H6afdzlG5HtettU6aN
         APsZsn7KXm7ie1JvWWN6/+ZZbUHs768q2uvAZIFShcRS+amvdPm6/GThWU0jN44qh1G7
         FDjlkqXmYHjxVvtj7C7izhE2NLotU52N+VMr3D66+dGymxfQ5jiL0wDz1uSKic3Dtvxl
         J/Ig==
Received: by 10.182.145.8 with SMTP id sq8mr1611972obb.50.1345739309832; Thu,
 23 Aug 2012 09:28:29 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Thu, 23 Aug 2012 09:28:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204153>

I'm planning on using Git for a deployment process where the steps are
basically:

 1. You log into a deployment host, cd into software.git, do git pull
 2. A tool runs "make" for you, creates a deployment-YYYYMMDD-HHMMSS tag
 3. That make step will create a bunch of generated (text) files
 4. Get a list of these with : git clean -dxfn
 5. Copy those to to software-generated.git, removing any that we
didn't just create, adding any that are new
 6. Commit that, tag it with generated-deployment-YYYYMMDD-HHMMSS
 7. Push out both our generated software.git and
software-generated.git tag to our servers
 8. git reset --hard both of those to our newly pushed out tags
 9. Do git clean -dxf on software.git remove old generated files
 10. Copy new generated files from generated-software.git to software.git
 11. Restart our application to pick up the new software

For this I'll need to write some "git snapshot-commit" tool for #5 and
#6 to commit whatever the current state of the directory is (with
removed/added files), and hack up something to do #9-#10.

This should all be relatively easy, I was just wondering if there was
any prior art on this that I could use instead of hacking it up
myself.

For what it's worth the reason I'm using Git like this for deployment
is that I'm converting things away from an rsync-based sync process
that's becoming increasingly slow since rsync with -c needs to
recursively checksum everything we're syncing out (which is quite a
lot), since it's all text files Git can be really efficient in just
transferring deltas and quickly doing a hard reset to a new commit.
