From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Grafting mis-aligned trees.
Date: Tue, 02 Dec 2008 17:20:58 +0100
Message-ID: <4935606A.8050906@drmicha.warpmail.net>
References: <200811171645.12869.bss03@volumehost.net> <492289B0.4010903@drmicha.warpmail.net> <200811281701.46778.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Y10-0007LJ-NE
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYLBQVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYLBQVE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:21:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54772 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751163AbYLBQVD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 11:21:03 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 458041B6C05;
	Tue,  2 Dec 2008 11:21:01 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 02 Dec 2008 11:21:01 -0500
X-Sasl-enc: Cw2K4qkw38JlaIVJGs8k7blza/Z1gy2eD38rnKexf8t3 1228234860
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 968023956B;
	Tue,  2 Dec 2008 11:21:00 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <200811281701.46778.bss03@volumehost.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102153>

Boyd Stephen Smith Jr. venit, vidit, dixit 29.11.2008 00:01:
> On Tuesday 2008 November 18 03:24, Michael J Gruber wrote:
>> Boyd Stephen Smith Jr. venit, vidit, dixit 17.11.2008 23:45:
>>> I haven't gotten a response from my subscription email, so please CC me
>>> on any replies.
>>>
>>> So, I've been managaing the source I had from a client project in git and
>>> have a non-linear history.  Currently, two tips (production and testing)
>>> but there are many feature branches that were git-merge'd in, not
>>> rebased.
>>>
>>> Now, I've gotten the full tree.  Turns out all the source code I was
>>> working on was in a subdirectory "project/web".  I'd like to "graft" the
>>> *changes* I made onto the full tree.
>>>
>>> I figured this might be a job for git-filter-branch.  Certainly, that did
>>> the job of moving all my changes into the subdirectory.  But, now I want
>>> to do something that's a combination or git-rebase and git-filter-branch.
>>>  I want to replay the *patches/deltas* (like rebase) on top of the full
>>> tree I have, but *maintain the non-liear history* (like filter-branch).
>>>
>>> Can anyone think of a recipe for me?
>>>
>>> Trees look something like this right now.
>>>
>>> <some history> -> FT
>>>
>>> TI -> <non-linear history> -> A -> <non-linear history> -> C
>>>    \                            \                           \
>>>     -> PI ------------------------> B ------------------------> D
>>>
>>> I'd like to have it look something like:
>>>
>>> <some history> -> FT -> <non-linear history> -> A' -> <non-linear
>>> history> -> C' \                            \                           \
>>> -> PI' ----------------------> B' -----------------------> D'
>>>
>>> A', B', C', and D' are different commits, but the diff (and history)
>>> between FT and A' is the same as the diff (and history) between TI and A.
>>>
>>> Again, please CC me on any replies.
>> [CCing is customary here anyways.]
>>
>> So, your base directory for TI and FT is different, right? I.e.: In the
>> TI repo, your project sits at the root, whereas in the FT repo it sits
>> in project/web?
> 
> Yes.
> 
>> Has FT advanced since you took the initial subdir 
>> snapshot for TI?
> 
> No.  Well, maybe.  I think the subdir diff is fairly trivial if not empty.  TI 
> is an import from the code actually present on the testing server.  FT was 
> the a subversion repository obtained later after some hullabaloo with the 
> ex-development house.
> 
> Right now this tree is effectively all mine, so I can always graft in commits 
> to synchronize the common subtree of FT and TI, if that makes things easier.

OK, here's a possibly primitive solution, but it works with my little
toy model of your layout:

- filter-branch your TI branches so that they are in the proper subdir
(you did that already)

- take a snapshot (say ftstuff.tar) of everything in FT's head (assuming
this is where TI branched off, or else take that point) *but exclude
project/web*

- using filter-branch again, rewrite your TI branches to contain those
missing FT files:
git filter-branch --tree-filter 'tar -xf /tmp/ftstuff.tar && git add .'
-f -- ti/master ti/whatever

Now your TI branches produce the same diffs as before, but are based on
the full tree. You can happily graft FT's head onto TI's root as a parent.
In fact those two should produce no diff in between them, so you might
as well get rid of one of them.

[cleaning out refs/original and repack -adf might be in order afterwards]

The tree-filter part feels hacky but does the job (probably with -f). I
don't think a subtree merge can do what you want.

Cheers,
Michael
