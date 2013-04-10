From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Wed, 10 Apr 2013 19:08:28 +0530
Message-ID: <CALkWK0=_NAfOdVKet9k33ZuwAtcaZ42ok_r+Ln1rswcaJi6eTA@mail.gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <7vr4ijsish.fsf@alter.siamese.dyndns.org> <CALkWK0=Py3_LiL=88GOiQkHsYWERnNPvvU1M5wDhu+WioN56Uw@mail.gmail.com>
 <7vehejsfpe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 15:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPvF5-0000qQ-99
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 15:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab3DJNjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 09:39:10 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34676 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab3DJNjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 09:39:09 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so526274ieb.29
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qQkr7RRz8Ib+8sHoxhZhgVmtBHzt6VVs62+oS/43Xng=;
        b=pT5FVPD5Q9vbFjZV00wcy7uWiIUo0j21X8KWmDmsEoTAu9HDkXTTtAq6XPvk6sEPuo
         Bx+zadkXtyQ5iuLayCNzG5KUf6Q9VXfkp3pLkIrKHUxp+5DZUPRZvwAPbGJfFBD0MtHr
         mbRQ+Twow08NNy+2ae9OQqhcfJEA8gxGBBFdG9Xnc+XwdpTon6UdvnuFcWuxHMgJc91q
         4QMTuDt58eHSd9YqMjyMtuRdCfLt5XJ8Orj/gw6zs8zQXcfqwZLh1aBjzS41UCDSwB/i
         V9ax3RPF8fA3UqvmXnEWWrEZ4NR23RZQg36k4qytk1JJq/xzmTOu2/CBTIFPFxZ6hn2F
         sLug==
X-Received: by 10.50.17.166 with SMTP id p6mr13264139igd.12.1365601149012;
 Wed, 10 Apr 2013 06:39:09 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 06:38:28 -0700 (PDT)
In-Reply-To: <7vehejsfpe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220689>

Junio C Hamano wrote:
> One can have symlinks to anywhere all one wants.  We track symlinks.
> [...]

Yes, I know.  We store symlinks as blobs containing one line, the path
to the file, without a trailing newline.  And we have a mode for it to
distinguish it from regular files.

What I meant is:

    echo "baz" >newfile
    cd foo/bar/quux
    ln -s ../../../newfile
    cd ../../..                    # Back to toplevel
    git add foo/bar/quux/newfile

This is allowed.  While:

    cd foo/bar/quux
    echo "baz" >newfile
    cd ../../..                    # Back to toplevel
    ln -s foo/bar/quux
    git add quux/newfile

is disallowed.  Then again, if we were to replace the last line with:

    cd quux
    git add newfile

and it works.

Notice that both symlinks are pointing to paths inside out repository,
and the only difference is that the second example attempts to add a
path with a symlink as the non-final component.  The path is not
pointing "outside" our repository, as the function name would
indicate.

Anyway, it's just a minor detail that would be nice to fix in the
future.  Nothing urgent.
