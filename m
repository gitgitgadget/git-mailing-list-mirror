From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 06/15] contrib: related: show role count
Date: Sat, 18 May 2013 06:46:46 -0500
Message-ID: <1368877615-9563-7-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfd9-00075M-LE
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab3ERLsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:47 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:39373 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab3ERLsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:47 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so5627532obb.3
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q1Js+D/ta3PgvXAZR+AIvsN6q89ttTkM93wqrbfb3e4=;
        b=aMaLBzgTitVbmHrXQIkZJlSUEbRKo52xy/FWBECCsRdD4Uugf7e6FQJA4DniQOa/Wg
         Ttf0cVhL0cWhWujg3yPusW+yTQowN9htq5YCqfa4YAhlJT555yS+OQ1y9qf5k3T8LP1h
         BrKcaSor0KnFldyvG4pkJhoMAbw2/NHalQufPaPgCkKoHkAocFP5vY4LoiNa2rK1Y1Uq
         90LzUHNAlS+bYFA7fNbqceflwcSut5zrTjZB3jnIY9KW1OtJA+EJzn8tGRxQLFAuinD6
         RZ97caMqZgG6KGQFYNcNZ3ADiQdsTJM59QbebczBS8/a6ZDd5V3tnbexO4rnOG7sUk1j
         dHQw==
X-Received: by 10.60.63.174 with SMTP id h14mr24759519oes.137.1368877726630;
        Sat, 18 May 2013 04:48:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm11291648obc.2.2013.05.18.04.48.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224779>

Instead of showing the total involvement, show it per role: author, or
signer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index df13148..cd1ef59 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -31,10 +31,12 @@ class Person
     @name = name
     @email = email
     @commits = {}
+    @roles = Hash.new(0)
   end
 
-  def add_role(commit)
+  def add_role(commit, role)
     @commits[commit] = true
+    @roles[role] += 1
   end
 
   def <=>(b)
@@ -79,20 +81,20 @@ class Commit
   end
 
   def parse(data)
-    msg = nil
+    msg = author = nil
     data.each_line do |line|
       if not msg
         case line
         when /^author ([^<>]+) <(\S+)> (.+)$/
           author = Persons.get($1, $2)
-          author.add_role(@id)
+          author.add_role(@id, :author)
         when /^$/
           msg = true
         end
       else
         if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
           person = Persons.get($2, $3)
-          person.add_role(@id)
+          person.add_role(@id, :signer) if person != author
         end
       end
     end
@@ -174,5 +176,11 @@ persons = Persons.new
 persons.sort.reverse.each do |person|
   percent = person.size.to_f * 100 / commits.size
   next if percent < $min_percent
-  puts '%s (involved: %u%%)' % [person, percent]
+
+  roles = person.roles.map do |role, role_count|
+    role_percent = role_count.to_f * 100 / commits.size
+    '%s: %u%%' % [role, role_percent]
+  end
+
+  puts '%s (%s)' % [person, roles.join(', ')]
 end
-- 
1.8.3.rc2.542.g24820ba
