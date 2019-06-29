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
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F1D1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 10:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfF2KXd (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 06:23:33 -0400
Received: from forward102o.mail.yandex.net ([37.140.190.182]:41940 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbfF2KXd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Jun 2019 06:23:33 -0400
Received: from mxback15g.mail.yandex.net (mxback15g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:94])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id D4EC4668139C
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 13:23:27 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback15g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id A2liGnhctT-NRMuurCo;
        Sat, 29 Jun 2019 13:23:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1561803807;
        bh=tCygK8IcYt5QB//g5A66VqEAWH0/rve1h2nTbbRBdho=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID;
        b=kpV3gP02in7H8wIyUEIQ9SkyS5y9NQofmV4Mplnf6jx2Ej+JdNE2jJNt9zeOZ9Wcy
         qDheIy0Y+RSTUDKvvwz75cByO8iUCSHima0CSEc3v5LYl1Qq0IaK/6fQMBJWrKlnCv
         AzP4QnmZq+Hyi5RjJw0PAq0xPUGsRIHKHOVjHbt4=
Authentication-Results: mxback15g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ryr1dx5x3u-NQI0pitS;
        Sat, 29 Jun 2019 13:23:26 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Sat, 29 Jun 2019 13:23:25 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <542494034.20190629132325@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Why "Updated upstream" block is so small?
In-Reply-To: <1936584831.20190629130545@yandex.ru>
References: <1936584831.20190629130545@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eugen,

If I do space changes to lines as next:

        ## Create radius account
        eval{
        my $radius_dbh =  $self->result_source->storage->schema->{ _radius_dbh };
        $radius_dbh->begin_work;
        my $sth =  $radius_dbh->prepare(
                "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
        );
        $sth->execute( $package->login );

        $sth =  $radius_dbh->prepare(
                "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
        );
        # my $package_type =  $package->Invoice->Order->Tariff->type;
        my $pass =  $package->password;
        ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
        $sth->execute( $package->login, 'NT-Password', ':=', $pass //'' );
        $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );

        $sth =  $radius_dbh->prepare(
                "INSERT INTO radreply ( username, attribute, op, value, nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
        );
        my $ip =  $package->Ips->first;
        $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );

        $radius_dbh->commit;
        # NOTICE: This is a bit inconsistent
        # if whole payment failed we will have radius account without payment
        };


and `git stash apply` then I get expected result:

diff --cc lib/App/Schema/Result/Invoice.pm
index 07e1b373,0ce2d698..00000000
--- a/lib/App/Schema/Result/Invoice.pm
+++ b/lib/App/Schema/Result/Invoice.pm
@@@ -223,23 -217,22 +223,29 @@@ sub new_package 
         "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
     );
     # my $package_type =  $package->Invoice->Order->Tariff->type;
     my $pass =  $package->password;
     ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
++<<<<<<< Updated upstream
     $sth->execute( $package->login, 'NT-Password', ':=', $pass //'' );
++||||||| merged common ancestors
++   $sth->execute( $package->login, 'NT-Password', ':=', $pass );
++=======
++   $sth->execute( $package->login, 'NT-Password', ':=', $pass //'');
++>>>>>>> Stashed changes
     $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
  
     $sth =  $radius_dbh->prepare(
         "INSERT INTO radreply ( username, attribute, op, value, nasip) values ( ?, 'Frame
     );
     my $ip =  $package->Ips->first;
-    $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
+    # $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
  
     $radius_dbh->commit;
     # NOTICE: This is a bit inconsistent
     # if whole payment failed we will have radius account without payment
 +   };
  
  
     return $package;
  }


Why before space change I get broken result?



Saturday, June 29, 2019, 1:05:45 PM, you wrote:

> Hello

> I want to apply this patch from stage:

