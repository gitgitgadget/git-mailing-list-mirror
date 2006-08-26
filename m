From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 22:18:14 +0200
Organization: At home
Message-ID: <ecqaa3$j0u$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252135.27894.jnareb@gmail.com> <7vpsen1eq3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 26 22:18:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH4cA-0003Iz-9h
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 22:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWHZUSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 16:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWHZUSf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 16:18:35 -0400
Received: from main.gmane.org ([80.91.229.2]:38577 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750792AbWHZUSf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 16:18:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GH4bn-0003Gs-KN
	for git@vger.kernel.org; Sat, 26 Aug 2006 22:18:23 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 22:18:23 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 22:18:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26066>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Remove $git_temp variable which held location for temporary files
>> needed by git_diff_print, and removed creating $git_temp directory.
> 
> Very good.  Not writing into the filesystem even in the
> temporary location is a very good thing.
> 
> Other things I noticed in this 19 series (note that I've applied
> them more or less intact already, expecting that any issues will
> be fixed in-tree):
> 
[...]
> 
>  * 06/19 gitweb: Add git_get_{following,preceding}_references functions
>    07/19 gitweb: Return on first ref found when
>          git_get_preceding_references is called in scalar context
> 
>    This looks *VERY* expensive.  Does git_get_references()
>    cache and reuse its result?  How many times during a single
>    invocation are these subs called?
> 
>    Also I am not sure about the correctness of "get-following".
> 
>             B------D------F
>            /              base
>       --A------C------E
>                         hash
> 
>    You read from "rev-list $base", stop when you see $hash, and
>    grab all the refs that point at the rev you have seen before
>    stopping as "following".  But in the above picture, you will
>    follow from F down to the very initial commit without
>    stopping and there actually is _no_ rev that follows E so
>    your result would contain B D A (if they are tagged) but none
>    of them follows E.  There is something wrong here.
> 
>    At least you should read from "rev-list $hash..$base"; then
>    traversal would go F D B and stop at A; you probably would
>    want --boundary to force showing of A as well, but even then
>    I am not sure how well the result would work.
> 
>    "get-preceding" also wants to go down to the initial commit.
> 
>    "get-following" is inherently a very expensive operation, so
>    I would suggest not doing this.  It seems that nobody uses
>    these two subs yet, so probably it is better to yank them
>    before they cause damages.

I agree.
    
>  * 08/19 gitweb: Add git_get_rev_name_tags function
>    09/19 gitweb: Use git_get_name_rev_tags for commitdiff_plain 
>          X-Git-Tag: header
> 
>    I suspect these make the generation of the header extremely
>    expensive.  I'd suggest reverting them to the original.

The git_get_following_references is copied almost verbatim from the original
(i.e. before this series) git_commitdiff_plain implementation, modified
only to allow for changed output of git_get_references (formerly
read_info_ref), and with "HEAD" changed to $hash_base || "HEAD".

git_get_preceding_references was made to be companion to
git_get_following_references, so of course it shares it's warts, errors
and disadvantages.


First patch in series changed X-Git-Tag: header to show only the tag that
points _directly_ to 'hash' commit, similarly to the ref marker in HTML
output (in git_commitdiff for example).

There was mentioned in discussion that it is nice to know what version you
need to have feature introduced by commitdiff. Hence writing code
generating X-Git-Tag: header into subroutine, writing companion
subroutine... then deciding that as there is native git command for that,
namely 'git name-rev --tags', why not use it? The git_get_following_refs
and git_get_preceding_refs didn't get used.

git name-rev is quite fast, perhaps up to half a second, or a second.
And is called only once per commitdiff_plain


I guess that generating (properly!) X-Git-Follows:, X-Git-Branch: and
X-Git-Precedes: (similarly to what gitk and qgit do) should be made into
feature, as it is time and resource consuming.

>  * 13/19 gitweb: Add invisible hyperlink to from-file/to-file diff header
> 
>    You seem to have forgotten esc_html() on the patch-line
>    before sending it to the browser.  Careful.

Cannot esc_html() line with HTML code, namely the hyperlink. I know that the
line is "+++ a/<filename>" or "--- b/<filename>", and we replace <filename>
with hyperlink, which has esc_html($filename) as contents. There is no need
to escape "+++ a/" or "--- b/".

I guess I rely on git-diff/git-diff-tree to have "+++ /dev/null" and
"--- /dev/null" (both HTML safe), if there is no "a/" and "b/" in
from-file/to-file unified diff header.

>  * 14/19 gitweb: Always display link to blobdiff_plain in git_blobdiff
> 
>    Need justification why this change is needed (or why previous
>    logic to avoid showing it in certain cases is wrong).

Why we didn't display it before? I though it was a bug (oversimplification
in case we don't have $hash_base or it is not a commit). If we can display
"blob" view, we can display "blob_plain" view...

>  * 16/19 gitweb: Use git-diff-tree or git-diff patch output for blobdiff
> 
>    Is git_to_hash sub always called with object names and
>    nothing else?  "git rev-parse no-such" would die with an
>    error message, and "git rev-parse Makefile" in populated
>    working tree would say "Makefile" without complaints.
>    Perhaps you want --revs-only --no-flags here.
> 
>    I think it is a bad style to return [] or $ in scalar context
>    depending on the number of results.  It forces the caller to
>    do a conditional depending on the type of the stuff returned.
> 
>    I would suggest just removing if (wantarray) and always
>    return @hashes.  A caller who is interested in a single
>    element can say "($it) = your_sub(...)", a caller who wants
>    the number of elements can say "$cnt = your_sub(...)", and a
>    caller who wants to know all can say "(@them) = your_sub(...)".
> 
>    I think that is the usual thing to do in Perl.  Unless there
>    is a compelling reason that is so important that it is worth
>    to deviate from that norm and confusing the programmer, that
>    is.
> 
>    I think "# try to find filename from $hash" part would
>    misbehave if $hash returned by git_to_hash($hash) becomes
>    undef.

Gaaah, perhaps we should stop to try to be too nice, and just barf or use
legacy output if user didn't provide filename, and hash is not sha1 of blob
(don't try too hard to find filename if it is not provided).

And remove git_to_hash function until the correct implementation is written.

>    You seem to spell out '-M', '-C' everywhere.  I suspect
>    fixing them all to just '-C' (or perhaps '-B', '-C') would be
>    tedious but probably is a good idea.

Does '-C' imply '-M'?
 
>  * 17/19 gitweb: git_blobdiff_plain is git_blobdiff('plain')
> 
>    Needs justification why commitdiff and blobdiff plain needs
>    to behave differently.

First, if we have blobdiff generated with renames/copying detection (and
"commit" view uses it, and provides link to blobdiffs using it), there not
always is single diff (blobdiff) without renames/copying detection. So to
have blobdiff and blobdiff_plain equivalent, and blobdiff_plain without
renames detection, then blobdiff_plain view would have sometimes _two_
patches.

This isn't the case with commitdiff. The diff with and without renames
detection are equivalent for diff of whole commit.

Originally comittdiff and comitdiff_plain both were without renames
detection, while blobdiff and blobdiff_plain were called from commit with
renames detection, and from history with no need for renames detection.


The idea behind changing comittdiff (HTML version) to including rename
detection was that it gives shorter and better to understand patches. The
idea (perhaps wrong) behind leaving comitdiff_plain output without renames
detection was that this output can be applied directly by non-git-aware
tools. It can be easily changed to include renames/copying detection (put
'-C' in one place).

The idea behind having both blobdiff and blobdiff_plain have renames
detection was that commit view used rename detection, the two views should
be equivalent and one exist always for the other, and that it was easier on
implementation ;-)


P.S. I have most problems with having legacy blobdiff URL (without 'hpb' 
i.e. hash_parent_base parameter) working correctly without making use of
external diff.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
