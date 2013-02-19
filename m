From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 19 Feb 2013 20:47:02 +0700
Message-ID: <CACsJy8DmPV+61kP6TPCVir-b_xMOWJxoWXunWmvK--7_3cW-iA@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <CAM9Z-nnWE9LeHaefKdju_p=_he7aJcOunGf1Ms6K=vEXgxS25w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:48:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7nY6-0003NH-1Y
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 14:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867Ab3BSNre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 08:47:34 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:40106 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762Ab3BSNrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 08:47:33 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so6779980oag.7
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=K3Ri2J1xFyUxXBpoYVyE+Ccy3Am3Kd1/gcZAhGNBxKE=;
        b=c1Y6vZV5QU4byJipavjPRZCVnSDWmNs6W4thOjr2pJxjY/PU3k51OPWyTBHdQ5H2Qf
         N9pkQ9CyJ5qkf+jCX5anJjwssmO5ja3JfqfyYElcYuYydLuVj5QeqqIMNIFJV/jfeQ6c
         54+53wBC4LWnAI9s7U6Am7v2m9dTNaNUCN1tJIpksAwjKrXdLtvTe9bZ1Diac+57qlEK
         O/khas7eJ2mhfYZBimpSPcl51BMddhXoyZm15BXPuTAT/gSznW7/jLubG8SPZA/xwAUL
         hbo0Xub0IzDMopeY5n3SsnqXOa7ecZEojnA6lk26LH+vpjBxJnrNUNzjSRi0ThDkrGK6
         y6Qg==
X-Received: by 10.182.119.101 with SMTP id kt5mr7744135obb.22.1361281652938;
 Tue, 19 Feb 2013 05:47:32 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Tue, 19 Feb 2013 05:47:02 -0800 (PST)
In-Reply-To: <CAM9Z-nnWE9LeHaefKdju_p=_he7aJcOunGf1Ms6K=vEXgxS25w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216617>

On Tue, Feb 19, 2013 at 8:16 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> Did your testing turn up anything about the amount of time spent
> parsing the .gitignore/.gitattributes files? Not the syscall count,
> but the actual time spent running the parser (which I presume is
> largely CPU-bound). The other notable bit of information to know would
> be how much time is spent applying what has been parsed out of those
> files to the content of the tree. Both will give a clear signal of the
> prominence of those segments of code versus others elsewhere in the
> "git stat" flow path. That information will tell us more clearly what,
> if anything, it is worth keeping a cache of and what form that cache
> should take.

Not specifically parsing, but we do waste CPU on
.gitignore/.gitattributes stuff. See

http://thread.gmane.org/gmane.comp.version-control.git/216347/focus=216381

Other measurements (which led to the above patch):

http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=215900
http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=216029
http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=216195

So far we could reduce lstat, {open,read,close}dir syscalls with the
help of inotify, which saves time. I'm not sure if we should cache the
list of untracked-but-not-ignored files. It cuts down cpu time on
.gitignore but invalidation could be complicated.
-- 
Duy
