From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Thu, 05 Jan 2012 23:52:54 +0100
Message-ID: <4F0629C6.9010908@web.de>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com> <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de> <7vsjjwvdyl.fsf@alter.siamese.dyndns.org> <4F037CBF.9010005@web.de> <7vhb0csa6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 23:53:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiwBP-0006HO-76
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 23:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983Ab2AEWxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 17:53:09 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:58231 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab2AEWxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 17:53:08 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id A17A668D0269
	for <git@vger.kernel.org>; Thu,  5 Jan 2012 23:52:56 +0100 (CET)
Received: from [192.168.178.43] ([91.3.186.209]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0McneT-1S0sXG0XVx-00Hwap; Thu, 05 Jan 2012 23:52:55
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vhb0csa6w.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:6QY2qArshYN5Dp0EXrs2LAImHzOPL9biU2HJZOxI8/Y
 Qve1xRyGFXPlTUI3K7PjdnVnc4TFxIgDQgCWKHM2CgSdwyAKD7
 ORdrTsncXLF8nwdlDIpTPiztLfCYteUFuCqVaIZoTLLy6qFY9H
 jXqtOZNAxLHzO6yIUvSN8rilg8MZ20zO9Y5EWEuSe7R46PLwu5
 JjEAwoLbvxSgUnKkyFBmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188007>

Am 03.01.2012 23:17, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Not if we would implement a "if no worktree is set but we came here via
>> a gitfile, then take the directory the gitfile was found in as worktree"
>> heuristic. And that heuristic looks quite sane to me, as a gitfile can
>> only be found in a work tree, or am I missing something obvious here?
> 
> Like it wouldn't work without changes to the core side?

I totally agree that when just talking about being able to move the
superproject around that approach is more invasive than just adding
a relative core.worktree setting and is just not worth the hassle.

But I was also thinking about moving the submodule around inside the
superproject. Until the gitfile was used that meant just mv'ing the
submodule and changing the path in .gitmodules accordingly. Now you
also have to adjust the core.worktree setting and maybe also the
gitfile content (if you move the submodule out of the directory level
it lived in before).

One solution I can think of is to teach "git mv" about submodules and
let it do the necessary changes to .gitmodules (which seems to be a
good idea anyways), core.worktree and the gitfile. The manipulation of
core.worktree could be obsoleted by not using that setting but instead
implementing the heuristic I described above. And if the gitfile could
be taught somehow that a path in there is relative to the superprojects
root directory, then it would never have to be changed either, restoring
the behavior we had before introducing the gitfile.

So in the long run I suspect we might have to change core git anyways
to make moving submodules easy for the user (surely "git mv" and maybe
also the setup and gitfile code). Does that make more sense?

If not I'm fine with just setting core.worktree to a relative path in
the git-submodule.sh script (like I did for the gitfile). And I'll look
into teaching "git mv" about submodules right after that.
