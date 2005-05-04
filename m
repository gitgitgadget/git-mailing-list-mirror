From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Wed, 04 May 2005 18:26:25 +1000
Organization: Core
Message-ID: <E1DTFD7-00063T-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.58.0505031947530.26698@ppc970.osdl.org>
Cc: dwheeler@dwheeler.com, pj@sgi.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:21:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTF8C-0002VL-64
	for gcvg-git@gmane.org; Wed, 04 May 2005 10:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVEDI1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 04:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVEDI1T
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 04:27:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:14604 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261388AbVEDI06
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 04:26:58 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DTFDA-00030N-00; Wed, 04 May 2005 18:26:28 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DTFD7-00063T-00; Wed, 04 May 2005 18:26:25 +1000
To: torvalds@osdl.org (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.58.0505031947530.26698@ppc970.osdl.org>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> But putting the traps _inside_ the loops seems to help. So something like 
> the appended at least makes it somewhat useful

It's not the loop that's important, but the subshell where the
signal is caught.  Every time you enter a subshell all traps are
reset.  Since anything that comes (before or) after a pipe symbol
goes into a subshell...

> Index: cg-log
> ===================================================================
> --- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-log  (mode:100755 sha1:aa2abf370753117a350818dbc91991b14d30ec6b)
> +++ uncommitted/cg-log  (mode:100755)
> @@ -47,10 +47,12 @@
> fi
> 
> $revls | $revsort | while read time commit parents; do
> +       trap "exit 1" SIGPIPE
>        [ "$revfmt" = "git-rev-list" ] && commit="$time"
>        echo $colheader""commit ${commit%:*} $coldefault;
>        git-cat-file commit $commit | \
>                while read key rest; do
> +                       trap "exit 1" SIGPIPE
>                        case "$key" in
>                        "author"|"committer")
>                                if [ "$key" = "author" ]; then

You need it in both places because the signal may be received
in either place, depending on whether it's the echo or something
inside the loop that dies while writing output.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
