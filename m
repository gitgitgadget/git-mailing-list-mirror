From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Wed, 28 Jan 2015 08:53:46 +1300
Message-ID: <CAFOYHZDcvBvF8rgyax_4xMc88sZJFTVX-fXwV1iZa8veTaFixQ@mail.gmail.com>
References: <54C7B115.7020405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 20:53:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGCD0-0000lZ-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 20:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbbA0Txs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2015 14:53:48 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41120 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733AbbA0Txr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 14:53:47 -0500
Received: by mail-pd0-f171.google.com with SMTP id fp1so20784458pdb.2
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7mN4QSdQWch2gmb33X3yxyBScHQ7jYXMPi6mFClyAYc=;
        b=l9KjTzrxKNb++Vx4mK+bK5aH+96BxW9U81ubRQVt6U55HnXPTOA0tXur1cS7jYtBEn
         p4x7S3L0XC5efoXr4I4GpHoJjEp3ldqzghY3xN2HBVLO4DKi3YmjBOEQTLKaj0gXUbyr
         lGogzMkapz3IDka1q5Vx+wgRUJLTg6w7A+YjIYK9ND7baOoCytR8T3kMq9tln02F4JXN
         x+eEvsV2PlpKB7zOhHyB2efKR7kGMlGwXOveGR3N6aBFjQS22KVNr3WBKGT8+2vM9OuA
         clQxXrSfPX/xuEA8bVxhI5guDM2Dsai+VFK7gEqyBiKpCvPYFcCQ73O0hTZ/yKCQW6Fm
         jHWg==
X-Received: by 10.70.49.99 with SMTP id t3mr4690992pdn.105.1422388426598; Tue,
 27 Jan 2015 11:53:46 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Tue, 27 Jan 2015 11:53:46 -0800 (PST)
In-Reply-To: <54C7B115.7020405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263084>

Minor typo in a comment.

On Wed, Jan 28, 2015 at 4:39 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> The SANITY precondition was not set when running as root,
> but this is not 100% reliable for CYGWIN:
>
> A file may be allowed to be deleted when the containing
> directory does not have write permissions.
>
> See
> https://technet.microsoft.com/en-us/library/bb463216.aspx
> "...In UNIX, the write permission bit on a directory permits both
> the creation and removal of new files or sub-directories in the direc=
tory.
> On Windows, the Write_Data access right controls the creation of new
> sub-files and the Delete_Child access right controls the deletion. ..=
=2E."
>
> We may argue that the translation of the POSIX write permission bit
> into "Windows access rights" can be improved in CYGWIN.
>
> A dynamic test handles all cases: when the sequence
> $ mkdir SANETESTD &&
> $ chmod +w SANETESTD &&
> $ >SANETESTD/x &&
> $ ! rm SANETESTD/x
> succeeds the prerequisite SANITY is true.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/test-lib.sh | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 93f7cad..887e986 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1038,8 +1038,23 @@ test_lazy_prereq NOT_ROOT '
>
>  # When the tests are run as root, permission tests will report that
>  # things are writable when they shouldn't be.
> +# Special check for CYGWIN (or Windows in general):
> +# A file can be deleted, even if the containing directory does'nt

s/does'nt/doesn't/

> +# have write permissions
>  test_lazy_prereq SANITY '
> -       test_have_prereq POSIXPERM,NOT_ROOT
> +       mkdir SANETESTD &&
> +       chmod +w SANETESTD &&
> +       >SANETESTD/x &&
> +       chmod -w SANETESTD ||
> +       error "bug in test sript: cannot prepare SANETESTD"
> +
> +       ! rm SANETESTD/x
> +       status=3D$?
> +
> +       chmod +w SANETESTD &&
> +       rm -rf SANETESTD ||
> +       error "bug in test sript: cannot clean SANETESTD"
> +       return $status
>  '
>
>  GIT_UNZIP=3D${GIT_UNZIP:-unzip}
> --
> 2.2.0.rc1.26.g3e3a70d
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
