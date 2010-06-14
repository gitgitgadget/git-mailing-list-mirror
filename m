From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash completion: Support "divergence from upstream" messages in __git_ps1
Date: Mon, 14 Jun 2010 09:42:42 +0200
Message-ID: <201006140942.43099.trast@student.ethz.ch>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> <4C13F32B.7060106@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 09:42:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO4Js-0005uq-Ks
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 09:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0FNHmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 03:42:51 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:5764 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab0FNHmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 03:42:50 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 09:42:48 +0200
Received: from thomas.localnet (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 09:42:50 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <4C13F32B.7060106@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149081>

Andrew Sayers wrote:
> I've added a message in the "equal to upstream" case, to differentiate
> it from the "no upstream" case.  Again, this is an over-the-shoulder
> issue - when I see an "=" (or " u=") in someone's prompt, I don't have
> to patronise them about whether they've e.g. misconfigured their
> branch.

I omitted it because I thought it would be too cluttery, but then my
branches seem to rarely agree with their upstream.

> +       local cfg=( $( git config --get-regexp '^bash\.showUpstream$|^svn-remote\..*\.url$' 2>/dev/null ) )

Doesn't this break if the config value contains spaces?  I don't know
enough about bash arrays but in my simple tests, the array elements
are split between words.

And with the new design, you practically *expect* the config key to
contain spaces.

Along the same lines, I think
> +                               GIT_PS1_SHOWUPSTREAM="${cfg[$((n+1))]}"
> +                               if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
can never trigger because bash will never see the empty config string.

Slightly more robust would be to use

  git config --get-regexp '^bash\.showUpstream$|^svn-remote\..*\.url$' \
    2>/dev/null |
  while read key value, do
    # stuff
  done

That still breaks in the case of values containing newlines, though.

> I like the "ref" option, but I'm not really sure when "eval" would be
> useful.  I've changed it here to "cmd" so people are encouraged to put
> their work in a script.
[...]
> +#           cmd=<command> compare HEAD to the output of <command>
[...]
> +		cmd\=*) upstream=$( "${option:4}" ) ;;

"Encourage" is a mild understatement; AFAICS the code doesn't work
with more than single-word command any more.

The original intent was that the user could put a (very small) shell
script directly in the configuration if the normal DWIMming doesn't
fit his neds, perhaps most likely in the case of git-svn (do other
remote helpers have the same problem?).

Having to wrap it in a script defeats that point, as it becomes almost
as easy to edit the completion script.  So I think if it can't eval,
you might as well remove it.

BTW, please spell $(command) substitution without the spaces.  Your
current style does not match what is already in the file.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
