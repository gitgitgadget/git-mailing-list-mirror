From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 07/15] contrib: related: add support for more roles
Date: Sat, 18 May 2013 06:46:47 -0500
Message-ID: <1368877615-9563-8-git-send-email-felipe.contreras@gmail.com>
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
	id 1UdfdA-00075M-5T
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab3ERLsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:51 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52548 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab3ERLsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:50 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so5639557obb.18
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GwInsCiMilIM56FQINBjb1TsFEVv4UwhIzr9UD6RXzE=;
        b=RMdjmSu2B6BRywN5kMHFVFUVUOdP+CMMbydbBSreqdCgBrrnnRBDD1QErJ/QsIMUK0
         EkCZGUVyU6MzHB1HZhXjZbdpUJ7d6hRTRwwnG8m5vmE61PlyW4503G+qiId/q8mc1PeN
         Hx0kw+HvRISSsIOfhBWdDrJuGhux1Y8ou+hX+KgR/4PhBBbGONlxJJMRf4KMJXHlUrxC
         pf6tpucgLyHTPFEahZCMvw66DKuQF+aNML9QTLGQQneRMqrTDdh+j+UGe/ZjydVxnQYb
         E3nJ3060xOudv6zAqpYVYrzBQhcVoqIuxxI47WjPGiIEh4RJ09/kQLLxl3SJb5FwjxY7
         G5zg==
X-Received: by 10.182.144.232 with SMTP id sp8mr20759047obb.80.1368877729954;
        Sat, 18 May 2013 04:48:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm8698245oby.12.2013.05.18.04.48.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224780>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index cd1ef59..eef776a 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -23,6 +23,12 @@ begin
 rescue OptionParser::InvalidOption
 end
 
+KNOWN_ROLES = {
+  'Signed-off' => :signer,
+  'Reviewed' => :reviewer,
+  'Acked' => :acker,
+}
+
 class Person
 
   attr_reader :roles
@@ -92,9 +98,12 @@ class Commit
           msg = true
         end
       else
-        if line =~ /^(Signed-off|Reviewed|Acked)-by: ([^<>]+) <(\S+?)>$/
+        role_regex = KNOWN_ROLES.keys.join('|')
+        if line =~ /^(#{role_regex})-by: ([^<>]+) <(\S+?)>$/
           person = Persons.get($2, $3)
-          person.add_role(@id, :signer) if person != author
+          role = KNOWN_ROLES[$1]
+          next if role == :signer and person == author
+          person.add_role(@id, role)
         end
       end
     end
-- 
1.8.3.rc2.542.g24820ba
