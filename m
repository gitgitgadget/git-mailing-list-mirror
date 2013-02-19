From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 19 Feb 2013 15:10:21 +0530
Message-ID: <CALkWK0=_AoWwAd8FN+GGvogT+p7PmTsm+KHNk0F09ymi2Snywg@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <CACBZZX6BVuQWtrLuTVXZo+77sT4yZQ3pvN=_fMma24-zd0NNqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:41:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jhE-0008Mh-7x
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556Ab3BSJkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 04:40:43 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45697 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464Ab3BSJkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 04:40:42 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so8240451iec.18
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=FMvDyWw/bcSY/lzAhOUQ60Ig8DUo40lwyOuxXp+B9pE=;
        b=RPDZPn+27FhA8PuRpHc+nRhBWnrvgfEjB/YdkCei6XydKM74YE2kR2MO8YXaM6iozb
         lCeFmjzvOAkqRxXIfU8BdBJO1ezu1EQqm9Q39cyF3Sl6GI/cJVRai11umgO0opGAyASm
         56y2ShfexGkwtmY3Jkbzm1rMBf2c5cnm0eWuUSe9KqcTWG29b/5wba2k4vBECokfqf60
         DqZv77Vjsv7yiklhNy0a5x/3qdBT6wY+eITzi4njPDou1HfJp+nxupRLhptqI0M0M7M8
         SNtBGIc0JGuGLKO8tUP2+88Zx4/NZkxPGL6FmkFCMnQHquH5JmmuGENX4HY4HmiMx2oT
         ZFew==
X-Received: by 10.42.67.10 with SMTP id r10mr7266611ici.7.1361266841617; Tue,
 19 Feb 2013 01:40:41 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 01:40:21 -0800 (PST)
In-Reply-To: <CACBZZX6BVuQWtrLuTVXZo+77sT4yZQ3pvN=_fMma24-zd0NNqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216584>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Feb 8, 2013 at 10:10 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> For large repositories, many simple git commands like `git status`
>> take a while to respond.  I understand that this is because of large
>> number of stat() calls to figure out which files were changed.  I
>> overheard that Mercurial wants to solve this problem using itnotify,
>> but the idea bothers me because it's not portable.  Will Git ever
>> consider using inotify on Linux?  What is the downside?
>
> There's one relatively easy sub-task of this that I haven't seen
> mentioned: Improving the speed of interactive rebase on large (as in
> lots of checked out files) repositories.
>
> That's the single biggest thing that bothers me when I use Git with
> large repos, not the speed of "git status". When you "git rebase -i
> HEAD~100" re-arrange some patches and save the TODO list it takes say
> 0.5-1s for each patch to be applied, but at least 10x less than that
> on a small repository. E.g. try this on linux-2.6.git v.s. some small
> project with a few dozen files.
>
> I looked into this a long while ago and remembered that rebase was
> doing something like a git status for every commit that it made to
> check the dirtyness.

What is it really doing?  I think the main culprit is
require_clean_work_tree() from git-sh-setup.sh, and that is only run
in the `--continue` and `exec` codepaths.
