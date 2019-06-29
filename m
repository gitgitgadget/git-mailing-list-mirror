Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE801F461
	for <e@80x24.org>; Sat, 29 Jun 2019 10:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfF2KLc (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 06:11:32 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:40973 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbfF2KLc (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Jun 2019 06:11:32 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 06:11:29 EDT
Received: from mxback23g.mail.yandex.net (mxback23g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:323])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 9BD974A10BF
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 13:05:47 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback23g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id tjh9ggqQst-5lo4AZeM;
        Sat, 29 Jun 2019 13:05:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1561802747;
        bh=16gFfJTjktUHLu3ilVjJoNfDTIOwFgaTk/9s0Kj5xTo=;
        h=Subject:To:From:Date:Message-ID;
        b=YrGSyVFw7xsl4yXSjlVLjZLsH6raqc4gEmJy7xYMsxzFkcbbe2qnb3eotqeykKV1O
         yI8hJqiqIbujPyNtlLt9FPqukPw3yYLRRu/1b3EJwc8ShYq1dm4ZLucuXQTvf15Wev
         FjDs6nExdSuz+CcN19aeAuHX/8JNItmZ1PodBaZs=
Authentication-Results: mxback23g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7AV1EQYgFr-5k4aGSt4;
        Sat, 29 Jun 2019 13:05:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Sat, 29 Jun 2019 13:05:45 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1936584831.20190629130545@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Why "Updated upstream" block is so small?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I want to apply this patch from stage:

diff --git a/lib/App/Schema/Result/Invoice.pm b/lib/App/Schema/Result/Invoice.pm
index 0176916f..0ce2d698 100644
--- a/lib/App/Schema/Result/Invoice.pm
+++ b/lib/App/Schema/Result/Invoice.pm
@@ -219,14 +219,14 @@ sub new_package {
     # my $package_type =  $package->Invoice->Order->Tariff->type;
     my $pass =  $package->password;
     ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
-    $sth->execute( $package->login, 'NT-Password', ':=', $pass );
+    $sth->execute( $package->login, 'NT-Password', ':=', $pass //'');
     $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
 
     $sth =  $radius_dbh->prepare(
         "INSERT INTO radreply ( username, attribute, op, value, nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
     );
     my $ip =  $package->Ips->first;
-    $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
+    # $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
 
     $radius_dbh->commit;
     # NOTICE: This is a bit inconsistent


after applying I get merge conflict:


diff --cc lib/App/Schema/Result/Invoice.pm
index e3f55654,0ce2d698..00000000
--- a/lib/App/Schema/Result/Invoice.pm
+++ b/lib/App/Schema/Result/Invoice.pm
@@@ -211,33 -204,34 +211,87 @@@ sub new_package 
     }
  
     ## Create radius account
 +   eval{
         my $radius_dbh =  $self->result_source->storage->schema->{ _radius_dbh };
 -   if( !$radius_dbh->FETCH('AutoCommit') ) {
 +       $radius_dbh->begin_work;
 +       my $sth =  $radius_dbh->prepare(
 +           "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
 +       );
 +       $sth->execute( $package->login );
 +
 +       $sth =  $radius_dbh->prepare(
 +           "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
 +       );
 +       # my $package_type =  $package->Invoice->Order->Tariff->type;
 +       my $pass =  $package->password;
 +       ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
 +       $sth->execute( $package->login, 'NT-Password', ':=', $pass //'' );
 +       $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
 +
 +       $sth =  $radius_dbh->prepare(
 +           "INSERT INTO radreply ( username, attribute, op, value, nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
 +       );
 +       my $ip =  $package->Ips->first;
 +       $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
 +
         $radius_dbh->commit;
++<<<<<<< Updated upstream
 +       # NOTICE: This is a bit inconsistent
 +       # if whole payment failed we will have radius account without payment
 +   };
++||||||| merged common ancestors
++   }
++   $radius_dbh->begin_work;
++   my $sth =  $radius_dbh->prepare(
++       "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
++   );
++   $sth->execute( $package->login );
++
++   $sth =  $radius_dbh->prepare(
++       "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
++   );
++   # my $package_type =  $package->Invoice->Order->Tariff->type;
++   my $pass =  $package->password;
++   ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
++   $sth->execute( $package->login, 'NT-Password', ':=', $pass );
++   $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
++
++   $sth =  $radius_dbh->prepare(
++       "INSERT INTO radreply ( username, attribute, op, value, nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
++   );
++   my $ip =  $package->Ips->first;
++   $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
++
++   $radius_dbh->commit;
++   # NOTICE: This is a bit inconsistent
++   # if whole payment failed we will have radius account without payment
++=======
+    }
+    $radius_dbh->begin_work;
+    my $sth =  $radius_dbh->prepare(
+        "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
+    );
+    $sth->execute( $package->login );
+ 
+    $sth =  $radius_dbh->prepare(
+        "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
+    );
+    # my $package_type =  $package->Invoice->Order->Tariff->type;
+    my $pass =  $package->password;
+    ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
+    $sth->execute( $package->login, 'NT-Password', ':=', $pass //'');
+    $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
+ 
+    $sth =  $radius_dbh->prepare(
+        "INSERT INTO radreply ( username, attribute, op, value, nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
+    );
+    my $ip =  $package->Ips->first;
+    # $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
+ 
+    $radius_dbh->commit;
+    # NOTICE: This is a bit inconsistent
+    # if whole payment failed we will have radius account without payment
++>>>>>>> Stashed changes
  
  
     return $package;



Why updated upstream block is so small?

++<<<<<<< Updated upstream
 +       # NOTICE: This is a bit inconsistent
 +       # if whole payment failed we will have radius account without payment
 +   };
++||||||| merged common ancestors

 
I suppose it should start from to line line:

     +       $radius_dbh->begin_work;
     ...
    +    # if whole payment failed we will have radius account without payment




-- 
Best regards,
Eugen Konkov

