Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE3F1F404
	for <e@80x24.org>; Sat,  6 Jan 2018 11:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbeAFLv7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 06:51:59 -0500
Received: from forward102j.mail.yandex.net ([5.45.198.243]:48156 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753342AbeAFLv5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 Jan 2018 06:51:57 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2018 06:51:57 EST
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id D41BC5602CA2
        for <git@vger.kernel.org>; Sat,  6 Jan 2018 14:44:28 +0300 (MSK)
Received: from web58g.yandex.ru (web58g.yandex.ru [2a02:6b8:0:1402::9c])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id j6AsZUmcSt-iMdKIpvn;
        Sat, 06 Jan 2018 14:44:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1515239062;
        bh=gxFacHve2ZkHBPILk3mwKvVNQoZk20zLAAzOLCgYwZg=;
        h=From:To:Subject:Message-Id:Date;
        b=nM3aqypTas8kYVW1x/nvu2ha5iEby2wwyD1kbkZdCePQn3rJ8W18+trz4G7eELNyH
         VfrrNUGndNvk8Phtc7ClXgxhkXsVSxBQ1LK4MV5KAQ1a2IfMA0+TgKpJP4LkcHTXX6
         9CzrSmf3ft2A2UQMxaUq6DpRSJTYSFzZVofcL3sI=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web58g.yandex.ru with HTTP;
        Sat, 06 Jan 2018 14:44:22 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: -C options do not work for code evaluation
MIME-Version: 1.0
Message-Id: <654491515239062@web58g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 06 Jan 2018 13:44:22 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I run this command:

git log --graph --decorate --pretty=oneline --abbrev-commit --color-moved -C -L 534,545:lib/DB/Hooks.pm

at some point of evalutation I see:

http://joxi.net/Y2L4GQ0in480l2

* e348241 Wrap whole DB::DB into &dbcall by moving DB::db into DB::interact
| 
| diff --git a/lib/DB/Hooks.pm b/lib/DB/Hooks.pm
| --- a/lib/DB/Hooks.pm
| +++ b/lib/DB/Hooks.pm
| @@ -528,5 +528,12 @@
| -  dbcall \&emit, 'btrap', $source, $f, $l;
| -  dbcall \&emit, 'interact';
| -  dbcall \&emit, 'atrap';
| +sub db {
| +  my $dd =  DB::new   if DB::state( 'dbcall' );
| +  DB::start_dd   if $DB::DB  ||  DB::state( 'dbcall' );
| +  local $DB::DB =  1;
| +
| +  &save_context;
| +  my $dbg =  DB::new \&restore_context;
| +
| +  my( undef, $f, $l ) =  caller(1);
| +  dbcall \&interact, $f, $l;
|  }
|  


When I look at commit e348241 I can see that code is moved:
http://joxi.net/eAOMjW1I4W7LBm

commit e348241bfb9ba563c82d28c05d3f45ab9c1a765d
Author: Eugen Konkov <kes-kes@yandex.ru>
Date:   Fri Jan 5 15:58:17 2018 +0200

    Wrap whole DB::DB into &dbcall by moving DB::db into DB::interact
    
    This allow us to not wrap each &emit call into &dbcall

diff --git a/lib/DB/Hooks.pm b/lib/DB/Hooks.pm
index 6ade20a..dabe701 100644
--- a/lib/DB/Hooks.pm
+++ b/lib/DB/Hooks.pm
@@ -490,23 +490,16 @@ sub goto {
 }
 
 
-sub db {
-    my $dd =  DB::new   if DB::state( 'dbcall' );
-    DB::start_dd   if $DB::DB  ||  DB::state( 'dbcall' );
-    local $DB::DB =  1;
 
-    &save_context;
-    my $dbg =  DB::new \&restore_context;
-
-
-    my( undef, $f, $l ) =  caller(1);
+sub interact {
+    my( $f, $l ) =  @_;
 
     my $source =  DB::source( $f )->[ $l ]; chomp $source;
-    dbcall \&emit, 'trace', $source, $f, $l   if $DB::trace;
+    emit( 'trace', $source, $f, $l )   if $DB::trace;
 ... #<<<<I remove part of patch to minify text
@@ -525,9 +518,23 @@ sub db {
 
 
 
-    dbcall \&emit, 'btrap', $source, $f, $l;
-    dbcall \&emit, 'interact';
-    dbcall \&emit, 'atrap';
+    emit( 'btrap', $source, $f, $l );
+    emit( 'interact' );
+    emit( 'atrap' );
+}
+
+
+
+sub db {
+    my $dd =  DB::new   if DB::state( 'dbcall' );
+    DB::start_dd   if $DB::DB  ||  DB::state( 'dbcall' );
+    local $DB::DB =  1;
+
+    &save_context;
+    my $dbg =  DB::new \&restore_context;
+
+    my( undef, $f, $l ) =  caller(1);
+    dbcall \&interact, $f, $l;
 }
 


To workaround this problem I run:
git log --graph --decorate --pretty=oneline --abbrev-commit --color-moved -C -L 492,505:lib/DB/Hooks.pm e348241b
http://joxi.ru/vAWMwOZIkNy7Rm
* e348241 Wrap whole DB::DB into &dbcall by moving DB::db into DB::interact
| 
| diff --git a/lib/DB/Hooks.pm b/lib/DB/Hooks.pm
| --- a/lib/DB/Hooks.pm
| +++ b/lib/DB/Hooks.pm
| @@ -492,21 +492,14 @@
|  
| -sub db {
| -  my $dd =  DB::new   if DB::state( 'dbcall' );
| -  DB::start_dd   if $DB::DB  ||  DB::state( 'dbcall' );
| -  local $DB::DB =  1;
|  
| -  &save_context;
| -  my $dbg =  DB::new \&restore_context;
| -
| -
| -  my( undef, $f, $l ) =  caller(1);
| +sub interact {
| +  my( $f, $l ) =  @_;
|  
|    my $source =  DB::source( $f )->[ $l ]; chomp $source;
| -  dbcall \&emit, 'trace', $source, $f, $l   if $DB::trace;
| +  emit( 'trace', $source, $f, $l )   if $DB::trace;
|  
|    my @trap;
|    if( my $info =  DB::traps( $f )->{ $l } ) {
| -      @trap =  dbcall \&emit, 'trap', $info, $f, $l;
| +      @trap =  emit( 'trap', $info, $f, $l );
|        # Stop unconditionally if there is no subscribers for the event
|        @trap =  (1)   unless @trap;
|    }
* 30c07c0 If we come from { dbcall } start debugger debugging too
| 
| diff --git a/lib/DB/Hooks.pm b/lib/DB/Hooks.pm
| --- a/lib/DB/Hooks.pm
| +++ b/lib/DB/Hooks.pm
| @@ -489,20 +489,21 @@
|  
|  sub db {
| -  DB::start_dd   if $DB::DB;
| +  my $dd =  DB::new   if DB::state( 'dbcall' );
| +  DB::start_dd   if $DB::DB  ||  DB::state( 'dbcall' );
|    local $DB::DB =  1;
|  
|    &save_context;
|    my $dbg =  DB::new \&restore_context;
|  
|  
|    my( undef, $f, $l ) =  caller(1);
|  
|    my $source =  DB::source( $f )->[ $l ]; chomp $source;
|    dbcall \&emit, 'trace', $source, $f, $l   if $DB::trace;
|  
|    my @trap;
|    if( my $info =  DB::traps( $f )->{ $l } ) {
|        @trap =  dbcall \&emit, 'trap', $info, $f, $l;
|        # Stop unconditionally if there is no subscribers for the event
|        @trap =  (1)   unless @trap;
|    }


1. In the example above moved code is not displayed as moved. It seems the whole 
changeset (commit) is not inspected despite on the `-C` option is supplied

2. Please provide an option which will allow to follow moved code (maybe this should be done by default,
because 71% (77%) of code in interested block is moved and not changed)

| @@ -528,5 +528,12 @@
| -  dbcall \&emit, 'btrap', $source, $f, $l;
| -  dbcall \&emit, 'interact';
| -  dbcall \&emit, 'atrap';
| +sub db {
| +  my $dd =  DB::new   if DB::state( 'dbcall' );
| +  DB::start_dd   if $DB::DB  ||  DB::state( 'dbcall' );
| +  local $DB::DB =  1;
| +
| +  &save_context;
| +  my $dbg =  DB::new \&restore_context;
| +
| +  my( undef, $f, $l ) =  caller(1);
| +  dbcall \&interact, $f, $l;
|  }

Maybe supply interactive mode which will suggest where to follow

Thank you
