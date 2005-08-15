From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Mergeback patch - (was: Switching heads and head vs branch after CVS import)
Date: Tue, 16 Aug 2005 08:50:04 +1200
Message-ID: <46a038f90508151350675527e7@mail.gmail.com>
References: <20050815204511.B6D793300AD@ng.eduforge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 15 22:51:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4luL-00066n-VE
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVHOUuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVHOUuG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 16:50:06 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:20337 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964955AbVHOUuF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 16:50:05 -0400
Received: by rproxy.gmail.com with SMTP id i8so844249rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 13:50:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DD/R+KEgLxSHuNvvVAXwzsy90J00kC0E+5r26KZLz+EG5Sscq47YkbOkT6kLMFKewXsJSzcCTO71U1VVC0PbOXRKoW6Yc5xB1TODFnGxaznWzL8RXr52h7XObDOTUmvspR0Mp60CYZ9EnsJTU4xf/C/Iwbvw/gvgM2nVvCw4ENc=
Received: by 10.38.181.31 with SMTP id d31mr1864606rnf;
        Mon, 15 Aug 2005 13:50:04 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 13:50:04 -0700 (PDT)
To: GIT <git@vger.kernel.org>
In-Reply-To: <20050815204511.B6D793300AD@ng.eduforge.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just a work-in-progress sample. I've done a pretty successful import
of a small tree with this patch. It is showing the merges /almost/ in
the right place. The almost is due to bad cvs practices, and not this
code.

Definitely doable, though it'll never be "nice" -- CVS doesn't have
the right data for this. I want to make the regexes configurable, and
have a more decent way of extracting the parent sha. B

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -542,6 +542,24 @@ my $commit = sub {

                my @par = ();
                @par = ("-p",$parent) if $parent;
+
+               # detect additional branches
+               my @rx = ( qr/Merged from (\w+)/i , qr/merge of (\w+)/i );
+               foreach my $rx (@rx) {
+                   if ($logmsg =~ $rx) {
+                       my $parent = $1;
+                       if ($parent eq 'HEAD') { $parent = 'origin'};
+                       if ( -e "$git_dir/refs/heads/$parent") {
+                           warn "grabbing $parent";
+                           $parent = `cat $git_dir/refs/heads/$parent`;
+                           chomp $parent;
+                           warn "grabbed $parent";
+                           push @par, '-p', $parent;
+                       }
+                   }
+               }
+               # %seen_branches
+
                exec("env",
                        "GIT_AUTHOR_NAME=$author",
                        "GIT_AUTHOR_EMAIL=$author",
