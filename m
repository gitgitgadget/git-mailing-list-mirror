From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv2] Clarified how "git submodule add" handles relative paths.
Date: Thu,  2 Jun 2011 10:21:28 -0400
Message-ID: <1307024488-10130-1-git-send-email-marcnarc@xiplink.com>
References: <7vsjrth4iy.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 16:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS8mz-0006Y3-Cy
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 16:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab1FBOVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 10:21:55 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:35015 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750970Ab1FBOVy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 10:21:54 -0400
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p52ELeGG029234;
	Thu, 2 Jun 2011 10:21:40 -0400
X-Mailer: git-send-email 1.7.5.3.1.ge85f0.dirty
In-Reply-To: <7vsjrth4iy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174950>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-submodule.txt |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

On 11-06-01 12:59 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> So this is really about saving the users the hassle of modifying all the
>> URLs in the .gitmodules file.  Does this patch document what you mean?
> 
> I do not necessarily think it is _solely_ about users. Another obvious
> example I left unsaid was what would happen when your project gets popular
> and gets mirrored to many places. Surely you need to advise people of
> alternate locations of the top-level, but what is recorded in .gitmodules
> will be relative to that top-level, so they do not have to be changed.
> Even if you have only one public repository, I would imagine that the same
> convenience would apply if you ever decide to switch the project hosting
> site.

I think I understand.  How does this version grab ya?

> "Users can use a URL different from what was given by the maintainer" is
> merely an example; I doubt it deserves stressing that much.
> 
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 1a16ff6..54dfebb 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -77,8 +77,17 @@ to exist in the superproject. If <path> is not given, the
>>  +
>>  <repository> is the URL of the new submodule's origin repository.
>>  This may be either an absolute URL, or (if it begins with ./
>> -or ../), the location relative to the superproject's origin
>> -repository.
>> +or ../) a URL relative to one of the superproject's remote
>> +repostories:  If the superprojet's currently checked-out branch tracks
>> +a remote branch then that remote's URL is used, otherwise the "origin"
>> +remote's URL is used.  Relative URLs allow users to easily clone the
>> +superproject and its submodules using a different URL than what the
>> +superproject's maintainer might use (e.g. the maintainer can use ssh://
>> +URLs while the users might use git:// URLs).  With relative URLs in the
>> +.gitmodules file, the users won't have to edit all the submodule URLs.
>> ++
>> +*NOTE*: This means that you can *not* use a relative path to refer to a
>> +repository in your local filesystem.
> 
> It is not "can not" but "do not", is it?  More importantly, I do not think
> it is limited to the case of relative path at all.

Well, the way the code currently works I think it's "can not".  It'll
happily accept an absolute file path but any relative path is either
successfully "remotified" or the command fails.

(I also agree with Jens that there's utility in allowing local-filesystem
submodules.)

		M.


diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1a16ff6..8daa33c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -77,8 +77,21 @@ to exist in the superproject. If <path> is not given, the
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
-repository.
+or ../) a URL relative to one of the superproject's remote
+repostories:  If the superprojet's currently checked-out branch tracks
+a remote branch then that remote's URL is used, otherwise the "origin"
+remote's URL is used.
++
+Relative submodule URLs provide flexibility in cases where the
+super-project and its submodules are hosted together.  For example,
+the relative submodule URLs remain valid if the repository collection
+moves to a different hosting site, or if the collection is mirrored at
+different sites.  Similarly, maintainers can conveniently make clones
+with a different URL (say an ssh:// URL) than users (who might use
+git:// URLs).
++
+*NOTE*: This means that you can *not* use a relative path to refer to a
+repository in your local filesystem.
 +
 <path> is the relative location for the cloned submodule to
 exist in the superproject. If <path> does not exist, then the
-- 
1.7.5.3.1.ge85f0.dirty
