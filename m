From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: what file extensions must be explicitly configured with respect
 to eol-type in gitattributes?
Date: Mon, 20 Sep 2010 18:51:49 +0200
Message-ID: <AANLkTikJO631YDE_UpNrC-4kjc_LF5_Gb8Xv7pCJfOf=@mail.gmail.com>
References: <AANLkTikK2oL3sUYHdqoQ7C47nd6Pi53N17GSfh8nx6Q-@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 18:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxjbG-0007On-3c
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 18:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab0ITQwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 12:52:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48097 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab0ITQwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 12:52:10 -0400
Received: by vws3 with SMTP id 3so3442074vws.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=tYiurplzETRaLQN1fHVpZNyczBM2TqGtMaQoSo0HDN4=;
        b=azWvpVSN/H311okujaiYFwslp8MfdpYb5C3ZVd5+q0nxDwz/CUC1v6gBQ5a6ZUG892
         kP0p86z9BwdMp+vWXZ64uD26xU4lvPSe6I43/wfEUPk6glZskfzOe0MfK949DnR/CCWL
         t8pK67xVdD2wtrowBwo9thMLBamTzJZSOKIW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=AAExYJTlBgGjkbSHIeZytfh7YfeCNPlN/32AlGWC+me6fzYEs+b1cn59+MYGNwH8sE
         UIO0qCT0jkNCR9Y4QqwxZJw3FfIfyXHgUylpjv+7c3eOnfBgnxwfMx92j8esKPc+SGY8
         EP0O+wcvkmiJDIOz4lU3t9RveIkehxK8rzFB8=
Received: by 10.220.122.203 with SMTP id m11mr4929664vcr.258.1285001529529;
 Mon, 20 Sep 2010 09:52:09 -0700 (PDT)
Received: by 10.220.95.193 with HTTP; Mon, 20 Sep 2010 09:51:49 -0700 (PDT)
In-Reply-To: <AANLkTikK2oL3sUYHdqoQ7C47nd6Pi53N17GSfh8nx6Q-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156638>

On Mon, Sep 20, 2010 at 6:19 PM, Robert Buck <buck.robert.j@gmail.com> wrote:
> Hello,
>
> One project we have in house has approximately 160 different file
> extensions used for the files checked in. In our repository there are
> files that MUST be CRLF (.bat, .cmd, .vcproj, etc), files that MUST be
> LF (.xml, .xsl, .sh, etc), and files that MUST be binary. All others
> are just text and so long as they appear in native form I'd be happy.
>
> It would seem a default rule to handle text files would make sense:
>
> * text=auto
>
> But I have not found material explaining how git identifies binary
> files, so one concern would be that it could mangle binary file types
> in some cases.
>
> Do I have to explicitly mention all 160 file types in the gitattributes file?

If you want to be 100% sure, yes.

> How does git internally determine whether a file is text vs binary?
> Does it use the 'file' command in Unix?

No. Git applies the following heuristics to the file content:
- Does the file contain any NUL-characters? If so, it's binary.
- Is the ratio of printable characters vs non-printable characters
(when interpreted as ascii) below 128? If so, it's binary.
- Otherwise, it's text.

You can find the exact function here (beware of wrapping):
http://git.kernel.org/?p=git/git.git;a=blob;f=convert.c;h=01de9a84c21b31a0120065a32a386f27321cdf7b;hb=HEAD#l77

In general, this works pretty well. In addition, there's the
core.safecrlf configuration variable, which can be used to protect you
against normalizing the file in such a way that the exact original
file can't be recovered.

> And where I am going with this specifically is a question: what rules
> MUST be specifically stated in gitattributes and what rules are there
> implicitly?

Given the above information, you should be able to figure this one out
for yourself. The answer depends on how pedantic you are ;)
