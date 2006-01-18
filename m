From: Andreas Ericsson <ae@op5.se>
Subject: Re: [QUESTION] What is a tag for?
Date: Wed, 18 Jan 2006 11:35:30 +0100
Message-ID: <43CE19F2.6000709@op5.se>
References: <1137538344.9104.34.camel@malory>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 11:35:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzAfB-000631-4U
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 11:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWARKfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 05:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWARKfc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 05:35:32 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:61657 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964856AbWARKfc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 05:35:32 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C0A2A6BCBE; Wed, 18 Jan 2006 11:35:30 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: kernel-hacker@bennee.com
In-Reply-To: <1137538344.9104.34.camel@malory>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14816>

Alex Bennee wrote:
> Hi,
> 
> So I want to track Linus's 2.6 git tree as well as do a little small
> time hacking. I'm not brave enough to sit on the very bleeding edge and
> build what ever happens to be at the "HEAD" of the tree. However when a
> kernel releases I'd like to build *that* kernel.
> 
> I keep thinking of tags like labels in the old convetional SCM case. Is
> this correct? I can see once I've done my update (fetch/cogito what
> ever) that these tags apear in my local tree:
> 

I'm not sure if you got the answer you wanted from Junio or Petr, so I 
thought I'd add my own explanation to this as well. If nothing else it 
might be useful for someone greping through the archives.

There are three types of tags: simple, annotated and signed+annotated. 
All tags work just as a branch head, except that you can't do 'git 
checkout' on it (i.e. it's a pointer to a particular commit, but lives 
in $GIT_DIR/refs/tags instead of  $GIT_DIR/refs/heads).

Simple, or unannotated, tags are useful for creating anchor points so 
that you can jump to a particular state of development that's useful for 
you as a developer to know about (I for one think sha-hashes are a tad 
hard to remember). You could just as easily create a branch for doing 
this, but that's not always practical. F.e. when you're resetting or 
rebasing the current branch or doing some other of gits more voodoo-ish 
things. If you do

	$ git cat-file -t <tagname>

on a simple tag it'll tell you it's a "commit" object, because that's 
the type of the object it points to in the object database.

If you do the same on an annotated tag, whether it's signed or not, "git 
cat-file -t <tagname>" will tell you it's a 'tag' object.

A tag object has a reference to a commit-object and some additional data 
inside it. Try

	$ git cat-file tag v1.0.0

in the current git-repo and you'll see the following output
----8<---8<---8<----
object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
type commit
tag v1.0.0
tagger Junio C Hamano <junkio@cox.net> 1135152060 -0800

GIT 1.0.0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDqOh7wMbZpPMRm5oRAg+OAJ90pNi/fq5rguVou1PSxx95PYCVeACfbnZM
nN/PlwOWKA3rW8EPmWO4BzE=
=TCRg
-----END PGP SIGNATURE-----
----8<----8<----8<----


'object' at the first line is the commit the tag points to. The rest 
should be fairly self-evident.

After the empty line there follows a message that the tagger can enter 
when typing the tag. This can be fairly useful if you wish to make it 
so. I use it to write a gisted changelog, listing new features and fixed 
bugs in a few words. All annotated tags that gets pushed to our shared 
repos are automatically, through the 'update' hook, sent by email to our 
sales and marketing people. I like that, since I only have to use one 
tool for hacking, reporting, logging history and everything else that's 
real developer work. It also means I never forget sending feature 
updates to the suits, so they pester me less and life is a bit sweeter.

A signed annotated tag requires that you have a valid gpg key. The tag 
shown above is signed using gpg (the only way of signing supported, I 
think).

So, in essence;
* A simple, or unannotated tag just points to a commit object and has no 
message attached to it.
* An annotated tag points to a tag object and has a message of arbitrary 
length attached to it. The tag object points to a commit object.
* Only annotated tags can be signed.


I'd recommend not allowing un-annotated tags in your shared repo. I sent 
a patch for the default update-hook sometime ago that disallows this. 
Junio seemed happy about it so I don't understand why it hasn't been 
pushed to the master branch yet.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
