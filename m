From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an
 ignored directory
Date: Thu, 19 Aug 2010 02:52:28 -0500
Message-ID: <AANLkTi=u2jA5MOKwyYO_pwcZaK=A1D2g+gueFGF2L+5U@mail.gmail.com>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
	<vpq8w44mer6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	Jens.Lehmann@web.de, jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 19 15:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om5BV-0007p4-E4
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 15:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab0HSN3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 09:29:23 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:61841 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750930Ab0HSN3W convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 09:29:22 -0400
X-AuditID: 1209190e-b7b91ae0000068d0-63-4c6d31b26b67
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 22.11.26832.2B13D6C4; Thu, 19 Aug 2010 09:29:23 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o7JDTIBk011774
	for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:29:19 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7JDTHhF004107
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:29:18 -0400 (EDT)
Received: by iwn1 with SMTP id 1so75458iwn.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 06:29:17 -0700 (PDT)
Received: by 10.231.187.194 with SMTP id cx2mr9986741ibb.165.1282204348426;
 Thu, 19 Aug 2010 00:52:28 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Thu, 19 Aug 2010 00:52:28 -0700 (PDT)
In-Reply-To: <vpq8w44mer6.fsf@bauges.imag.fr>
X-Brightmail-Tracker: AAAAAhWs/CYVrch4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153922>

>> + =A0 =A0 mkdir ignored-dir &&
>> + =A0 =A0 echo ignored-dir >> .gitignore &&
>> + =A0 =A0 touch ignored-dir/file &&
>
> I think >ignored-dir/file is more portable than touch, and is
> recommanded in the testsuite. But a quick grep shows that touch is
> already used.
Ok, sure.  I'll switch over to >ignored-dir/file.

>> + =A0 =A0 test_must_fail git add ignored-dir/file >actual 2>&1 &&
>> + =A0 =A0 test_cmp actual expect &&
>> + =A0 =A0 git add -f ignored-dir/file &&
>> + =A0 =A0 git add ignored-dir/file &&
>
> (so, this is the first thing you're fixing, shouldn't be
> controversial)
Hopefully not :).

>> +test_expect_success 'git add with ignored directory using git globs=
' "
>> + =A0 =A0 mkdir ignored-dir2 && echo ignored-dir2 >> .gitignore && t=
ouch ignored-dir2/file &&
>> + =A0 =A0 git add 'ignored-dir2/*' >actual 2>&1 &&
>> + =A0 =A0 echo \"fatal: pathspec 'ignored-dir2/*' did not match any =
files\" | test_cmp - actual
>
> Currently, "git add 'dir/*'" will add the files under dir/ if dir/
> isn't ignored, and require -f if dir is ignored.
>
> I don't think you want to complain with "did not match any files"
> here.
Well, I copied the behavior of 'git add "*"' here, where every file in
=2E is ignored.  E.g.
"""
$ echo >ignore-file
$ echo .gitignore >>.gitignore
$ echo ignore-file >>.gitignore
$ git add '*'
fatal: pathspec '*' did not match any files
"""
One could reasonably choose to instead say "The following paths are
ignored by one of your .gitignore files: ...".  When I chose the "did
not match any files", I had been assuming that globbing works roughly
analogously to shell globbing, meaning the error one gets from a '*'
should be the same as that one gets from a 'dir/*' or '*/*'.  I
realized today that git globbing seems to act differently depending on
where the wildcard appears.  E.g.:
"""
$ mkdir a && echo >a/b
$ git add '*/*' # complains, doesn't stage any files
fatal: pathspec '*/*' did not match any files
$ git add 'a/*'
$ echo change >a/b
$ git add '*/*' # doesn't complain, but doesn't stage changes
$ git ls-files -m
a/b
"""
Is this a bug?  I looked for some docs on the globbing functionality,
but I didn't come across anything that specified it in detail.
Anyway, either way I still think consistency is ideal, and hence would
still vote for "did not match any files".  Thoughts?

>> + =A0 =A0 git add -f ignored-dir2/file && echo change > ignored-dir2=
/file &&
>> + =A0 =A0 git add 'ignored-dir2/*' >actual 2>&1 &&
>
> Just making sure I'm reading correctly: this is the second thing that
> should be fixed, and that your earlier patch didn't.
Yes, that's correct.  (Again, just trying to match functionality with
ignored files.)

> You're not testing the case
>
> =A0git add ignored-dir/
>
> which gives another case where Git tries to add files not explicitely
> given on the command-line. But the correct behavior of this case may
> be more controversial, so maybe it's indeed better to focus on the
> other cases.
A fair point.  I would have thought the behavior here should be
unchanged, namely that 'git add ignored-dir/' should spit out a "The
following paths are ignored by one of your .gitignore files: ..."
error, regardless of the directory's contents.  Does anyone believe
this should be different/would it be useful for me to draw up a test
case for it now?  In any case, I'll certainly put a test case for this
into the final patch.

Greg
