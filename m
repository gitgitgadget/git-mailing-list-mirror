From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Sun, 9 Dec 2012 22:18:19 +1100
Message-ID: <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
	<7v8v9bjd44.fsf@alter.siamese.dyndns.org>
	<7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 12:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Theu5-000834-LI
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 12:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412Ab2LILSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 06:18:21 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63946 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2LILSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 06:18:20 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2867329iay.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 03:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qyPQZ3FL+qMKHkqf1e9fQi9S3ow/vVfGqf2Ysdd4img=;
        b=hg7WeGi3gIOcTQ0QlB6UTUrO0a7DU8iko+zjDeCzCWgAB24SGdCsL0Ot0TkgpuOd68
         XmBJEVHIzwAG/4PKtTuFHTCJBYqxEcrMhPVkahqIz13IJEDic0O1aqRDAY2zJFZTdEqe
         lPStW0CtKZ5H+k9CGd2x5xH3JRCdbL9JGHhMQeyA4JD3zyGzHmBkA2CWW+tMyYCqzFeT
         aQ3S2Ti9CisTtXShnz+Y9y0CgDCQi0V0po1r1/VlyFoWd+B0efurZd1bzDP7ezyiFfVV
         G52kkdHHVhgIMs6B3gadmjG+FI63KI9wER9KJM0uiT2jnqE6j74qGHdzPouY7JSMyg7J
         O7LQ==
Received: by 10.43.49.199 with SMTP id vb7mr8579802icb.6.1355051899897; Sun,
 09 Dec 2012 03:18:19 -0800 (PST)
Received: by 10.64.126.138 with HTTP; Sun, 9 Dec 2012 03:18:19 -0800 (PST)
In-Reply-To: <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211235>

>> Hrm, following your discussion (ellided above), I would have
>> expected that you would show
>>
>>     Removing directory foo/bar
>>     Removing untracked_file1
>
> Also it would be nice to have warnings about undeleted directories since this git
> clean behavior (or the work around to pass -f twice) is not documented.
> Without a warning you would probably miss that something was _not_ deleted.

Thanks for the feedback. I think you're right. Showing 'foo/bar/bar.txt' in
the list when 'foo/bar/' directory has been successfully deleted is just noise.

Would like to get some more feedback on the proposed output in case of
 (1) an untracked subdirectory with multiple files where at least one of them
     cannot be removed.
 (2) reporting ignored untracked git subdirectories

Suppose we have a repo like the one below:
  test.git/
    |-- tracked_file
    |-- untracked_file
    |-- untracked_foo/
    |     |-- bar/
    |     |     |-- bar.txt
    |     |-- emptydir/
    |     |-- frotz.git/
    |     |     |-- frotx.txt
    |     |-- quux/
    |           |-- failedquux.txt
    |           |-- quux.txt
    |-- untracked_unreadable_dir/
    |     |-- afile
    |-- untracked_some.git/
          |-- some.txt

$ git clean -fd
Removing untracked_file
Removing untracked_foo/bar
Removing untracked_foo/emptydir
Removing untracked_foo/quux/quux.txt
warning: failed to remove untracked_foo/quux/failedquux.txt
warning: failed to remove remove untracked_unreadable_dir/
warning: ignoring untracked git repository untracked_foo/frotz.git/
warning: ignoring untracked git repository untracked_some.git/
Use git clean --force --force to delete all untracked git repositories

$ # use forced remove
$ git clean --force --force -d
Removing untracked_foo/frotz.git
Removing untracked_foo/quux/quux.txt
Removing untracked_some.git/
warning: failed to remove untracked_foo/quux/failedquux.txt
warning: failed to remove untracked_unreadable_dir/

Can you see any issues with the proposed output, wording above? If
everyone is happy,
I'm going to prepare patch V2 for it.

Thanks,
Zoltan
