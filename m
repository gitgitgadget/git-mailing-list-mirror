From: KES <kes-kes@yandex.ua>
Subject: Improving auto conflict resolving while merge
Date: Mon, 07 Sep 2015 20:15:46 +0300
Message-ID: <856611441646146@web13j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?koi8-r?B?5dfHxc7JyiDrz87Yy8/X?= <kes-kes@yandex.ua>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 19:23:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ08i-0008JL-6e
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 19:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbbIGRXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 13:23:30 -0400
Received: from forward15j.cmail.yandex.net ([5.255.227.179]:50217 "EHLO
	forward15j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331AbbIGRX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2015 13:23:29 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2015 13:23:28 EDT
Received: from web13j.yandex.ru (web13j.yandex.ru [5.45.198.54])
	by forward15j.cmail.yandex.net (Yandex) with ESMTP id 0BC0E211EA
	for <git@vger.kernel.org>; Mon,  7 Sep 2015 20:15:47 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web13j.yandex.ru (Yandex) with ESMTP id 8E953D403A1;
	Mon,  7 Sep 2015 20:15:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1441646147; bh=9QIfmK6CPsaLVxqSqkecWr5R3PtaCFoXCvO3NMlosfs=;
	h=From:To:Cc:Subject:Date;
	b=McoPYUztwuijjlOktkWtdXnCWwGn/w1aKNMiM7oDSCCBo68wQN45RnCqPn0x1GdA5
	 dUYmSITr0p+CoKA9HuXIH5VdxIDRQm31WYobNFGR7Ee3h6XPZJtNpcoKpiX651hYVz
	 X94spJvzm1Tdy63qs21QHUHSHgN1SfuQbASgktF4=
Received: by web13j.yandex.ru with HTTP;
	Mon, 07 Sep 2015 20:15:46 +0300
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277470>

Hi.

**To not apply big patches, I will supply links to public repository

Lets start

1. git clone https://github.com/KES777/Plack

2. git show ed485bf75a6

Nothing interesting. Usual merge conflict while merge branch 'feature/doc_contribute' to 'master'

But I was interested by this part:

   my $app = sub {
       my $env =  shift;
 
+<<<<<<< HEAD
+=======
+  my $app = sub {
+      my $env =  shift;
+
+>>>>>>> master

I know that some code were cherry picked(??) by maintainer from by branch. Ans this is the part which are same in master and branch.
So I not expect conflict here. I start to dig.

I compare Log4perl.pm files from branch and master 
3. git checkout feature/doc_contribution
4. cd lib/Plack/Middleware
5. git diff d095870 Log4perl.pm

I see that both master and branch has same resulting changes:
@@ -36,10 +35,10 @@ __END__
 
 =head1 NAME
 
-Plack::Middleware::Log4perl - Uses Log::Log4perl to configure logger
+Plack::Middleware::Log4perl - Uses Log::Log4perl to configure psgix.logger
 
 =head1 SYNOPSIS
-
+  # How to use logger in your app
   my $app = sub {
       my $env =  shift;
 
@@ -53,18 +52,25 @@ Plack::Middleware::Log4perl - Uses Log::Log4perl to configure logger

But this part of code were edited in both branches too:

The branch were started at this commit: 0a5ff8427

6. git diff 0a5ff8427

@@ -35,14 +35,28 @@ __END__
 
 =head1 NAME
 
-Plack::Middleware::Log4perl - Uses Log::Log4perl to configure logger
+Plack::Middleware::Log4perl - Uses Log::Log4perl to configure psgix.logger
 
 =head1 SYNOPSIS
+  # How to use logger in your app
+  my $app = sub {
+      my $env =  shift;
 
-  use Log::Log4perl;
+      $env->{'psgix.logger'}({ level => 'error', message => 'Hi' });
+
+      return [
+          '200',
+          [ 'Content-Type' => 'text/plain' ],
+          [ "Hello World" ],
+      ];
+  };

7. git checkout master 
8. git diff 0a5ff8427

@@ -39,28 +40,41 @@ Plack::Middleware::Log4perl - Uses Log::Log4perl to configure logger
 
 =head1 SYNOPSIS
 
-  use Log::Log4perl;
+  my $app = sub {
+      my $env =  shift;
+
+      $env->{'psgix.logger'}({ level => 'error', message => 'Hi' });
+
+      return [
+          '200',
+          [ 'Content-Type' => 'text/plain' ],
+          [ "Hello World" ],
+      ];
+  };
+

I repeat for emphasis. In the resulting file we have same code and not expect conflict.

At this point I have same changes on master and branch.
master head is d095870
branch head is a3db36a
fork point is 0a5ff84

Comparing step-by-step 
(A)   git diff 0a5ff84..d095870
(B)   git diff 0a5ff84..a3db36a
Find patches which apply to same lines
 =head1 SYNOPSIS
 
-  use Log::Log4perl;
+  my $app = sub {
+      my $env =  shift;
+
+      $env->{'psgix.logger'}({ level => 'error', message => 'Hi' });
+
+      return [
+          '200',
+          [ 'Content-Type' => 'text/plain' ],
+          [ "Hello World" ],
+      ];
+  };
+

 =head1 SYNOPSIS
+  # How to use logger in your app
+  my $app = sub {
+      my $env =  shift;
 
-  use Log::Log4perl;
+      $env->{'psgix.logger'}({ level => 'error', message => 'Hi' });
+
+      return [
+          '200',
+          [ 'Content-Type' => 'text/plain' ],
+          [ "Hello World" ],
+      ];
+  };

And check with 
(C)  git diff a3db36a..d095870
 =head1 SYNOPSIS
-  # How to use logger in your app
+
   my $app = sub {
       my $env =  shift;
 
(D) So this merge conflict (the result of `git checkout master; git merge feature/doc_contribution`)
@@@ -36,13 -35,13 +36,19 @@@ __END_
  
  =head1 NAME
  
- Plack::Middleware::Log4perl - Uses Log::Log4perl to configure logger
+ Plack::Middleware::Log4perl - Uses Log::Log4perl to configure psgix.logger
  
  =head1 SYNOPSIS
+   # How to use logger in your app
+   my $app = sub {
+       my $env =  shift;
  
++<<<<<<< HEAD
 +  my $app = sub {
 +      my $env =  shift;
 +
++=======
++>>>>>>> feature/doc_contribution
        $env->{'psgix.logger'}({ level => 'error', message => 'Hi' });
  
        return [

can be simplified to:

@@@ -36,13 -35,13 +36,19 @@@ __END_
  
  =head1 NAME
  
- Plack::Middleware::Log4perl - Uses Log::Log4perl to configure logger
+ Plack::Middleware::Log4perl - Uses Log::Log4perl to configure psgix.logger
  
  =head1 SYNOPSIS
+   # How to use logger in your app
    my $app = sub {
        my $env =  shift;
  

NEXT
Next merge conflict seems this:
(A)
+  };
+
 
+  # Use your own Log4perl configuration
+  use Log::Log4perl;
   Log::Log4perl::init('/path/to/log4perl.conf');

(B)
+  };
 
+
+  # Initialization. Case#1
+  use Log::Log4perl;
   Log::Log4perl::init('/path/to/log4perl.conf');

Comparing to (C)
@@ -53,18 +52,25 @@
   };
 
 
-  # Use your own Log4perl configuration
+  # Initialization. Case#1
   use Log::Log4perl;
   Log::Log4perl::init('/path/to/log4perl.conf');

So current merge conflict (D) 
@@@ -51,20 -50,27 +57,33 @@@
            [ "Hello World" ],
        ];
    };
++<<<<<<< HEAD
 +
 +
 +  # Use your own Log4perl configuration
++=======
+ 
+ 
+   # Initialization. Case#1
++>>>>>>> feature/doc_contribution
    use Log::Log4perl;
    Log::Log4perl::init('/path/to/log4perl.conf');

Can be simplified to: (E) 
@@@ -51,20 -50,27 +57,33 @@@
            [ "Hello World" ],
        ];
    };


++<<<<<<< HEAD
 +  # Use your own Log4perl configuration
++=======
+   # Initialization. Case#1
++>>>>>>> feature/doc_contribution
    use Log::Log4perl;
    Log::Log4perl::init('/path/to/log4perl.conf');

NOTICE: in (C) only two lines are different.

NEXT
(A)
-  # Or let middleware to configure log4perl
-  enable "Log4perl", category => "plack", conf => '/path/to/log.conf';
+  # Configure with Log4perl middleware options
+  builder {
+      enable "Log4perl", category => "plack", conf => '/path/to/log4perl.conf';
+      $app;
+  }

(B)
-  # Or let middleware to configure log4perl
-  enable "Log4perl", category => "plack", conf => '/path/to/log.conf';
+
+  # Initialization. Case#2
+  # Let middleware to configure log4perl
+  builder {
+      enable "Log4perl", category => "plack", conf => '/path/to/log4perl.conf';
+      $app;
+  }

(C)


-  # Configure with Log4perl middleware options
+  # Initialization. Case#2
+  # Let middleware to configure log4perl
   builder {
       enable "Log4perl", category => "plack", conf => '/path/to/log4perl.conf';
       $app;


(D)
  
++<<<<<<< HEAD
 +  # Configure with Log4perl middleware options
++=======
+ 
+   # Initialization. Case#2
+   # Let middleware to configure log4perl
++>>>>>>> feature/doc_contribution
    builder {
        enable "Log4perl", category => "plack", conf => '/path/to/log4perl.conf';
        $app;

->(E) Notice, that in (C) one line is deleted and two added
++<<<<<<< HEAD
 +  # Configure with Log4perl middleware options
++=======
+   # Initialization. Case#2
+   # Let middleware to configure log4perl
++>>>>>>> feature/doc_contribution
    builder {
        enable "Log4perl", category => "plack", conf => '/path/to/log4perl.conf';
        $app;


NEXT
(A)
 =head1 DESCRIPTION
 
 Log4perl is a L<Plack::Middleware> component that allows you to use
-L<Log::Log4perl> to configure the logging object, C<psgix.logger>.
+L<Log::Log4perl> to configure the logging object C<psgix.logger> for a
+given category.
 
 =head1 CONFIGURATION

(B)
 =head1 DESCRIPTION
 
-Log4perl is a L<Plack::Middleware> component that allows you to use
-L<Log::Log4perl> to configure the logging object, C<psgix.logger>.
+Log4perl is a L<Plack::Middleware> component that initialize the logging object
+C<psgix.logger> by L<Log::Log4perl> logger with giving C<category>.
 
 =head1 CONFIGURATION

(C)
@@ -72,9 +78,8 @@
 
 =head1 DESCRIPTION
 
-Log4perl is a L<Plack::Middleware> component that allows you to use
-L<Log::Log4perl> to configure the logging object C<psgix.logger> for a
-given category.
+Log4perl is a L<Plack::Middleware> component that initialize the logging object
+C<psgix.logger> by L<Log::Log4perl> logger with giving C<category>.
 
 =head1 CONFIGURATION

(D)
@@@ -72,9 -78,8 +91,14 @@@
  
  =head1 DESCRIPTION
  
++<<<<<<< HEAD
 +Log4perl is a L<Plack::Middleware> component that allows you to use
 +L<Log::Log4perl> to configure the logging object C<psgix.logger> for a
 +given category.
++=======
+ Log4perl is a L<Plack::Middleware> component that initialize the logging object
+ C<psgix.logger> by L<Log::Log4perl> logger with giving C<category>.
++>>>>>>> feature/doc_contribution
  
  =head1 CONFIGURATION
  

In this example (E) is same as (D)



Feel free to ask how steps are done if you are not clear with mine explanation.
