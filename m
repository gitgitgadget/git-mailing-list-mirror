From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] get_authors.sh, author.rb: use -s option of git shortlog.
Date: Mon,  5 Jan 2009 23:52:26 +0100
Message-ID: <1231195946-20967-1-git-send-email-dato@net.com.org.es>
References: <20090105185737.GV21154@genesis.frugalware.org>
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	=?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 23:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJyKX-0003Yd-21
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 23:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZAEWwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 17:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZAEWwa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 17:52:30 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4451
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZAEWw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 17:52:29 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id CA4AC801BF94;
	Mon,  5 Jan 2009 23:52:26 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LJyJ8-0005Ug-22; Mon, 05 Jan 2009 23:52:26 +0100
X-Mailer: git-send-email 1.6.1.62.g677ca
In-Reply-To: <20090105185737.GV21154@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104602>

Suggested by Miklos Vajna <vmiklos@frugalware.org>.
---
 app/models/author.rb  |   26 ++++++++++++--------------
 script/get_authors.sh |    2 +-
 2 files changed, 13 insertions(+), 15 deletions(-)

> I suppose fixing up the ruby part after this is not that hard, sadly I
> don't speak Ruby myself, so I have no idea where and what to touch. ;-)

Done.

Btw, I don't think authors.txt should be in the repo at all, since it's
automatically generated, but it's your choice. :-)

diff --git a/app/models/author.rb b/app/models/author.rb
index 8fafc15..6bf069a 100644
--- a/app/models/author.rb
+++ b/app/models/author.rb
@@ -1,22 +1,20 @@
 class Author
-	
-	def self.all
-		authors =  File.join(RAILS_ROOT, 'config/authors.txt')
+  def self.all
+    authors = File.join(RAILS_ROOT, 'config/authors.txt')
     if File.exists?(authors)
       authors = File.readlines(authors)
       @authors = {:main => [], :contrib => []}
       authors.each do |author|
-        data = author.split(' ')
-        number = data.pop.gsub('(', '').gsub(')', '').chomp
-        name = data.join(' ')
-        if(number.to_i > 50)
-          @authors[:main] << [name, number.to_i]
-        else
-          @authors[:contrib] << [name, number.to_i]
+        if author =~ /(\d+)\s+(.+)/
+          name, number = $2, $1.to_i
+          if number > 50
+            @authors[:main] << [name, number]
+          else
+            @authors[:contrib] << [name, number]
+          end
         end
       end
+      @authors
     end
-		@authors
-	end
-	
-end
\ No newline at end of file
+  end
+end
diff --git a/script/get_authors.sh b/script/get_authors.sh
index 9aa8c6b..028a354 100755
--- a/script/get_authors.sh
+++ b/script/get_authors.sh
@@ -1,3 +1,3 @@
 export GIT_DIR=/Users/schacon/projects/git/.git
 cd /Users/schacon/projects/git
-git log --pretty=short --no-merges | git shortlog -n | grep -v -e '^ ' | grep ':' > ../gitscm/config/authors.txt
+git shortlog --no-merges -sn > ../gitscm/config/authors.txt
-- 
1.6.1.62.g677ca
