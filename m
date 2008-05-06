From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 21:38:26 -0400
Message-ID: <32541b130805051838k367c44bau715774b46f7894cb@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com>
	 <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com>
	 <200805052349.35867.robin.rosenberg.lists@dewire.com>
	 <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 06 03:39:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtC9F-0008Q7-KW
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 03:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680AbYEFBi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 21:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755808AbYEFBi3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 21:38:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:31511 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbYEFBi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 21:38:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so937499fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NfQ6nSNb2SrPwmh8g3wtd4LJCpfcPkuARIRqNU+QrX0=;
        b=oNi1UlTdKj+CRx+q9Br3t7YmteW+cogGN6K5uqggLWec9rR8cB2/Qi/Mp1tqxXCIrBsjtHF8yASKFTaaKAiD+7UD5eAlqgba3sZI26U+oOSNaOq0uljE9+FgCEFsEl2WwdMNatfinAhXfDdQV64xEU6u8+m9rewifY8Pc4R549s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LAbtrJK8U2H9CDmIC98jq/lMWoZU9esWAvMZr/+g/lKbEvw5RyKEZwm3vUlKofAHw+KQVXe3qzxnpnAvUVGK3jc2op7pwmSJoRIwp7wTtu5cUngLaUm7E4ys1X+uQHIC72rNFfgotel57ARSfm56Vl1DlQll3dIWtYfEgFq7tBM=
Received: by 10.82.167.9 with SMTP id p9mr11610bue.40.1210037906623;
        Mon, 05 May 2008 18:38:26 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 5 May 2008 18:38:26 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81319>

On 5/5/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  I really don't understand why people expect a directory rename to be
>  handled automatically, when it is (a) not that common and (b) not obvious
>  what the solution is, but MOST OF ALL (c) so damn _easy_ to handle it
>  manually after-the-fact when you notice that something doesn't compile!

I general I agree with your point here, but I still find it surprising
how hard the directory-rename problem is made out to be.  As far as I
can see, the right implementation exactly parallels the single-file
rename implementation.

I think the same problem that prevents git from knowing the difference
between empty and nonexistent directories (eg.
http://kerneltrap.org/mailarchive/git/2007/7/18/251976) is the one
that prevents it from handling directory renames: git doesn't
acknowledge that it's *already* treating directories as first-class
objects.

What if you thought of a directory as simply a list of filenames?
(This is more or less what unix does anyway.)  Then an *empty*
directory is a tree of zero length; a nonexistent (or not tracked)
directory is simply not listed in the parent; a directory with
untracked files is like a file with patches not yet added to the
index(*); and trying to merge a file into a nonexistent directory
(when the original patch *didn't* create the directory fresh) would
trigger similar logic to the existing rename handling.  That is, put
the new file with the content that used to be next to it, by looking
for a tree with contents (names, not so much sha1's) similar to the
one it was expected to be in.

> It really is mental
> masturbation, and has absolutely no relevance for any real-world problem.

I personally don't get very interested in non-real-world problems.
Here's the actual case I tried to use a few months ago, but couldn't,
because git doesn't track directory renames.  (Note that I was quite
happily able to do this in svn, as much as you can do anything happily
in svn.)

I have a branch called 'mylib' with my library project in its root
directory.  What I wanted was to maintain my library in the 'mylib'
branch, then merge my library into the "libs/mylib" directory of my
application, which is in the 'myapp' branch.  (Of course, in real
life, there's more than one app using mylib in more than one
repository, and I'm actually doing 'git pull' of the mylib branch from
elsewhere.)

This actually works like magic in git - except when you create a file
in the 'mylib' branch, in which case it gets merged to the wrong path
every single time.  It seems to me like it should be very easy to put
it in the right place instead, making one more interesting use case
possible.

I realize git-submodule is the way you're supposed to do something
like this, but git-submodule doesn't really do what I want (yet) for
reasons discussed in other threads.

Have fun,

Avery

(*) Applying the same metaphor in reverse, operations that are valid
on directories are also valid for file contents.  I can think of
immediate uses for a .gitignore-style list that talks about file
*contents*.  Imagine if I could make a local patch to my Makefile,
mark that one patch as "ignored", and never accidentally check it in.