> diff --git a/lib/App/Schema/Result/Invoice.pm
> b/lib/App/Schema/Result/Invoice.pm
> index 0176916f..0ce2d698 100644
> --- a/lib/App/Schema/Result/Invoice.pm
> +++ b/lib/App/Schema/Result/Invoice.pm
> @@ -219,14 +219,14 @@ sub new_package {
>      # my $package_type =  $package->Invoice->Order->Tariff->type;
>      my $pass =  $package->password;
>      ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
-    $sth->>execute( $package->login, 'NT-Password', ':=', $pass );
+    $sth->>execute( $package->login, 'NT-Password', ':=', $pass //'');
>      $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
>  
>      $sth =  $radius_dbh->prepare(
>          "INSERT INTO radreply ( username, attribute, op, value,
> nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
>      );
>      my $ip =  $package->Ips->first;
-    $sth->>execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
+    # $sth->>execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
>  
>      $radius_dbh->commit;
>      # NOTICE: This is a bit inconsistent


> after applying I get merge conflict:


> diff --cc lib/App/Schema/Result/Invoice.pm
> index e3f55654,0ce2d698..00000000
> --- a/lib/App/Schema/Result/Invoice.pm
> +++ b/lib/App/Schema/Result/Invoice.pm
> @@@ -211,33 -204,34 +211,87 @@@ sub new_package 
>      }
>   
>      ## Create radius account
>  +   eval{
>          my $radius_dbh =  $self->result_source->storage->schema->{ _radius_dbh };
>  -   if( !$radius_dbh->FETCH('AutoCommit') ) {
>  +       $radius_dbh->begin_work;
>  +       my $sth =  $radius_dbh->prepare(
>  +           "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
>  +       );
>  +       $sth->execute( $package->login );
>  +
>  +       $sth =  $radius_dbh->prepare(
>  +           "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
>  +       );
>  +       # my $package_type =  $package->Invoice->Order->Tariff->type;
>  +       my $pass =  $package->password;
>  +       ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
>  +       $sth->execute( $package->login, 'NT-Password', ':=', $pass //'' );
>  +       $sth->execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
>  +
>  +       $sth =  $radius_dbh->prepare(
>  +           "INSERT INTO radreply ( username, attribute, op,
> value, nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
>  +       );
>  +       my $ip =  $package->Ips->first;
>  +       $sth->execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
>  +
>          $radius_dbh->commit;
> ++<<<<<<< Updated upstream
>  +       # NOTICE: This is a bit inconsistent
>  +       # if whole payment failed we will have radius account without payment
>  +   };
> ++||||||| merged common ancestors
> ++   }
++   $radius_dbh->>begin_work;
> ++   my $sth =  $radius_dbh->prepare(
> ++       "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
> ++   );
++   $sth->>execute( $package->login );
> ++
> ++   $sth =  $radius_dbh->prepare(
> ++       "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
> ++   );
> ++   # my $package_type =  $package->Invoice->Order->Tariff->type;
> ++   my $pass =  $package->password;
> ++   ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
++   $sth->>execute( $package->login, 'NT-Password', ':=', $pass );
++   $sth->>execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
> ++
> ++   $sth =  $radius_dbh->prepare(
> ++       "INSERT INTO radreply ( username, attribute, op, value,
> nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
> ++   );
> ++   my $ip =  $package->Ips->first;
++   $sth->>execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
> ++
++   $radius_dbh->>commit;
> ++   # NOTICE: This is a bit inconsistent
> ++   # if whole payment failed we will have radius account without payment
> ++=======
> +    }
+    $radius_dbh->>begin_work;
> +    my $sth =  $radius_dbh->prepare(
> +        "INSERT INTO radusergroup ( username, groupname, priority ) values (?,'static',1)"
> +    );
+    $sth->>execute( $package->login );
> + 
> +    $sth =  $radius_dbh->prepare(
> +        "INSERT INTO radcheck ( username, attribute, op, value ) values ( ?, ?, ?, ? )"
> +    );
> +    # my $package_type =  $package->Invoice->Order->Tariff->type;
> +    my $pass =  $package->password;
> +    ($pass) =  (`smbencrypt $pass` =~ /([^\s]+)$/s);
+    $sth->>execute( $package->login, 'NT-Password', ':=', $pass //'');
+    $sth->>execute( $package->login, 'NAS-Identifier', '=~', 'ppp' );
> + 
> +    $sth =  $radius_dbh->prepare(
> +        "INSERT INTO radreply ( username, attribute, op, value,
> nasip) values ( ?, 'Framed-IP-Address', '=', ?, ? )"
> +    );
> +    my $ip =  $package->Ips->first;
+    # $sth->>execute( $package->login, $ip->ip, $ip->Listener->first->nas_ip );
> + 
+    $radius_dbh->>commit;
> +    # NOTICE: This is a bit inconsistent
> +    # if whole payment failed we will have radius account without payment
++>>>>>>>> Stashed changes
>   
>   
>      return $package;



> Why updated upstream block is so small?

> ++<<<<<<< Updated upstream
>  +       # NOTICE: This is a bit inconsistent
>  +       # if whole payment failed we will have radius account without payment
>  +   };
> ++||||||| merged common ancestors

>  
> I suppose it should start from to line line:

>      +       $radius_dbh->begin_work;
>      ...
>     +    # if whole payment failed we will have radius account without payment







-- 
Best regards,
Eugen Konkov

