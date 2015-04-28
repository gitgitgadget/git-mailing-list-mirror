From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Windows path limites, was Re: [PATCH v5 2/5] setup: sanity check
 file size in read_gitfile_gently
Date: Tue, 28 Apr 2015 10:33:42 -0500
Message-ID: <CAEtYS8QMSSbfd2xSCMh2YTW2NSz7uBnsmKUi9SjSCrJ1TBEH+w@mail.gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
	<20150428060222.GK24580@peff.net>
	<e7c614c97eb4b1819cec25567a7adc97@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:33:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yn7W8-0000iZ-JU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 17:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965724AbbD1Pdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 11:33:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34034 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965700AbbD1Pdm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2015 11:33:42 -0400
Received: by pacyx8 with SMTP id yx8so167821051pac.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Zt/0I4q8JoXw5P2TUjwmkJ4VHZkJtN8/wEGxANiDa0U=;
        b=W0BcpjqHm6ZIe+AJDqA9A5zapMFULrhp+z/umAABfz0J35XiGE+GilLlj4wI8Y5FrM
         HoTYQX9AnOU6qzX0TWbeWSEiFmiGp/AG2c43eEPteZlaS3zE8a2WQ/lnX+7SBAw8X8FP
         QH2VhCUkBHSWNuv99hry7YeHlLVqwBqTGcobG6HhK1F0Z5C+QtLNbi+uQc4kkVZGPDDQ
         HXLAfIOLnkAO0PkPfiDLFNVRrHHcAVfYpsxHrcja2lHe0cMutO0rU3HxbfZwIMIwa+9T
         gA1yCGywdQO6CVt65v6oMvRev3RxeZvkAVHaH/Ehhih82UxpOVcMHmOJoRSQCrMg/MjW
         lF5Q==
X-Received: by 10.70.140.108 with SMTP id rf12mr32706070pdb.140.1430235222106;
 Tue, 28 Apr 2015 08:33:42 -0700 (PDT)
Received: by 10.70.106.198 with HTTP; Tue, 28 Apr 2015 08:33:42 -0700 (PDT)
In-Reply-To: <e7c614c97eb4b1819cec25567a7adc97@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267928>

On Tue, Apr 28, 2015 at 2:23 AM Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
>
> Hi Peff,
>
> On 2015-04-28 08:02, Jeff King wrote:
>
> > My understanding is that PATH_MAX is set absurdly low on Windows
> > systems (and doesn't actually represent the real limit of a path!).
>
> Well, yes and no. Yes, it is absurdly low on Windows, and yes, it is not the real limit of a path *if you know how to work around it*. Most Win32 API calls actually do have that absurdly low limit, but internally longer paths can be represented (and there is a hack where you prefix the path -- which must be an absolute one for this hack -- by `\\?\`). Keep in mind, though, that even the Windows Explorer is (at least sometimes) limited by the absurdly low path limit.
>

One more thing worth noting is that path lengths are actually restricted further
within git_path_submodule(), I would presume to reserve some amount of space
when cloning a submodule (it seems to set aside 100 characters)?  For other
cases, yes, Dscho is absolutely right: the MAX_PATH constant is 260 (which gives
something like 256 usable characters).  If you're able to do everything through
the Unicode Win32 APIs, you can reach 65535 characters, assuming the filesystem
supports it (NTFS does, FAT32 would not, for example).  I recall there being one
function (possibly thinking of mktemp) that couldn't properly handle the long
paths, but I believe that was it.

Other apps may or may not handle the longer paths well; the core.longpaths
switch may prevent mishaps in more than just Explorer, but the downside isn't
disaster always either -- for example, Explorer just refuses to browse
to that path.
(Note that other apps may include both the msys bits as well as the Windows
command line built-in commands, which may make things that farm out to sh
behave in unusual ways.  I vaguely remember testing this myself, but I
don't recall
what I did exactly or what happened.)

--Doug
