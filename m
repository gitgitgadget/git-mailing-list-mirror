From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue, 9 Apr 2013 23:26:39 +0530
Message-ID: <CALkWK0=Py3_LiL=88GOiQkHsYWERnNPvvU1M5wDhu+WioN56Uw@mail.gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <7vr4ijsish.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:57:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcnP-0000CV-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935172Ab3DIR5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:57:21 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51996 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933797Ab3DIR5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:57:20 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so8886624iec.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aSyMhFzutPVLUo3OMoQtMbt9f1/G9MS+F64LO8Nh62o=;
        b=JHBWYzZSrvX2rJv8NciUsn+9HJFJaMBDEKFALfikgLb2QcYXmhfANg3bHgXNeGSua8
         Y+e0qkWGYm/wBG7LhV7eaMj4pzJ3Wcjm7be2o/q750n8zEXQYx4fwdcvIdYdUyjCcM0n
         1UlddLmd8ND/2KK9Htf2+pP76fylupL8VyVZaHbIk4cLKLcqk0IODInEZIP8BY64Ejn2
         LUksVbUPp+0U3U+U5h4smpmXLw6Q4LdZ4V0BnaNFYo+qc80PlIEiOJmzn9Cm1Hla4zzk
         gcUgGu4TBFmKwSOPkY0IT5QSF9yYE8wC/1rGqBmfJz16lYAZTNz4ZNWNOPvC7Leqg/dY
         bSvg==
X-Received: by 10.50.50.71 with SMTP id a7mr10706734igo.14.1365530239765; Tue,
 09 Apr 2013 10:57:19 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 10:56:39 -0700 (PDT)
In-Reply-To: <7vr4ijsish.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220602>

Junio C Hamano wrote:
> I think what the callers of this function care about is if the name
> is a path that should not be added to our index (i.e. points
> "outside the repository").  If you had a symlink d that points at e
> when our project does have a subdirectory e with file f,
>
>         check_leading_path("d/f")
>
> wants to say "bad", even though the real file pointed at, i.e. "e/f"
> is inside our working tree, so "outside our working tree" is not
> quite correct in the strict sense (this applies equally to
> has_symlink_leading_path), but

Actually, you introduced one naming regression:
has_symlink_leading_path() is a good name for what the function does,
as opposed to die_if_path_outside_our_tree(), which is misleading.
What about die_if_path_contains_links() to encapsulate gitlinks and
symlinks?

> I think we should treat the case
> where "d" (and "d/f") belongs to the working tree of a repository
> for a separate project, that is embedded in our working tree the
> same way.

I'm not too sure about this.  It means that I can have symlinks to
files in various parts of my worktree, but not to directories.  Isn't
this an absurd limitation to impose?  I'm not saying that it's
particularly useful to have a symlink at / pointing to a directory
deeply nested in your repository, but that limitations must have some
concrete rationale.

Anyway, since we're not introducing any regressions (as
has_symlink_leading_path imposes the same absurd limitation), we don't
have to fix this now.  But it's certainly something worth fixing in
the future, I think.
