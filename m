From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Mon, 18 Jul 2011 01:59:19 -0700 (PDT)
Message-ID: <m3pql8yngt.fsf@localhost.localdomain>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu>
	<4E200611.9010005@alum.mit.edu>
	<7vlivz1inu.fsf@alter.siamese.dyndns.org>
	<20110715212059.GA2117@sigill.intra.peff.net>
	<4E212113.6000906@alum.mit.edu>
	<1310909091.21563.23.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Jul 18 11:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qijku-0004dX-VR
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 11:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab1GRJEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 05:04:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51867 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1GRJEl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2011 05:04:41 -0400
Received: by ewy4 with SMTP id 4so1353790ewy.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=jbFwg+KQ4NeVo01kNvLPD8P0XfBUBVCQoNZ2e9Y4OFw=;
        b=W8vw5Wunhff8i5auIOea2A2DeMz+Hb0xQCX14kqipS9XC3ObnixmVAoCVLpJNJ3wLj
         BcNE/83rZWr8ETySu5kRG2ObGv4Zmnou7ffW0OUsOJyVODBYqr/9ym+beiohIJdsROF1
         XicZ9JLmBAX1GwbiGSYKJ/3qZWbj4DAHxYDxM=
Received: by 10.213.13.19 with SMTP id z19mr2175666ebz.107.1310979560487;
        Mon, 18 Jul 2011 01:59:20 -0700 (PDT)
Received: from localhost.localdomain (abvm165.neoplus.adsl.tpnet.pl [83.8.210.165])
        by mx.google.com with ESMTPS id c10sm1808861eeb.67.2011.07.18.01.59.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 01:59:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6I8wtIR012093;
	Mon, 18 Jul 2011 10:59:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6I8wQFW012088;
	Mon, 18 Jul 2011 10:58:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1310909091.21563.23.camel@drew-northup.unet.maine.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177363>

Drew Northup <drew.northup@maine.edu> writes:

> On Sat, 2011-07-16 at 07:26 +0200, Michael Haggerty wrote:
>=20
> > Currently, the loose ref cache is stored as a single linked list, s=
o
> > there is no easy way to populate part of it now and part of it late=
r.
> > So with the current data structure, the loose refs cache is
> > all-or-nothing.  It would be possible to avoid filling it if there =
are
> > not replace references, but if there is even one loose replace refe=
rence
> > then the whole refs tree would have to be crawled.  Implementing th=
is
> > variation is alternative 4 from the early email.
> >=20
> > More flexible would be to change the way the loose ref cache is sto=
red
> > from a linked list into a tree (probably mirroring the directory tr=
ee).
>=20
> Given the potential for high performance inherent with trees, why mix
> metaphors like this? What would the gain be?

Did you mean: "why linked list"?  I _guess_ that it is most probably
because linked list is simpler and better known data structure than
non-binary tree.

What is needed I think is something like trie[1], but with path
components and not letters stored in trie nodes.

[1]: http://en.wikipedia.org/wiki/Trie
=20
> >  If this were done, then it would be possible to populate the cache
> > lazily, only crawling the part of the refs tree that is needed for =
a
> > particular call of for_each_ref() and reusing any part of the cache=
 that
> > is already in memory. =20
>=20
> Is this the argument for directory structure mirroring?

--=20
Jakub Nar=EAbski
