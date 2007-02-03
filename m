From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 3 Feb 2007 22:45:33 +0100
Message-ID: <200702032245.34087.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <Pine.LNX.4.64.0702021050350.15057@woody.linux-foundation.org> <20070203212030.GA91453@kobe.laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial@selenic.com, git@vger.kernel.org
To: Giorgos Keramidas <keramida@ceid.upatras.gr>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSgC-0002ac-1L
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXBCVoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbXBCVoM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:44:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:60290 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbXBCVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:44:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1036436uga
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 13:44:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mOwKYymnICiYSwYJd6v4LeKSjP7whdsZfb4CxRWC6EivgMxxm2eiN7ALGwpVJalrf/kuFrUOXXPqIwdNthodw+6eb61FmQUDwmYSJIFfjo6aqORBe31e2uXc+cg2uwTHEF+6XgnIGQnH0qe6l95kVS97ep2rz7jnFUDBvG2sXRc=
Received: by 10.67.106.3 with SMTP id i3mr495852ugm.1170539050514;
        Sat, 03 Feb 2007 13:44:10 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id l33sm6231841ugc.2007.02.03.13.44.09;
        Sat, 03 Feb 2007 13:44:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070203212030.GA91453@kobe.laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38610>

On 03-02-2007, Giorgos Keramidas wrote:
> On 2007-02-02 11:01, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>On Fri, 2 Feb 2007, Giorgos Keramidas wrote:

>>> Sometimes, 'sliding a tag' is a real-world need.  Losing the
>>> information of who did the tag sliding and when, is not good.
>>
>> In practice, this is not much of an issue.
> 
> Sure it is.  Maybe not in the context of all projects or all teams, but
> properly versioning tag names and knowing who installed the tag, and
> when is quite often an issue with unversioned tags in some of the teams
> I have worked with.

Knowing who installed (made) a tag, and when is totally separate issue
from versioning tag names. In git first (along with tag description,
and optional PGP signing of tag) is solved by using tag objects, it
means indirect pointers: name like v1.4.0 (refs/tags/v1.4.0) refers
to tag object, which looks like below:

  object 41292ddd37202ff6dce34986c87a6000c5d3fbfa
  type commit
  tag v1.4.0
  tagger Junio C Hamano <junkio@cox.net> Sat Jun 10 12:43:37 2006 -0700
  
  GIT 1.4.0
  -----BEGIN PGP SIGNATURE-----
  Version: GnuPG v1.4.3 (GNU/Linux)
  
  iD8DBQBEiyDswMbZpPMRm5oRAr5KAJ95nnyY8x7nRVIxkV87AHux6Kdf2gCgi4xu
  NxK2qKsAkGXCil7zSFviawA=
  =Qhax
  -----END PGP SIGNATURE-----
 

Second, [local] versioning tags (if it is really needed, see discussion
below)  is solved using reflogs for tags, which look like below:

000000... fab4f1... Jakub Narebski <jnareb@gmail.com> 1163751632 +0100 \
    fetch origin git://git.kernel.org/pub/scm/git/git.git: storing tag

(it is in single line, broken here for better readibility). It is local
history; I don't thing global history of tags is needed (see below).

>> First off, CVS tag usage is insane, but it's insane for *other*
>> reasons (ie people use tags differently in CVS, but they do it not
>> because they want to use tags that way, but because CVS makes it
>> impossible to do anything saner).
>>
>> So pointing to CVS tag usage as an argument is pointless. You might as
>> well say that you shouldn't save the merge information, because CVS
>> doesn't do it, and manual tags are a good way to do it.
>>
>> Secondly, the problems with tags having "history" is that you can't
>> really resolve them anyway. You have to pick one. You can't "merge"
>> them.
> 
> Ok, maybe CVS was not so good as an example of why versioned tags *are*
> useful, but my comment came from the experience I have with the tagging
> of FreeBSD release builds.  The -STABLE branch os FreeBSD may be tagged
> with RELENG_X_Y_Z_RELEASE at a particular point in time.  If we find
> that some important bug fix has to go in, the fix is committed, and the
> tag can 'slide' forward for only a particular file or set of files.

That is a bad, bad idea. You should have v1.4.4 tag, and published tag
should be immutable, so if someone tells that there is bug in v1.4.4
you know what this version is. If you want to gather fixes for v1.4.4,
you make v1.4.4-fixes _branch_, commit fix on this branch (perhaps also
merging it into current work), and tag result v1.4.4.1 or v1.4.4-patch1.
Tags are meant to be immutable.

> When tags are versioned, this operation is properly versioned too.  It's
> apparent from browsing the global tag history that the specific tag
> *was* moved forward; it's obvious where it was pointing before the
> 'slide' operation; it's obvious which files the 'slide' affected, etc.

This operation IBHO has no sense; I understand that you can have local,
private tags you slide like bisect-low, bisect-up, before-merge,...
Public tags: no.

[...]
>> In other words, tags are atomic *events*, not history. And I certainly
>> agree that you shouldn't lose the events (unless you want to, of course).
> 
> Tags are a little of two different things:
> 
> (1) They are 'events' in the sense that someone has placed them to a
> tree, and this operation is a very real, very natural event, and *this*
> event should be versioned.

Tags should not be placed to a tree.

[...]
-- 
Jakub Narebski
Poland
