From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 13 Jul 2010 09:00:23 +0100
Message-ID: <1279008023.2030.11.camel@wpalmer.simply-domain>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
	 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>
	 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
	 <20100712184754.GA18429@localhost>
	 <7v39vo8dkn.fsf@alter.siamese.dyndns.org>
	 <20100713071317.GA26348@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 13 10:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYaPq-0005IT-S2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 10:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab0GMIA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 04:00:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55074 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0GMIA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 04:00:27 -0400
Received: by bwz1 with SMTP id 1so11308bwz.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=X0g2DINo3tIyRYeXDW2/KvKK4BOeCVb6GaN66ljYBZM=;
        b=GghVCnTNErUCn6e1uzZwSO1Mv+TbcXRJhvFuKCs12j0xIYn/CZCrJOI/pgn55FNu4v
         +GDZ2J5H8Vzn/KgQ8UuTqhQnbWdgrEZkNDYlVvkmjx2FwttYv3Dz8GB1WTbF2Hzc5I23
         iiP3tfaqKv4uX4ETmt5mG9xFWpmXAwBn5QPWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=t3IaBM5/1YuNq9oltcdS5ftVIyPGxN78JGEapEru20GmNi2otQE8SwsPf40vcqgWwB
         b3fi/k+zJzgaCCFRyacH9eq5mDpvsX9ZonR157kzwGwsvRgV/6aVG2mYdusH1nz454Lk
         9uCJElXzUmbF0V4rGSxxsnYVwnXtEmCVefYZI=
Received: by 10.204.14.71 with SMTP id f7mr11743290bka.200.1279008026286;
        Tue, 13 Jul 2010 01:00:26 -0700 (PDT)
Received: from [192.168.2.128] ([193.164.118.24])
        by mx.google.com with ESMTPS id o20sm22561293bkw.3.2010.07.13.01.00.24
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 01:00:25 -0700 (PDT)
In-Reply-To: <20100713071317.GA26348@localhost>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150885>

On Tue, 2010-07-13 at 09:13 +0200, Clemens Buchacher wrote:
> Why would we need that? Even now, it is not enough to do "git
> branch -D frotz; git gc --prune". You need to expire the reflog,
> since HEAD may still have a reference to it. So instead you would
> need
> 
>  git branch -D frotz
>  git reflog expire --expire=now HEAD frotz
>  git gc --prune
> 
> Purging a branch becomes just a special case of purging anything
> from history.
> 
> Clemens

With that in mind, would it not be enough to simply remove the ref, but
not the reflog, and change the logic to let the reflog live on until
either pruned or all of its entries have expired normally? On branch
creation, if a reflog already exists, it would remain untouched. Reflog
entries would ALWAYS expire using the same expire-time rules, regardless
of whether or not the ref itself exists, and everything just makes
sense. Simple to follow, simple to prune, branch -d becomes just as safe
as any other operation. I like this.

I understand the argument for "but you may wind up creating an unrelated
branch with the same name", but I can't really think of any cases where
it would matter, and it would be impossible to guess whether or not a
new branch were related to the old one. If we'd really want to take care
of that sort of thing, we'd need to move into two-dimensional reflog
territory, with something like somebranch@{3,5} to mean "3 reflogs ago,
5 states ago", which goes too far and looks ugly.
