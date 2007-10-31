From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Wed, 31 Oct 2007 16:08:37 +0100
Message-ID: <104D272D-AD9E-49D7-A503-E9402766CF6F@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <11935038084055-git-send-email-prohaska@zib.de> <7vwst7wvdr.fsf@gitster.siamese.dyndns.org> <722152C5-299C-435E-B720-D2D331D16249@zib.de> <7vd4uzuu1g.fsf@gitster.siamese.dyndns.org> <7v7il7usyx.fsf@gitster.siamese.dyndns.org> <55CCFD12-C10F-46A6-8D65-544231DEBF3F@zib.de> <7v1wbfufbo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:08:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InFB6-0008VE-Dt
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166AbXJaPIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756322AbXJaPIG
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:08:06 -0400
Received: from mailer.zib.de ([130.73.108.11]:39282 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759372AbXJaPIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 11:08:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9VF7Gs9025524;
	Wed, 31 Oct 2007 16:07:16 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9VF7Cv1007353
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 31 Oct 2007 16:07:12 +0100 (MET)
In-Reply-To: <7v1wbfufbo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62842>


On Oct 28, 2007, at 9:58 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Oct 28, 2007, at 5:03 PM, Junio C Hamano wrote:
>> ...
>>> An alternative, just to let me keep my nicer public image by
>>> pretending to be constructive ;-)
>>>
>>> Introduce a configuration "remote.$name.push_default" whose
>>> value can be a list of refs.  Teach the push command without
>>> refspecs:
>>>
>>> 	$ git push
>>> 	$ git push $remote
>>>
>>> to pretend as if the listed refspecs are given, instead of the
>>> traditional "matching branches" behaviour.
>>>
>>> Then, introduce another option
>>>
>>> 	$ git push --matching
>>> 	$ git push --matching $remote
>>>
>>> to override that configuration, if set, so that the user who
>>> usually pushes only the selected branches can use the "matching
>>> branches" behaviour when needed.
>>>
>>> Along with your earlier "git push $remote HEAD" patch, this will
>>> allow you to say:
>>>
>>> 	[remote "origin"]
>>>         	push_default = HEAD
>>>
>>> and your
>>>
>>> 	$ git push
>>>
>>> will push only the current branch.
>>
>> Sounds reasonable; but it is more work. I'm not starting to
>> implement this today.
>
> Take your time; nobody is in a hurry.
>
> If somebody usually uses "matching" behaviour, i.e. without
> remote.$name.push_default configuration, but wants to push only
> the current branch as a one-shot operation, we can obviously use
> "git push $remote HEAD".  But to be complete, it may make sense
> to have another option
>
> 	$ git push --current
>
> that lets you omit $remote (and default to the value configured
> with branch.$name.remote).

Here is an alternative proposal.

The idea is that in a workflow based on a shared repository
git pull and git push should be 'more' symmetric than they are
in a pull-only based workflow. The integration of changes is
'more' direct. Working against a shared repository may require
to integrate new changes before pushing. Changes are also
pushed directly to the remote branch you originally branched
off. Both is different from a pull-only workflow, where I first
push my changes to a privately owned but publicly readable repo
and someone else does the integration by pulling from there.

The branch in the shared repository serves as the single
'integration' branch. One can use 'git branch --track' to set
up local branches that automatically merge changes from the
shared 'integration' branch. That is git pull without further
arguments is the right command to integrate changes from the
shared branch to the local branch. (git provides more advanced
ways, but git pull is simple and in principle does the right
thing.)

What is missing is a simple way to 'push' local changes back
to shared integration branch in the remote repository. This
can be seen as a 'symmetric' operation to pulling. So, git push
should do the right thing. And the right thing is pushing the
current branch to the shared 'integration' branch.

The automerge behaviour stores information in branch.$name.remote
and branch.$name.merge that provide sufficient information to
make "git pull" the equivalent of

    git pull <remoteURL> <remoteref>

where <remoteURL> is the full URL of the remote stored in
branch.$name.remote, and <remoteref> is the value of
branch.$name.merge.

A 'symmetric' push command would push the current branch to the
remote head it originally was branched off, that is

    git push <remoteURL> <currentbranch>:<remoteref>

Now, the proposal is

- add a configuration variable branch.$name.push

- change git push to check if the push configuration variable
   is set for the current branch $name, and if so run the
   equivalent of

     git push branch.$name.remote $name:branch.$name.push


- teach git branch a flag --push/--no-push that sets up
   branch.$name.push. Add branch.autosetuppush configuration
   flag to configure if --push or --no-push is the default.
   (maybe we need better names here).


This breaks the symmetry between git fetch/git push and
replaces it with a symmetry between git pull/git push for some
branches. I believe this might be the right thing to do for
a workflow based on shared repos.

	Steffen
