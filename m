From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git doesn't detect change, if file modification time is restored to original one
Date: Thu, 23 Jul 2015 10:32:31 -0700
Message-ID: <xmqqsi8epyog.fsf@gitster.dls.corp.google.com>
References: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
	<55B09E95.4000700@gmail.com>
	<CABEDGg_R49K61wiV9SsTnLS9SztHDjEQhOHjwzYn2JJwrrb-KA@mail.gmail.com>
	<20150723175342.77f635820fb9f1b69a73d39a@domain007.com>
	<55B1053D.7030006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	=?utf-8?Q?Konr=C3=A1d_L?= =?utf-8?Q?=C5=91rinczi?= 
	<klorinczi@gmail.com>, Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKMJ-0003xX-DY
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbbGWRcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:32:35 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35627 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbbGWRce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:32:34 -0400
Received: by pdrg1 with SMTP id g1so160379140pdr.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HJUn7ru9C98hDyWfdObckXDM60DqkAJgDSWHgInPmbw=;
        b=bnyYaxIzzhbSsyymom23ScYOvv4LXNy9sBp29VlR9dSalkm5pqlxqgAz98vGU7qSC6
         UqvFVOYOFGuzT8U6p3e1ly+kJIYYJ++deAMVwJ28nLkfW1UXrMFvZt/b8ozfc/xLpiMD
         +w7y7pnDDLvkZR1+e1RtiNsJp8EPcO65jlXdNJuxo6ZOtsGeKKTQG2xGeFt7dAs7OgK8
         hWWVQnSgCDES3SbBoP+j9GZoCUucxeR1GxsmEroWPCpyAP2zv+425uIpDSHiSSJDfM06
         dqDxcgd4hfV2erBxQIu+wnumvjt+c/A+dHemwq0qpVKZZn/D3KguqYPmqQX+tbeoGyS2
         8A2A==
X-Received: by 10.70.89.109 with SMTP id bn13mr11804287pdb.163.1437672753941;
        Thu, 23 Jul 2015 10:32:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id i10sm10045845pdr.78.2015.07.23.10.32.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 10:32:32 -0700 (PDT)
In-Reply-To: <55B1053D.7030006@gmail.com> (Karsten Blees's message of "Thu, 23
	Jul 2015 17:16:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274511>

Karsten Blees <karsten.blees@gmail.com> writes:

> I'd like to add that this is not a git-specific problem: resetting mtime
> on purpose will fool lots of programs, including backup software, file
> synchronization tools (rsync, xcopy /D), build systems (make), and web
> servers / proxies (If-Modified-Since requests).
>
> So you would typically reset mtime if you *want* programs to ignore the
> changes.

Yup.  Nicely phrased.

When you run a wholesale rewrite of many files, often you find that
some (or many) of the files did not have to be modified.  E.g.
"perl -i -e 's/old/new/' *" may want to touch all files, but the
files that did not have string 'old' in them would have the same
contents as before.  In such a case, you can avoid unnecessary
reinspection of contents (e.g. recompilation) by many tools that pay
attention to mtime to see if contents changed by reverting mtime to
the original for files that did not change.

Git also pays attention to fields other than mtime, so after

    perl -i -e 's/old/ancient/' *

and reverting mtime even for ones that got changed, we should notice
the changes.  But you are correct that such an abuse of "touch" will
break many other tools.
