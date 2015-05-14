From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Thu, 14 May 2015 17:52:53 -0400
Organization: Twitter
Message-ID: <1431640373.17436.16.camel@ubuntu>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
	 <xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:53:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt13t-0008Gl-8T
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbbENVw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:52:57 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34388 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422740AbbENVw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:52:56 -0400
Received: by qcyk17 with SMTP id k17so47606896qcy.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=nbAsgMe2d2I9w4OaP3LS6zYtkUoHIloVLSOJvoQNqx0=;
        b=BmN+Ws23N7G2FJzz4kXSVWm33uj5a4mbwvlwaK/F7gKyAcr+o2RRLijJ5IUnA77mCm
         JCEhuzuEVDY6hG4YDbh/jcoUlC74GYzg6Urfmjib33Zz2Oip6e0fY0tehVzc/2QjpaUc
         zojXTDIi0lL7AZeb7LBp8m81mO0O6BYR5aaq0FymYiGzJBxSohgctKveRskb3U+zhFpP
         858kZsVWmWC7tEIE1JDzHX9q15xACZOQA/t4e6wZ7CL83NlR9I0pKIJN7j5QKHW/r2Lx
         bBEM7FydP3Px0PYmt4kE43mG9PFjuFVl9MXbCsZHR4wvSWyWmuSMP4y7pPRqxq4dIYlg
         x6Ow==
X-Gm-Message-State: ALoCoQmkzr5Fe5RCtWVtbWQy+W2Zihm4GiwbXXaIpB7VljTZN/0M20FWUqAS7yd4OUSiHswjTfqo
X-Received: by 10.55.31.27 with SMTP id f27mr6406785qkf.9.1431640375434;
        Thu, 14 May 2015 14:52:55 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id g184sm244867qhc.6.2015.05.14.14.52.54
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 14:52:54 -0700 (PDT)
In-Reply-To: <xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269106>

On Thu, 2015-05-14 at 14:45 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > During a git clean, some other process might be deleting files as
> > well.  If this happens, make git clean no longer die.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> 
> I am having a hard time to convince myself that this is a good
> change.
> 
> For this change to be an improvement that matters, you must be
> allowing some other process mucking around with the files in your
> working tree when you run "git clean".  The original catches such
> situation as an anomaly that the user would want to be aware of (and
> investigate), but this patch essentially declares that having such a
> random process touching your working tree from sideways is a normal
> situation.  I do not think I am willing to make such a declaration
> myself; I'd rather want to know why other people are touching my
> working tree while I am working in it.

Our build tool[1] stores statistics in a hidden file in the working
tree.  After it runs, it daemonizes and uploads those stats, and then
deletes the stats file.  Because the upload might take some time, the
user might run git clean in the meantime.  (I think there might be some
other deletion that happens in the background too; I haven't really
investigated).

Of course, in interactive use, very little harm is done if clean dies
here: the user simply must notice that the clean has failed and retry
it.  But in non-interactive use, scripts could fail.

At least, I think that's what could be causing us to hit this error; I
haven't actually done any research to see if this is true.

[1] https://github.com/pantsbuild/pants
