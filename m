From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 03 Sep 2007 09:47:42 +0200
Message-ID: <46DBBC1E.4010407@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 09:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS6fw-0002iO-BX
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 09:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbXICHsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 03:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbXICHsa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 03:48:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25905 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXICHs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 03:48:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IS6fb-0001Vk-NP; Mon, 03 Sep 2007 09:48:28 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0A4F59614; Mon,  3 Sep 2007 09:48:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46DACE0D.5070501@trolltech.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.360, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57435>

Marius Storm-Olsen schrieb:
> This gives us a significant speedup when adding, committing and stat'ing files.
> (Also, since Windows doesn't really handle symlinks, it's fine that stat just uses lstat)

Unfortunately, the patch fails t0010-racy-git.sh. I suspect the filetime 
conversion:

> -int lstat(const char *file_name, struct stat *buf)
> +static inline time_t filetime_to_time_t(const FILETIME *ft)
> +{
> +	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
> +	winTime -= 116444736000000000LL; /* Windows to Unix Epoch conversion */
> +	winTime /= 10000000;		 /* Nano to seconds resolution */

Shouldn't this be 1000000000 according to your comment? However, even if 
I make that change, the test still fails. Could you please look into this?

> +	return (time_t)winTime;
> +}

-- Hannes
