From: "David Tweed" <david.tweed@gmail.com>
Subject: ok for git to delete temporary packs on write error?
Date: Wed, 28 Nov 2007 07:42:52 +0000
Message-ID: <e1dab3980711272342x7afad721m113fe21f6879a886@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKvJ-0004A0-WA
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:46 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHhi-0008HW-VQ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 08:51:30 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHha-0000mF-HE
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 08:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXK1Hm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 02:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXK1Hmz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 02:42:55 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:2458 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751455AbXK1Hmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 02:42:54 -0500
Received: by rn-out-0102.google.com with SMTP id s46so1946640rnb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 23:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=njHtdzyR+VjFjbt+vRcY8aCQr7ubCVTXlbg86ZK+Kx0=;
        b=Rnal0Cbh6ciCDekOiYUdBNQHy3HPxJPDu9GUnXjoS/TEg1xaRvnEibSi/2sJLd0Su4e8NJNXQqmQ/xnlBqNXX/7oS0Sj4duOnnKMMvkIOWfsG8ARhyetyKfemi6rjt8/Ys3oXiI1Jf1dAKmEjtis6bRsyiA14D2eNuAQ7Fca4uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JkLGCI7QOZKTXzw1FlGr+anG7IifVzeFmsIEHponE/3wLtWKyrnolihRZZuq3lvAKXXd2JvosnqW5ao6CARwc1LMwDGwxhCfQ+0hfRfMy5KwA4jld4iP4LfxgJx5SHP1CrMkqIOEXgQZINTPMRKuYW6cV8vlYg8M0wfmrdyvMRk=
Received: by 10.150.135.2 with SMTP id i2mr1122291ybd.1196235772023;
        Tue, 27 Nov 2007 23:42:52 -0800 (PST)
Received: by 10.150.53.15 with HTTP; Tue, 27 Nov 2007 23:42:52 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 7BF89D05484D10A03A71B003947EDF6975328EFE
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 73 total 724061 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66318>

Hi, I'd like to check if there's any reason in the overall design of
git which would make deleting tmp_pack's that have suffered
write errors a bad idea? (Before I look further into this I may be missing
a good reason why they shouldn't be auto-deleted.)

My encounter with this comes from using an almost full
usbstick which I discovered when I was poking around
for other reasons several partial packs from occasions
(separated by weeks) where gc failed. On each failure
I'd removed stuff from the drive to clear space and done
a successful gc but hadn't thought to
check below .git for removable stuff so they'd just accumulated.

Below is a output of a test session:

$ git version
git version 1.5.3.6

$ git gc --aggressive --prune
Generating pack...
Done counting 22216 objects.
Deltifying 22216 objects...
 100% (22216/22216) done
Writing 22216 objects...
fatal: sha1 file '/media/usbdiskc/v.git/objects/tmp_pack_QCYYAi' write
error (No space left on device)
error: failed to run repack

$ ls -l /media/usbdiskc/v.git/objects/
total 3944
drwxr-xr-x 2 sis05dst sis05dst    2048 2007-11-28 07:25 info
drwxr-xr-x 2 sis05dst sis05dst    2048 2007-11-28 07:25 pack
-rwxr-xr-x 1 sis05dst sis05dst 4034560 2007-11-28 07:25 tmp_pack_QCYYAi
-rw------- 1 sis05dst sis05dst       0 2007-04-18 23:02 tmp_pack_RYLguI

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
