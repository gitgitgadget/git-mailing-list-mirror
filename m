From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH] Fix git-archimport on empty summary
Date: Wed, 28 Feb 2007 21:02:02 +0100
Message-ID: <45E5DFBA.9070400@lu.unisi.ch>
References: <es39f9$sqh$1@sea.gmane.org> <7vd53u13p3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070704050707090400080900"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 21:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMV0i-0008I3-6G
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 21:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXB1UCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 15:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXB1UCL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 15:02:11 -0500
Received: from server.usilu.net ([195.176.178.200]:49855 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751889AbXB1UCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 15:02:10 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 21:02:08 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <7vd53u13p3.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 28 Feb 2007 20:02:08.0457 (UTC) FILETIME=[538E9B90:01C75B73]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41003>

This is a multi-part message in MIME format.
--------------070704050707090400080900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> I would have liked a proposed commit message that is more in
> line with the rest of the git.git history.

Oops, sorry.  I guess that shows where I come from, and I hope that the 
attached one is better.

> However, I see that the result is used this way:
> 
>     my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
>         or die $!;
>     print WRITER $ps->{summary},"\n";
>     print WRITER $ps->{message},"\n";
> 
> What's the arch way of formatting log messages?  Are summary
> lines expected to be multi-line?

No, but the message is formatted as RFC-822, and I can guess Martin was 
just being defensive.  I've never seen a multi-line summary, but I fully 
agree with you that it's better to get the whole summary on the first line.

Patch attached, tested using the same arch import as before.

Thanks,

Paolo

--------------070704050707090400080900
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="git-archimport-empty-summary.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-archimport-empty-summary.patch"

git-archimport: support empty summaries, put summary on a single line.

Don't fail if the summary line in an arch commit is empty.  In this case,
try to use the first line in the commit message followed by an ellipsis.
In addition, if the summary is multi-line, it is joined on a single line.


diff --git a/git-archimport.perl b/git-archimport.perl
index 66aaeae..0fcb156 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -553,7 +553,7 @@ foreach my $ps (@psets) {
 
     my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par) 
         or die $!;
-    print WRITER $ps->{summary},"\n";
+    print WRITER $ps->{summary},"\n\n";
     print WRITER $ps->{message},"\n";
     
     # make it easy to backtrack and figure out which Arch revision this was:
@@ -755,7 +755,8 @@ sub parselog {
             $ps->{tag} = $1;
             $key = undef;
         } elsif (/^Summary:\s*(.*)$/ ) {
-            # summary can be multiline as long as it has a leading space
+            # summary can be multiline as long as it has a leading space.
+	    # we squeeze it onto a single line, though.
             $ps->{summary} = [ $1 ];
             $key = 'summary';
         } elsif (/^Creator: (.*)\s*<([^\>]+)>/) {
@@ -787,8 +788,18 @@ sub parselog {
         }
     }
    
-    # post-processing:
-    $ps->{summary} = join("\n",@{$ps->{summary}})."\n";
+    # drop leading empty lines from the log message
+    while (@$log && $log->[0] eq '') {
+	shift @$log;
+    }
+    if (exists $ps->{summary} && @{$ps->{summary}}) {
+	$ps->{summary} = join(' ', @{$ps->{summary}});
+    }
+    elsif (@$log == 0) {
+	$ps->{summary} = 'empty commit message';
+    } else {
+	$ps->{summary} = $log->[0] . '...';
+    }
     $ps->{message} = join("\n",@$log);
     
     # skip Arch control files, unescape pika-escaped files

--------------070704050707090400080900--
