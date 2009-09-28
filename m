From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Mon, 28 Sep 2009 10:12:47 +0200
Message-ID: <4AC06FFF.20008@viscovery.net>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com> <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com> <20090927074015.GB15393@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Himpel <chressie@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 10:12:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsBLt-0005f4-E5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 10:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbZI1IMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 04:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbZI1IMs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 04:12:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16282 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZI1IMr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Sep 2009 04:12:47 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MsBLk-0008LL-0j; Mon, 28 Sep 2009 10:12:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9D977A4A1; Mon, 28 Sep 2009 10:12:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20090927074015.GB15393@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129235>

Jeff King schrieb:
> On Fri, Sep 25, 2009 at 06:43:20PM +0200, Christian Himpel wrote:
>=20
>> According to egrep(1) the US-ASCII table is used when LC_ALL=3DC is =
set.
>> We do not rely here on the LC_ALL value we get from the environment.
>=20
> Hmm. Probably makes sense here, as it is a wide enough range that it =
may
> pick up other stray non-ascii characters in other charsets (though as
> the manpage notes, the likely thing is to pick up A-Z along with a-z,
> which is OK here as we encompass both in our range).
>=20
> There are two other calls to egrep with brackets (both in
> git-submodule.sh), but they are just [0-7], which is presumably OK in
> just about any charset.
>=20
> Do you happen to know a charset in which this is a problem, just for
> reference?

It's not so much about charsets than about languages:

       Within a bracket expression, a range expression consists
       of two characters separated by a hyphen.  It matches any
       single character that sorts between the two  characters,
       inclusive,  using  the  locale's  collating sequence and
       character set.  For example, in the  default  C  locale,
       [a-d]  is equivalent to [abcd].  Many locales sort char-
       acters in dictionary order, and in these  locales  [a-d]
       is  typically  not  equivalent  to  [abcd];  it might be
       equivalent to [aBbCcDd], for  example.   To  obtain  the
       traditional  interpretation  of bracket expressions, you
       can use the C locale by setting the  LC_ALL  environment
       variable to the value C.

=46or example, in locale de_DE.UTF-8, GNU grep '[a-z]' matches lowercas=
e
letters, uppercase letters (!), and umlauts (!!) because in dictionary
order, 'A' and 'a' are equivalent and '=C3=84' sorts after 'A'. (The in=
put must
be UTF-8, of course.)

Given that this applies not only to egrep, but to grep in general (and
perhaps even to other tools that support ranges, like sed), it may be
necessary to audit all range expressions.

The case identified by Christian is certainly important because it is
applied to a file whose contents can be anything, and the purpose of th=
e
check is to identify the text as an mbox file, whose header section can=
 be
only US-ASCII by definition. So, I think it has merit to apply the patc=
h.

-- Hannes
