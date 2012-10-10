From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] Support "**" wildcard in .gitignore and .gitattributes
Date: Wed, 10 Oct 2012 12:40:51 +0700
Message-ID: <CACsJy8AW4bCrXZtNtpYGT4=Z72u=Ge2OuX1sG3xs_jUx9gRfPw@mail.gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
 <1349752147-13314-9-git-send-email-pclouds@gmail.com> <5073D8FF.8080503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLp31-0001Ng-Px
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab2JJFlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 01:41:23 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40093 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab2JJFlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 01:41:22 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so4202795qad.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f2t4+l3gkjsq2Ia4eRJAAwgLt7a5PrtHgoy+xqHkjEI=;
        b=QPPPy6Gqy8hjM2ZHaTiVr3Q62+i3Txfae3UD3JgvuDveBb3BSC9UnYc5/gvBEQUPtV
         NdTOArYdFZ4+j+69nrctJckP/Q9WXiSzNg+p+J3ms4KlB++vSxUCB8UBu1Rj3QjpU6Cf
         oMPLh5wTIiZIAjEC84sMxYe+dheUH58fFBouceiynFGL+fLeE+trzpdw2EbgffCj7yUs
         9i42MhhWunP0d2CNRNisqbvC5ZIw5CMhgd5tbh2vUlUvLPXh5s7sNv1HymxcpoCktgj8
         wKejqUEDm6XcJa51wXXEswis5wbB5hceS0Bus0PnYWJAvTsJTlrAn7KUg3CDUmYznq4E
         F8Sw==
Received: by 10.224.222.13 with SMTP id ie13mr38773509qab.69.1349847681503;
 Tue, 09 Oct 2012 22:41:21 -0700 (PDT)
Received: by 10.49.13.194 with HTTP; Tue, 9 Oct 2012 22:40:51 -0700 (PDT)
In-Reply-To: <5073D8FF.8080503@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207365>

On Tue, Oct 9, 2012 at 2:57 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> + - A trailing "/**" matches everything inside. For example,
>> +   "abc/**" is equivalent to "`/abc/`".
>
> It seems odd that you add a leading slash in this example.  I assume
> that is because of the rule that a pattern containing a slash is
> considered anchored at the current directory. But I find it confusing
> because the addition of the leading slash is not part of the rule you
> are trying to illustrate here, and is therefore a distraction.  I
> suggest that you write either
>
> - A trailing "/**" matches everything inside. For example,
>   "/abc/**" is equivalent to "`/abc/`".
>
> or
>
> - A trailing "/**" matches everything inside. For example,
>   "abc/**" is equivalent to "`abc/`" (which is also equivalent
>   to "`/abc/`").

The tricky thing in .gitignore is that the last '/' alone does not
imply anchor. So "abc/" means match _directory_ abc anywhere in
worktree. So the former is probably better. I should also add a note
here (or in gitattributes.txt) about the difference between "/abc/*"
and "/abc/**". The former assigns attributes to all files directly
under abc (e.g. depth 1), the latter infinite depth.

>> + - A slash followed by two consecutive asterisks then a slash
>> +   matches zero or more directories. For example, "`a/**/b`"
>> +   matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
>> +
>> + - Consecutive asterisks otherwise are treated like normal
>> +   asterisk wildcards.
>> +
>
> I don't like the last rule.  (1) This construct is superfluous; why
> wouldn't the user just use a single asterisk?  (2) Allowing this
> construct means that it could appear in .gitignore files, creating
> unnecessary confusion: extrapolating from the other meanings of "**"
> users would expect that it would somehow match slashes.  (3) It is
> conceivable (though admittedly unlikely) that we might want to assign a
> distinct meaning to this construct in the future, and accepting it now
> as a different way to spell "*" would prevent such a change.
>
> Perhaps this rule was intended for backwards compatibility?

We break backwards compatibility already. Existing "**/" or "/**"
patterns now behave differently.

> I think it would be preferable to say that other uses of consecutive
> asterisks are undefined, and probably make them trigger a warning.

Instead of undefined, we can reject the pattern as "broken". I have to
check how fnmatch/wildmatch deals with broken patterns (it must do).
If it returns a different code for broken patterns, then we can warn
users, which is not limited in just "**" breakage.
-- 
Duy
