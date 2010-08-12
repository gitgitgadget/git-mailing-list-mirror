From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked files
Date: Thu, 12 Aug 2010 11:54:01 -0400
Message-ID: <AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<vpqsk2kjks7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 12 17:54:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oja6g-00057k-4W
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 17:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303Ab0HLPyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 11:54:08 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:55371 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760260Ab0HLPyG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 11:54:06 -0400
X-AuditID: 1209190c-b7c0dae000000a0c-52-4c64191e890a
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 91.BF.02572.E19146C4; Thu, 12 Aug 2010 11:54:06 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o7CFs4Tr017996
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 11:54:04 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7CFs240019440
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 11:54:03 -0400 (EDT)
Received: by wwj40 with SMTP id 40so1716168wwj.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 08:54:02 -0700 (PDT)
Received: by 10.227.155.139 with SMTP id s11mr209402wbw.221.1281628442022;
 Thu, 12 Aug 2010 08:54:02 -0700 (PDT)
Received: by 10.216.19.142 with HTTP; Thu, 12 Aug 2010 08:54:01 -0700 (PDT)
In-Reply-To: <vpqsk2kjks7.fsf@bauges.imag.fr>
X-Brightmail-Tracker: AAAAARWXE7o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153383>

>> Currently, 'git add' will complain about excluded files, even if the=
y
>> are already tracked:
>
> This is not exactly true:
>
> $ echo '*.pdf' > .gitignore; touch foo.pdf; git add -f foo.pdf
> $ echo content >> foo.pdf; git add foo.pdf
>
> Here, the second "git add" didn't need the -f flag.
>
> So, your problem is not about already-tracked exclude files, but it i=
s
> about already-tracked files in an excluded directory.
Good catch.  My commit message is definitely wrong.

>> This commit changes 'git add' to disregard excludes for tracked file=
s
>> whose paths are explicitly specified on the command-line.
>
> I don't think you need this to solve the problem, and as Junio said,
> that would make "git add dir/*" add all the ignored files, which woul=
d
> make -f essentially useless.
I respectfully disagree with this assessment, however.

=46irst of all, as you point out 'git add foo.pdf' works where foo.pdf
has been explicitly ignored, while in contrast 'git add dir/file'
fails when file has only been indirectly ignored because it is in an
ignored directory.  In the former case, the user explicitly specified
a policy for that file.  In the later case, the policy is only
indirectly expressed because that file happens to be in an ignored
directory; in my and =C6var's use cases what we mean is "I only care
about a few files in a big directory and don't feel like writing out a
=2Egitignore entry for each one".  So it doesn't make sense to me to
allow the user to add the file in the first place (whether by a 'git
add foo.pdf' or a 'git add f*') but not the second.  Perhaps the
answer is to swing in the opposite direction of this patch series and
make 'git add foo.pdf' fail as well, but I must ask what we'd be
defending against... it seems the only reason is to allow the user to
maintain local changes to a tracked file, but as I've stated many
other tools don't seem to similarly respect the .gitignore.

Secondly, I don't think this makes '-f' useless.  '-f' would still be
used to initially add an untracked file to the index.  So this would
maintain an invariant that no ignored files are tracked unless the
user has specified a '-f' for it in the past.

Incidentally, I noticed that 'git add dir/file' for ignored dir worked
fine in an older version of git.  'git bisect' reveals that the
behavior I would like to change was introduced in 29209cb.  From the
commit message, I get the sense that this particular behavior was not
actually intentional (someone please correct me if I'm missing
something).

Thanks,

Greg
