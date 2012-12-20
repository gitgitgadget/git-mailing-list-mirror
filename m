From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] wildmatch: support "no FNM_PATHNAME" mode
Date: Thu, 20 Dec 2012 20:34:06 +0700
Message-ID: <CACsJy8AFAKEeeFMp1EF+=QyZydoyVRFqPdAKrZbPe2h4_bf=fg@mail.gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
 <1355922488-20976-3-git-send-email-pclouds@gmail.com> <7vlicu9cpk.fsf@alter.siamese.dyndns.org>
 <CACsJy8C9Nhdq_xBAOxtmLcUnrUioAMvWCPk=sBZKOzFY2WR+iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 14:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlgH2-0006eN-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 14:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab2LTNej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 08:34:39 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35875 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab2LTNei (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 08:34:38 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so3297436obb.9
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iZHKvCxT7ryxBRqBFdkmCBDTqRgVgHN5h4z1Ix0g6Rg=;
        b=wO0QOYE3XYv5Ev8PfPUm99dXH/mkNLlH56uOnOuMybvYSYYyeWSK22l6B2s7JS7tPM
         MecyYlhkG84OYOSfyVQbzBo4ef/JIogbS7DnoXQoWwxDGDqRXG4zWDfFZjr3P2F7Xei3
         u33RCSPlWAYq5RbWk/bC5Nv7c+ypRdL9fOoz4s5gSz+2mmQHTFAq0MIOo6W9wNiL4kGV
         cqwut1GL9wIDxyEoeCFd4elewYG16cNWCzcsQMPy49uUi2/i5qP3EhZ1VweZjCHSYED1
         dI3mHrFnHQEhNbZzX59m7yBv3a1zf5Ji/LBjxDUhPC9xUN+8TeRqJcRwQ8XY2HfVCong
         GB9g==
Received: by 10.182.207.8 with SMTP id ls8mr4213911obc.65.1356010477594; Thu,
 20 Dec 2012 05:34:37 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Thu, 20 Dec 2012 05:34:06 -0800 (PST)
In-Reply-To: <CACsJy8C9Nhdq_xBAOxtmLcUnrUioAMvWCPk=sBZKOzFY2WR+iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211887>

On Thu, Dec 20, 2012 at 8:55 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> As long as simpler patterns fnmatch() groks (namely, '?', '*', and
>> '[class]' wildcards only) are not slowed down by replacing it with
>> wildmatch(), that is, of course.
>
> I'm concerned about performance vs fnmatch too. I'll probably write a
> small program to exercise both and measure it with glibc.

I'll send out proper patches later this weekend, but unless I make big
mistakes it seems wildmatch is faster than fnmatch from glibc 2.14.1
on x86-64 :) Maybe I did make mistakes. The test matches every line in
/tmp/filelist.txt (which is ls-files from linux-2.6.git) 2000 times.
"pathname" means FNM_PATHNAME.

$ export LANG=C
$ ./test-wildmatch-perf /tmp/filelist.txt 'Documentation/*' 2000
wildmatch 1s 528394us
fnmatch   2s 588396us
$ ./test-wildmatch-perf /tmp/filelist.txt 'drivers/*' 2000
wildmatch 1s 957243us
fnmatch   3s 134839us
$ ./test-wildmatch-perf /tmp/filelist.txt 'Documentation/*' 2000 pathname
wildmatch 1s 548575us
fnmatch   2s 629680us
$ ./test-wildmatch-perf /tmp/filelist.txt 'drivers/*' 2000 pathname
wildmatch 2s 142377us
fnmatch   3s 318295us
$ ./test-wildmatch-perf /tmp/filelist.txt '[Dd]ocu[Mn]entation/*' 2000
wildmatch 1s 748505us
fnmatch   3s 224414us
$ ./test-wildmatch-perf /tmp/filelist.txt '[Dd]o?u[Mn]en?ati?n/*' 2000
wildmatch 1s 743268us
fnmatch   3s 278034us
$ ./test-wildmatch-perf /tmp/filelist.txt '[Dd]o?u[Mn]en?ati?n/*' 2000 pathname
wildmatch 1s 745151us
fnmatch   3s 314127us
$ ./test-wildmatch-perf /tmp/filelist.txt nonsense 2000 pathname
wildmatch 1s 310727us
fnmatch   2s 279123us
-- 
Duy
