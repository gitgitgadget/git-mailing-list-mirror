From: Pascal Obry <pascal@obry.net>
Subject: [PATCH] Do not scramble password read from .cvspass
Date: Fri, 04 Sep 2009 13:58:32 +0200
Organization: Home - http://www.obry.net
Message-ID: <4AA100E8.9030806@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 13:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjXR9-0005db-UN
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 13:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZIDL6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 07:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbZIDL6a
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 07:58:30 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:56106 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbZIDL63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 07:58:29 -0400
Received: by bwz19 with SMTP id 19so197271bwz.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 04:58:30 -0700 (PDT)
Received: by 10.204.152.23 with SMTP id e23mr9005217bkw.127.1252065510452;
        Fri, 04 Sep 2009 04:58:30 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-8-39.w82-124.abo.wanadoo.fr [82.124.70.39])
        by mx.google.com with ESMTPS id y15sm823689fkd.47.2009.09.04.04.58.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 04:58:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127722>


Passwords stored in .cvspass are already scrambled, we do not
want to scramble them twice. Only passwords read from the
command line are scrambled.

This fixes a regression introduced by:
b2139dbd72d16e40eddfd5b9ad1314703b39fe65

Signed-off-by: Pascal Obry <pascal@obry.net>
---
  git-cvsimport.perl |    7 ++++---
  1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 593832d..c5cdcae 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -238,7 +238,10 @@ sub conn {
                 }
                 my $rr = ":pserver:$user\@$serv:$port$repo";

-               unless ($pass) {
+               if ($pass) {
+                   $pass = $self->_scramble($pass);
+               } else
+               {
                         open(H,$ENV{'HOME'}."/.cvspass") and do {
                                 # 
:pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
                                 while (<H>) {
@@ -253,8 +256,6 @@ sub conn {
                         };
                 }

-               $pass = $self->_scramble($pass);
-
                 my ($s, $rep);
                 if ($proxyhost) {

--
1.6.4.2.253.g0b1fac


-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
