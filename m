From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 	MSVC
Date: Thu, 17 Sep 2009 09:11:20 +0200
Message-ID: <4AB1E118.70504@viscovery.net>
References: <cover.1253088099.git.mstormo@gmail.com>	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net> <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoB9R-00074L-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403AbZIQHLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386AbZIQHLW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:11:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33576 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758329AbZIQHLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 03:11:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoB9F-0005RM-DZ; Thu, 17 Sep 2009 09:11:21 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1AB22BC81; Thu, 17 Sep 2009 09:11:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128719>

Alexey Borzenkov schrieb:
> Searching which executables set _fmode and which don't I found the
> culprit. test-genrandom.c didn't include git-compat-util.h, so mingw.h
> was never included. This caused different random data to be generated,
> and as it seems more importantly, of different sizes. Can be fixed
> with this patch:
> 
> diff --git a/test-genrandom.c b/test-genrandom.c
> index 8ad276d..b3c28d9 100644
> --- a/test-genrandom.c
> +++ b/test-genrandom.c
> @@ -4,8 +4,7 @@
>   * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
>   */
> 
> -#include <stdio.h>
> -#include <stdlib.h>
> +#include "git-compat-util.h"
> 
>  int main(int argc, char *argv[])
>  {

Thanks for digging this out. With this change, the t5302 passes again.

I verified that the SHA1s that are generated with this fix are identical
to those that are generated on Linux. (And without this fix they are
different.)

Just for the records: The reason why including git-compat-util.h was not
necessary before 04/15 is that test-genrandom is linked against libgit.a.
This way the startup code had picked up the definition of _CRT_fmode from
mingw.c that is initialized to _O_BINARY. After the original 04/15 this
symbol was not present anymore in libgit.a, and the default (text mode)
was used. And with this fix, main() is overridden to explicitly set the
mode of stdout to _O_BINARY.

-- Hannes
