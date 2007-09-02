From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 20:16:54 +0200
Message-ID: <200709022016.54262.johannes.sixt@telecom.at>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 20:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRu2j-0000ik-0C
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 20:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbXIBSTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 14:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXIBSTU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 14:19:20 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33753 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbXIBSTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 14:19:18 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id B5B4E10B15C;
	Sun,  2 Sep 2007 20:16:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 79B8957CF4;
	Sun,  2 Sep 2007 20:16:54 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <46DACE0D.5070501@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57375>

On Sunday 02 September 2007 16:51, Marius Storm-Olsen wrote:
> This gives us a significant speedup when adding, committing and stat'ing
> files. (Also, since Windows doesn't really handle symlinks, it's fine that
> stat just uses lstat)
>
> Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>

Your numbers show an improvement of 50% and more. That is terrific!

I'll test it out an put the patch into mingw.git. I hope you don't mind if I 
also include your analysis and statistics in the commit message. It's worth 
keeping around! BTW, which of your email addresses would you like registered 
as author?

> +		ext = strrchr(file_name, '.');
> +		if (ext && (!_stricmp(ext, ".exe") ||
> +			    !_stricmp(ext, ".com") ||
> +			    !_stricmp(ext, ".bat") ||
> +			    !_stricmp(ext, ".cmd")))
> +			fMode |= S_IEXEC;
> +		}

I'm slightly negative about this. For a native Windows project the executable 
bit does not matter, and for a cross-platform project this check is not 
sufficient, but can even become annoying (think of a file 
named 'www.google.com'). So we can just as well spare the few cycles.

> +		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since
> it's not a stat64 */

Here's an idea for the future: With this self-made stat() implementation it 
should also be possible to get rid of Windows's native struct stat: Make a 
private definition of it, too, and use all 64 bits.

>  		return 0;
> +	}
> +	errno = ENOENT;

Of course we need a bit more detailed error conditions, most importantly 
EACCES should be distinguished.

> +/* Make git on Windows use git_lstat and git_stat instead of lstat and
> stat */ +int git_lstat(const char *file_name, struct stat *buf);
> +int git_stat(const char *file_name, struct stat *buf);
> +#define lstat(x,y) git_lstat(x,y)
> +#define stat(x,y) git_stat(x,y)

I'd go the short route without git_stat() and

#define stat(x,y) git_lstat(x,y)

-- Hannes
