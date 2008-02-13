From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 21:23:52 +0300
Message-ID: <87zlu4vhon.fsf@osv.gnss.ru>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <vanicat@debian.org>, git@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 19:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPMHl-0002Oy-U1
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 19:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYBMSYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 13:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbYBMSYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 13:24:09 -0500
Received: from javad.com ([216.122.176.236]:2110 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbYBMSYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 13:24:07 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m1DINwd79132;
	Wed, 13 Feb 2008 18:23:59 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JPMGu-00045j-Ku; Wed, 13 Feb 2008 21:23:52 +0300
In-Reply-To: <20080213164356.GA5828@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Wed\, 13 Feb 2008 17\:43\:56
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73807>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-13 17:30:02 +0100, Karl Hasselstr=C3=B6m wrote:
>
>> Why the prefix? Wouldn't it be easier to just have one "switch
>> branch" prompt that would tab complete existing branch names, and
>>
>>   * if the user enters the name of an existing branch, just switch t=
o
>>     it;
>>
>>   * if the user enters a name that's not the name of an existing
>>     branch, ask for confirmation, and then create the new branch and
>>     switch to it.
>
> Reading your code a bit more carefully, I realize that my suggestion
> doesn't give you the opportunity to base the new branch on anything
> but HEAD. So change the second bullet to
>
>   * if the user enters a name that's not the name of an existing
>     branch, display a prompt like this
>
>       Creating new branch "foo". Where should it start?
>
>     Tab complete on existing tags and branches, but accept any
>     committish. Create the new branch and switch to it.

It still doesn't allow to detach HEAD at arbitrary tag/committish, as
far as I can see.

I believe the interface should be designed more carefully. Here are som=
e
thoughts/suggestions:

1. Let `git-checkout' switch HEAD. It will never create new branches bu=
t
   will be able to detach HEAD. Use tab-completion on branch names and
   maybe tags (maybe by inserting tags/ into completion list, and
   switching completion list to tags after tags/ is enterd by user), bu=
t
   allow any commitish. Ideally, it will also revert Emacs buffers for
   which working copy files are changed during checkout.

2. Let `git-create-branch' create new branches. It will prompt for a br=
anch
   name, then prompt for starting point with default set to HEAD, and
   create the branch. As it doesn't switch HEAD, it won't touch working
   files.

3. Let `git-branch' create new branch at HEAD and switch to it. This
   will be just a short-cut for common and simple case. Note that this
   will never change working files as newly created branch will match
   HEAD.

4. Reserve C-u prefix for ability to provide arbitrary options to
   underlying GIT commands. For example, it's useful to be able to give
   -m or -f option to "git checkout"; or --track or -f to "git branch".

The "create new branch at arbitrary point and then switch to it" will
then be a two-step operation: either "

((git-create-branch <name> <point>) (git-checkout <name>)

or

((git-checkout <point>) (git-branch <name>))

but that is IMHO reasonable trade-off for interface simplicity, though
yet another function could be defined to do it in one step.

-- Sergei.
