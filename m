From: Jonathan Nieder <jrnieder@gmail.com>
Subject: fast-import tweaks for remote helpers (Re: Status of the svn remote
 helper project (Dec 2010, #1))
Date: Sun, 12 Dec 2010 00:14:37 -0600
Message-ID: <20101212061437.GA17185@burratino>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
 <4CFFCDCD.9060602@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 07:14:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRfCy-0000QS-D2
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 07:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab0LLGOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 01:14:49 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42580 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0LLGOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 01:14:49 -0500
Received: by gwb20 with SMTP id 20so4226743gwb.1
        for <git@vger.kernel.org>; Sat, 11 Dec 2010 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QHoKYVGj4RPulLKELsg+9dKi662qxCk9zQ29YkZZpd0=;
        b=i+uOthBMGH/IRL7dnyVe5cza1KW/KZ1PxshrDVKAk2l9j/GtbU+obd1RHS4fZDsGjt
         mWptrZL6q3QJMLtzPwkfp/pRuLEHuUUgggnfkvMGIcWGz0YvUCAwjiN1OJUvoVpo+U/w
         EH+SMzA6UEm1zX2SxJiCEZUFuKhTCrgPU9hnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iafls2j/nvMtkdcdMcjlL4gfvPcJcJP+2N7sLinMO+aEvS00NyJ8yjBfR5KRIDyq+f
         kI7jMi8i3aTnEgmvn4er33mK3tG+jbH0LjQ70g5OMM5h25fFqbgFEpt4HkZ3DgvHBk3R
         50PRyEBeZXSDx8Hq6cCV0ULbFB2WnO86ACHqk=
Received: by 10.151.6.15 with SMTP id j15mr3909754ybi.391.1292134488071;
        Sat, 11 Dec 2010 22:14:48 -0800 (PST)
Received: from burratino ([69.209.48.248])
        by mx.google.com with ESMTPS id k1sm985284ybj.0.2010.12.11.22.14.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Dec 2010 22:14:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CFFCDCD.9060602@dbservice.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163472>

Tomas Carnecky wrote:

> I simplified the code and the requirements on fast-import are much
> lighter now. All I need is a way to tell fast-import to stop writing
> refs and after each commit write its sha1 to stdout.

That's good to hear.  What should be the syntax for asking fast-import
not to write to a ref?  Something like this?

	commit
	mark :1
	committer c o mitter <committer@example.com> now
	data <<END
	...

Writing the sha1 as each commit is written: how early does the
frontend need access to the sha1?  Would a facility to report marks
back to the frontend at the end of the stream take care of it?

Based on [1] I guess the main need is some way for fast-import to
tell the transport machinery what refs the transport machinery
should update (or at least ought to report as updated).  A hackish
way might be to make the remote helper send "progress" commands
with that information.

> It's possible to
> to modify fast-import.c with a small patch to make it behave like
> that. However, I haven't followed the svn remote helper that much
> lately so I don't know whether one of the other patches already
> modifies fast-import in this way.

No, the patches have mostly been adding commands that send information
back to the frontend.

 cat-blob (<dataref> | <mark>):
	Sends back an old blob along with its length (in
	cat-file --batch format).  svn-fe uses this to acquire
	the preimage when applying deltas.

 ls <quoted-path>:
	Sends back information about the current state of a path
	in the commit being prepared (as a single line in ls-tree
	format).  svn-fe uses this to move around files and to find
	a <dataref> to use with cat-blob when applying deltas.

 ls (<dataref> | <mark>) <path>:
	Sends back information about a path in a previous revision
	(tag, commit, or tree), in ls-tree format.

 M 040000 (<dataref> | <mark>) <path>:
	Like "M 100644 <dataref> <path>", replaces an entry in the
	active commit with content of the frontend's choice.  This
	gets used to copy in old directories.

> From the beginning my code was meant to be just an example how the
> interaction between git and the svn remote helper could look like.

It makes a nice demo, too. :)

> For example I save the svn rev <-> sha1 mapping in notes, which is
> appears to work well. I'll take a look if I'll be able to use the
> svn-fe in my script.

svn-fe needs a fast mapping svn rev -> sha1; it currently uses a marks
file for that.  (In the back of my mind, I have the idea of using a
file that allows O(1) access, perhaps of the form

	<commit name for rev 1> NL
	<commit name for rev 2> NL
	...

but as Ram has noted, keeping the whole table in memory is pretty
cheap already.)  A remote helper needs a fast mapping sha1 -> svn rev,
and imho notes are ideal for that[2].

The way I imagine it, the authoritative mapping is in notes and the
reverse mapping (e.g. in a marks file) is rebuilt when needed.

[1] remote-helper branch at git://github.com/wereHamster/git.git
[2] Why?  When a project switches from one svn server to another,
revision numbers tend to change, so revision numbers are not permanent
enough to belong in the commit message imho.  (If only git-notes had
existed when git svn was written...)
