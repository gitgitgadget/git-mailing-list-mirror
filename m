From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 5/5] mingw_rmdir: set errno=ENOTEMPTY when appropriate
Date: Tue, 14 Dec 2010 23:49:17 +0100
Message-ID: <AANLkTi=12WqYn5GJpqPYqKE_2L51Em7Ek5szTZYryHd9@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <20101214222830.GF4084@sandbox>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdgm-00014B-60
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127Ab0LNWtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:49:39 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:65032 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759195Ab0LNWti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:49:38 -0500
Received: by fxm18 with SMTP id 18so1355610fxm.2
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 14:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=G34BJj70cnopWcZ9hLR5l0jYSe+H3KeFdrd5JYsegv4=;
        b=KHu9IxXWif7BGu2Ca7s4wabFWrMfDzUVWeFPrzle4kbxtTfASynTmfnptAHcZZztFV
         4p94XcdRBoFiCbwVe4jlosPM0QnZXnxi7FiG6xZoFA6jU2s6/Dv6Q7DEZVHbw74lHAIa
         seqb+exSu8W2PZN+sXXYojqaNhlx7gbGSOPGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=XJAulxP0PnmgIqOT7G/UIFrAiXGR028PC77kiLMbeiZr/ARCG9bbAdm7CGPB6lk908
         EkfU2FL1SFmUhZNx5SjTIr7wVIOLvCH1OeaPHvCDtUIVaA0QZy3bxz3I1b9tZMs6Sht5
         MGXjmZlGlw6Yh7jUe43KEMgsxV+lP5nuW0V04=
Received: by 10.223.83.194 with SMTP id g2mr2495999fal.75.1292366977388; Tue,
 14 Dec 2010 14:49:37 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Tue, 14 Dec 2010 14:49:17 -0800 (PST)
In-Reply-To: <20101214222830.GF4084@sandbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163704>

On Tue, Dec 14, 2010 at 11:28 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, EACCES overrules ENOTEMPTY when calling rmdir(). But if the
> directory is busy, we only want to retry deleting the directory if it
> is empty, so test specifically for that case and set ENOTEMPTY rather
> than EACCES.
>

Hmm... According to MSDN, rmdir(*) should already handle ENOTEMPTY.
Isn't the problem rather the structure of that loop? Shouldn't it be
sufficient to do something like this (note: untested, but the concept
should work, no)?

---8<---
#undef rmdir
int mingw_rmdir(const char *pathname)
{
       int ret, tries;

       for (tries = 0; tries < ARRAY_SIZE(delay); ++tries) {
               if (!(ret = rmdir(pathname)) || errno == ENOTEMPTY ||
                   !is_file_in_use_error(GetLastError()))
                      return ret;

               /*
                * We assume that some other process had the source or
                * destination file open at the wrong moment and retry.
                * In order to give the other process a higher chance to
                * complete its operation, we give up our time slice now.
                * If we have to retry again, we do sleep a bit.
                */
               Sleep(delay[tries]);
       }
       while (is_file_in_use_error(GetLastError()) &&
              ask_user_yes_no("Deletion of directory '%s' failed. "
                       "Should I try again?", pathname))
              ret = rmdir(pathname);
       return ret;
}
---8<---

(*) http://msdn.microsoft.com/en-us/library/wt8es881(v=VS.80).aspx
