From: Monard Vong <travelingsoul86@gmail.com>
Subject: [PATCH] git-svn: Initialize SVN::Client with svn config instead of,
 auth for "git svn branch".
Date: Fri, 18 Jul 2014 16:58:25 +0200
Message-ID: <53C93611.7090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 16:58:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X89cJ-0002NZ-TA
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 16:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761800AbaGRO6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 10:58:32 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38654 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859AbaGRO6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 10:58:31 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so1019176wiv.11
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=PkDXuHsX6FHKej4myuptILHAxDzi5oAvyMTWdZ7nkyM=;
        b=DZH9xTPSQE8+156vJNd+UucKVu8Fe+6Y2e0ks7u5O3y57WzpDCnzJya4ZZu8bExjVO
         ab2LXMoz51jiavnGeU/yqPi/QLMW+G+NyH4E0xU1pAOPRUTeIt/thBWj3fnfl/G4bJ3s
         V4hDsosPlKaPA0afo/j3HGhZCxXVS3hgffhr3asDtHI6n8iwyjumOiLK71gf6dDVNCcV
         vtMl0Vw4+FUe9R4i+o+MdPchC9/mfPosWtZX+9NXJAIkq8wIfpLmWp/Ndhg2xmPljBya
         uWHLZtlSzNG89KGzuzl8bgw15/AcTBF2XaRtyWk0LFU8r8/eI7kC8BOkyM8Uh2QK3d+F
         r1wQ==
X-Received: by 10.180.9.202 with SMTP id c10mr33407803wib.13.1405695510052;
        Fri, 18 Jul 2014 07:58:30 -0700 (PDT)
Received: from [192.168.59.212] ([178.132.31.226])
        by mx.google.com with ESMTPSA id ut2sm14759618wjc.49.2014.07.18.07.58.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 07:58:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253820>

If a client certificate is required to connect to svn, "git svn branch"
always prompt the user for the certificate location and password,
even though those parameters are stored in svn file "server"
located in svn config dir (generally ~/.subversion).
On the opposite, "git svn info/init/dcommit" read the config dir
and do not prompt if the parameters are set.

This commit initializes for "git svn branch", the SVN::Client with the 
'config'
option instead of 'auth'. As decribed in the SVN documentation,
http://search.cpan.org/~mschwern/Alien-SVN-v1.7.17.1/src/subversion/subversion/bindings/swig/perl/native/Client.pm#METHODS
the SVN::Client will then read cached authentication options.

Signed-off-by: Monard Vong <travelingsoul86@gmail.com>
---
  git-svn.perl | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a32372..1f41ee1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1161,7 +1161,9 @@ sub cmd_branch {
      ::_req_svn();

      my $ctx = SVN::Client->new(
-        auth    => Git::SVN::Ra::_auth_providers(),
+        config => SVN::Core::config_get_config(
+            $Git::SVN::Ra::config_dir
+        ),
          log_msg => sub {
              ${ $_[0] } = defined $_message
                  ? $_message
-- 
1.9.3
