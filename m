From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Best way to check for a "dirty" working tree?
Date: Tue, 14 Jun 2011 15:28:07 +0200
Message-ID: <4DF761E7.8040707@dirk.my1.cc>
References: <4DF381BF.3050301@dirk.my1.cc> <20110613222225.GA14446@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 15:28:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWTfE-0006iE-Pq
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 15:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab1FNN2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 09:28:12 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:57929 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1FNN2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 09:28:10 -0400
Received: from [84.176.57.13] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1QWTf5-0006Bz-GL; Tue, 14 Jun 2011 15:28:07 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110613222225.GA14446@elie>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175769>

Hi Jonathan,

Am 14.06.2011 00:22 schrieb Jonathan Nieder:
> Hi Dirk,
>=20
> Dirk S=C3=BCsserott wrote:
>=20
>> I have a script which moves data from somewhere to my local repo and
>> then checks it in, like so:
>>
>> -----------
>> mv /tmp/foo.bar .
>> git commit -am "Updated foo.bar at $timestamp"
>> -----------
>>
>> However, before overwriting "foo.bar" in my working directory, I'd l=
ike
>> to check whether my working tree is dirty (at least "foo.bar").
>=20
> Interesting example.  Sensible, as long as you limit the commit to
> foo.bar (i.e., "git commit -m ... --only foo.bar")!

Uhh, nice hint. I didn't know that git-commit accepts a path, too.
That's safer. However, in my particular case the working tree is either
clean or exactly the file in question has changed. If sth. else changes
(e.g. my commit-script) I do that in a separate "transaction".

> Now, a word of warning.  One aspect of this "do not second-guess the
> caller" behavior is that low-level commands like "git diff-index"
> blindly trust stat() information in the index, rather than going to
> re-read a seemingly modified file and updating the index if the
> content is not changed.  You can see this by running "touch foo.bar";
> "git diff-index" will report the file as changed, until you use "git
> update-index" to refresh the stat information:
>=20
> 	git update-index --refresh --unmerged -q >/dev/null || :
> 	if ! git diff-index --quiet HEAD -- foo.bar; then
> 		dirty=3D1
> 	fi
>=20
> Alas, this doesn't seem to be documented anywhere (except for the
> gitcore-tutorial(7))!  It ought to be.

Hmm, it MUST be documented somewhere, because I have several scripts
that use "update-index --refresh" to get rid of what I call "phantom
changes": sometimes I transfer (scp) files from a remote machine to the
local tree. The set of files is already known to Git, so my first guess
was that Gitk would only show the "real" diff, but it actually showed
*all* transferred files as changed. After running "git status" Gitk doe=
s
it right and shows only content's diff. Surprisingly, "git status" seem=
s
to be a read/write operation and does "update-index --refresh" in the
background. After some research I learned about "update-index --refresh=
"
and use it frequently for scp'ed files.

Unfortunately, I cannot remember *where* I learned about it.

> Hope that helps,
> Jonathan

That helped a lot. Thank you,
Dirk
