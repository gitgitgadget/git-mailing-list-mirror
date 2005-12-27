From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] t5300 considered dangerous
Date: Tue, 27 Dec 2005 14:57:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512271452470.17086@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512270018310.3067@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5jjffxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 14:57:09 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErFK9-0008U3-3W
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 14:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVL0N5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 08:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVL0N5F
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 08:57:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10195 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932316AbVL0N5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 08:57:04 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F417E1415C4; Tue, 27 Dec 2005 14:57:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id E78D22AAE;
	Tue, 27 Dec 2005 14:57:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id C80D127CA;
	Tue, 27 Dec 2005 14:57:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BB2781415C4; Tue, 27 Dec 2005 14:57:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5jjffxu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14074>

Hi,

On Mon, 26 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The test case corrupts a pack, and then also the index of that pack, by 
> > writing "0" at certain offsets, and then tests if git-verify-pack fails.
> 
> These certain offsets are:
> 
>  . byte    2 in pack
>    This corrupts PACK_SIGNATURE ("A" in "PACK").
> 
>  . byte    7 in pack
>    This corrupts PACK_VERSION ("\002" in "\0\0\0\002").
> 
>  . byte   12 in pack
>    This corrupts the type/size byte of whatever the first object
>    happens to be (the type/size byte has non-zero upper nibble).
> 
>  . byte 1200 in idx that is currently 1208 bytes long.
>    This tries to corrupt the checksum of the index file itself,

Thank you for clarifying this.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 7dfb1ab..dd719bb 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -163,8 +163,10 @@ test_expect_success \
>       else :;
>       fi &&
>  
> +     l=`wc -c <test-3.idx` &&
> +     l=`expr "$l" - 20` &&

This needs to be

> +     l=`expr $l - 20` &&

since there are textutils out there (notably version 2.1) where "wc -c" 
prints a leading space.

>       cp test-1-${packname_1}.pack test-3.pack &&
> -     dd if=/dev/zero of=test-3.idx count=1 bs=1 conv=notrunc seek=1200 &&
> +     dd if=/dev/zero of=test-3.idx count=20 bs=1 conv=notrunc seek=$l &&
>       if git-verify-pack test-3.pack
>       then false
>       else :;

When the commit is not skipped, I fail to see why this should not fail in 
one out of 256 cases: the input is (partially) pseudo-random. The last 20 
bytes are the SHA-1 which should inherit this pseudo-randomness. So, the 
first byte should be pseudo-random, too.

Something I missed?

Ciao,
Dscho
