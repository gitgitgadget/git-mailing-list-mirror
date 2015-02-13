From: Duy Nguyen <pclouds@gmail.com>
Subject: Pack v4 again..
Date: Fri, 13 Feb 2015 17:46:57 +0700
Message-ID: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 11:47:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMDmX-0005fv-J9
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 11:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbBMKr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 05:47:29 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33043 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbBMKr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 05:47:28 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so9817095igk.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=U7lFUbmfOgATTCQrtdz2CO71/8gERzL8qpfaNsXyTyk=;
        b=ttPGeedliRShY3AbM32Aik/secFiZ4d/BVerZZo5nQWxSmsTMTZTuiSmWeNalgHYb0
         0vbUm3tv4S0dRgAx8xKkl9L8biPTrI1p4xKPElYKKYC39fZjDlPTYtf64RmmoeCIdjpr
         yKZyUvdVhylhN9jFSS5fOdNLuyE84ehjoPC2yGjbQZ2ptYiN5/yecNeuoQf6Y7P6c4D3
         cDdNqtTHvU+0rBZEnj4IzFuYgq4i40xPN38dC+rX0WxduGMdskvSL2YKJ5r9QM6Xqw6K
         reVEbVyK5jIsSLDHRUpNF11ib5CRL9hP5/vR/swady2l+yHwC4CRFBycH5oqvtkboQaU
         SN9Q==
X-Received: by 10.50.222.70 with SMTP id qk6mr2627708igc.47.1423824448048;
 Fri, 13 Feb 2015 02:47:28 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 13 Feb 2015 02:46:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263806>

After taking 1.5 years "vacation" from pack v4, I plan to do something
about it again. Will post more when I have some patches to discuss.
Only one question for now (forgive me if I asked already, it's been
quite some time)

I think pack v4 does not deliver its best promise that walking a tree
is simply following pointers and jumping from place to place. When we
want to copy from the middle of another tree, we need to scan from the
beginning of the tree. Tree offset cache helps, but the problem
remains. What do you think about an alternative format that each
"copy" instruction includes both index of the tree entry to copy from
(i.e. what we store now)  _and_ the byte offset from the beginning of
the tree? With this byte offset, we know exactly where to start
copying without scanning from the beginning. It will be a bit(?)
bigger, but it's also faster.

I imagine this is an optimization that can be done locally. The pack
transferred over network does not have these byte offsets. After the
pack is stored and verified by index-pack, we can rewrite it and add
this info. The simplest way is use a fixed size for this offset (e.g.
uint16_t or even uint8_t), add the place holder in copy instructions
of all v4 trees. After that object offsets will not change again and
we can start filling real offsets to placeholders.

PS. The rebased version on recent master is here if anyone is interested

https://github.com/pclouds/git/commits/pack-v4
-- 
Duy
