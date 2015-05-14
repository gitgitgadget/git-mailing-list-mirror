From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Thu, 14 May 2015 18:33:59 -0400
Organization: Twitter
Message-ID: <1431642839.17436.22.camel@ubuntu>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
	 <xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
	 <1431640373.17436.16.camel@ubuntu>
	 <xmqqbnhmiz78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 00:34:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1hg-00026l-OI
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbbENWeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:34:04 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34251 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933754AbbENWeB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:34:01 -0400
Received: by qkgx75 with SMTP id x75so59677286qkg.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 15:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=7jR9XPmkPwcQs6JrRy7voMcBsCLqbr0iKIFzTibi0B8=;
        b=bH7nJY3E2Zt41I4p7SlabaTuHgCcNUemFONWBnBYVlJKc0wgxwAWPcxVwXwDlDLDfl
         xwUTpMKabWcqnOpp3OAFMFrCGYp2XZlCvgz0/TGMf+SjL1h2uAdKg5mBmS/WC0boAf8e
         UmV6Kp+QYyN7BDZqVRgW6L3wCa1bi7OjVk7eE9oJyQVfua7zZtZZGKPzL1Hgpf9WfOFQ
         cfnE5qxpVAa4/8iYhx5tRMWYrfal07CM7LhEPHxB8hkAzpLOAT9+DY2BXnzfhP6LSqfc
         uUT087TJz2GCfnlJHZYnU9M6ZgoSvqakBJKL2f9Ar49q1wxYadnyMBdbR6sf7Wd7emeA
         5diw==
X-Gm-Message-State: ALoCoQmMTUq0jW77dch2w7uzfEfuYD5vT1feSvB8RYvt0ifhn609XxvvQCQXCnp/Y8xHkqaGsVAg
X-Received: by 10.55.40.132 with SMTP id o4mr14129353qko.61.1431642841214;
        Thu, 14 May 2015 15:34:01 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id 63sm300771qkz.30.2015.05.14.15.34.00
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 15:34:00 -0700 (PDT)
In-Reply-To: <xmqqbnhmiz78.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269117>

On Thu, 2015-05-14 at 15:14 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >> For this change to be an improvement that matters, you must be
> >> allowing some other process mucking around with the files in your
> >> working tree when you run "git clean".  The original catches such
> >> situation as an anomaly that the user would want to be aware of (and
> >> investigate), but this patch essentially declares that having such a
> >> random process touching your working tree from sideways is a normal
> >> situation.  I do not think I am willing to make such a declaration
> >> myself; I'd rather want to know why other people are touching my
> >> working tree while I am working in it.
> >
> > Our build tool[1] stores statistics in a hidden file in the working
> > tree.  After it runs, it daemonizes and uploads those stats, and then
> > deletes the stats file.  Because the upload might take some time, the
> > user might run git clean in the meantime.  (I think there might be some
> > other deletion that happens in the background too; I haven't really
> > investigated).
> >
> > Of course, in interactive use, very little harm is done if clean dies
> > here: the user simply must notice that the clean has failed and retry
> > it.  But in non-interactive use, scripts could fail.
> >
> > At least, I think that's what could be causing us to hit this error; I
> > haven't actually done any research to see if this is true.
> 
> I find that the above argues that this patch is a bad idea.
> 
> The change sweeps the problem under the rug, killing the canary in
> the mine, instead of motivating you to figure out why it is
> happening to you.

But it's totally legit for processes to create and delete files in the
working tree at any time.  Maybe I'm editing during the clean, and my
editor creates a backup file (or creates a lock file which it's going to
move on top of my old file).

> Of course, scripts could choose to ignore errors from "git clean" it
> runs.  At that point, the "sweeping under the rug" ugliness is not
> in Git, which is better ;-).

The problem is that git clean does not finish the job it has done in
this case.  So my script would have to retry on error (and every script
that git clean uses would have to so). 
