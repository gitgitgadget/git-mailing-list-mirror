From: David Kastrup <dak@gnu.org>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 04 Feb 2014 10:31:07 +0100
Organization: Organization?!?
Message-ID: <87mwi7xm04.fsf@fencepost.gnu.org>
References: <loom.20140204T030158-758@post.gmane.org>
	<CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com>
	<loom.20140204T055040-646@post.gmane.org>
	<87r47jxp6k.fsf@fencepost.gnu.org>
	<loom.20140204T094437-148@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 10:31:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAcLm-0002ti-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 10:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbaBDJbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 04:31:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:36071 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbaBDJbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 04:31:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAcLd-0002oB-0i
	for git@vger.kernel.org; Tue, 04 Feb 2014 10:31:17 +0100
Received: from x2f46198.dyn.telefonica.de ([2.244.97.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 10:31:17 +0100
Received: from dak by x2f46198.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 10:31:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f46198.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:eaAGuOEhp+FIbRJPrTfquKDYlZc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241518>

chris <jugg@hotmail.com> writes:

> David Kastrup <dak <at> gnu.org> writes:
>> chris <jugg <at> hotmail.com> writes:
>> > Duy Nguyen <pclouds <at> gmail.com> writes:
>> >> On Tue, Feb 4, 2014 at 9:20 AM, chris <jugg <at> hotmail.com> wrote:
>> >> > $ git push origin next
>> >> > Counting objects: 56, done.
>> >> > Delta compression using up to 4 threads.
>> >> > Compressing objects: 100% (9/9), done.
>> >> > Writing objects: 100% (9/9), 895 bytes | 0 bytes/s, done.
>> >> > Total 9 (delta 8), reused 0 (delta 0)
>> >> > Auto packing the repository for optimum performance.
>> 
>> > However, I question why I should even care about this message?  I'm going to
>> > assume that simply it is a lengthy synchronous operation that someone felt
>> > deserved some verbosity to why the client push action is taking longer than
>> > it should.  Yet that makes me question why I'm being penalized for this
>> > server side operation.  My client time should not be consumed for server
>> > side house keeping.
>> 
>> Your "client time" is not consumed: this is not a busy wait.  Git server
>> processes are synchronous: they are initiated and completed under the
>> control of a client.  That means that if you run a batch script
>> executing a number of commands in a client, it will not saturate the
>> server with half-finished processes and/or will refuse to honor requests
>> because the repository is locked.
>
> I'm slightly confused by your response.  You say "client time" is not
> consumed, but then go on to say that git server processes are
> synchronous to avoid build up from batched client requests.  I expect
> you took "client time" to have some specific technical meaning, while
> I simply meant that the client command did not return until the server
> completed its own house keeping.

Until the server completed the house keeping initiated under the control
of the client and on behalf of its command.

> But I do think we are on the same page otherwise in that the client
> command is blocked until the server process completes.

Sure.

> That said I would naively assume that a server side house keeping
> operation that does not get invoked with every client request be a
> nice candidate for asynchronous handling without any need to tell the
> client about it.

Except that there are _no_ asynchronously handled repository actions
executed on behalf of a client action.  If the repository owner decided
to disable demand-based garbage collection in favor of a cron job,
that's his call to make.  It makes some sense when there are frequent
and multiple accesses to the repository since it avoids getting denied
access because of somebody _else_ triggering garbage collection
predominantly when times are busiest.

Usually you are not denied access by your _own_ garbage collection since
the client waits until completion.

It would be quite bad for scripting git if you constantly had to check
after every action whether any associated garbage collection might or
might not have completed.

Note also that when pushing without a separate server process (like when
pushing into a local repository), there is no other job which could be
responsible for packing the repository rather than the one doing the
push.

-- 
David Kastrup
