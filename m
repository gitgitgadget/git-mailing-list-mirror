From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v6 3/7] setup: sanity check file size in read_gitfile_gently
Date: Tue, 12 May 2015 08:46:08 +0200
Message-ID: <CAMpP7NYEqTeVm3ybPmV7TvRkj5MjRYvD0J76ezXi9_jQsFterg@mail.gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
	<1431288041-21077-4-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 08:46:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys3xH-0004qh-Te
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 08:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbELGqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2015 02:46:11 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37726 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbbELGqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 02:46:09 -0400
Received: by widdi4 with SMTP id di4so926598wid.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4E6ZR7vaEmURIovpVzIvAsWP8SBmBHIRY2Kw6KsvTmw=;
        b=B8K3L/fqVXJCFEYG6RLUsFrkHMBPk2wfQGIZyp7JVq1F6cEonZC7uo6vkJ2AtFfnP6
         K5KGxYW2QhgBxxqOa/GkCF8GQ88CCFLUDYH0lSPdVnYgiCvZokywRC5zpkScbmePuLQS
         2CAD2VRMy7BhJrYZZQZuHVQv1l2VMC+GPddPQxeeY3N0z5coVaE4MyGfN+kTB+Xs1WFK
         dznTYLkhm0Qhny/DBokrReWu1RCp0WX/kS1vpOPXQPrF10Ib6GAdn9klLMo1LKInhxTv
         LW6jcTQPhmAlHvcq2ejviLyokLuSZ+lg/tSu9Ru+BfteNpsdwHRoTa9duc1c1d2QhSCP
         sXZg==
X-Received: by 10.180.108.100 with SMTP id hj4mr2361234wib.22.1431413168218;
 Mon, 11 May 2015 23:46:08 -0700 (PDT)
Received: by 10.28.49.66 with HTTP; Mon, 11 May 2015 23:46:08 -0700 (PDT)
In-Reply-To: <1431288041-21077-4-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268845>

On Sun, May 10, 2015 at 10:00 PM, Erik Elfstr=C3=B6m <erik.elfstrom@gma=
il.com> wrote:
> @@ -404,6 +405,11 @@ const char *read_gitfile_gently(const char *path=
, int *return_error_code)
>                 error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
>                 goto cleanup_return;
>         }
> +       if (st.st_size > one_MB) {
> +               close(fd);
> +               error_code =3D READ_GITFILE_ERR_TOO_LARGE;
> +               goto cleanup_return;
> +       }

Hmm... The order should probably be changed here. It would make more
sense to check the size before opening the file. That way the error
handling in clean would be more consistent if we can't open a large
=2Egit file.

Right now we would treat any file that we can't open as a potential
repository and avoid cleaning but if we can open it and it turns out
that it is larger than 1MB we will ignore it and clean. By switching
the order here we would always ignore files larger than 1MB regardless
of if we can open them or not and I think that would make more sense.
It would also remove the need to close the file when erroring out due
to size so it makes more sense from a pure structural point of view as
well.

Sorry for not thinking of this earlier.

/Erik
