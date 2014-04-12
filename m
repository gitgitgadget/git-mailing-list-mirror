From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] test: fix t7001 cp to use POSIX options
Date: Sat, 12 Apr 2014 23:52:35 +0200
Message-ID: <5349B5A3.30601@web.de>
References: <1c3e86191de8c91545ac3ddc18fd31e@74d39fa044aa309eaea14b9f57fe79c>	<20140411114338.GD28858@sigill.intra.peff.net> <xmqq1tx3u0ts.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 12 23:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ5rH-00033L-8g
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 23:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbaDLVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 17:53:00 -0400
Received: from mout.web.de ([212.227.17.12]:49686 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715AbaDLVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 17:52:59 -0400
Received: from [192.168.178.41] ([79.193.67.45]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M5x3d-1WsXS10eXx-00xwP2; Sat, 12 Apr 2014 23:52:36
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq1tx3u0ts.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:qWa3tRXrukGrlusixXDU3w09Qeo/AWHe/2yW/zxw5Kx7HCSieM7
 C7f9tJrjzGB8GyChOtMxCDx8RMI4+xi+vk4EjmZSlFGfAoGYoreH0AOobRli9ldII8W4Cy3
 SDuL3Y8IsTb5xM24BoyvFUCXU8ZhZe9R425ydx/KBOnmoUEZa4CJgDfqJkhl9q2c6tgcGmF
 uphhZ/0ROaIBQ9Im6h9rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246197>

Am 11.04.2014 21:23, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> On Fri, Apr 11, 2014 at 01:24:02AM -0700, Kyle J. McKay wrote:
>>
>>> Since 11502468 and 04c1ee57 (both first appearing in v1.8.5), the
>>> t7001-mv test has used "cp -a" to perform a copy in several of the
>>> tests.
>>>
>>> However, the "-a" option is not required for a POSIX cp utility and
>>> some platforms' cp utilities do not support it.
>>>
>>> The POSIX equivalent of -a is -R -P -p.
>>>
>>> Change "cp -a" to "cp -R -P -p" so that the t7001-mv test works
>>> on systems with a cp utility that only implements the POSIX
>>> required set of options and not the "-a" option.
>>
>> I wonder if the "-R" is the part that we actually care about here.
>> Including the others does not hurt in that case, but using only "-R"
>> would perhaps make it more obvious to a later reader of the code exactly
>> what we are trying to do.
> 
> These calls to "cp" are about "We know that earlier 'update' created
> the GIT_DIR of the submodule in the top-level superproject, because
> we are running a modern Git.  But we want to make sure the command
> we are testing, "git mv", would work correctly if the repository
> were made with an older Git that created the GIT_DIR embedded in the
> working tree of the submodule, so let's emulate that case."  As we
> create files and directories in GIT_DIR with explicit permission
> bits, we may care about
> 
>  (1) making sure "git mv" can actually move the directory, with some
>      paths having mode bits different from the umasked default; and
> 
>  (2) checking that the GIT_DIR after "git mv" has the permission
>      bits right.

When writing these tests I didn't care about (2), but - in addition
to the first half of (1) - I had another thing in mind:

(3) "git mv" shouldn't try to update the 'core.worktree' setting
    when the GIT_DIR is embedded in the submodule's work tree.

> and if we cared, "-R -p" would be required here, not just "-R".
> 
> If core.prefersymlinkrefs is set, GIT_DIR would have a symbolic link
> HEAD pointing at the current branch, and "-P" may become relevant,
> but manually running "cp -R .git git && ls -l git/HEAD" in such an
> old repository tells me that symbolic link HEAD is not dereferenced
> without an explicit "-L", so I dunno.
> 
> Because we do not check anything inside GIT_DIR of the moved
> submodule after "git mv" is done, the more correct use of "cp" is
> moot for the purpose of (2), but it could be possible that "git mv"
> fails to move a submodule with GIT_DIR created embedded in its
> working tree by an older version of Git, while successfully copying
> an emulated one, due to differences such as modes and symlinks.
> 
> The current implementation just does rename(2) on the whole
> submodule working tree and let its contents move together, so I do
> not think it matters at the moment for the purpose of (1); use of
> flags other than "-R" are purely for future-proofing, I would think.

Thanks for your detailed analysis and sorry to all parties involved
for the hassle caused by my knee-jerk reaction to just use "cp -a"
when I wanted to have an exact copy of 'that' directory 'there'.

Given that all other tests just use "cp -R" too in that situation
I'm all for the second version of Kyle's patch, so an "Acked-by"
from me on that one.
