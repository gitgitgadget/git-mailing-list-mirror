From: Manu <manu@blairos.org>
Subject: Re: git-svnimport issue with rename+change in the same commit
Date: Tue, 14 Feb 2006 18:29:23 +0100
Message-ID: <43F21373.8040400@blairos.org>
References: <20060214171233.GC4381@duckman.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 18:30:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F93zq-0005RT-V1
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 18:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWBNR31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWBNR31
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 12:29:27 -0500
Received: from ovh.blairos.org ([213.186.41.56]:24759 "EHLO mail.blairos.org")
	by vger.kernel.org with ESMTP id S1422694AbWBNR30 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 12:29:26 -0500
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by mail.blairos.org (Postfix) with ESMTP
	id 8BFBA844C8; Tue, 14 Feb 2006 18:46:44 +0100 (CET)
User-Agent: Thunderbird 1.5 (Windows/20051201)
To: Eduardo Pereira Habkost <ehabkost@mandriva.com>
In-Reply-To: <20060214171233.GC4381@duckman.conectiva>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16143>

Hi,
Eduardo Pereira Habkost wrote:
 > Hi,
 >
 > I've just hit a problem when using git-svnimport to import a big
 > subversion repository: it doesn't import correctly a commit when the
 > commit renames (or copies) and modify a file at the same time.

I came accross the same problem myself. Here is a patch that seemed to 
do the trick for me.
I tried your script, and it also seems to work.
Regards,

Emmanuel

---

[PATCH] git-svnimport: Correction when a "copy_path" has different 
contents for src and dest.

In my SVN repository, there is a weird log:

   A /trunk/mydir2 (from /trunk/mydir1:4)
   R /trunk/mydir2/test.txt (from /trunk/mydir1/test.txt:4)

As a result, mydir2/test.txt is different than mydir1/test.txt, but
git-svnimport assumes that the content of mydir2/test.txt is the same
as mydir1/test.txt.

This patch adds a test in copy_path, that makes sure that src and dest
have the same content. If not, it uses the content of dest.

---

 git-svnimport.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

e107ff9a06497a0003036ffafa45fa9dc050ecc4
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f17d5a2..a2faa9a 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -409,6 +409,12 @@ sub copy_path($$$$$$$$) {
             $p = $path . substr($p,length($srcpath)-1);
         } else {
             $p = $path;
+            # Deal with copy and modification
+            my $f=get_file($newrev,$newbranch,$path);
+            my ($tmode,$tsha1,$tp)=@$f;
+            if ($tsha1 ne $sha1) {
+                $sha1=$tsha1;
+            }
         }
         push(@$new,[$mode,$sha1,$p]);   
     }
-- 
1.1.GIT
