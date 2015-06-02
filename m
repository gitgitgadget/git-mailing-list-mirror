From: Petr Stodulka <pstodulk@redhat.com>
Subject: [PATCH] request-pull: short sha handling, manual update
Date: Tue, 02 Jun 2015 16:14:15 +0200
Message-ID: <556DBA37.2010402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 16:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzmxS-0002mJ-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049AbbFBOOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:14:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758907AbbFBOOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:14:17 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 4AC682CAF31
	for <git@vger.kernel.org>; Tue,  2 Jun 2015 14:14:17 +0000 (UTC)
Received: from [10.34.4.110] (unused-4-110.brq.redhat.com [10.34.4.110])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t52EEF3A022090
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 2 Jun 2015 10:14:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270539>

request-pull prints incorrectly warn messages about not found commits 
and man pages don't say
anything about todays changed behaviour. People are confused and try 
look for errors at wrong places.
At least these should be fixed/modified.

Warn massage says that commit can't be found ar remote, however there it 
is in and is missing on local repository
in 'many' cases. So I don't know if better solution is check, where 
commit is truly missing or transform warning message.
Something like:

    warn: No match for commit <commit> found at <url> or local repository.
    warn: Are you sure you have synchronized branch with remote repository?

......
man page could be changed like this:

-------------------------------------------------------
diff --git a/Documentation/git-request-pull.txt 
b/Documentation/git-request-pull.txt
index 283577b..6d34fc7 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -73,6 +73,17 @@ then you can ask that to be pulled with
         git request-pull v1.0 https://git.ko.xz/project master:for-linus


+NOTES
+-----
+
+Since git version 2.0.0 is behaviour of git request-pull little different.
+It is recommended use of third argument for each request-pull, otherwise
+you can get error message like:
+
+   warn: No match for commit <commit> found at <url>
+   warn: Are you sure you pushed 'HEAD' there?
+
+
  GIT
  ---
  Part of the linkgit:git[1] suite

-------------------------------------------------------

Second patch provides right processing of third parameter when short 
version of sha hash is used (e.g. 897a111). Now is
supported only full hash, what is different behaviour against first 
parameter or what can be found in other functions. Extra
solves one of cases of wrong warn message.

-------------------------------------------------------
diff --git a/git-request-pull.sh b/git-request-pull.sh
index d5500fd..2dc735e 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -92,9 +92,11 @@ find_matching_ref='
                 chomp;
                 my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
                 my ($pattern);
+               my ($pattern2);
                 next unless ($sha1 eq $headrev);

                 $pattern="/$head\$";
+               $pattern2="^$head";
                 if ($ref eq $head) {
                         $found = $ref;
                 }
@@ -104,6 +106,9 @@ find_matching_ref='
                 if ($sha1 eq $head) {
                         $found = $sha1;
                 }
+               elsif ($sha1 =~ /$pattern2/ and (length $head) gt 7) {
+                       $found = $sha1
+               }
         }
         if ($found) {
                 print "$found\n";
-------------------------------------------------------
