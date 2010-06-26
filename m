From: Lane Brooks <lane@brooks.nu>
Subject: Re: How to manage merges from one line while excluding its merges
 from another
Date: Fri, 25 Jun 2010 18:35:46 -0600
Message-ID: <4C254B62.6020108@brooks.nu>
References: <4C252D1C.4010702@brooks.nu> <20100626000358.GA11473@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 02:35:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSJNF-0007QM-G7
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 02:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab0FZAfv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 20:35:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62475 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0FZAfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 20:35:50 -0400
Received: by pxi8 with SMTP id 8so944127pxi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 17:35:49 -0700 (PDT)
Received: by 10.114.186.36 with SMTP id j36mr1706037waf.193.1277512549684;
        Fri, 25 Jun 2010 17:35:49 -0700 (PDT)
Received: from dome.lane.brooks.nu (c-98-202-126-209.hsd1.ut.comcast.net [98.202.126.209])
        by mx.google.com with ESMTPS id d39sm12416263wam.16.2010.06.25.17.35.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 17:35:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100621 Fedora/3.0.5-1.fc13 Thunderbird/3.0.5
In-Reply-To: <20100626000358.GA11473@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149723>

On 06/25/2010 06:03 PM, Jonathan Nieder wrote:
> Hi Lane,
>
> Lane Brooks wrote:
>
>   =20
>> I have a tree like this:
>>
>>       G---H---I---J---K   devel
>>      /       /       /
>> A---B---C---D---E---F    main
>>          \
>>           L---M---N---O   my
>>     =20
> Nice diagram.
>
> What is missing is a picture of what you want the result to be.
>
>   =20
>> The 'my' branch forked off the 'main' line and for reasons out of my
>> control cannot merge the 'main' changes (D,E,F) back.
>>     =20
> [...]
>   =20
>> I want to continue to merge from the devel line as additional commit=
s
>> are made that are not on the main branch, but I do not want any of
>> the future merge commits.
>>     =20
> (I) I am guessing that the 'main' line is not part of the published
> history, in which case you what you want might look like this:
>
>           ... devel
>        /
>   A---B---C- ... main
>            \
>             L---M---N---O---H'---J' my
>
> The J commit itself could not be included in the history of the 'my'
> branch because its ancestor D is not meant to be published.
>
> (II) In an alternative scenario, the 'main' changes (D, E, F) are
> forbidden because they introduce bugs.  In this case, a solution migh=
t
> look something like this:
>
>         ...                  K devel
>       /               /       \
> A---B---C---D---E---F main    \
>           \                     \
>            L---M---N---O---------P---Q---R---S
>
> where Q, R, and S are commits (created with =E2=80=98git revert=E2=80=
=99) that
> undo the effect of F, E, and D.  From then on, you can just merge
> from devel as usual.
>
>   =20
>> Is there an automated way to do this or do I have to cherry pick
>> everything by hand?
>>     =20
> In git 1.7.2, you will be able to automate (I) as follows:
>
>   git cherry-pick --no-merges ^my ^main devel
>
> Until then, you might want to try experimenting with something
> like this:
>
>   git rev-list --no-merges ^my ^main devel |
>   while read rev
>   do
> 	git cherry-pick $rev ||
> 	{
> 		echo>&2 cherry-pick failed
> 		break
> 	}
>   done
>
> Hope that helps,
> Jonathan
>   =20
I guess (I) is what I want, but your enumerating those two options make=
s=20
me wonder how well things will go when 'devel' and 'main' merge and the=
n=20
'my' needs to merge in from 'main'. Seems like a disaster waiting to ha=
ppen.

I'll take a look at your suggested cherry-pick script. Can it be rerun=20
multiple times or is it run one-time only. In others, as 'devel'=20
continues to grow can I run it again and will it cherry-pick=20
intelligently or will it try to reapply commits already cherry-picked?

Thanks,
Lane
