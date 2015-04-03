From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-p4: Fetch the proper revision of utf16 files
Date: Fri, 3 Apr 2015 17:46:17 -0400
Message-ID: <CAPig+cT59B-ccvbfyPvVt_1dTO7jFPn7YQdhu81WSz_1WFM2GA@mail.gmail.com>
References: <1428095627-8772-1-git-send-email-git@dbingham.com>
	<1428095627-8772-2-git-send-email-git@dbingham.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, luke@diamond.org,
	Pete Wyckoff <pw@padd.com>, Daniel Bingham <git@dbingham.com>
To: Daniel Bingham <daniel@dbingham.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9Q0-0005iC-64
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbbDCVqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:46:19 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36044 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbDCVqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:46:19 -0400
Received: by lbbug6 with SMTP id ug6so85643564lbb.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FbXf/hKsVK4XjFPiURsjj0kCJvKWMHtanmQZaD7RFOk=;
        b=Y4mATkCmSaKvc5/IA8n3bu75qmazAPIsoKwQupRSrfverFYMi9hErMUzrH2H5vKvWZ
         jzakqBC2kSx8RERe4Rzud5zo3NYIONfR62xiGHm0oWFLfsn9deyhroj9Va1KUc8lINr1
         m0o/srs6FmUoSxhwbDCG3ULsRTgaw7ckRyra9zeL/QyjSvRq8G9NlMMr4lovJVekpq1j
         eGBD0ic0asTQv05z47J7GCJAbYwDv4NyFpyJlOO2cm8nhPd2oi1cuqnLjP7aqmegsJtJ
         86C/O0owe78cJRvzTmcjwoGJTC+IrtxYM74f5jYQ2DlHxCLS8ewGXa7dSUncnNKrGp99
         E+Sg==
X-Received: by 10.112.173.41 with SMTP id bh9mr3664169lbc.107.1428097577777;
 Fri, 03 Apr 2015 14:46:17 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 3 Apr 2015 14:46:17 -0700 (PDT)
In-Reply-To: <1428095627-8772-2-git-send-email-git@dbingham.com>
X-Google-Sender-Auth: 9W9lb8xY8IgAs_tchedTvWnNqTo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266734>

On Fri, Apr 3, 2015 at 5:13 PM, Daniel Bingham <daniel@dbingham.com> wrote:
> git-p4 always fetches the latest revision of UTF16
> files from P4 rather than the revision at the commit being sync'd.
>
> The print command should, instead, specify the revision number from the
> commit in question using the file#revision syntax.
>
> The file#revision syntax is preferable over file@changelist for
> consistency with how streamP4Files formats the fileArgs list.

As a non-Perforce reader trying to understand this patch, there are a
couple issues which are unclear or inadequately explained. Perhaps you
could provide a bit more detail or cite relevant sources.

First, does "UTF16 file" refer to the content or the filename?

Second, I may be entirely missing it, but the commit message doesn't
seem to explain why this impacts only "UTF16 files", and why this
solution is the appropriate fix.

If the answer to the first question is that the filename is UTF-16,
then would an alternate fix be to convert the value of
file['depotFile'] to have the same encoding as the "print -q -o - ..."
command-line? (Again, please excuse my Perforce-ignorance if I'm
completely off the mark.)

> Signed-off-by: Daniel Bingham <git@dbingham.com>
> ---
>  git-p4.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index ff132b2..156f3a4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2101,7 +2101,8 @@ class P4Sync(Command, P4UserMap):
>              # them back too.  This is not needed to the cygwin windows version,
>              # just the native "NT" type.
>              #
> -            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
> +            ufile = "%s#%s" % (file['depotFile'], file['rev'])
> +            text = p4_read_pipe(['print', '-q', '-o', '-', ufile])
>              if p4_version_string().find("/NT") >= 0:
>                  text = text.replace("\r\n", "\n")
>              contents = [ text ]
> --
> 2.3.5
