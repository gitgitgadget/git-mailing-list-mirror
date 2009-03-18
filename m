From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7700-repack: repack -a now works properly, expect success
 from test
Date: Wed, 18 Mar 2009 15:59:02 -0500
Message-ID: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil>
References: <cover.1235812035.git.gitster@pobox.com> <7Vazs5mFk91IKAarOd0wrBNmYj7eSJxVIcR0PEQxJl8R0aQmQDEqSJMphMrXhmVu570fijupQ34@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 18 22:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk2si-0001kI-Ov
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbZCRU7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZCRU7X
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 16:59:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35222 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZCRU7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 16:59:23 -0400
Received: by mail.nrlssc.navy.mil id n2IKx3hh011892; Wed, 18 Mar 2009 15:59:03 -0500
In-Reply-To: <7Vazs5mFk91IKAarOd0wrBNmYj7eSJxVIcR0PEQxJl8R0aQmQDEqSJMphMrXhmVu570fijupQ34@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Mar 2009 20:59:02.0682 (UTC) FILETIME=[5DFEBFA0:01C9A80C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113661>

Brandon Casey wrote:
> Since Junio's keep-pack series was merged in at aec81306, git-repack now
> properly packs objects from alternate repositories even when the local
> repository contains packs.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> Well, I finally got some time last week to take a look at this issue, and
> what do I find, but you've already fixed it.  Did you even realize? :)
> 
> 
> I was too busy to notice the emails on the subject last month...
> 
> http://article.gmane.org/gmane.comp.version-control.git/111758
> 
> Junio C Hamano wrote:
>> I think we probably could get rid of --honor-pack-keep mechanism after
>> this series, but I didn't look very deeply into it.
> 
> This makes sense, but doesn't seem to be working.  Possibly the way
>  --kept-pack-only is implemented, it only deals with commits.  So if the
> commit object is _not_ in a kept pack, but the trees and/or blobs that it
> references _are_, then both the commit and the trees/blobs will be added to
> the list of objects to pack even though the trees/blobs should not be.
> 
> The test in t7700 is contrived, and creates two pack files; one marked with
> .keep which contains a single blob object that is missing from the other.
> Then the test repacks and checks whether the blob object was placed into the
> new pack.  The --honor-pack-keep mechanism handles this case since it works
> on the back end and checks whether each object that is added to the objects
> list exists in a kept pack, and skips it if so.
> 
> Disclaimer: I have not taken the time to fully understand revision.c

Hmm, I think there are a couple of new issues.

  1) The --kept-pack-only mechanism does not operate solely on "local"
     packs now.  This means that objects residing in an alternate pack
     which has a .keep file will not be repacked with repack -a.  My
     current opinion is that .keep files in an alternate object database
     should not be honored since the user may not have any control over
     them.  This seems to be in line with your statement about this feature
     affecting locally existing packs from the Release Notes:

       git-gc spent excessive amount of time to decide if an object appears
       in a locally existing pack

  2) The 'repack unpacked objects' and 'loosen unpacked objects' mechanisms
     now do not operate solely on local packs.  I think this means that
     objects residing in alternate not-kept packs will be repacked when
     '-A -d' is used, and will be loosened when '-a -d' is used.


I have a test for #1 above. I'll think about a test for #2.

I wonder if we'll ever be interested in non-local keep files?  If not, then
why not set pack_keep _only_ for local packs?

diff --git a/sha1_file.c b/sha1_file.c
index 4563173..a595eac 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -881,9 +881,11 @@ struct packed_git *add_packed_git(const char *path, int pat
        }
        memcpy(p->pack_name, path, path_len);
 
-       strcpy(p->pack_name + path_len, ".keep");
-       if (!access(p->pack_name, F_OK))
-               p->pack_keep = 1;
+       if (local) {
+               strcpy(p->pack_name + path_len, ".keep");
+               if (!access(p->pack_name, F_OK))
+                       p->pack_keep = 1;
+       }
 
        strcpy(p->pack_name + path_len, ".pack");
        if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {


I'd also change the name from pack_keep to something that identivies it as local.

The alternative would require that find_pack_ent() differentiate between
local kept packs and alternate kept packs.

-brandon
