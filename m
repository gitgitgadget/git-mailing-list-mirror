From: list@phuk.ath.cx
Subject: Re: git rm --cached and pull semantics
Date: Sun, 17 Jan 2010 23:50:02 +0100
Message-ID: <4B53941A.6020500@phuk.ath.cx>
References: <4B51EE39.3010401@phuk.ath.cx> <vpq1vhpufec.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWe5M-0003IR-35
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 23:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab0AQW4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 17:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139Ab0AQW4r
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 17:56:47 -0500
Received: from xdsl-78-35-144-86.netcologne.de ([78.35.144.86]:59563 "EHLO
	horst.phuk.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab0AQW4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 17:56:46 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2010 17:56:46 EST
Received: from [192.168.10.144] (wald.phuk.ath.cx [192.168.10.144])
	by horst.phuk.ath.cx (Postfix) with ESMTP id 502DC24992D;
	Sun, 17 Jan 2010 23:49:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091230 Thunderbird/3.0
In-Reply-To: <vpq1vhpufec.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137348>

On 01/17/2010 12:42 PM, Matthieu Moy wrote:
> list@phuk.ath.cx writes:
>
>> Hello everyone,
>>
>> I'm trying to manage and distribute a subset of /etc with git.
>> Therefore, I have * in .gitignore and use git add -f to add files. Now
>> sometimes I want to un-track a file that has been in previous commits,
>> but naturally I don't want the file deleted. I just want git to ignore
>> it again. As I read it, the way to do that is "git rm --cached $file".
>> On the local working tree, that works as expected, but when some remote
>> machine pulls a subsequent commit, it deletes the file from its working
>> tree. But I just want git to ignore the file again, just as it does in
>> the origin repo. How can I do that?
>
> I'd say there's no way, and there will hardly ever be any :-(.
>
> Git is purely snapshot-oriented, which means that when you do a "git
> rm --cached", the next commit doesn't say "this file has been
> removed", but instead, it says "the file is not here", which can be
> interpreted as "the file is not here _anymore_" when comparing the
> commit and its ancestor.
>
> But as a result, there's no place to store information about _how_ the
> file was removed. So, for the remote machine doing a "git pull", the
> merge algorithm just sees that it's not there, and deletes it.
>
> OTOH, after "git pull", it's rather simple to do something like
>
> git show HEAD@{1}:your-file.txt > your-file.txt
>
> to restore it as an untracked file. Maybe it's possible to automate
> this in a script, but I have no idea how.
>
Thanks for the clarification. I already suspected that this would
require extra information to be transmitted. However, wouldn't it make
sense for the data model to implement this? As far as I can see, the
non-existence of a special placeholder for files being un-added via rm
--cached effectively breaks the semantics of that statement. That is,
the behaviour on the local tree is inconsistent with the behaviour on
trees being pulled. Right now I can't think of a situation where it
would be desirable that a local "git rm --cached" is equivalent to a
plain "git rm" in the trees being pulled. We do have that
differentiation in the UI, so why not implement it consistently?
I'd be willing to dig into the code and come up with patches, but only
if somebody tells me the overall concept could be acceptable.

But thanks anyway for your attention so far ;-)
