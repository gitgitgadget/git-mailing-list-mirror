From: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <tor.arne.vestbo@nokia.com>
Subject: Re: [PATCH] require_work_tree: Look for top-level instead of is-inside-work-tree
Date: Fri, 30 Jul 2010 13:04:30 +0200
Message-ID: <4C52B1BE.8020804@nokia.com>
References: <1280335624-90132-1-git-send-email-tor.arne.vestbo@nokia.com> <7v4ofjw6t6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: ext Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 13:43:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OenzS-0002fG-Vi
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 13:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab0G3Lm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 07:42:56 -0400
Received: from mgw-sa02.nokia.com ([147.243.1.48]:28461 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932157Ab0G3Lm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 07:42:56 -0400
X-Greylist: delayed 2239 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jul 2010 07:42:55 EDT
Received: from [172.24.90.128] (olwst90128.europe.nokia.com [172.24.90.128])
	by mgw-sa02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o6UB1rA7008991;
	Fri, 30 Jul 2010 14:01:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.11) Gecko/20100711 Lightning/1.0b1 Thunderbird/3.0.6
In-Reply-To: <7v4ofjw6t6.fsf@alter.siamese.dyndns.org>
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152240>

Hey, and thanks for your feedback Junio!

On 29.07.10 01.00, ext Junio C Hamano wrote:
> Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com> writes:
>
>  > The documentation describes require_work_tree as guarding against
>  > bare repositories, and that's also the way it's used from porcelai=
n
>  > such as git-rebase. When implemented using --is-inside-work-tree
>  > the samantics change, causing git-rebase to fail if run from outsi=
de
>  > GIT_WORK_TREE, even if GIT_WORK_TREE is valid.
>  >
>  > Signed-off-by: Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com>
>  > ---
>
> The "requirement" is that we _have_ work tree somewhere that we can
> cd-to-toplevel to if we wanted to, not that we _are_ already in the w=
ork
> tree. I can buy that rationale.

Right. You put it much nicer than me :)

> However, I notice that "git bisect", "git mergetool" and "git submodu=
le"
> do not seem to do cd_to_topleve immediately after require_work_tree. =
The
> last one has cd_to_toplevel in later parts of the codepath, presumabl=
y so
> that it can collect paths relative to the subdirectory in the work tr=
ee.
> I wonder if all of them actually need to be run from inside a work tr=
ee?
> Don't they need a separate "git rev-parse --is-inside-work-tree || di=
e"
> check after require_work_tree (or perhaps cd_to_toplevel) if we apply=
 this
> patch?

I think if we have a work tree somewhere, we can at least do "git=20
rev-parse --is-inside-work-tree || cd_to_toplevel" instead of dying,=20
unless there's some danger to that (the user running a command from=20
outside GIT_WORK_TREE but expecting GIT_WORK_TREE to not be touched).

=46or "git bisect" and "git submodule" running them in a sub-directory =
of=20
the work tree complains about needing to be run from the top-level, so =
I=20
assume we can do an unconditional cd_to_toplevel after the=20
require_work_tree?

=46or "git mergetool" we should probably do it conditionally only if th=
e=20
user is not inside a work tree already, so that the behavior of running=
=20
the tool in a sub-directory is not changed.

Tor Arne
