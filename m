From: Jeff King <peff@peff.net>
Subject: Re: git-am cannot apply git format-patch -M
Date: Mon, 28 Mar 2011 08:14:12 -0400
Message-ID: <20110328121412.GB9232@sigill.intra.peff.net>
References: <09D72CB4-1B48-4799-B0D5-DB54942D840F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Maarten Billemont <lhunath@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 14:14:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4BKt-00053D-8m
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1C1MOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:14:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52088
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098Ab1C1MOO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 08:14:14 -0400
Received: (qmail 9242 invoked by uid 107); 28 Mar 2011 12:14:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 08:14:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 08:14:12 -0400
Content-Disposition: inline
In-Reply-To: <09D72CB4-1B48-4799-B0D5-DB54942D840F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170120>

On Mon, Mar 28, 2011 at 09:44:34AM +0200, Maarten Billemont wrote:

> I've created a series of patches for my local commits using:
> 
> git format-patch -M -C ...
> 
> The resulting patch files contain hunks like:
> 
> diff --git a/file1 b/file2
> similarity index 93% 
> rename from file1
> rename to file2
> index 7cf3a09..88c9c13 100644
> --- a/file1
> +++ b/file2
> [...]
> 
> git-am fails at applying these hunks, failing with:
> 
> Applying: [commit description]
> fatal: git apply: bad git-diff - inconsistent old filename on line 109
> Patch failed at [HEAD commit]

I can't replicate your problem using this script:

  git init repo && cd repo

  perl -le 'print for(1 .. 100)' >file1
  git add file1
  git commit -m 'add file1'

  sed 50d file1 >file2
  rm file1
  git add -A
  git commit -m 'move file1 to file2, with tweak'

  git format-patch -M --stdout -1 >patch
  git checkout -b other HEAD^
  git am patch

which generates a patch like the one you mention above. Does that script
work for you? If not, what git version are you using? If it does work,
then perhaps there is something more complex going on in your real repo.
Can you show us a more complete example, with the real filenames?

> Additionally, I'd like to report that the line number reported by
> git-am in this error message does not reflect the actual line number
> of the problem in the patch file.  The reported line number is offset
> by -[amount of lines before the [---] line in the patch file], which
> makes understanding the error message hard, confusing and potentially
> misleading.

Yes. "git am" splits the email into pieces and just feeds the patch
portion to "git apply". The lines it is referencing are in
.git/rebase-apply/patch. It would perhaps be useful if "git apply" gave
the filename in addition to the line number (alternatively, "git am"
could mention the filename after a failed apply).

-Peff
