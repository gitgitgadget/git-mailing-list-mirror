From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add a fast version of fstat to cygwin port
Date: Thu, 19 Mar 2009 15:54:38 +0100
Message-ID: <49C25CAE.6000003@viscovery.net>
References: <81b0412b0903190730s40589291iea9a861ddeedcc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 15:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJfr-00010g-DR
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 15:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbZCSOyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 10:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbZCSOyu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 10:54:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32937 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZCSOyt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 10:54:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LkJdo-0002oU-Tf; Thu, 19 Mar 2009 15:54:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A34A2543; Thu, 19 Mar 2009 15:54:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <81b0412b0903190730s40589291iea9a861ddeedcc0@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113774>

Alex Riesen schrieb:
> Besides, the output of the fast stat and lstat is not compatible
> with cygwin's fstat with regard to uid, gid and ctime fields.

Why do you need this? I don't think that fstat() is used in a critical
path. Do you see problems with the incompatible fields?

> This is not strictly related to the other stat patches. The fstat
> code is shamelessly stolen from the mingw port, sorry.

I wouldn't call it "stolen", but "copied". Because if you copy it, it
becomes your responsibility and all copied bugs are yours ;)

> BTW, why do we have to #undef fstat, but not stat/lstat?

Because stat and lstat are #defined with an argument list, but in those
instances where the cygwin version of stat/lstat is meant, they are used
*without* argument list (see cygwin_stat/lstat_stub), and no macro
expansion happens, and therefore we don't need to #undef the macro.

OTOH, do_fstat calls into cygwin's fstat() if the file handle is not a
file and uses an argument list that would cause a macro expansion if it
were not #undef'd:

> +#undef fstat
> +static int cygwin_fstat(int fd, struct stat *buf)
> +{
> +	HANDLE fh = (HANDLE)_get_osfhandle(fd);
> +	BY_HANDLE_FILE_INFORMATION fdata;
> +
> +	if (fh == INVALID_HANDLE_VALUE) {
> +		errno = EBADF;
> +		return -1;
> +	}
> +	/* direct non-file handles to cygwin's fstat() */
> +	if (GetFileType(fh) != FILE_TYPE_DISK)
> +		return fstat(fd, buf);

We never do that for stat/lstat.

-- Hannes
