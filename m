From: Dimitar Bonev <dsbonev@gmail.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD
 state while preserving its staged state
Date: Sun, 5 May 2013 01:46:28 +0300
Message-ID: <CADeMBopBvCmb4cz8p8vf-jXaOhfzP3GZKF94Efgsh-NOBs+d3Q@mail.gmail.com>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
	<7va9oawmbp.fsf@alter.siamese.dyndns.org>
	<7v61yywm49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 00:46:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYlE5-0003WL-Qs
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 00:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709Ab3EDWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 18:46:29 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:56595 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab3EDWq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 18:46:29 -0400
Received: by mail-ve0-f177.google.com with SMTP id jw11so2416096veb.36
        for <git@vger.kernel.org>; Sat, 04 May 2013 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sWL5IRXxoUn5/OATfwnotssrjlIiN6iwwXqwAtnMAMo=;
        b=kCgrIkYmHubpVMHuugMhdrlEGBQX++0jo/r8cFBbJ/1y6tnObIAAmCHvbACrNco6XS
         qSKmaEFtPhOMcLXzZXKgJzOhB605/73L2Aob5enytI6omac84P7i/YOL4kNybnXq6OBp
         v9kAXciVvObV+7rFDOu214WZcls04dRkXCd6p+h+b1eDfoW97H+bvLcDYzBkyrGLvPQg
         aYtF1jQeTQMmH1n84Yjmdkk/z5hpk10KyvReHwg6f5Pjha/H14iwYIu7kt+91wUe75qe
         yJKNzvDzPSMxI9lGSaByAdk8sNx4AcJ/rKXkVL08Dr9NxFN4Bk4mmovoCcNqanDEpduF
         XksA==
X-Received: by 10.220.194.5 with SMTP id dw5mr4160723vcb.47.1367707588211;
 Sat, 04 May 2013 15:46:28 -0700 (PDT)
Received: by 10.220.101.140 with HTTP; Sat, 4 May 2013 15:46:28 -0700 (PDT)
In-Reply-To: <7v61yywm49.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223380>

On Sat, May 4, 2013 at 9:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Is there no way to convince PowerShell to treat the output of a
> command as binary data with no particular encoding?

The best I could find out is to pipe the output to set-content:

git show HEAD:targetfile | set-content targetfile

The default console output redirection pipes the output to Out-File
which encodes the resulting file by default with little endian unicode
encoding, but it can be overridden by providing an argument:

git show HEAD:targetfile | Out-File -encoding utf8 targetfile

Also if I provide 'default' encoding to Out-File it produces the exact
same result as set-content command:

git show HEAD:targetfile | Out-File -encoding default targetfile

The API docs state that "Default" uses the encoding of the system's
current ANSI code page. So I guess it is system dependent, it could be
the case for set-content also, but at the very least set-content is
shorter to write.

On Sat, May 4, 2013 at 11:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> But if your result is _also_ something worth saving, what would you
>> do?  "git add" to update the index will trash the work that was in
>> the index, and that is by definition unrelated to what you worked on
>> in the working tree (you wanted to start from the version in the
>> HEAD, not from the version in the index, so the end result is likely
>> to lack the work you saved in the index).
>>
>> As Thomas said, I think a more reasonable workflow would begin by
>> saving the "somewhat worth saving" state you have in your index as a
>> WIP commit, i.e.
>>
>>       git commit -m wip
>>
>> When I experiment starting from a clean slate (after saving away
>> such a WIP commit), I would then do this:
>>
>>         git checkout HEAD^
>>

Actually this is not the case as I tried to explain with the 'git
commit' followed by 'git checkout HEAD~1 -- targetfile' followed by
'git commit --amend' example. The index and the working dir states are
very well related. Lets imagine that I am adding an MVC feature X - it
could be implemented with 3 or more files. If I stage the files and
came up with an idea that requires a major rewrite of one of these
files - lets say the controller one - then it is more convenient to
checkout the file's HEAD state and build on top of it - I had been
doing just that right before staging - building the previous
implementation so this is so familiar and still recent in time. If the
new controller implementation is less acceptable than the old one I
just commit, otherwise I stage the new implementation and just commit.
So simple, so common workflow.

One more argument against the suggestion of doing a commit ahead of
time is that I like to think in separation to reduce complexity - in
particular I like to think only for the working dir and index states,
commits - I treat them as finished work. If I have to amend a commit,
it is about fixing a mistake - adding/removing a wrong file, fixing a
typo, that sort of things and not for actual work to be done.
