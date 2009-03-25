From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] git-filter-branch: avoid collisions with variables in 
	eval'ed commands
Date: Wed, 25 Mar 2009 15:33:31 -0600
Message-ID: <51419b2c0903251433s75775206x556fc2d65a347d7d@mail.gmail.com>
References: <1238015581-12801-1-git-send-email-newren@gmail.com>
	 <20090325212403.GU8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmakd-0004QU-Ph
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbZCYVdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 17:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZCYVdf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:33:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:38173 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbZCYVde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:33:34 -0400
Received: by yw-out-2324.google.com with SMTP id 5so232775ywb.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FILfpkDfDpsgiBqO/scfinwLoOz8uBTs8szEnpSGbYA=;
        b=C2h+md4pqjFQzwzQuH7FXlisjdJQRey8uTTQ0RYH2NPscQPU9oCfAHuICioo0bqTyF
         NrQHoaotJx1NVOAcLHXkvXBBeknW8JbxoiiWa58ceXso7u9e3TUgp0TGjTXxwOrFeFYy
         4/fygE4bPi9Lw9nTTKAvTmQCzOAtA9n7V612E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YpJU4ClRUzAlqNk/U3nmpRDAcfESuePUpFeEV67ya/5ZRvszBefFGob+yyvUzuTarg
         dRiFoRoicq/GulKQbWfyob1fQud5txQkLMDPS59tH74rq+thXu49iXYEUklMV5dJopMC
         cmgZxPWBJgG7rOCuwNhwm22QXRUhvWz4srOeU=
Received: by 10.231.20.2 with SMTP id d2mr16193ibb.27.1238016811636; Wed, 25 
	Mar 2009 14:33:31 -0700 (PDT)
In-Reply-To: <20090325212403.GU8940@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114670>

Hi,

On Wed, Mar 25, 2009 at 3:24 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Wed, Mar 25, 2009 at 03:13:01PM -0600, newren@gmail.com wrote:
>> From: Elijah Newren <newren@gmail.com>
>>
>> Avoid using simple variable names like 'i', since user commands are =
eval'ed
>> and may clash with and overwrite our values.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Almost-acked-by: Petr Baudis <pasky@suse.cz>
>
> But:
>
>>-i=3D0
>>+git_filter_branch_count=3D0
>
> Why branch_count? It counts commits, not branches, doesn't it?

Oh, I was just changing i->git_filter_branch_i, then thought as long
as it was long I might as well use a word instead of "i".  Didn't
think about the combined meaning.  How about
"git_filter_branch_commit_count"?  Maybe a double underscore between
the "namespace" and the "variable"?

>> I discovered this a few months ago, but apparently never got around =
to
>> sending it earlier. =C2=A0Anyway, without this patch in a repository=
 with a
>> file called 'world' I see the following behavior:
>
> Some hints:
>
>> $ git filter-branch --tree-filter '
>> =C2=A0 =C2=A0for i in $(find . -type f); do
>
> This won't work right if your filenames contain $IFS.

Yeah, luckily for me, my repository didn't have any filenames with
whitespace.  :-)

>> =C2=A0 =C2=A0 =C2=A0if ( file $i | grep "\btext\b" > /dev/null ); th=
en
>
> if [[ "$(file $i)" =3D=3D *text* ]] might run noticeably faster (thou=
gh is
> slightly less precise). Having a filename-keyed cache of file types e=
ven
> more so.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0perl -i -ple "s/\\\$(Id|Date|Source|Heade=
r|CVSHeader|Author|Revision):[^\
>> \$]*\\$/\\$\1\\$/" $i;
>
> Using '\'' instead of " could save you quite a few backslashes in net
> count.

Cool, thanks for the tips.
