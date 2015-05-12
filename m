From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 17:37:26 -0400
Organization: Twitter
Message-ID: <1431466646.16652.32.camel@ubuntu>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	 <1431384645-17276-4-git-send-email-dturner@twopensource.com>
	 <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	 <1431455779.16652.20.camel@ubuntu>
	 <xmqqh9rhftlh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHrp-0004G0-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933762AbbELVh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:37:29 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:33276 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbbELVh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:37:29 -0400
Received: by qcvo8 with SMTP id o8so12503089qcv.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=YqBF6JtffnniEyD02MsP5Vo5jTvbgppOIW0byfHasn4=;
        b=lqpTxfES1vya+Dkag3kVPZFVpFhawRTY7bBfKR3wenq6G+fvmQ3Pxg9wMDNntcD3zq
         yZyWElVp7j3182o2r8ENwxCEWwTG0XtLwOLLAm+bNy7UU9AMTBDr7ZyrRA+fvBSZ3ku2
         TQK63+ulfEHqD9V6yELjUBu/0imzaowJUupdwObvkC4Vbppq8IQJ+GRzhLZqsrYa07vn
         QTBHKO8r5JX/NDmb0NgigasTRc4aeVVgGhaium2C8NQGPPnhcQlOSm1B4cY/ir/nXhzA
         mgv8zxen7nTYNb6XwYTxbtvZI0LebUozetdMQq8FzO6T3YtxSPPqvGpqDz+r3cwyerIH
         rrHw==
X-Gm-Message-State: ALoCoQnKd5EbFfKgSwi72jLVYith85rd804XPLiERFvS4Dw5u21u7Hh4/v/dquBiFaDSa4evEtq+
X-Received: by 10.55.22.88 with SMTP id g85mr37387471qkh.48.1431466648433;
        Tue, 12 May 2015 14:37:28 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id 202sm14140502qhg.16.2015.05.12.14.37.27
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 14:37:27 -0700 (PDT)
In-Reply-To: <xmqqh9rhftlh.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268892>

On Tue, 2015-05-12 at 13:07 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >>  * I am not sure if HEAD:link that points at HEAD:link should be
> >>    reported as "missing".  It may be better to report the original
> >>    without any dereferencing just like a link that points at outside
> >>    the tree? i.e. "symlink 4 LF link".
> >
> > Unfortunately, a symlink loop might include relative symlinks
> > (e.g. ../a).  If we return a relative symlink, the user will
> > not be able to distinguish it from a non-loop, out-of-tree symlink.  So
> > I think we may not return symlink 4 LF ../a for these cases.  
> 
> I do not follow.  Let's start from a shared example.
> 
>     HEAD:sub/link is a symbolic link whose value is ../nextlink
>     HEAD:nextlink is a symbolic link whose value is sub/link
> 
> That's a loop.  Now, I think what I am sugesting is
> 
> 	$ git cat-file --batch-check --follow-symlinks <<\EOF
> 	HEAD:sub/link
>         HEAD:nextlink
> 	EOF
> 	symlink ../nextlink
>         symlink sub/link
> 
> If you asked about sub/link and then got ../nextlink back, then
> isn't it clear for the reading script that it is about nextlink
> at the top-level?  Why can't it tell it from out-of-tree link?

Because maybe sub/link was actually a link to ../../nextlink.  Or maybe
sub/link was actually a link to ../outlink, and ../outlink was a link
to ../nextlink. 

But I think I'm OK with implementing your proposed solution[1] of
categorizing all of the possible cases.


[1] http://www.spinics.net/lists/git/msg250893.html
xmqqd225fsw8.fsf@gitster.dls.corp.google.com 
