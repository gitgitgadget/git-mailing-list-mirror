From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] merge-recursive::removeFile: remove empty directories
Date: Sun, 20 Nov 2005 12:51:02 +0100
Message-ID: <20051120115102.GC4946@c165.ib.student.liu.se>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com> <20051119140736.GA24901@lst.de> <Pine.LNX.4.64.0511190957320.13959@g5.osdl.org> <7vy83k2bwn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sun Nov 20 12:52:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ednj2-0003iX-7s
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 12:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVKTLvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 06:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKTLvK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 06:51:10 -0500
Received: from [85.8.31.11] ([85.8.31.11]:28833 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751051AbVKTLvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 06:51:09 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8823C4102; Sun, 20 Nov 2005 13:00:07 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Ednip-0004Cx-00; Sun, 20 Nov 2005 12:51:03 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy83k2bwn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12380>

On Sat, Nov 19, 2005 at 08:14:48PM -0800, Junio C Hamano wrote:
> When the last file in a directory is removed as the result of a
> merge, try to rmdir the now-empty directory.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  And this is the one for 'git pull -s recursive' which is the
>  default these days.
> 
>  git-merge-recursive.py |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> applies-to: ea62f7003bb2769fa23d5ca371d84cee9d2ec46f
> 80e21a9ed809d98788ff6fb705d911bee37d460b
> diff --git a/git-merge-recursive.py b/git-merge-recursive.py
> index d7d36aa..37258ad 100755
> --- a/git-merge-recursive.py
> +++ b/git-merge-recursive.py
> @@ -293,6 +293,10 @@ def removeFile(clean, path):
>          except OSError, e:
>              if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
>                  raise
> +        try:
> +            os.removedirs(os.path.dirname(path))
> +        except:
> +            pass
>  

Looks good, but I would prefer to have 'except OSError:' instead of
the except without any exception class. A plain 'except:' will catch
every kind of exception which includes things such as NameError and
AttributeError and we really don't want to silently ignore those two.

A plain 'except:' exists in one other place (actually two, but one of
them is ok) in git-merge-recursive.py. I will send a patch to remove
that one.

- Fredrik
