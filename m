From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 17:46:23 +0200
Message-ID: <9e0f31700909110846h54959ae6u466ceda40799ba37@mail.gmail.com>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
	 <20090911102329.GA13044@sigill.intra.peff.net>
	 <20090911135110.GA30860@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aloisio <aloisiojr@gmail.com>, git@vger.kernel.org,
	support@gitorious.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm8KW-0007JV-Cr
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 17:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbZIKPqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 11:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbZIKPqW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 11:46:22 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39681 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbZIKPqV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2009 11:46:21 -0400
Received: by bwz19 with SMTP id 19so871302bwz.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 08:46:24 -0700 (PDT)
Received: by 10.223.81.84 with SMTP id w20mr1487265fak.17.1252683983594; Fri, 
	11 Sep 2009 08:46:23 -0700 (PDT)
In-Reply-To: <20090911135110.GA30860@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128201>

On Fri, Sep 11, 2009 at 3:51 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 11, 2009 at 06:23:29AM -0400, Jeff King wrote:
>
>> > I faced a problem when trying to clone git://gitorious.org/qt/qt.g=
it
>> >
>> > this works:
>> > git clone -n git://gitorious.org/qt/qt.git repo
>> >
>> > this doesn't:
>> > git clone -n git://gitorious.org/qt/qt.git repo >log
>> > fatal: The remote end hung up unexpectedly
>> > fatal: early EOF
>> > fatal: index-pack failed
>>
>> I can reproduce the problem here. But after staring at the strace fo=
r a
>> long time, I don't think the problem is on the client side. The remo=
te
>> end _does_ hang up unexpectedly.
>>
>> Looking at what we send, the only difference between the redirected =
and
>> unredirected case I could find is that we send the "no-progress" fla=
g to
>> the server, which then hangs up on us instead of sending us the pack=
=2E
>> Which makes no sense.
>
> I did a little more testing, and I can't reproduce the problem agains=
t a
> local git-daemon. I tried using several versions for the server, goin=
g
> all the way back to v1.5.0, which pre-dates no-progress, and all of t=
hem
> worked just fine.
>
> So I am inclined to think there is something non-standard or broken a=
t
> gitorious.org. I'm cc'ing support@gitorious to see if they have any
> comment.

Some quick tests seem to indicate it's related to the fact that our
wonderful little fork+exec git-daemon[1] (which is different from the
one distributed with git) exec's to "git-upload-pack --strict
--timeout=3D30 /path/to/repo". Now, why exactly that'll trigger when th=
e
no-progress flag is given I'm not sure of. The daemon itself execs as
soon as it figures out what repo the client requested, so apart from
the timeout the only thing it reacts to is the header (the
"${headersize}git-upload-pack project/repo.git\0host=3Dgitorious.org\0"
part).

We also do redirect stderr to /dev/null for reasons I cannot remember
(so probably not good ones), that may be related as well. Well run
some more tests...

[1]: http://gitorious.org/gitorious/mainline/blobs/master/script/git-da=
emon

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
