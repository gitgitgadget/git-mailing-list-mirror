From: "Cameron McBride" <cameron.mcbride@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Thu, 25 May 2006 23:11:55 -0400
Message-ID: <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
	 <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 26 05:12:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjSkI-0006LW-1f
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWEZDL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWEZDL4
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:11:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:24354 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030214AbWEZDL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:11:56 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1956906wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:11:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VysrmAFGbmjSdHWz48EEwmhKN1xeWmPxUUgehFkaqTpJOQX4fuZIm8IxMZW64q8NwwB8k4p/BRNG+pubCa8d8WSqWH7lOMByk3+3EuedwdZa1dJej/kNTXF1tL9Xe1SJvvqIIcrKpyxU2sObNN76OGY3z8Gmb3YQVx3th+qR4HY=
Received: by 10.64.24.20 with SMTP id 20mr1325501qbx;
        Thu, 25 May 2006 20:11:55 -0700 (PDT)
Received: by 10.65.53.4 with HTTP; Thu, 25 May 2006 20:11:55 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
In-Reply-To: <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20783>

On 5/25/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 5/26/06, Cameron McBride <cameron.mcbride@gmail.com> wrote:

> There's been some recent changes to cvsserver -- so version info is
> crucial. What git version are you using? Can you try with the lastest
> #master head from Junio? That's the latest and greatest...

sorry, my bad. This error was discovered using the git stable, v1.3.3.
 Grabbing the latest at git://git.kernel.org/pub/scm/git/git.git
showed the same problem.

> If that doesn't fix it, can you post the logs? I think you have to
> declare CVS_LOG=/tmp/cvslog or somesuch.

I'm assuming you mean the log from git-cvsserver (set via git/config
with logfile=...)

Besides the log cutoff in the broken attempt, it appears the culprit
is a lack of arguments being passed down as that is the only
difference in the logs.  Specifically, the working versions output
'Arguments : (something) ' which seemed to come from the
req_Argument()
subroutine around line 550 (in the case of newer CVS, the output is '--').

Anyhow, the error seems to be that $state->{args} is not getting
initialized.  In the newer version, there seemed to be additional
uninitialized variables, e.g. $state->{prependdir}.  These might be
signs of some larger problem (where the $state isn't getting set
properly).

To quiet it down and get it to run - a crude hack seemed to work
(included below).  I didn't test any of this much, nor do I really
understand the whole of what's going on - my alterations just seemed
to allow 'cvs up' to complete without errors or warnings from both
clients.  Not a very robust criteria, so please review.

Cameron

--
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5ccca4f..a52e838 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1702,6 +1702,7 @@ sub argsfromdir
 {
     my $updater = shift;

+    $state->{args} = [] unless defined($state->{args});
     $state->{args} = [] if ( scalar(@{$state->{args}}) == 1 and
$state->{args}[0] eq "." );

     return if ( scalar ( @{$state->{args}} ) > 1 );
@@ -1729,7 +1730,11 @@ sub argsfromdir
         foreach my $file ( @{$updater->gethead} )
         {
             next if ( $file->{filehash} eq "deleted" and not defined
( $state->{entries}{$file->{name}} ) );
-            next unless ( $file->{name} =~ s/^$state->{prependdir}// );
+            if( defined($state->{prependdir} ) )
+            {
+                $file->{name} =~ s/^$state->{prependdir}//;
+            }
+            next unless ( $file->{name} );
             push @{$state->{args}}, $file->{name};
         }
     }
@@ -1812,7 +1817,7 @@ sub filenamesplit
     ( $filepart, $dirpart ) = ( $2, $1 ) if ( $filename =~ /(.*)\/(.*)/ );
     $dirpart .= "/";

-    if ( $fixforlocaldir )
+    if ( $fixforlocaldir and defined($state->{prependdir}))
     {
         $dirpart =~ s/^$state->{prependdir}//;
     }
@@ -1832,7 +1837,10 @@ sub filecleanup
     }

     $filename =~ s/^\.\///g;
-    $filename = $state->{prependdir} . $filename;
+    if( defined($state->{prependdir}) )
+    {
+        $filename = $state->{prependdir} . $filename;
+    }
     return $filename;
 }
