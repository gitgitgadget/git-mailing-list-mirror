From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Sun, 1 Jul 2007 18:09:37 +0200
Message-ID: <e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
	 <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	 <20070701122625.GC26243@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 01 18:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I51zZ-0002TX-77
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbXGAQJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbXGAQJj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:09:39 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:42956 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbXGAQJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:09:38 -0400
Received: by nz-out-0506.google.com with SMTP id s18so713290nze
        for <git@vger.kernel.org>; Sun, 01 Jul 2007 09:09:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BS76n35FtnL8hR0DzG8fKfkXRFjGJ+B62eKucuX/C4PEvoWA3V8tK4f5fPqvTuG0n/Z9ARQZX1XImQH36H6mp7jPwe8sYOqSk7xMSrLK/AdLQlkh5r3VoEa7NKdNXvaDGGO2MqkNHUJ30UAqk7k4YJ1m8ihGYfWNvpSm2FdArx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JLp+0taDaFZ3oS6ky1l6mCO+GOS0zvZI09X/gFJ58BBUYPxvZ7w/WVuMPSH0F2KsJFOMtPw5QIXiXKtxaRvGf9AqLD8QcVmXV/DoNUqZAzbGNnmSexVCTAl71FL54Ah1MXzWa4bFklmmZgq+4nQd6Fj7ofwYRQWc/AgHIJtvlRo=
Received: by 10.114.137.2 with SMTP id k2mr4326488wad.1183306177544;
        Sun, 01 Jul 2007 09:09:37 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 1 Jul 2007 09:09:37 -0700 (PDT)
In-Reply-To: <20070701122625.GC26243@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51306>

On 7/1/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Mon, Jun 11, 2007 at 07:45:51 +0200, Marco Costalba wrote:
> > On 6/11/07, Jan Hudec <bulb@ucw.cz> wrote:
> > >
>
> However, I am currently not sure how to handle errors. If the current commit
> fails, it will show a message box with it's output, but I can't see where it
> is generated. It seems it's somewhere inside MyProcess, so I don't have to do
> anything special though, right?
>

You have 2 ways to start a git command:

QGit::run() and QGit::runAsync()

The first starts the command and wait for completion, a bool is
returned to indicate success as example

if (!run("git read-tree --reset HEAD"))
	return false;

The second one is use to start a command and return immediately, so
it's used for long commands that should be non-blocking, as example:

if (!runAsync("git diff-index -r -m --patch-with-stat HEAD"))
    return false;

In the latter case success it means the command has been _started_ successfully.


A bool is the only flag returned, because error detect is done at
lower level, in MyProcess::sendErrorMsg() in file myprocess.cpp that
handles the low level of running an external process and is called by
run().

In case of an error MyProcess::sendErrorMsg() is called to inform the
GUI (a popup dialog box) about the error and the stderr output
received.

What is an error ? :-)

It's not so trivial due to different OS and git commands behaviours
regarding stderr and exiting codes, check the comment at the beginning
of MyProcess::on_finished() in myprocess.cpp to see *how* qgit detects
an error has occurred and informs upstream.


So the bottom line is: no, you don't have to do anything special. The
returned 'false' value from run() call is for your use only, if
needed, you don't have to propagate upstream to let user be informed.

Hope this helps.

Marco


P.S: Why 'git-commit --amend -F' it's explicitely forbidden?
