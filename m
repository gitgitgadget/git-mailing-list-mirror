From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Fri, 7 Oct 2011 12:57:30 +1100
Message-ID: <CAH5451kUf=vPfgOOusmJjfbiyueX9VByJLzZ9WbyqLd0z78wxA@mail.gmail.com>
References: <20110929142027.GA4936@zelva.suse.cz> <20111004103056.GB11236@sigill.intra.peff.net>
 <7vfwj8dbn0.fsf@alter.siamese.dyndns.org> <201110050034.46334.chriscool@tuxfamily.org>
 <7v62k4ban7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Michal Vyskocil <mvyskocil@suse.cz>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 03:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBzhF-0005Bx-8O
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 03:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab1JGB5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 21:57:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48669 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759450Ab1JGB5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 21:57:51 -0400
Received: by eyg7 with SMTP id 7so657513eyg.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SNeoTce/IaQWknTANnU6tj61o456V99iKqwEYUtUymk=;
        b=tmtjtqTiIOMPoWkeWjodo3WEMIHswJPmNbsk+bBSR12JPRLYjLvMOmGuvzR2Yjg/V2
         SAuX3L1ny8JI/3TYK6LGmsWoM2fT/ysvw1N/2YucNBgJ1iaTQjFfzUA2puMjD8shshmO
         M5vkwn7m4jukAX/+14suwSrB9pvMSb3w7q98w=
Received: by 10.223.58.83 with SMTP id f19mr7325139fah.36.1317952670285; Thu,
 06 Oct 2011 18:57:50 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Thu, 6 Oct 2011 18:57:30 -0700 (PDT)
In-Reply-To: <7v62k4ban7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183053>

Hi, I have given this some thought and have a slightly different
proposal for the options to use. I have written a commit message that
I think explains the need for the improvement, and justifies my
proposal. The options I propose are '--intoduced' and '--removed'.

--->8---

Bisect is used to look for a commit that causes a specific change.
Such a change can be classified by the user as either introducing
something, or removing something, and this distinction is arbitrary. A
change could be said to introduce a bug fix, or remove a bug - both
formulations have inherently the same meaning, but search behaviour
changes depending on which one we use.
Suppose I want to find the commit that removed a bug. If I examine a
snapshot and it contains the bug, the bug has not yet been *removed*
and I must look in the future for its removal. Conversely, if I
examine a snapshot and the bug fix exists, the bug fix must have been
*introduced* at some earlier point and so I must search backwards.

Confusion exists at this point because at each verification step a
question like 'Does this snapshot have X?' is asked, when what we
eventually want to know is 'When was X introduced?' or 'When was X
removed?'. Previously there has been no way to specify if we are
looking for X being introduced or removed; it was assumed that we were
looking for when something was introduced, for example when a bug was
introduced.

Teach git bisect if we are looking for when something was introduced
or when something was removed.

Examples.
Search for a feature add:
   $ git bisect start --introduced='feature: git frotz says xyzzy' v0.99 master
   Bisecting: 171 revisions left to test after this (roughly 8 steps)
   $ ... build and then test ...
   $ git bisect tested
   Does this snapshot have 'feature: git frotz says xyzzy' [y/n]? yes
# already added, look backwards

Search for a feature regression:
   $ git bisect start --removed='feature: git frotz says xyzzy' v0.99 master
   Bisecting: 171 revisions left to test after this (roughly 8 steps)
   $ ... build and then test ...
   $ git bisect tested
   Does this snapshot have 'feature: git frotz says xyzzy' [y/n]? yes
# not removed yet, look forwards

--->8---

Regards,

Andrew Ardill
