From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 02:59:44 -0600
Message-ID: <20111116085944.GA18781@elie.hsd1.il.comcast.net>
References: <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
 <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:59:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQbLa-0003sz-CO
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab1KPI7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 03:59:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46603 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1KPI7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 03:59:53 -0500
Received: by iage36 with SMTP id e36so299520iag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tIWnfZahwK550fS6/fh1j1Md0Q66V/At1FSq1x/FqDs=;
        b=FN/PJNCrF1Lqcebl2pr8zO8grjGlfQTq53Q6Jbl7AJdOYj8b+GmjpKOSHHrL5W+s/g
         cF0xmmCBhhhlsXparWc2iXMpgzpnwrCu3L8aiQMaXwgd6XrEfPoKyZKJgPVysxxG0//b
         koED3mKadW4y2neLdqeUN8rNb7uP20ASsJ/Vg=
Received: by 10.42.197.195 with SMTP id el3mr31019417icb.54.1321433992766;
        Wed, 16 Nov 2011 00:59:52 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bu33sm41797391ibb.11.2011.11.16.00.59.51
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 00:59:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185530>

Nguyen Thai Ngoc Duy wrote:

> Or perhaps
[...]
>  - git_path(const char *path) maintains a small hash table to keep
> track of all returned strings based with "path" as key.
>
> Out of 142 git_path() calls in my tree, 97 of them are in form
> git_path("some static string").

The main bit I dislike about patch 3/3 is that constructs like
'unlink(git_path("MERGE_HEAD"));' are not actually unsafe, unless they
happen to sit in the middle of an unsafe

	const char *filename = git_path(foo);
	int fd;

	call_a_function_i_dont_control();
	fd = open(filename, O_CREAT|O_WRONLY|O_TRUNC, 0600);

sequence.  Lacks that feeling of truth in advertising.  And on the
other hand that this doesn't help with thread-safety at all.

I think if I ran the world, the fundamental operation would be
strbuf_addpath().  Unlike git_pathdup(), this lets callers avoid some
allocation churn if they are in the middle of a loop.
