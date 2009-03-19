From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: [PATCH 2/2] Make Git respect changes to .gitattributes during checkout.
Date: Thu, 19 Mar 2009 16:42:27 +0100
Message-ID: <49C267E3.1020205@nokia.com>
References: <49B8DD1D.3060908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: ext Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 16:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkKPe-0005cO-AP
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZCSPmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZCSPmg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:42:36 -0400
Received: from hoat.troll.no ([62.70.27.150]:50925 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbZCSPmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:42:35 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id E01E52081A;
	Thu, 19 Mar 2009 16:42:28 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id CF94620C24;
	Thu, 19 Mar 2009 16:42:28 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2JFgSaO030989;
	Thu, 19 Mar 2009 16:42:28 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Thu, 19 Mar 2009 16:42:28 +0100 (CET)
In-Reply-To: <7vprgkg2kx.fsf@gitster.siamese.dyndns.org>
References: <1236950656-1967-3-git-send-email-kristian.amlie@nokia.com>
References: <7vprgkg2kx.fsf@gitster.siamese.dyndns.org>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.19 (X11/20090122)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113784>

ext Junio C Hamano wrote:
> In a well structured git program, we always read from the work tree and
> the index (to see if there is something changed---you need to be able to
> apply convert_to_git when you do this), internally compute what should
> happen (e.g. decide that the new result needs to be checked out for a
> path), and then write it out (you apply convert_to_working_tree while you
> do this).  So how about doing something like the attached patch?
> 
> The patch allows the caller to tell the usual "read from the working tree,
> if not use the version from the index as the fallback" logic to be swapped
> around, and take the index version.  It may or may not pass your new tests
> (I haven't even compile tested it), but I think the damage is minimized
> compared to your version.

You're right, that's a much cleaner approach. The patch is really good
as far as I can see. It fixes both my test cases (including the one I
wasn't able to fix), and there are no additional failures when running
the autotests. Do you have second thoughts about it, or is it good
enough to apply?

If it is, I'll move the test case into t0021-conversion.sh like you said
and give you a new patch for that.

> It is great that you are trying to fix this issue for the most obvious
> "switching between two branches while not having a local change" case, but
> frankly, I do not think this is solvable in more general cases, and that
> is why it was kept "known to be broken, not worth fixing" state.
> 
> For example, you may notice that, after making a clean checkout, one path
> has a wrong attribute assigned to it, and may try to correct it.  But how?
> 
>  $ edit .gitattributes ;# mark foo.dat as binary
>  $ rm foo.dat
>  $ git checkout foo.dat ;# make sure the new settings is correct???

As far as I can see, this works without any modifications to the patch.
Is that maybe because git_attr_set_direction() is not called if you use
that form of checkout?

--
Kristian
