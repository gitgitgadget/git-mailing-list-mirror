From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 06/10] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Tue, 22 Jan 2013 00:38:25 -0800
Message-ID: <20130122083825.GG6085@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-7-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZNd-0000uW-V8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab3AVIic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:38:32 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38030 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab3AVIib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:38:31 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so3830698pbc.31
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 00:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tf4OaAtiusLeR5H2Zgw9YVzHkyOGgQxJURnw7PwwJ0k=;
        b=Dly3R+1wOQaLXgU6+x5U7mcMxiG5ynemqHSADUd30tV4pjq1BvJmKZgOw83tN3mx95
         WBK2OwVWR/xT1A/YZBiwuOT2JoxvG/yxvNQJeEy88XiTFEqz3ZEvSk5CzCb0z9kROzTH
         Dp5dMF9NJdAF+zIyQgG3Ll3Vt9JGyW/CALQjO8uadz/JLY+ry5hY0lKRgQ56iZESZaT+
         pYYwSudOuvWdvS8CTvtkXVTJ26RW/ju53FCojm7i/Li96R8jzdEH2CT1I0Oc1UaJNflC
         WY8mtHmhpMVLrwsjQVTRDV6fLSelMBlfAi0CrB5Z+vOxtMYqxaHzSW/ZNPLPw5Sk3QUE
         4JIw==
X-Received: by 10.66.52.79 with SMTP id r15mr54391997pao.46.1358843910853;
        Tue, 22 Jan 2013 00:38:30 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a4sm10994287pax.25.2013.01.22.00.38.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 00:38:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-7-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214220>

Brandon Casey wrote:

> Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
> This is in preparation to unify the append_signoff implementations in
> log-tree.c and sequencer.c.
[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1082,9 +1101,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	return pick_commits(todo_list, opts);
>  }
>
> -void append_signoff(struct strbuf *msgbuf, int ignore_footer)
> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)

Isn't the behavior of passing '1' here just a bug in "format-patch -s"?

Style: callers will be easier to read if the function takes a flag
word with named bits, as in:

	#define APPEND_SIGNOFF_DEDUP (1 << 0)
	void append_signoff(..., int ignore_footer, unsigned flag)
