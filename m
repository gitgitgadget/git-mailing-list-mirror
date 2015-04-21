From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Tue, 21 Apr 2015 20:17:04 +0200
Message-ID: <CAMpP7NaFYmpjbVVJSXX9OTiOm=ycL+nABgLTHBDV3h75ZqbVTw@mail.gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
	<xmqqfv7wor6e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkcjP-0002oT-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 20:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbbDUSRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2015 14:17:07 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34267 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbDUSRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 14:17:05 -0400
Received: by obfe9 with SMTP id e9so150956537obf.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dBgkcRQazw4gw686ilf/QJME09dDzZ6OlIoIWFONGZ8=;
        b=YP/XVat7/i6117Un0IvBKNd3UjuJ+9ZattDnXT4pWc+4L366yrZoJwOBfwhWuwfOOn
         ynuvhln5uxgdXta3yw1bc3vyNQDgp55BhbERKORgpK+PXMzb4qPZAnwMurePb1Kg0+TT
         DbOKf9dOAcn4wj0Ex37F4rnMQyq8MhLOA7OOFSxqQU8mFZV0O6WzBq5rGBUJC56+HP55
         Cnwb/DXhdkXPrWpoO7kvUu9etH2Tr72URhugaUWWjxPtQ7kckMyTJ8qsK0QVXr2C39MC
         Ri5DN6n2i06jz8bUIylR6KL7LJCGPBPU6iksvlLa4JxF+dxgkIHvxxaEh081ov1PVTDY
         G2xg==
X-Received: by 10.60.37.73 with SMTP id w9mr3701666oej.49.1429640224824; Tue,
 21 Apr 2015 11:17:04 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 21 Apr 2015 11:17:04 -0700 (PDT)
In-Reply-To: <xmqqfv7wor6e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267544>

On Sun, Apr 19, 2015 at 3:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:
>
>> Known Problems:
>> * Unsure about the setup.c:read_gitfile refactor, feels a bit
>>   messy?
>
> The interface indeed feels somewhat messy.  I suspect that a better
> interface might be more like setup_git_directory_gently() that is a
> gentler version of setup_git_directory().  The function takes an
> optional pointer to an int, and it behaves not-gently-at-all when
> the optional argument is NULL.  The location the optional pointer
> points at, when it is not NULL, can be used to return the error
> state to the caller.  That function pair only uses the optional
> argument to convey one bit of information (i.e. "are we in any git
> repository or not?") back to the caller, but the interface could be
> used to tell the caller a lot more if we wanted to.
>
> If you model read_gitfile_gently() after that pattern, I would
> expect that
>
>  - The extra pattern would be "int *error";
>  - The implementation of read_gitfile() would be
>
>        #define read_gitfile(path) read_gitfile_gently((path), NULL)
>
>    and the _gently() version will die when "error" parameter is set
>    to NULL and finds any error.
>
>  - The caller of the gentle variant can use the error code to
>    determine what went wrong, not just the fact that it failed.  I
>    do not think your caller does not have an immediate need to tell
>    between "invalid gitfile format" and "No path in gitfile", but
>    such an interface leaves that possibility open.
>
> Thanks.
>

Ok, I'll try that approach, thanks. (and apologies for the late reply)

/Erik
