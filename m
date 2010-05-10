From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH/RFC] autocrlf: Make it work also for un-normalized
  repositories
Date: Mon, 10 May 2010 19:29:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1005101921460.7651@pacific.mpi-cbg.de>
References: <20100510171119.GA17875@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:29:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWnk-0005Td-0a
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab0EJR3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:29:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:42840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751399Ab0EJR3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:29:48 -0400
Received: (qmail invoked by alias); 10 May 2010 17:29:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 10 May 2010 19:29:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8XwtSvM7837lwkB3bRtH6xVCVapI/hUpKQ+2bBS
	/tbti062Zl1bBr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100510171119.GA17875@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146839>

Hi Finn Arne,

this is great stuff!

On Mon, 10 May 2010, Finn Arne Gangstad wrote:

> Previously, autocrlf would only work well for normalized
> repositories. Any text files that contained CRLF in the repository
> would cause problems, and would be modified when handled with
> core.autocrlf set.
> 
> Change autocrlf to not do any conversions to files that in the
> repository already contain a CR. git with autocrlf set will never
> create such a file, or change a LF only file to contain CRs, so the
> (new) assumption is that if a file contains a CR, it is intentional,
> and autocrlf should not change that.
> 
> The following sequence should now always be a NOP even with autocrlf
> set (assuming a clean working directory):
> 
> git checkout <something>
> touch *
> git add -A .    (will add nothing)
> git comit       (nothing to commit)

s/comit/commit/

> Previously this would break for any text file containing a CR
> 
> Signed-off-by: Finn Arne Gangstad <finag@pvv.org>
> ---
> 
> Some of you may have been folowing Eyvind's excellent thread about
> trying to make end-of-line translation in git a bit smoother.
> 
> I decided to attack the problem from a different angle: Is it possible
> to make autocrlf behave non-destructively for all the previous problem cases?
> 
> Stealing the problem from Eyvind's initial mail (paraphrased and
> summarized a bit):
> 
> 1. Setting autocrlf globally is a pain since autocrlf does not work well
>    with CRLF in the repo
> 2. Setting it in individual repos is hard since you do it "too late"
>    (the clone will get it wrong)
> 3. If someone checks in a file with CRLF later, you get into problems again
> 4. If a repository once has contained CRLF, you can't tell autocrlf
>    at which commit everything is sane again
> 5. autocrlf does needless work if you know that all your users want
>    the same EOL style.
> 
> I belive that this patch makes autocrlf a safe (and good) default
> setting for Windows, and this solves problems 1-4.
> 
> I implemented it by looking for CR charactes in the index, and
> aborting any conversion attempt if this is found. The code to read
> the index contents was copied pretty verbatim from attr.c, and should
> probably be made into a non-static function instead if there is no
> better way of doing this.

One technical question, see below.

> Note that ALL the tests still pass unmodified. This is a bit
> surprising perhaps, but think it is an indication that no one ever
> intented autocrlf to do what it does to files containing CRs.

Indeed. But a test of its own would be nice, no? If you do not have time, 
I will come up with one.

BTW all this technical description after the "---" should probably go into 
the commit message.

> diff --git a/convert.c b/convert.c
> index 4f8fcb7..9d062c8 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -120,6 +120,43 @@ static void check_safe_crlf(const char *path, int action,
>  	}
>  }
>  
> +static int has_cr_in_index(const char *path)
> +{
> +	int pos, len;
> +	unsigned long sz;
> +	enum object_type type;
> +	void *data;
> +	int has_cr;
> +	struct index_state *istate = &the_index;
> +
> +	len = strlen(path);
> +	pos = index_name_pos(istate, path, len);
> +	if (pos < 0) {
> +		/*
> +		 * We might be in the middle of a merge, in which
> +		 * case we would read stage #2 (ours).
> +		 */
> +		int i;
> +		for (i = -pos - 1;
> +		     (pos < 0 && i < istate->cache_nr &&
> +		      !strcmp(istate->cache[i]->name, path));
> +		     i++)
> +			if (ce_stage(istate->cache[i]) == 2)
> +				pos = i;
> +	}

I think it makes sense to assume that "ours" determines whether we should 
assume that the index has a wrong format. But if there is also a "base" 
that disagrees on CR-ness with "ours", should we not try to pick "ours"?

Ciao,
Johannes
