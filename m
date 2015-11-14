From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH RFC] completion: add support for completing email
 aliases
Date: Sat, 14 Nov 2015 10:44:02 +0100
Message-ID: <20151114104402.Horde.1et7Ak3QVluviq1iADQupQI@webmail.informatik.kit.edu>
References: <20151114015504.Horde.4mcBf20X0mnolD3xNrtymin@webmail.informatik.kit.edu>
 <CA+P7+xpxpkCJxesU4Tif46pYeQHG-NdvMuD0bj1Kr_kGz4djTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 10:44:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxXNf-0003nz-7b
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 10:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbbKNJoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2015 04:44:16 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59435 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbbKNJoK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 04:44:10 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZxXNM-0002Ox-U6; Sat, 14 Nov 2015 10:44:04 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZxXNK-0000WB-EQ; Sat, 14 Nov 2015 10:44:02 +0100
Received: from x590d706e.dyn.telefonica.de (x590d706e.dyn.telefonica.de
 [89.13.112.110]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 14 Nov 2015 10:44:02 +0100
In-Reply-To: <CA+P7+xpxpkCJxesU4Tif46pYeQHG-NdvMuD0bj1Kr_kGz4djTg@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1447494244.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281303>


Quoting Jacob Keller <jacob.keller@gmail.com>:

> On Fri, Nov 13, 2015 at 4:55 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:

>> However, 'git send-email' already knows how to parse these files, so
>> how about letting it do all the work, i.e. teach it a new 'git
>> send-email --list-aliases' option that would only read the config,
>> parse the alias file, print all the aliases, i.e. the keys from the
>> 'aliases' associative array and exit.  That way we wouldn't have to
>> duplicate parts of an already working and tested parsing into a
>> different language, the completion script would be simpler, because =
we
>> wouldn't need __git_email_aliases() helper function, it would
>> immediately benefit from future bug fixes to 'send-email', and new
>> alias file formats would Just Work.
>>
>
> Agreed. I hadn't thought about it this way. We could also add email
> addresses to the complete list, if that was a reasonable addition?
> Maybe not worth it though.

I don't really see the use case of listing email addresses as well.

> I'll respin a version like this in the next few days.

Great, thank you!


>>> @@ -1735,6 +1786,24 @@ _git_send_email ()
>>>                         " "" "${cur##--thread=3D}"
>>>                 return
>>>                 ;;
>>> +       --to=3D*)
>>> +               __gitcomp "
>>> +               $(__git_email_aliases)
>>> +               " "" "${cur##--to=3D}"
>>> +               return
>>> +               ;;
>>> +       --cc=3D*)
>>> +               __gitcomp "
>>> +               $(__git_email_aliases)
>>> +               " "" "${cur##--cc=3D}"
>>> +               return
>>> +               ;;
>>> +       --bcc=3D*)
>>> +               __gitcomp "
>>> +               $(__git_email_aliases)
>>> +               " "" "${cur##--bcc=3D}"
>>> +               return
>>> +               ;;
>>
>>
>> These case branches look essentially the same except what has to be
>> removed from the word being completed.  And what gets removed is
>> essentially everything before and including the first '=3D'.
>> So how about squashing these three cases into a single (untested) on=
e
>> like this:
>
> I tried this, but I wasn't sure if it was reasonable or not inccase
> there was an equals later in the section? since glob will match the
> longest one?

That's why I used a single '#' in the parameter expansion below.  A =20
single '#' removes the shortest matching prefix pattern, '##' removes =20
the longest:

$ cur=3D"foo=3Dbar=3Dbaz"
$ echo "#: ${cur#*=3D}    ##: ${cur##*=3D}"
#: bar=3Dbaz    ##: baz

(Don't ask why we use '##' without glob everywhere... :)

>>
>>      --to=3D*|--cc=3D*|--bcc=3D*)
>>        __gitcomp "$(__git_email_aliases)" "" "${cur#*=3D}"
>>        return
>>
>>        ;;
>>

There's an other point: these options have an unstuck variant as well, =
=20
i.e. '--to alice'.  It would be great to support those, too.
Perhaps something like this snippet looking at the previous word on =20
the command line could come before the big case statement handling the =
=20
current word:

   case "$prev" in
   --to|--cc|--bcc)
     __gitcomp "$(git --git-dir=3D"$dir" send-email --list-aliases 2>/d=
ev/null)"
     return
     ;;
   esca
