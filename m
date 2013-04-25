From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/11] contrib: related: group persons with same email
Date: Thu, 25 Apr 2013 14:59:42 -0500
Message-ID: <1366919983-27521-11-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMR-0004FC-H1
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab3DYUBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:37 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40935 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab3DYUBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:34 -0400
Received: by mail-oa0-f49.google.com with SMTP id j1so3196692oag.8
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Sazuk6FNr0BIro30P3NGy+PfA2aQWmFQSLQcRlZWPPE=;
        b=j5JSIs3CMZ8Ll7/0kBmzKdyeQNgiUqXQu5ldFZzH+qVI1eSj4MfO9FoLO5y8cjYdye
         ae6GYImusUD8OrVu6kobQpBHiCo0YqaIpXqPluhYWFWs3WLp/gfb7G037wSaHe/oylgk
         2QCBuK+vdvJz5map91Beik0J9LtwuyTmLN1kfoQmr1Jr8UgWMU9cTDGYhtUWMNOo6cRc
         C46q1E3/dxTzJKbpcHZsUxQ5VBG4EJI3G6pYCaxpuu/06F3fbf2cZOrE2ZqmLeSSL0mL
         HgJdjZdHS3pnarCQKwLjOWX+qdyJ57cycHPnFJd4unTuBPecLWFmwI7kxCfbI9x6plc1
         ETqw==
X-Received: by 10.60.34.202 with SMTP id b10mr16588101oej.119.1366920094576;
        Thu, 25 Apr 2013 13:01:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id fl7sm4735936obb.0.2013.04.25.13.01.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222438>

We still need the name of the person, so it might make sense to have a
Person object to simplify the code. Later.

Suggested-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 4e9b916..f85e924 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -202,12 +202,15 @@ end
 
 # hash of hashes
 persons = Hash.new { |hash, key| hash[key] = {} }
+names = {}
 
 commits.items.values.each do |commit|
   commit.roles.each do |person, roles|
+    name, email = person
+    names[email] ||= name
     roles.each do |role|
-      persons[person][role] ||= 0
-      persons[person][role] += 1
+      persons[email][role] ||= 0
+      persons[email][role] += 1
     end
   end
 end
@@ -217,7 +220,7 @@ count_sort = lambda do |a, b|
   b[1].values.reduce(:+) <=> a[1].values.reduce(:+)
 end
 
-persons.sort(&count_sort).each do |person, roles|
+persons.sort(&count_sort).each do |email, roles|
   roles = roles.map do |role, count|
     percent = count.to_f * 100 / commits.size
     next if percent < $min_percent
@@ -225,7 +228,7 @@ persons.sort(&count_sort).each do |person, roles|
   end.compact
   next if roles.empty?
 
-  name, email = person
+  name = names[email]
   # must quote chars?
   name = '"%s"' % name if name =~ /[^\w \-]/i
   person = name ? '%s <%s>' % [name, email] : email
-- 
1.8.2.1
