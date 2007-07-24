From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: Big syntax change; support rewriting 
 multiplerefs
Date: Tue, 24 Jul 2007 11:27:49 +0200
Organization: eudaptics software gmbh
Message-ID: <46A5C615.24C24F0F@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 11:28:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGgT-0002P5-Dp
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761176AbXGXJ16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761713AbXGXJ16
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:27:58 -0400
Received: from main.gmane.org ([80.91.229.2]:56481 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760279AbXGXJ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:27:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDGgH-0004jX-N3
	for git@vger.kernel.org; Tue, 24 Jul 2007 11:27:49 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 11:27:49 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 11:27:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53545>

Johannes Schindelin wrote:
> +# These refs should be updated if their heads were rewritten
> +
> +git rev-parse --revs-only --symbolic "$@" |
> +while read ref
> +do
> +       # normalize ref
> +       case "$ref" in
> +       HEAD)
> +               ref="$(git symbolic-ref "$ref")"
> +       ;;
> +       refs/*)
> +       ;;
> +       *)
> +               ref="$(git for-each-ref --format='%(refname)' |
> +                       grep /"$ref")"
> +       esac
> +
> +       git check-ref-format "$ref" && echo "$ref"
> +done > "$tempdir"/heads

This does not work as I'd expected it: I can't successfully say:

   git-filter-branch master

It tells me:

   Which ref do you want to rewrite?

> +# NEEDSWORK: we should sort the unmapped refs topologically first
> +while read ref
> +do
> +       sha1=$(git rev-parse "$ref"^0)
> +       test -f "$workdir"/../map/$sha1 && continue
> +       # Assign the boundarie(s) in the set of rewritten commits
> +       # as the replacement commit(s).
> +       # (This would look a bit nicer if --not --stdin worked.)
> +       for p in $((cd "$workdir"/../map; ls | sed "s/^/^/") |
> +               git rev-list $ref --boundary --stdin |
> +               sed -n "s/^-//p")
> +       do
> +               map $p >> "$workdir"/../map/$sha1
> +       done
> +done < "$tempdir"/heads

This logic seems to be borked, and I don't grok it. I was trying this:

   git-filter-branch -- --since=2007.01.10 \
		refs/heads/topic refs/heads/master

where topic's last change is from before 2007.01.10, i.e. it is not
among the rewritten commits. And I get this:

WARNING: Ref 'refs/heads/master' is unchanged
WARNING: 'refs/heads/topic' was rewritten into multiple commits:
329325526647503382ae7dee41c12fe6b81bbe43
2bdf3349b76f72ceb71755c75a555d60bc7c73aa
ce6c9dfeac5ddbd64da2d9360d6552717df81d1f

The first 2 of these 3 sha1s happen to be merge bases of topic and
master, but none of them appear anywhere in

   git rev-list --parents --boundary --since=2007.07.10 \
		refs/heads/topic refs/heads/master

What's up?

-- Hannes
