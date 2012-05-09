From: David Ebbo <david.ebbo@gmail.com>
Subject: Seeing high CPU usage during git-upload-pack
Date: Wed, 9 May 2012 00:01:37 -0700
Message-ID: <CAPeUw3EsFCxki6obAAeVBb0g4MKNWBteL3VueG5djbajkFiv3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 09:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS0u7-00071W-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 09:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab2EIHBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 03:01:39 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38161 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab2EIHBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 03:01:38 -0400
Received: by wibhr2 with SMTP id hr2so112697wib.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=PjxFaf+3gTvdh6p7Uzz/D90OSi/cOzW3w3Pkwtw+e7o=;
        b=yPjJBR66OdQHP3s7/1yPJXIw+hfPB8r6uir1ur4TqjfuAsm3v0aRcpVfEm2aPm5wFr
         N3jeYzTNdpkOyibgR31KizRU2rzBkYHQiTZ4QnaKuJX8bAWMCl0ex4FpNE1NiCirCSV5
         kNSIjdd5z3vaiHbQHlDVJZXNPHnNWV0vgnRiasMXuoxgigVwhEi0afVTi22Ud/bRdjCO
         /U7oBI3WvRDNyJKlk5h/jINgi3KdTqxpMA3TsNM0s/ZAzZuMCb8BA52kES8WT7YUGrVP
         YUPfaujVoGRlSRFzz1oVJJD97M4cMDcHoLVcWTZ+4FJZjuh5HuGwJuKh5IqSCMFmV8xg
         X1bg==
Received: by 10.216.213.10 with SMTP id z10mr13526969weo.65.1336546897202;
 Wed, 09 May 2012 00:01:37 -0700 (PDT)
Received: by 10.216.37.131 with HTTP; Wed, 9 May 2012 00:01:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197455>

We=92re using git-upload-pack in a simple git server. When the repo is
on a slow share, we=92re noticing that git-upload-pack is hugging the
CPU during the whole pack-objects operation.

More details:

- git-upload-pack gets launched (with params git-upload-pack
--stateless-rpc //path/to/repo)
- it itself launches a git process (with params pack-objects --revs
--all --stdout --progress --delta-base-offset). This git process is
the one that does all the disk I/O, but it's not the one using up the
CPU time.
- git-upload-pack appears to be waiting for the git process, and is at
high CPU during that time, suggesting that it's doing some kind of
busy wait. To further test that, I stopped the git process in the
debugger, preventing it from making progress. At that point,
git-upload-pack pegs the CPU forever.

Would someone familiar with the sources be able to comment on this
busy wait behavior, and on whether it could conceivably be done in a
way that doesn=92t use up some much CPU?

Thanks,
David
