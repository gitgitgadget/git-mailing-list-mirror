From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Approaches to SVN to Git conversion (was: Re: [RFC] "Remote
 helper for Subversion" project)
Date: Tue, 6 Mar 2012 11:29:59 -0800
Message-ID: <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com>
References: <4F536FE9.1050000@pileofstuff.org>
	<3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S505J-0003Yj-OA
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077Ab2CFTaD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 14:30:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63421 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555Ab2CFTaB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 14:30:01 -0500
Received: by bkcik5 with SMTP id ik5so4553648bkc.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 11:29:59 -0800 (PST)
Received-SPF: pass (google.com: domain of n8gray@n8gray.org designates 10.204.156.90 as permitted sender) client-ip=10.204.156.90;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of n8gray@n8gray.org designates 10.204.156.90 as permitted sender) smtp.mail=n8gray@n8gray.org
Received: from mr.google.com ([10.204.156.90])
        by 10.204.156.90 with SMTP id v26mr3600683bkw.132.1331062199897 (num_hops = 1);
        Tue, 06 Mar 2012 11:29:59 -0800 (PST)
Received: by 10.204.156.90 with SMTP id v26mr2690834bkw.132.1331062199613;
 Tue, 06 Mar 2012 11:29:59 -0800 (PST)
Received: by 10.205.43.137 with HTTP; Tue, 6 Mar 2012 11:29:59 -0800 (PST)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
X-Gm-Message-State: ALoCoQkw4wtkbeAQpD1zfD3qfocsRJXUDX3Bi/7LYzZJsE7LiAaGGcvNE+oLtKejeK3kLfHAzH23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192378>

Hi everyone,

Soon I'm going to be undertaking a migration of a subproject from a
very messy multiproject SVN repo to git, so this is a topic that's
quite near to my heart at the moment.  More inline...

On Mon, Mar 5, 2012 at 7:27 AM, Stephen Bash <bash@genarts.com> wrote:
>
> ----- Original Message -----
>> From: "Andrew Sayers" <andrew-git@pileofstuff.org>
>> Sent: Sunday, March 4, 2012 8:36:41 AM
>> Subject: Re: [RFC] "Remote helper for Subversion" project
>>

[snip]

>> Personally, I think SVN export will always need a strong manual
>> component to get the best results, so I've put quite a bit of work
>> into designing a good SVN history format. =A0Like git-fast-import, i=
t's
>> an ASCII format designed both for human and machine consumption...
>
> First, I'm very impressed that you managed to get a language like thi=
s up and working. =A0It could prove very useful going forward. =A0On th=
e flip side, from my experiments over the last year I've actually been =
leaning toward a solution that is more implicit than explicit. =A0Takin=
g git-svn as a model, I've been trying to define a mapping system (in P=
erl):
>
> =A0my %branch_spec =3D { '/trunk/projname' =3D> 'master',
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'/branches/*/projname' =3D=
> '/refs/heads/*' };
> =A0my %tag_spec =3D { '/tags/*/projname' =3D> '/refs/tags/*' };

The problem of specifying and detecting branches is a major problem in
my upcoming conversion.  We've got toplevel trunk/branches/tags
directories but underneath "branches" it's a free-for-all:

/branches/codenameA/{projectA,projectB,projectC}
/branches/codenameB   (actually a branch of projectA)
/branches/developers/joe/frobnicator-experiment (also a branch of proje=
ctA)

Clearly there's no simple regex that's going to capture this, so I'm
reduced to listing every branch of projectA, which is tedious and
error-prone.  However, what *would* work fabulously well for me is
"marker file" detection.  Every copy of projectA has a certain file at
it's root.  Let's call it "markerFile.txt".  What I'd really love is a
way to say:

my %branch_markers =3D {'/branches/**/markerFile.txt' =3D> '/refs/heads=
/**'}

I'm using ** to signify that this may match multiple path components
(sorry, I don't know perl glob syntax).  A branch point is any
revision that creates a new file that matches the marker pattern.

Ideally one could use logical connectives like AND and OR to specify a
set of patterns that could account for marker files changing over the
history of the project, but for my purposes that wouldn't be necessary
-- we've got a well-defined marker that's always present.

=46or bonus points I'd like to be able to speed things up by excluding
known-bad markers.  Say projectB has a file "badMarker.txt" at its
root and I don't want to import projectB into my new repo.  Maybe I
could specify:

my %branch_spec =3D {
        '/branches/**/markerFile.txt' =3D> '/refs/heads/**',
        '/branches/**/badMarker.txt' =3D> '!'}

I'm assuming that it would be helpful for the script to have this
information (e.g. it could stop recursive searches when badMarker.txt
is found), but maybe that's not the case.

I'd welcome any comments or (especially!) code to try out.  ;^)

Cheers,
-Nathan

--=20
http://n8gray.org
