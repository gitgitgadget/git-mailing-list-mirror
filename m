From: Chris Pimlott <chris@pimlott.net>
Subject: git-describe considers WC dirty incorrectly when using --git-dir
Date: Wed, 4 Mar 2015 11:47:32 -0800
Message-ID: <CACWYfsCO3O-x8zBsFXoSTFZ8GiaO6CpAszUHRtjM0dCp0Q8ogg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 20:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTFGc-0004ZM-LF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 20:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbbCDTre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 14:47:34 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:51857 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbCDTre (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 14:47:34 -0500
Received: by mail-vc0-f176.google.com with SMTP id kv7so7012666vcb.7
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 11:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=yJJ2Bxc1nX1AQvWtwjFRDqOMvmsD38hFhvrGBeNPcl8=;
        b=Q5rGXzgAcOnAJa62/01tEcE8iTv0bJbsZewYc+aOP1HB8J10BYdOQNyASVTVrU5zmW
         tXUKJnxrh6+SGTNevY08g7w2i/pMFOKzuh1gSMYFeVHT0mTjHjuYyZIplmqPS1REIM6N
         +QiKyiA1fckCgMJ0/C2PW90dBo5m+QG1EP0FCLR9VeaafSrbGvaRZrM1y56q6ezTatDW
         QvW2/JC1I/WBA0XmZPusBzvHW14BN8TXm3/V+iyXuovjdkxi5P87U2ffeXtk6lNkNbrS
         Fj9XKHVHML1dEnUqmyPJdMh/01l+rA+rGMnF6KsjSxqyMtWBFzc2fMWn+F2N1ZQY1OpX
         xMmg==
X-Received: by 10.52.27.12 with SMTP id p12mr9121432vdg.2.1425498453140; Wed,
 04 Mar 2015 11:47:33 -0800 (PST)
Received: by 10.52.106.8 with HTTP; Wed, 4 Mar 2015 11:47:32 -0800 (PST)
X-Google-Sender-Auth: 8p75jDou98a9TXfyiw4AYZLQ5PE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264768>

It seems that git-describe always thinks that working copy is dirty if
you are not in the WC root and you explicitly specify the .git
directory location using --git-dir:

  # set up test repo
  folio:~ chris$ mkdir repo && cd repo
  folio:repo chris$ mkdir text && echo hi > text/hi.txt
  folio:repo chris$ git init . && git add . && git commit -m "text/hi.txt"
  Initialized empty Git repository in /home/chris/repo/.git/
  [master (root-commit) c0edd63] text/hi.txt
  1 file changed, 1 insertion(+)
  create mode 100644 text/hi.txt

  # git-describe from non-root directory
  folio:repo chris$ cd text
  folio:text chris$ git describe --always --dirty
  c0edd63
  folio:text chris$ git --git-dir=../.git describe --always --dirty
  c0edd63-dirty
  folio:text chris$ git --git-dir=$(git rev-parse
--show-toplevel)/.git describe --always --dirty
  c0edd63-dirty

  # git-describe from root directory
  folio:repo chris$ cd ..
  folio:repo chris$ git describe --always --dirty
  c0edd63
  folio:repo chris$ git --git-dir=.git describe --always --dirty
  c0edd63
  folio:repo chris$ git --git-dir=$(git rev-parse
--show-toplevel)/.git describe --always --dirty
  c0edd63
