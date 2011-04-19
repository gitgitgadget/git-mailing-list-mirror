From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4 issue
Date: Mon, 18 Apr 2011 23:57:52 -0400
Message-ID: <BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
	<BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
	<BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 05:58:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC24d-0008Jz-6R
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 05:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab1DSD5y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Apr 2011 23:57:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45910 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab1DSD5x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2011 23:57:53 -0400
Received: by qwk3 with SMTP id 3so2720268qwk.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mJ5qiSfOb35/dFpWKjWvj6VMiT1HyB7WI7WZPNQD6hQ=;
        b=qNIb5LjTRrWvu9S6G04k+7Q+wlTYtNmXJ0busVC2ADNE8pn3vWcm/saD9kDI+dc4/0
         lzWBeo0+Tu4oN1S6u8DgDw0egXRvmgbbEkP4grNJqHuGReZ+JKYJS1Iu2FwxwIvW0XO8
         S/ye3TC6+Ai6xgtV1oI1ou7UmWT1Il3pThZVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=m/ePxMWHdOyrnNV/ybvvbud+myoKgtmRdKm5Va201PAad24Hdl/h4J9nVmtAC7hiOw
         iDFOmqz/gd1aPlXFTmVRPOlBhNytMwOybPbWZCyKJfIxCl+udF0MdNkqCImJvzHGh+vW
         zIkQSJ5HbXjTH7TtyV8nat4GyYxspDj8XjG8I=
Received: by 10.229.43.232 with SMTP id x40mr4135303qce.32.1303185472282; Mon,
 18 Apr 2011 20:57:52 -0700 (PDT)
Received: by 10.229.237.194 with HTTP; Mon, 18 Apr 2011 20:57:52 -0700 (PDT)
In-Reply-To: <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
X-Google-Sender-Auth: yupmO0h_WffrzIKEYDnmyyrEUWY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171771>

OK, after some digging, I think I have figured out what is going on,
but I am not sure how to fix it, at least not safely.

There seem to be several different ways of detecting branches, and I
am not exactly sure what they are all used for, or why there are so
many, but the core of the issue I am having is that in importChanges
when it calls splitFilesIntoBranches, it assumes "self.knownBranches"
has all the branches, even though it already has the branches from
"self.p4BranchesInGit".  The exact reason I don't know, but the
results is splitFilesIntoBranches returns an empty array, and so when
the code loops over it, it silently does nothing.

The first fix that would be helpful is to at least report an error if
it can't find the branches, rather than silently doing nothing.  I am
not exactly sure why it needs to look in "self.knownBranches", so I
don't know what the error should report, maybe the error should be
reported earlier?

The other issue is how "self.knownBranches" seems to be populated.  It
looks like form my code path, which decides to "Import from/to
multiple branches", it tries to detect branches by using "p4
branches".  Again, this is odd, since I can see it already has the
names of the branches from "self.p4BranchesInGit".  I am not familiar
enough with the code (and figuring out Python as I go along) to know
why.  The problem with using "p4 branches" is those aren't really
branches, they are aliases to a merge command (integrate in p4 lingo)
which stores the from and to branch.  The branch in Perforce is really
just a directory.  Interestingly enough, it seems this logic also
attempts to detect new branches and automatically import them, but
ironically this doesn't actually work for me.

So, the crux of the problem is that "p4 branches" are not necessary to
have at all.  The reason this suddenly stopped working for me is that
someone had created one of these branch definitions and I didn't know,
so it was accidentally working all this time, but only for 2 of the
branches.  Then the person removed the definition, and it stopped
working.  Now the workaround is to go and create these things for
every branch, but considering these are unnecessary and cumbersome to
create, and the code seems to be able to find the branches already
from the "self.p4BranchesInGit" anyway, I would like to remove the
dependency on that logic.

Now, I could go ahead and hack something that does things differently,
but since I don't really know the intention of these structures or how
it might impact elsewhere in the code, I could use some guidance from
someone who knows this code well.

Thanks,

Mike




On Fri, Apr 15, 2011 at 4:39 PM, Michael Horowitz
<michael.horowitz@ieee.org> wrote:
> I am sure that is a common mistake people make, but not in this case.
> I have been using it successfully for a while now, it just suddenly
> stopped working, not sure what changed. =A0I am not seeing anything o=
n
> remotes/p4/master either, and I was originally doing rebase and went
> back to sync so I could run "--verbose" and see if it was even
> downloading those changes. =A0I can clearly see it says it is
> downloading them, but then they just don't end up in git.
>
> Since I don't see an error message about it failing to sync, I am at =
a
> loss to figure out why it says it succeeded, but it didn't. =A0Could
> there be one step in the code that is not catching an error condition=
?
> =A0I am not all that familiar with Python, but if someone could point=
 me
> where to put some debug messages, I can do some testing.
>
> Thanks,
>
> Mike
>
>
>
> On Fri, Apr 15, 2011 at 4:22 PM, Tor Arvid Lund <torarvid@gmail.com> =
wrote:
>>
>> On Fri, Apr 15, 2011 at 5:00 AM, Michael Horowitz
>> <michael.horowitz@ieee.org> wrote:
>> > Pete,
>> >
>> > I was hoping you could help me out again.=A0 After using git-p4 fo=
r a
>> > while without a problem, it has suddenly stopped working for me.=A0=
 I am
>> > using the latest master.=A0 I haven't seen any recent changes that=
 I
>> > think could have caused this, but maybe you'll have some insight.
>> >
>> > The issue is that when I do a git-p4 sync on my existing repositor=
y,
>> > it reports success, but seems to do nothing.=A0 It does not downlo=
ad the
>> > latest changes from p4.=A0 If I delete my repository and start ove=
r, it
>> > will download all the latest changes, even the ones it was not
>> > downloading previously, but if I try to sync again later, it does =
not
>> > do anything.=A0 I tried running it with the "--verbose" mode, and =
I see
>> > it says it is loading each of the changes, but they are not ending=
 up
>> > in the git repository, and it is not reporting any errors.
>>
>> Hi, Michael.
>>
>> Is it possible that you expect that 'git p4 sync' should update your
>> working branch and/or working tree? Assuming a simple clone with a
>> local master branch, running 'git-p4 sync' will update the branch
>> remotes/p4/master, but it won't do anything on my working master
>> branch...
>>
>> Maybe you want to call 'git rebase p4/master' afterwards, or use the
>> shorthand 'git p4 rebase' to do a sync+rebase.
>>
>> Regards,
>> Tor Arvid.
>>
>> > Any ideas of what this could be?=A0 Is there anything else I can r=
un to
>> > help debug this?
>> >
>> > Thanks,
>> >
>> > Mike
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe git" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
