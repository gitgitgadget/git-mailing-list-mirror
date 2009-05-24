From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Sun, 24 May 2009 23:43:40 +0200
Message-ID: <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7voctirzu6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 24 23:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8LTy-00021G-1m
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 23:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZEXVnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 17:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbZEXVnl
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 17:43:41 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:34664 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZEXVnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 17:43:40 -0400
Received: by bwz22 with SMTP id 22so2726542bwz.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kwhiJp5lFhRvhPLe+/AK5ezZCD7qWxPWUXSiARfpsWg=;
        b=XmeBvC1lli+9S50AuloigXk0CA8ZalG+cWhuXs1GWLpJyqCdfrqoNd635mMTwMbGnP
         FXGXHH3W6yZIKtGeNTBYTixoVPB1fx+hPT4nUnJqiDVGuOI+RiMJhtDYlPuxXtIbmG0L
         lGxoRR9rcPRjYLoCSt29jSv13xGJqQlQhSGAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dXOHVZWkS6VNFFryTL+bSY3oxlGV+KXTFnB/2N84OjcRJxPibCBJ1uaWLvKaebWljW
         JvL7/tu0argaEKXNTceSpTrQZmEOnJu3DaVg7T6O5VnoEU7mDkOUEb9hNyWoijjFEjSD
         sonZMLC6SDouhaf7oNoyfPUE4L8UOsgG+/eik=
Received: by 10.204.63.209 with SMTP id c17mr6210555bki.47.1243201420967; Sun, 
	24 May 2009 14:43:40 -0700 (PDT)
In-Reply-To: <7voctirzu6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119864>

On Sun, May 24, 2009 at 10:49 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> This small patch series implements support for Stacked Git patch
>> series import.
>>
>> The first commit adds support for StGit patches to mailinfo, which i=
s
>> required because StGit's default export template puts the From: line
>> between the subject and the body.
>
> This problem description makes it sound as if we always expect From: =
to
> come before Subject: in the mailbox, and reject the input if they com=
e in
> a different order, which would be a bug. =A0Fixing it would not be li=
mited
> to supporting StGIT generated patch email.

I should probably have added the information that the subject in StGIT
patches is _not_ prefixed by 'Subject: ', it's just placed as-is. So
it's not a matter of ordering.

> But a quick glance at the actual patch makes me suspect that is not w=
hat
> you are doing. =A0You are feeding something that is not a mailbox at =
all to
> the mailinfo and _unconditionally_ extract the information according =
to
> StGIT rules.
>
> That's a bad taste.
>
> At least, add a "this is not a mailbox, but is a StGIT formatted file=
, so
> please extract info according to the StGIT rule, not the mailbox rule=
"
> option, and
>
> =A0(1) have a parameter to mailinfo() to trigger your new codepath on=
ly
> =A0 =A0 =A0when the option is given; or

[snip]

> so that normal mailinfo invocation does not mishandle input that is _=
not_
> StGIT output.

When I started coding this feature, I had some thoughts about this,
and my initial choice was to implement it following the suggestions
you mentioned. However, after thinking about it a while I realized the
following: the new code-path is taken only if the file does not start
with (what looks like) a mail header. If the file is not a StGIT patch
exported with the default template, the info extraction will fail
somewhere else (e.g. because no author or no diff is found).

So in the end I decided to go the much simpler way of the patches I sen=
t.

>> The second commit makes git-am autodetect an StGit patch series inde=
x
>> (when it's the only file passed to it) and proceeds to import the
>> patches indicated in the series.
>
> And that change would be a good place to decide to pass that "This is=
 not
> a mailbox but is a StGIT output" option to the updated mailinfo progr=
am
> (or the new "stgitinfo" program).

That was my initial thought too, but then I realized that having the
'heuristics' (although a very braindead one) in mailinfo makes more
sense because otherwise StGIT patch autodetection would only work when
applying a whole series, and not when applying a single (or a few)
patches.

> What is the larger picture workflow that this new feature is expected=
 to
> help? =A0A project takes patches not in e-mail form but in a director=
y full
> of files uploaded via scp/sftp with the StGIT series file and individ=
ual
> StGIT patches that are pointed by the series file contained within?

Sort of.  The specifics is that there's a guy developing a DIB engine
for Wine and he's using StGIT to handle the patches on top of the
official Wine git tree. Periodically he zips the patch series
(index+patches) and attaches it to the relevant bugzilla entry.

> I do not use StGIT anymore, so I do not remember how flexible its exp=
ort
> template mechanism is, nor how widely people use non-default template=
s,
> but I have wonder about two and half things.
>
> =A0- I am assuming that your patch won't be able to read the StGIT ou=
tput if
> =A0 the uploader used non-default export template, so such a project =
needs
> =A0 to ask the uploaders to use the default template.

Well, in the use-case that triggered my need for the StGIT import,
that was the case already.

> =A0 If that is the case, why not ask them to use a custom template th=
at
> =A0 generates one single valid mailbox that stores the patches in the=
 right
> =A0 order? =A0That can be processed with stock "git am"; in addition,=
 the
> =A0 output can be fed not just to "git". =A0Any other SCM that can wo=
rk with
> =A0 e-mail based patchflow can use it.

We have actually asked him to use plain git instead of StGIT, but he's
more comfortable with the latter. We could ask him to fix the header,
yes. I'm not too optimistic about a positive response.

> =A0- Such a project can allow users to use random export templates as=
 long
> =A0 as the template used to export the series is indentifiable (perha=
ps by
> =A0 including that template itself in the upload). =A0Your mailinfo p=
atch
> =A0 needs to be extended to reverse what the export template did, and=
 it
> =A0 really shouldn't be in the normal mailinfo() codepath. =A0The rig=
ht
> =A0 approach would become something like (3) above, i.e. separate
> =A0 "StGITinfo" program called from "git am" if that is what you shoo=
t for.

Oh, in my grand plan of things git am should be able to handle all
kind of foreign patches (svn and the patches sent by Bram Moolenar
uses for vim being top candidates). (Of course it would be appropriate
to rename it to something else then.) Sadly, I quickly discovered that
my file and string manipulation-fu in C is not really what I would
call 'strong'.

(And since I needed it fast, I went the easy rather than the formally
correct way.)

> =A0- If StGIT is used by the project to such an extent to allow serie=
s
> =A0 directory upload, shouldn't the receiving end be also using StGIT=
 to
> =A0 import the series, instead of running "git am" anyway?

As I mentioned, Wine uses plain git, and we've tried asking this
(non-core) developer to expose a standard git tree. But he finds StGIT
much more comfortable for the task.

--=20
Giuseppe "Oblomov" Bilotta
