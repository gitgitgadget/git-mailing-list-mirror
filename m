From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Thu, 19 Apr 2012 13:11:00 -0400
Message-ID: <CAFouetg6T1pgAiTfyAeSxseR-k_omsZDfqv8X8AifekwPLoE2g@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
	<CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
	<CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
	<7vsjg1knwr.fsf@alter.siamese.dyndns.org>
	<CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com>
	<7v8vhsltk3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 19:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKusv-0006Ep-3n
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 19:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550Ab2DSRLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 13:11:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55474 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab2DSRLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 13:11:01 -0400
Received: by yenl12 with SMTP id l12so4622357yen.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R6bfBSI8l7R9LS9eVZAm08AqZJp3SgLBwQsWFTaBvf0=;
        b=FCrZmUNRgTowOFJMkYqayeIAfqNfkpy06DwIe+xGrLBUlyV8o92dt7mQEMd/5XrNKJ
         DyqpoFj9KjR6p7wHus2m7se61U5GFJiM1nu8TRMnoQLwnQqYxsg8i/GkmyUyyq4+733O
         +AJB8q1G1FoY3yN09rzpdSrZTi7hdeJjhQkVv01eK2kv7K89WbciMPer15DsW1NhGUTW
         QKiwQhxAUO815rCkA+ROc5wuBaMYvb+LwPDLq9M7I+XE1tJgmRVuKwvkebqN5Poqi+bw
         Cs12FEKzICC/O4k+Mdx88swT9V2LQRpEIWPFm6ivPtvicSQ/gm/QhZKHavGCs3qTGSri
         qVKQ==
Received: by 10.50.202.104 with SMTP id kh8mr3142860igc.21.1334855460601; Thu,
 19 Apr 2012 10:11:00 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Thu, 19 Apr 2012 10:11:00 -0700 (PDT)
In-Reply-To: <7v8vhsltk3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195954>

On Wed, Apr 18, 2012 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> For now, would you object to an updated patch that simply detects and
>> ignores options that change the output of 'git diff --raw'?
>
> As a script that uses 'git diff' is a short-term hack anyway, I think the
> most cost effective thing to do is to add '--no-renames' at the end and be
> done with it.

Adding '--no-renames' has no effect if the user specifies '-C -C' or
'--find-copies-harder'.  Is protecting for these cases too paranoid?

Also, the '--cc' option for viewing merge diffs is not affected by
'--no-renames'.

I have a revised patch that prunes out all of the above and warns the
user when it does so [1].

However, it also prunes them when difftool is called in serial diff
mode (i.e. non --dir-diff).  Before, if 'difftool
--find-[renames|copies]' was called it would open the external tool to
compare the two files, but the original file name was used for both
sides of the diff.

This seems confusing, but I don't know if people rely on that
behavior.  If we need to keep that behavior in the serial diff mode, I
will need to modify the patch again to only prune the options in
directory diff mode.

[1]: https://github.com/thenigan/git/commit/c3479940a36f3c7c8fe360bc244303b125f711ff
