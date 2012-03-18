From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 6/9] difftool: replace system call with Git::command_noisy
Date: Sat, 17 Mar 2012 21:21:47 -0400
Message-ID: <CAFouetgJsHD9UoVPE6V16vAsJ4Q1neHzH7jrwGma6e2ZHELgFA@mail.gmail.com>
References: <1331949557-15146-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 02:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S94pF-0008GT-10
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485Ab2CRBVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 21:21:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34244 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115Ab2CRBVr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 21:21:47 -0400
Received: by iagz16 with SMTP id z16so7535016iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bVXpsvkWiFkyNpHp2v7WGAbCImUQGrAdaWDj5mYkoXI=;
        b=E4Rdz3e1kD10p7j39Co99+Zx8L7OQvbjaKx14Su0fDA7jPDS/g1X5Crlw8XYlqAZMg
         EaR30ok3yH8GRlc134fH3XBIGjcEkuvChzNNSHoZoraWPrgIREXgr+IChumyzzy17dtq
         MF6bMoWDaHC9I6qMtSAJY8j6iLpZoWZvtcF5SmLHpfclDPZ66jcfWGUajMFzs5iQ9pp8
         MfYm+f3s6ch9f0Uunq35f/gyyitfdz+AN9xYYyTLt/eL5RBd6B8aF2fbtOCCs0BVO8Dv
         WlRBq2M0DuVT/DUaHPSS07Rf9Lsv7ZBsY+UICFE0PB+97hMr7FF7gK9NMqs/T7X5GZpz
         FzUg==
Received: by 10.50.149.131 with SMTP id ua3mr2866037igb.41.1332033707294; Sat,
 17 Mar 2012 18:21:47 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Sat, 17 Mar 2012 18:21:47 -0700 (PDT)
In-Reply-To: <CAJDDKr4+0iWoZhxo6kMVa0YUtDzmrH=XTZnDqQdbnM6TJ41UDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193354>

On Fri, Mar 16, 2012 at 10:48 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Fri, Mar 16, 2012 at 6:59 PM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>
> In general, I am a little nervous about having difftool copy worktree
> content somewhere temporary only to copy it back in later. =C2=A0Is t=
here
> some way to make the diff machinery reuse the worktree? =C2=A0I was u=
nder
> the impression that we could do some GIT_INDEX tricks to do it, thoug=
h
> I will admit that I did not read that suggestion in depth, nor did I
> grasp whether this was the problem it was meant to address.

I have not been able to find any other way to do it.  The GIT_INDEX
trick allows the tmp directories to be built using 'git update-index'
and 'git checkout-index', but they offer no help for this problem.

If we use the working tree directory as one of the diff targets, then
all the files in the working directory would be included in the
diff...unless there was some way to remove the files that aren't part
of the diff from the working tree.  However at that point, I don't
think the solution would be any better (i.e. deleting files from the
working tree and then checking them back out is no better than copying
files to the tmp dir and back again).

The only other option I can think of is to build a complete copy of
the repo in the tmp directory for comparison against the working tree.
 However, this could obviously lead to resource/performance problems
on large repos.

I am open to suggestions, but I have not found any better solution.
