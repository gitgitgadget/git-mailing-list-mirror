From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 16:52:49 +0200
Message-ID: <CALKQrgdMagUQMTGWX7RwBfBkA6+Q65aPfpk1W3m1BKMUNmjKFg@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
	<CAPig+cRg0ovyutXmTggr5P++dWuVP3izf5JfcJEeEVZhHuVJiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 16:53:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXBQC-0000n6-RV
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 16:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab3JROw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 10:52:56 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:50113 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3JROwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 10:52:55 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VXBQ5-0005qn-Fc
	for git@vger.kernel.org; Fri, 18 Oct 2013 16:52:53 +0200
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VXBQ5-00082k-7V
	for git@vger.kernel.org; Fri, 18 Oct 2013 16:52:53 +0200
Received: by mail-pd0-f175.google.com with SMTP id g10so3791732pdj.20
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 07:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h+Vn+G2zn2RQ0m+Po3g0ehjenkrd/4zaEnScZlc4N7U=;
        b=YAM7Ah9QFOEdzlzMfYHyajJuyHrbOqAHO5YFx87SnSONXsh1yqyDcex25GWn/Rr+Tk
         Vpe2PVUa1nFlNERsgAGPB36VRmUrY6NiCE9Te1ntMbI+NveKDcVCVNILMxBSSvGPDcrm
         Xmie7+hXhwF8n+GedrsQ0bOEBzHWcTIoS6SBqU8Ce4HE2qqc3ns9ewolxPUpP5RIFevb
         5VUN8CW/WcTUvx894xDXNUO7/SwWfYptYxuGCSw68rLfx5Q+Gu+4bEN9AT820s0lz4vv
         n1KKnDuXU6M/1iCLomQrZBTxJXI1QKt/0PgMAvEn7uo9x6cxlSX8dpMeFxTfD3/+xwIm
         NLuw==
X-Received: by 10.67.14.231 with SMTP id fj7mr3886184pad.115.1382107969328;
 Fri, 18 Oct 2013 07:52:49 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Fri, 18 Oct 2013 07:52:49 -0700 (PDT)
In-Reply-To: <CAPig+cRg0ovyutXmTggr5P++dWuVP3izf5JfcJEeEVZhHuVJiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236353>

On Fri, Oct 18, 2013 at 3:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Oct 18, 2013 at 9:17 AM, Johan Herland <johan@herland.net> wrote:
>> There are cases (e.g. when running concurrent fetches in a repo) where
>> multiple Git processes concurrently attempt to create loose objects
>> within the same objects/XX/ dir. The creation of the loose object files
>> is (AFAICS) safe from races, but the creation of the objects/XX/ dir in
>> which the loose objects reside is unsafe, for example:

[...]

>> The fix is to simply handle mkdir() setting errno = EEXIST as success.
>
> Would it make sense for the commit message to explain what happens if
> EEXIST is returned but the pathname is not a directory? (For instance,
> in the same race window, another process had created a plain file or
> pipe there.)

I'm pretty sure in that case, the following adjust_shared_perm() or
git_mkstemp_mode() would fail, and we'd end up returning error from
create_tmpfile() in any case.

I can add the above to the commit message if you insist. :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
