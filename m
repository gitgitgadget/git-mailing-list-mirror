X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Fri, 10 Nov 2006 15:59:09 -0300
Message-ID: <46a038f90611101059h1844bae8o9cc9d986eaaddd7b@mail.gmail.com>
References: <45530CEE.6030008@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 10 Nov 2006 18:59:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dopiydOoVo2Aqn5jvcikdkye8mT8zDe0hMFKCSwRIv/2xHbXUPcS1QA3R/i4FVbz97e7yaQwM83bkqXzeij0aWau9r5wfofC8R8NqtUbieM3trI0N8oLNRxn+968UsUO/jbqfoQMjZXGJrTNJmHU4Qsm+ukZoIyzhoTAmFJLvdA=
In-Reply-To: <45530CEE.6030008@b-i-t.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31207>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gibb0-0006zM-RH for gcvg-git@gmane.org; Fri, 10 Nov
 2006 19:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946306AbWKJS7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 10 Nov 2006
 13:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946800AbWKJS7N
 (ORCPT <rfc822;git-outgoing>); Fri, 10 Nov 2006 13:59:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:60091 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1946306AbWKJS7N
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2006 13:59:13 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1436137nfa for
 <git@vger.kernel.org>; Fri, 10 Nov 2006 10:59:11 -0800 (PST)
Received: by 10.48.254.10 with SMTP id b10mr3320364nfi.1163185149974; Fri, 10
 Nov 2006 10:59:09 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Fri, 10 Nov 2006 10:59:09 -0800 (PST)
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org

On 11/9/06, sf <sf@b-i-t.de> wrote:
> I want to access a git repository via git-cvsserver. The problem is that
> the repository contains paths with umlauts. These paths come out quoted
> and escaped when checked out with cvs.

Thanks for the detailed report! I am travelling right now, so with
"high latency" and on a machine that's missing sqlite libs :-/

But I'll give it a go anyway.

Does this mini-patch help? You'll need Perl 5.8.x and probably a
recent SQLite for this.

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 8817f8b..c534de5 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -22,6 +22,9 @@ use Fcntl;
 use File::Temp qw/tempdir tempfile/;
 use File::Basename;

+binmode(STDIN,  ':utf8');
+binmode(STDOUT, ':utf8');
+
 my $log = GITCVS::log->new();
 my $cfg;

@@ -2104,6 +2107,11 @@ sub new
         $self->{tables}{$table} = 1;
     }

+    # this will set the encoding for new DBs
+    # or return false for existing DBs that are not
+    # utf-8
+    $self->{dbh}->do('PRAGMA encoding = "UTF-8"');
+
     # Construct the revision table if required
     unless ( $self->{tables}{revision} )
