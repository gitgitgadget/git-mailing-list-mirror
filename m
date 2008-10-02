From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH/resent 0/9] Sparse checkout (first half)
Date: Thu, 2 Oct 2008 13:14:01 +0200
Message-ID: <adf1fd3d0810020414t127b25b0x4b74b9823d93bc20@mail.gmail.com>
References: <adf1fd3d0810010738j21a6432foef3758fc7ed1cb1f@mail.gmail.com>
	 <48e45071174c3_22373fefab26908c6423@app01.zenbe.com.tmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 13:15:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlM9O-0007dN-VD
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 13:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbYJBLOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYJBLOG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 07:14:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:6236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbYJBLOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2008 07:14:04 -0400
Received: by ug-out-1314.google.com with SMTP id k3so990097ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 04:14:02 -0700 (PDT)
Received: by 10.103.225.2 with SMTP id c2mr6669775mur.93.1222946041734;
        Thu, 02 Oct 2008 04:14:01 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Thu, 2 Oct 2008 04:14:01 -0700 (PDT)
In-Reply-To: <48e45071174c3_22373fefab26908c6423@app01.zenbe.com.tmail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97315>

On Thu, Oct 2, 2008 at 6:39 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On 10/01/2008 "Santi B=E9jar" <santi@agolina.net> wrote:
>>On Wed, Oct 1, 2008 at 2:09 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.c=
om> wrote:
>> > On 10/1/08, Santi B=E9jar <santi@agolina.net> wrote:
>> >> On Wed, Oct 1, 2008 at 12:20 PM, Santi B=E9jar <santi@agolina.net=
> wrote:
>> >>  > Not in this half but I've seen that you added a --default-spar=
se flag
>> >>  > to "git clone". I think it is useless as mostly always the one=
 given
>> >>  > in -sparse-checkout should be used.
>> >>
>> >>
>> >> To be more precise, whenever you do "git clone --sparse-checkout"=
 you
>> >>  will want it to be the default sparse pattern.
>> >
>> > Yes, if only the default pattern gets updated properly when you up=
date
>> > your checkout area.
>>
>> I don't parse this sentence, but I cannot see the connection between
>> the default sparse pattern for _clone_ and updating it or the workin=
g
>> area.
>
> After clone with sparse "Documentation/" you may want to extend the c=
heckout area to "t/" also. "git pull" after that should allow new files=
 in Documentation/ as well as t/. So the default sparse pattern should =
be updated to "Documentation/:t/"

Sure.

[...]

>> > The hard part is how to update default pattern with
>> > --include-sparse and --exclude-sparse.
>>
>> Maybe you could let the core.defaultsparse be defined multiple times=
=2E
>>
>> [core]
>>         defaultsparse =3D Documentation/*
>>         defaultsparse =3D t/*
>>         defaultsparse =3D !t/*svn*
>>
>> equivalent to
>>
>> [core]
>>         defaultsparse =3D Documentation/*:t/*:!t/*svn*
>>
>> but it moves the complexity to the parsing of the config.
>
> There are two issues regarding --{in,ex}clude-sparse:
>  1. we need to save the prefix somehow. "git checkout --include-spars=
e=3D'*.c'" in compat/ and the same command at top-level workdir give di=
fferent result.

then, core.defaultsparse=3D"compat//*.c" and core.defaultsparse=3D"*.c"=
, isn't it?

>  If we don't save prefix, we get wrong result with defaultsparse. Thi=
s one is easy although it may make sparse patterns and .git{ignore,attr=
ibutes} look different.

Possible bug, currently in your sparse-checkout branch the prefix is no=
t saved:

$ cd git
$ cd Documentation
$ git checkout --sparse=3DRelNotes*
$ git config -l | grep sparse
core.defaultsparse=3DRelNotes-1.*

>  2. cruft gets accumulated in core.defaultsparse. Consider this (assu=
me we cloned with sparse "Documentation/")
>
> for i in 1 2 3;do
> git checkout --include-sparse=3D"t/"
> git checkout --exclude-sparse=3D"t/" # oops, I did not mean to do tha=
t
> done
>
> The default sparse pattern would be "Documentation/:t/:!t/:t/:!t/:t/:=
!t/" while it should be just "Documentation/". Another example is
>
> git checkout --include-sparse=3Dt/test-lib.sh
> git checkout --include-sparse=3Dt/
>
> The defaultsparse would be "Documentation/:t/test-lib.sh:t/" while a =
better defaultsparse should be "Documentation/:t/"
>

But these are the steps to reproduce what the user asked for, so I
don't see a problem.

> But maybe I just overlook this. Maybe just show the defaultsparse to =
people and let them clean it with "--reset-sparse".

Sure.

>
>> > Also, people can use "git
>> > update-index" to update checkout area, which should not touch defa=
ult
>> > pattern at all.
>>
>> I would prefer having a --not-update-sparse-pattern.
>
> "git update-index" does not understand "sparse patterns" at all. It o=
perates at file level. But it is plumbling anyway so those who use it s=
hould take care of default sparse pattern themselves.

Well, "git checkout <paths>" does the trick.

Santi
