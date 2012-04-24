From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Potential problem in git-add may corrupt the index file
Date: Mon, 23 Apr 2012 18:51:48 -0700
Message-ID: <xmqq4ns9j3rf.fsf@junio.mtv.corp.google.com>
References: <CAEJt7hYYJh5dT1Tk99Oze6Hg4QaOqX5ERi0faWjyifQ6dr-pWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junfeng Yang <junfeng@cs.columbia.edu>,
	Heming Cui <heming@cs.columbia.edu>
To: Gang Hu <ganghu@cs.columbia.edu>
X-From: git-owner@vger.kernel.org Tue Apr 24 03:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMUv6-0002Fk-DM
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 03:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab2DXBvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 21:51:52 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:37249 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab2DXBvv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 21:51:51 -0400
Received: by faaa19 with SMTP id a19so168351faa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 18:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=+ddEmX9O6Zh+inV13UqaGCPtifrNU3cHCvqQHgP/gAY=;
        b=KYzHOHBxZotg6sMrLmuiDk4w8k5FiVkdNu2Jmsv04ldv6iTcFm0EZhapGJmxGi7i+E
         BB9xr1GhdjGvyDl7nGfJNp7nG4+7OPI0k9L28H3LwZYYySex/x5GG3R4q2SFygqikZSY
         PM5YLcmu4j0QtGhgfsXDGD32lXkzS5aaEYBSvnRkfVdb50WKP0xp2el3Kr7q3a3VmeBg
         hLnfC0fd3tZ18nno/2dnkrWjRfD1Wxhop1VwpGgClOLNP2n+8TN8knJZ3GH5+yeXX+Ms
         5Fcqnexx9usTZACu2i26qxkSk+tBAZngMy6ETgggWi9eoZrn/uhpvGLhqdr20T0vAOPT
         04MA==
Received: by 10.213.2.70 with SMTP id 6mr1454042ebi.18.1335232309965;
        Mon, 23 Apr 2012 18:51:49 -0700 (PDT)
Received: by 10.213.2.70 with SMTP id 6mr1454024ebi.18.1335232309806;
        Mon, 23 Apr 2012 18:51:49 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si11528480eef.1.2012.04.23.18.51.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 18:51:49 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 99D9A20004E;
	Mon, 23 Apr 2012 18:51:49 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id E40BCE120A; Mon, 23 Apr 2012 18:51:48 -0700 (PDT)
In-Reply-To: <CAEJt7hYYJh5dT1Tk99Oze6Hg4QaOqX5ERi0faWjyifQ6dr-pWw@mail.gmail.com>
	(Gang Hu's message of "Mon, 23 Apr 2012 19:30:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmVrAlrbtf7Lf6yp6sKkxeceNewPI5Z5coDTwqDph5rZ7XVjLv1emAOpLmZ8LARkt1+c0tJc70HxItUNV0y13iAzo94TihxijLJYhhMW+E7OfrJ4Le9N1717vUklHnssD05kTjRd/TCpIt43i2vdvZNqfuPMTq+WZop+0IcZEoTa85bIAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196175>

Gang Hu <ganghu@cs.columbia.edu> writes:

> If a crash happens after the rename(), the data may have not been
> completely flushed into the index file, so the user may face an empty
> or corrupted index file.

Yeah, probably we should add fsync_or_die() at the end of write_index()
in read-cache.c, possibly protect it with fsync_object_files just like
we do in close_sha1_file() in sha1_file.c for loose object files.

I think the real fix would be to update the write_index() codepath to
use the csum-file API, though.  Then sha1close() will give us the fsync
behaviour for free.
