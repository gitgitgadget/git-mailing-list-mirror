From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] sh-setup: make require_clean_work_tree() work on
 orphan branches
Date: Mon, 30 Nov 2015 13:37:35 +0100
Message-ID: <20151130133735.Horde.6JXMnrTluxoV71C8eVKrKLi@webmail.informatik.kit.edu>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
 <1448376345-27339-2-git-send-email-szeder@ira.uka.de>
 <20151124205036.GF7174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 13:37:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3NiR-0001es-4H
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 13:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbbK3Mhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2015 07:37:55 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52516 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321AbbK3Mhy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 07:37:54 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1a3NiL-0006Pc-7P; Mon, 30 Nov 2015 13:37:53 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1a3Ni3-0000st-D5; Mon, 30 Nov 2015 13:37:35 +0100
Received: from x4db1bb21.dyn.telefonica.de (x4db1bb21.dyn.telefonica.de
 [77.177.187.33]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 30 Nov 2015 13:37:35 +0100
In-Reply-To: <20151124205036.GF7174@sigill.intra.peff.net>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1448887073.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281805>


Quoting Jeff King <peff@peff.net>:

> On Tue, Nov 24, 2015 at 03:45:45PM +0100, SZEDER G=C3=A1bor wrote:
>
>> git-sh-setup's require_clean_work_tree() always exits with error on =
an
>> orphan branch, even when the index and worktree are both clean.  The
>> reason is that require_clean_work_tree() starts off with verifying
>> HEAD, to make sure that it can safely pass HEAD to 'git diff-index'
>> later when it comes to checking the cleanness of the index, and erro=
rs
>> out finding the invalid HEAD of the orphan branch.
>>
>> There are scripts requiring a clean worktree that should work on an
>> orphan branch as well, and those should be able to use this function
>> instead of duplicating its functionality and nice error reporting in=
 a
>> way that handles orphan branches.
>>
>> Fixing this is easy: the index should be compared to the empty tree
>> while on an orphan branch, and to HEAD otherwise.
>>
>> However, just fixing require_clean_work_tree() this way is also
>> dangerous, because scripts must take care to work properly on orphan
>> branches.  Currently a script calling require_clean_work_tree() woul=
d
>> exit on a clean orphan branch, but with the simple fix it would
>> continue executing and who knows what the consequences might be if
>> the script is not prepared for orphan branches.
>
> Hmm. I suspect this is not a big deal in practice. Lots of scripts
> (including some of our own, through history) get the orphan case wron=
g.

Well, to be honest, I thought it's not a big deal, too, but I also =20
thought that the patch will be quickly shot down during review if I =20
don't include some kind of a defense :)
I'd be happier to reroll treating the current behavior in the clean =20
orphan case as a bug, marking that test as expect_failure, and then =20
just fixing it without the ORPHAN_OK thing.

> I'm not sure that require_clean_work_tree is necessarily the place to=
 be
> enforcing it, even though it happened to have done so historically.

Yeah, right...  It should be checked in the main code path, in =20
git_dir_init(), but then it could hurt scripts that already do the =20
right thing on an orphan branch because they don't set the ORPHAN_OK =20
variable.  Though that's probably not a big deal in practice either.  =20
Anyway, as it stands the documentation update of this patch is wrong.
