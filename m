From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Thu, 28 Jul 2011 18:48:20 +0200
Message-ID: <4E3192D4.5000504@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>  <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>  <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>  <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>  <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com> <1311843465.3734.40.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:48:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTlD-0007mz-Ai
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603Ab1G1Qsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:48:31 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:37561 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab1G1Qsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:48:30 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 057BA1A7402AF;
	Thu, 28 Jul 2011 18:48:26 +0200 (CEST)
Received: from [93.246.48.187] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QmTl3-0001bw-00; Thu, 28 Jul 2011 18:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1311843465.3734.40.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18uhy3Mjk/BJzal0hL9iEl4TyJe4vJeR5fw+hnE
	rct7Z5xpF0CAltgNdF/+MzBlMCJv5kJ1WqMdzEf1GTcp5jINSp
	3Nwb4W7EoawGX9vAq1EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178080>

Am 28.07.2011 10:57, schrieb henri GEIST:
> In the current code it was not possible to add a gitlink to a repository
> outside of the main repository.

Me thinks this is a *feature* this patch removes (as I understand it it was
a major design decision that everything /inside/ a directory is controlled
by git).

> This pach :
<snip>
>   - Still forbids to add anything else.

Why? If you let submodules live outside the tree I don't see any reason why
regular files shouldn't live there too (Disclaimer: I d not think that would
be a good idea either ;-).

What you want looks like this:

-+- lib1    #registered as submodule of project1 *and* project2 but not here
 +- project1            # submodule of the superproject
 |  +- ../lib1
 +- project2            # submodule of the superproject
    +- ../lib1

You are opening a can of worms by having two different repos point to the same
submodule living in a third repo (which also happens to be their superproject
and must somehow ignore it). You'll have two SHA1s for a single submodule;
"git submodule foreach --recursive" will have interesting results too; and so
on. Not good.

What about solving that with a "ln -s ../lib1" in "project1" and "project2"
(you seem to need that for your build environment) and adding the submodule
"lib1" to the superproject just like "project1" and "project2"?
