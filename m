From: Junio C Hamano <gitster@pobox.com>
Subject: Re: StGit hooks
Date: Wed, 28 Nov 2007 11:31:08 -0800
Message-ID: <7vfxyq5fr7.fsf@gitster.siamese.dyndns.org>
References: <20071128101718.GA13940@diana.vm.bytemark.co.uk>
	<474D5482.5020609@op5.se>
	<20071128121905.GA15953@diana.vm.bytemark.co.uk>
	<474D69A7.6020404@op5.se>
	<20071128132605.GB15953@diana.vm.bytemark.co.uk>
	<474D7710.4090303@op5.se>
	<9e4733910711280653q119f2c2n173eaebdda6cd774@mail.gmail.com>
	<474D8205.8030401@op5.se>
	<20071128154059.GA19302@diana.vm.bytemark.co.uk>
	<474DA01C.8010901@op5.se>
	<20071128172152.GB21310@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSdq-00045w-35
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761261AbXK1TbT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 14:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760513AbXK1TbS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:31:18 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56979 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761243AbXK1TbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 14:31:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 143642F0;
	Wed, 28 Nov 2007 14:31:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F0DA9ABC0;
	Wed, 28 Nov 2007 14:31:33 -0500 (EST)
In-Reply-To: <20071128172152.GB21310@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Wed, 28 Nov 2007 18:21:52
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66414>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-11-28 18:06:36 +0100, Andreas Ericsson wrote:
>
>> True, but there are ways of figuring out which branch you're on,
>> using the arguments passed to the hook.
>>
>> The rebase hook (which is where this discussion started) gets the
>> branches passed to "git rebase" as arguments. Figuring out if either
>> of those branches are actually under stgit control shouldn't be
>> overly tricky for one so familiar with stgit as yourself.
>
> No, that part is trivial. The hard part is not messing up the user's
> existing hook scripts.
>
> If I do go ahead and do this, I have a feeling I'll be beefing up
> git's hook dispatch mechanism first -- if I can get it past Junio,
> obviously. :-)

I do not see a fundamental problem in a scheme like this:

 * when running a hook $foo, if .git/hooks/$foo.d/. does not exist, we
   operate as we have always done.

 * if .git/hooks/$foo.d/ exists, we readdir(3) it and run the hooks fou=
nd
   in the order their names sort bytewise (similar to /etc/rc$n.d/).

   - when the purpose of the $foo hook is to return a bool to refuse an
     operation, stop at the first failure;

   - when the purpose of the $foo hook is to cause effect, run them all
     in series.

 * When .git/hooks/$foo.d/ exists, there will always be "050-simple" in
   that directory.  It checks if .git/hooks/$foo exists and sources it
   if it does.  A custom hook that wants to run before or after it can
   be named NNN-mine in .git/hooks/$foo.d/, where NNN sorts earlier or
   later than 050 to define the execution order.

We probably would want to reserve a special exit code for the hooks run
for their effects so that they can signal "I do not want you to run the
remainder".
