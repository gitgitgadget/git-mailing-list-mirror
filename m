From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Wed, 25 Mar 2009 13:15:14 +0100
Organization: private
Message-ID: <86hc1hdcj1.fsf@broadpark.no>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 13:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmS2O-0001eh-RE
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 13:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbZCYMPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 08:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbZCYMPW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 08:15:22 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:45451 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbZCYMPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 08:15:22 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KH200ILQA1IEL30@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 25 Mar 2009 13:15:18 +0100 (CET)
Received: from localhost ([80.202.166.137]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KH200I39A1E1E30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 25 Mar 2009 13:15:18 +0100 (CET)
In-reply-to: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114595>

Nicolas Pitre <nico@cam.org> writes:

> On a 32-bit system, the maximum possible size for an object is less than 
> 4GB, while 64-bit systems may cope with larger objects.  Due to this 
> limitation, variables holding object sizes are using an unsigned long 
> type (32 bits on 32-bit systems, or 64 bits on 64-bit systems).
>
> When large objects are encountered, and/or people play with large delta 
> depth values, it is possible for the maximum allowed delta size 
> computation to overflow, especially on a 32-bit system.  When this 
> occurs, surviving result bits may represent a value much smaller than 
> what it is supposed to be, or even zero.  This prevents some objects 
> from being deltified although they do get deltified when a smaller depth 
> limit is used.  Fix this by always performing a 64-bit multiplication.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>

  I added this patch and rerun the 2 test cases form the table where
  --depth is 20000 and 95000, and got the following result:

    --depth=20000 => file size: 19126077  delta: 73814
    --depth=95000 => file size: 19126087  delta: 73814

  So, it seems that this patch almost fixed the issue.  But notice that
  the pack file was 10 bytes larger for the --depth=95000 case.

  I made a small perl script to compare the output from 'git verify-pack
  -v' of the 2 idx/pack files, and found the following difference(1)
  (first line from --depth=20000 case, second from --depth=95000):

  fe0a6f3e971373590714dbafd087b235ea60ac00  tree   9  19  18921247  731  96a3ec5789504e6d0f90c99fb1937af1ebd58e2d
  fe0a6f3e971373590714dbafd087b235ea60ac00  tree  20  29  18921247  730  12e560f7fb28558b15e3a2008fba860f9a4b2222

  'git show fe0a6f3e971373590714dbafd087b235ea60ac00' =>

tree fe0a6f3e971373590714dbafd087b235ea60ac00

Makefile
t0000-basic.sh
test-lib.sh

  'git show 96a3ec5789504e6d0f90c99fb1937af1ebd58e2d' =>

tree 96a3ec5789504e6d0f90c99fb1937af1ebd58e2d

Makefile
t0000-basic.sh
t0100-environment-names.sh
t0200-update-cache.sh
t0400-ls-files.sh
t0500-ls-files.sh
t1000-checkout-cache.sh
t1001-checkout-cache.sh
test-lib.sh

  'git show 12e560f7fb28558b15e3a2008fba860f9a4b2222' =>

tree 12e560f7fb28558b15e3a2008fba860f9a4b2222

Makefile
t0000-basic.sh
t0100-environment-names.sh
t0200-update-cache.sh
t0400-ls-files.sh
t0500-ls-files.sh
t1000-checkout-cache.sh
t1001-checkout-cache.sh
test-lib.sh

  -- kjetil

  1) there was lots of lines with different offsets, all of which was 10
     larger in the --depth=95000 case.
