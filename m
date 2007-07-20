From: Johan Herland <johan@herland.net>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 12:20:15 +0200
Message-ID: <200707201220.15114.johan@herland.net>
References: <85lkdezi08.fsf@lola.goethe.zz> <200707201029.10358.johan@herland.net> <86hcnzxy9a.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 12:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBpcw-0005uL-7J
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbXGTKU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754704AbXGTKU2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:20:28 -0400
Received: from sam.opera.com ([213.236.208.81]:33732 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921AbXGTKU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:20:28 -0400
Received: from pc166.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l6KAKFPP026391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 10:20:15 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <86hcnzxy9a.fsf@lola.quinscape.zz>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3701/Fri Jul 20 00:52:18 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53079>

On Friday 20 July 2007, David Kastrup wrote:
> Johan Herland <johan@herland.net> writes:
> > Sorry for jumping in late...
> 
> It could have given you a chance to read up on what has already been
> discussed.

I have tried to keep on top of the discussion so far.

> > Why do you want to add _all_ directories, and not just the ones we
> > want to explicitly track (independent of whether they're empty or
> > not).
> 
> Because the problematic cases are more often than not the _implicit_
> cases.  Do you check a directory tree for empty directories before you
> archive it?  In order to archive every empty directory explicitly?

No, of course I don't. But then archiving (as in tar) is intended to recreate 
the "working copy" exactly as it was. Git (and other SCMs), however, is only 
interested in recreating the part of the working copy it explicitly tracks.

Given the following working copy:
/
/tracked/
/tracked/file
/tracked/dir/
/untracked/
/untracked/file
/untracked/dir/

and the following commands:
$ git add tracked

$ git clone

The cloned result could be any of the following:

(1)
/
/tracked/
/tracked/file

This is the current behaviour; directories are not tracked at all, but only 
added as necessary to support files.

(2)
/
/tracked/
/tracked/file
/tracked/dir/
/untracked/
/untracked/dir/

i.e. implicitly tracking _all_ directories. This is what you literally ask 
for, but I think most would find this unreasonable.

(3)
/
/tracked/
/tracked/file
/tracked/dir/

i.e. recursively tracking directories (and files). This seems useful, but 
there is nothing _implicit_ about this.


I have a feeling that you're actually arguing for doing (3) by default. What I 
am arguing is to do (1) by default, and (3) if given a suitable command-line 
option (i.e. "git add --with-dirs tracked").

Note that this is really an interface question. How these entries are actually 
stored in the repo is a different discussion.


Finally, let's look at the case of "git add tracked/file" followed by "git rm 
tracked/file". I'm arguing that "tracked/" should be automatically removed, 
since I never asked for it to be tracked by git. On the other 
hand, "git-add --non-recursive tracked" followed by the above two commands, 
should of course leave "tracked/" in place, since I now actually asked 
explicitly for the directory to be tracked.

My point is fundamentally that selectively tracking directories is a more 
powerful concept than just tracking _all_ directories by default. Note that 
if we support selectively tracking directories, tracking _everything_ (like 
you seem to want) is trivially implemented by _always_ supplying the 
appropriate option to git-add. If we track everything by design, we don't 
have the option of selectively tracking some directories.


> > Basically, add a "--dir" flag to git-add, git-rm and friends, to
> > tell them you're acting on the directory itself (rather than its
> > (recursive) contents). "git-add --dir foo" will add the "040000
> > 123abc... 0 foo" to the index/tree whether or not foo is an empty
> > directory. "git-rm --dir foo" will remove that entry (or fail if it
> > doesn't exist), but _not_ the contents of foo.
> 
> There is nothing wrong with implementing something like this in
> _addition_ to treating directory entries implicitly.

I don't agree. By _selectively_ tracking directories you can implement any 
policy you want on top of it.

> For example, ls 
> has an option -d which does just that, and even git-ls-files has an
> option --directory.  Heck, I even have

Yes, having commandline options for explicitly specifying directories (and not 
their contents) is _exactly_ what I want.

> But the important, the _really_ important thing are the implicit
> behaviors.  If I have to hassle with every directory myself, I don't
> need a content tracking system.

I disagree. Just as you have to decide which files to track, you similarly 
should have to decide which directories to track. Of course, the tools make 
this easier for you by being able to recursively handle files. In the same 
way they should be able to do the same thing for directories.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
