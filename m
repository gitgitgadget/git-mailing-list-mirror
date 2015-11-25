From: Jack Nagel <jacknagel@gmail.com>
Subject: Combining APPLE_COMMON_CRYPTO=1 and NO_OPENSSL=1 produces unexpected result
Date: Wed, 25 Nov 2015 10:10:44 -0500
Message-ID: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 16:11:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1bjX-0006Fv-2D
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 16:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbbKYPLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 10:11:06 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33495 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbKYPLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 10:11:05 -0500
Received: by iouu10 with SMTP id u10so57199934iou.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=YGbbqUAE0jTbNYeMCZjSRQ1KEFl2CcDQ7yaieZGMfgs=;
        b=O6VVQhsThZf1bbHdwxMioP7W69+3Ido3d3c/zwYS0BiBMiLAKruX/QeINxvlMZ9F2P
         qa6jEtyxsL7emUhCATHnp4c2abJ7CdpojVuo8FtjyRwTaS3KpJSWa9OuzksOHBSQZeFK
         BpUlcOP7EWpQ7x86RnRB6zK9VG1GbyaHeBU7RKkwliMUypT0Q/9zPgCHq9gBygFaa1Fg
         HkI7o/AFdj8BmeLHWKWyPNjym74Pc7kYlaLHxWTID8XjHNNWLARTwDtO5liICOZCCGH5
         YaBglhb06i/Zej9sMUZnT/ZjVMzBn4LVkO0xiXkD2PVlVttsECZjMCLAeu/qdxraA7Ea
         M79A==
X-Received: by 10.107.13.143 with SMTP id 137mr25937079ion.72.1448464264371;
 Wed, 25 Nov 2015 07:11:04 -0800 (PST)
Received: by 10.36.105.146 with HTTP; Wed, 25 Nov 2015 07:10:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281714>

When compiling git on OS X (where APPLE_COMMON_CRYPTO=1 is the
default) and specifying NO_OPENSSL=1, the resulting git uses the
BLK_SHA1 implementation rather than the functions available in
CommonCrypto.

$ uname -a
Darwin broadwell.local 15.0.0 Darwin Kernel Version 15.0.0: Sat Sep 19
15:53:46 PDT 2015; root:xnu-3247.10.11~1/RELEASE_X86_64 x86_64

$ make NO_OPENSSL=1
[...]
$ nm git | grep _SHA1_
0000000100173f00 t _blk_SHA1_Block
0000000100174e80 T _blk_SHA1_Final
000000010018fbb0 s _blk_SHA1_Final.pad
0000000100173de0 T _blk_SHA1_Init
0000000100173e10 T _blk_SHA1_Update

However, with OpenSSL available, it does use the CommonCrypto functions:

$ make
[...]
$ nm git | grep _SHA1_
                 U _CC_SHA1_Final
                 U _CC_SHA1_Init
                 U _CC_SHA1_Update

I would not expect the presence of NO_OPENSSL=1 to change the behavior
here, since neither case actually makes use of the OpenSSL SHA1
functions.
