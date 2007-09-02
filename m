From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 17:33:42 +0100
Message-ID: <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
	 <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com>
	 <46DAE025.900@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 02 18:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsOZ-0005Gk-5Q
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbXIBQdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933153AbXIBQdv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:33:51 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:57460 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932901AbXIBQdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:33:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so761332rvb
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 09:33:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jYXEaK5M1Epf7ZqZqMBNFc2oV+/var7XWX2r36s4pW/BUZJII9QzkwCRFdBwX1zPHQPqtL8zxxc6UXnvlpaeBIAEg2QQeriPHBrob7kH4EMwECPqUEU5Z84BBV6sEY2Uj8SIq7A/8tbSNvSRQyIdn9q3T/rlg9SHxJtFSqezW2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=REsAnNzRu4mehrbfe4kIDjNazSOmID0GDJ4vZISFzG589RKrKPZ+4V1XTLzF60Jj4DuLn280yVYq46dNfqKh/ErWkEMHfHarTGb85InHhFAGwZhMJhDLXVb9n7cPH4KPybAN6RGilLDwJAu3XdkSxMZFEJaoYbirDMfPmBAsPTY=
Received: by 10.141.34.12 with SMTP id m12mr1616195rvj.1188750822261;
        Sun, 02 Sep 2007 09:33:42 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Sun, 2 Sep 2007 09:33:42 -0700 (PDT)
In-Reply-To: <46DAE025.900@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57355>

On 02/09/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Reece Dunn wrote:
> > On 02/09/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> >> This gives us a significant speedup when adding, committing and stat'ing files.
> >> (Also, since Windows doesn't really handle symlinks, it's fine that stat just uses lstat)
> >>
> >> +               if (ext && (!_stricmp(ext, ".exe") ||
> >> +                           !_stricmp(ext, ".com") ||
> >> +                           !_stricmp(ext, ".bat") ||
> >> +                           !_stricmp(ext, ".cmd")))
> >> +                       fMode |= S_IEXEC;
> >> +               }
> >
> > This breaks executable mode reporting for things like configure
> > scripts and other shell scripts that may, or may not, be executable.
> > Also, you may want to turn off the executable state for some of these
> > extensions (for example if com or cmd were not actually executable
> > files). This makes it impossible to manipulate git repositories
> > properly on the MinGW platform.
>
> Actually, you don't really need the EXEC bit for Git to work. I just
> added it for completeness. (We _could_ remove that too, since it's
> slowing us down slightly ;-)
>
> Remember that Git isn't using MSys for its builtins, so MinGW Git
> doesn't understand the MSys notion of executable files anyways.
> The MinGW port actually peeks at the beginning of a file (ignoring exe
> files), and sees if there's an interpreter there. If there is, it will
> expand
>     git-foo args...
> into
>     sh git-foo args...
> and execute the command. So, it's not really affected by this change.
>
> I haven't had any problems with this patch on my system, so could you
> explain what you mean with 'this makes it impossible to manipulate git
> repositories'?

You pull a repository that contains executable scripts that are
required to work in order to build the system. You then make some
modifications to the local repository and run the 'git add .' command.
Since this patch is reporting executable bits differently, the mode
change is stored as well as the local modifications. Now the changes
are pushed upstream (along with the file mode changes).

Someone running a Linux machine, pulls your changes. When those files
are checked out, the executable state of those scripts has now
changed, preventing the Linux user from running those scripts. _That_
is what I meant. Or am I misunderstanding how git works in this case?

> > Would it be possible to use the git tree to manage the executable
> > state? That way, all files would not have their executable state set
> > by default on Windows. The problem with this is how then to set the
> > executable state? Having a git version of chmod may not be a good
> > idea, but then how else are you going to reliably and efficiently
> > modify the files permissions on Windows?
>
> The file-state-in-git-tree belongs in a different discussion. Have a
> look at the '.gitignore, .gitattributes, .gitmodules, .gitprecious?,
> .gitacls? etc.' and 'tracking perms/ownership [was: empty directories]'
> threads. Permissions are not a trivial topic, since systems represent
> them differently. This patch just tries to reflect the read, write and
> execute permissions as normal Windows would; and it only cares about
> file extensions (and the PE header, if it exists).

I understand that this is not a trivial topic. I was thinking that
this different behaviour w.r.t. the executable permission will break
things when you have developers on both Linux and Windows, such as the
cairo developers, for current git usage.

I have not really been tracking those threads, but I will take a look at them.

> Also note that my patch totally ignores the Group & Others part of the
> permission bits. Again, we're on Windows so we don't really care. We
> _could_ make it reflect the ACLs in Windows, but then we'd have to make
> it optional, since that's _really_ slow to 'stat'.

Sure. Cygwin does use ACLs to implement stat which is why it is slow.
So anything that can speed git up here, without any breakage in
functionality, is a good thing.

- Reece
