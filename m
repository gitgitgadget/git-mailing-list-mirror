From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Tue, 22 Nov 2011 06:21:35 +0100
Message-ID: <4ECB315F.4080701@alum.mit.edu>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com> <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gerd Knops <gerti@bitart.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 06:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSinm-0006IU-DD
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 06:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab1KVFVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 00:21:45 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:32811 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab1KVFVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 00:21:44 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDD59.dip.t-dialin.net [84.190.221.89])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAM5LZNL014958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Nov 2011 06:21:36 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185774>

On 11/21/2011 08:18 PM, Jay Soffian wrote:
> On Sat, Nov 19, 2011 at 3:08 PM, Gerd Knops <gerti@bitart.com>
> wrote:
>> On Mac OS X with a case-insensitive file system (not sure if that
>> matters) git get's confused with branch names that differ only in
>> case.
> 
> This is true. The branch code assumes a case-sensitive filesystem. I 
> started working on a fix, but it was more involved than I first 
> thought it would be. See my local WIP commit below, apologies if
> gmail lines wraps it.

Is it obvious how references *should* be handled on case-insensitive
filesystems?  It's certainly not obvious to me (has it been discussed
elsewhere?)  I don't think it is a good idea to "fix" this one problem
without defining an overall policy.

Currently git handles references names case-sensitively and allows
multiple reference names that differ only in case.  If this behavior is
to be preserved on case-insensitive filesystems, then either loose
references must be stored differently (e.g., multiple references in the
same file) or ambiguous references need always to be packed.  Moreover,
given a refname, we would need to be careful not to just try to open a
file with that name and assume that it is the correct reference; rather,
we would have to ask the filesystem for the name of the file in its
original case and make sure that it agrees with the case of the refname
that we seek.

By the way, this could have ramifications for the recently-added test
that top-level refnames should be in ALL_CAPS.

If we want to consider bending git's behavior, there are a number of
ways we could go:

1. Remain case-sensitive but prohibit refnames that differ only in case.

2. Remain case-sensitive but prohibit refnames that differ only in case
*when running on a case-insensitive filesystem*.

3. Change the handling of refnames to be case-insensitive but
case-preserving.

The above all assumes a case-insensitive filesystem that is
*case-preserving*.  If we want to support filesystems that do not
preserve case, things get even more complicated.

And if we want to pretend to support non-ASCII refnames, then the issue
of encodings is another nasty can of worms...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
