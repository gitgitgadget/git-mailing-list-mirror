From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] t7063-status-untracked-cache flaky?
Date: Fri, 16 Oct 2015 13:34:33 -0700
Message-ID: <xmqqfv1aeena.fsf@gitster.mtv.corp.google.com>
References: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
	<56211619.3090907@web.de> <1445026298.20887.28.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:34:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnBi4-0000RP-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbbJPUeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:34:36 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32859 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbJPUef (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:34:35 -0400
Received: by pabrc13 with SMTP id rc13so129715794pab.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=avCRbm31Rax4sCZdO2bVpfvBNiJhY59D/4qArnB07gQ=;
        b=eeKnRpH7M+98JN3D88LAKymQ41coPKXHCMdvgkd/BGicw6g25rfUI/wyD3BuluDk3i
         4ZW5bh8Wx+k9zrJmsUa/ncbqPdgeqtJBMY03bZZdQCppeZMcc86RDEg3C1U5vXmcGpXH
         GjFzM7ujB1budoUgzcgi1JrGgkssYHDiTCsFQTrXdalgi8HAb7jh5xEBij1i3ul/DZkR
         eo0jhaZ46Wl7irIP7LXb6YAliVtRYXmmaHW1NaPdKj4WtlWrrp649YY0yLw/Hs4W/KA+
         l9601Z9kRxxYi10URaZikqeP8WGeqTI7Uid81Tf/NpDKRy88VBRsxqBU4oaTci2terTW
         Xe7g==
X-Received: by 10.68.204.37 with SMTP id kv5mr18529129pbc.64.1445027675276;
        Fri, 16 Oct 2015 13:34:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id ve8sm317687pbc.48.2015.10.16.13.34.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 13:34:34 -0700 (PDT)
In-Reply-To: <1445026298.20887.28.camel@twopensource.com> (David Turner's
	message of "Fri, 16 Oct 2015 16:11:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279765>

David Turner <dturner@twopensource.com> writes:

> The problem is:
>
> trash directory.t7063-status-untracked-cache$ diff trace trace.expect 
> 3,4c3,4
> < directory invalidation: 1
> < opendir: 1
> ---
>> directory invalidation: 2
>> opendir: 2
>
>
> I can repro on a SSD.
>
> I had to try many times to reproduce (I think even more the second
> time). I just ran the test in a while loop until it failed.
>
> I suspect that the kernel might be a bit slow to update the mtime on the
> directory, but I have not yet been able to repro, and I don't understand
> why it only happens in this one test, since sparseness should be
> completely unrelated.

If you are invalidating your cache based on mtime of the directory,
an operation within mtime granularity can cause you to miss it,
unless you try to be conservative and do the "assume invalid if
racy".  And if you do "assume invalid if racy", the result will
become timing dependent.  You may end up invalidating more than
absolutely necessary, i.e. the test writer may have known that at
least 1 must be definitely stale at that point in the test, but
if another directory was iffy and the code played safe, you would
see one more invalidation than expected (which would lead to
scanning the directory, hence one more opendir).

Is that what is going on here?
