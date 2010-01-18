From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Filenames and prefixes in extended diffs
Date: Tue, 19 Jan 2010 00:22:07 +0100
Organization: SUSE Labs
Message-ID: <201001190022.07580.agruen@suse.de>
References: <201001131713.05505.agruen@suse.de> <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 00:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX0vK-0004Zl-QM
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 00:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab0ARXWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846Ab0ARXWO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 18:22:14 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39305 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704Ab0ARXWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 18:22:13 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 5A21F867E2;
	Tue, 19 Jan 2010 00:22:11 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137411>

On Thursday 14 January 2010 01:16:21 am Junio C Hamano wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > Can git be changed to ...
> 
> Just to save your time coming up with more ways to *change* git diff...
> 
> Even though I wouldn't say _any_ change is too late to bring in, change in
> the output format from "git diff" family _must_ be usable by "git apply"
> people have been using for the last 4 years or so.
> 
> Suppose your updated version of "git diff" with a certain set of options
> produces output A, which is different from the output B you would get out
> of today's "git diff" that is run with the same set of options.
> 
> If "git apply" people have been using understands B (i.e. current output)
> and does something, the format change between A and B must be designed in
> such a way that the same "git apply" accepts A (i.e. your output) and do
> the same thing.
> 
> Two examples:
> 
>  - "git diff -M" (or "git show -M") is _defined_ to show the filenames
>    without prefix on "rename from" line, and deployed "git apply" relies
>    on this definition to apply the patch to the file the patch was meant
>    to apply.  If your modified "git diff -M" changes it to add the prefix,
>    and existing "git apply" changes behaviour (either by rejecting your
>    output, or applying the patch to a wrong file), then such a change has
>    *no chance* of getting in.  It is merely a breakage.

Git apply is currently broken in some (uncommon) cases.  Consider the 
following two patches:

	$ cat add.diff
	diff --git a/d/f b/d/f
	new file mode 100644
	index 0000000..6a69f92
	--- /dev/null
	+++ b/d/f
	@@ -0,0 +1 @@
	+f

	$ cat rename.diff
	diff --git a/d/f b/d/g
	similarity index 100%
	rename from d/f
	rename to d/g

They apply fine after each other with plain "git apply".  When you try to 
apply them to a different location, things break though:

	$ git apply --directory e -p2 add.diff
	$ git apply --directory e -p2 rename.diff
	error: e/d/f: No such file or directory

Had the second patch not been generated with "git diff -M", things would just 
have worked; in other words, the -M format is broken.

I think the easiest way to fix this in "git apply" would be to figure out what 
the missing prefixes are in the rename and copy lines (in this case, just "a/" 
and "b/"), and to prepend those prefixes to the decoded filenames before 
stripping off pathname components.  This is the same as just taking the 
filenames from the "diff --git" line, and ignoring the filenames in the "copy 
from", "copy to", "rename from", and "rename to" headers.

I don't see a way how to fix this in the existing headers in a backwards 
compatible way.  Do you?

Independent of whether and how this is addressed, can I please at least have 
the "diff --git" line parsing problem fixed so that filenames which contain 
spaces are put in double quotes there?  Then I can at least ignore all the 
prefix-less filenames in GNU patch and still make it understand git's output.

>  - If you say "git diff --src-prefix=a/b/c --dst-prefix=x/y", it _might_
>    produce something "git apply" won't grok (I haven't checked this,
>    though).  You can suggest to change the output from such a case to work
>    better.  We didn't work as expected so a change _could_ be a fix.

The output format for that is fine.

> The output from "git diff --no-index" is an exception to the above rule.
> It is primarily for people who have unmanaged contents and want to use
> features of the git diff engine that are not found in other people's diff
> implementations (e.g. wordwise colored diff), and the header part of its
> output does not currently follow "git diff" convention to be grokkable by
> "git apply".
> 
> Fixing _that_ is a welcome change, but I suspect that there are corner
> cases, e.g. "git diff --no-index frotz-1.2.36/ /tmp/frotz/" (i.e. you have
> a pristine version in frotz-1.2.36 directory, but your modified version is
> in /tmp/frtoz/) that might make fixing it fundamentally impossible (I
> haven't looked into it for a long time, so it could be easy, but my gut
> feeling is it isn't).

Patches with a different number of components in the from and to prefixes are 
a really bad idea.  (GNU patch will prefer the pathname with the fewer 
components, but this yould just as well be the wrong one.)

Thanks,
Andreas
