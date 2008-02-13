From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Optimize rename detection for a huge diff
Date: Wed, 13 Feb 2008 11:19:45 +0100
Message-ID: <864pcd9n0e.fsf@lola.quinscape.zz>
References: <20080127172748.GD2558@does.not.exist>
	<20080128055933.GA13521@coredump.intra.peff.net>
	<alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
	<20080129222007.GA3985@coredump.intra.peff.net>
	<7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
	<7vwspskynz.fsf@gitster.siamese.dyndns.org>
	<7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org>
	<7vodalqj0s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 11:20:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEjI-0001my-5m
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbYBMKUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYBMKUA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:20:00 -0500
Received: from main.gmane.org ([80.91.229.2]:35284 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbYBMKT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:19:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JPEia-0002zT-BS
	for git@vger.kernel.org; Wed, 13 Feb 2008 10:19:56 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 10:19:56 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 10:19:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:W9VrNNf85x6DNgzLFO+hPB7KkTo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73767>

Junio C Hamano <gitster@pobox.com> writes:


> The first hunk is about shrinking the diff_score structure;
> before the patch, it was O(NxM) where N and M are number of
> rename source and destination candidates, but after the patch it
> is now O(M), so this shrinkage should not matter, but score is
> capped to MAX_SCORE (60000) and name_score is actually 0 or 1.
> We cannot make it 1-bit unsigned bitfield as there is a qsort
> comparison callback that does (b->name_score - a->name_score).

Hm?  Can't that be changed into

(b->name_score > a->name_score ? 1 
 : b->name_score < a->name_score ? -1 : 0)

or something?  Or perhaps just

  ((int)b->name_score - (int)a->name_score)

or so?

It sounds like a factor 2 is in question here, and that would seem like
an easy fix?

-- 
David Kastrup
