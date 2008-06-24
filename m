From: "Adam Brewster" <adam@adambrewster.com>
Subject: [PATCH/RFC] Created git-basis and modified git-bundle to accept --stdin.
Date: Mon, 23 Jun 2008 22:21:44 -0400
Message-ID: <c376da900806231921y2d822been9cd573d509fbf78a@mail.gmail.com>
References: <1214273297-8257-1-git-send-email-adambrewster@gmail.com>
	 <1214273297-8257-2-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 04:22:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAyBB-0007hK-5q
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbYFXCVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYFXCVt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:21:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:14521 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbYFXCVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:21:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so7385599rvb.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=IIdyK5I92e+noqBgVNTAVpZeECQ0nGYVHxYinyyX7fg=;
        b=cBpmD2T1mLSVuKbWUR9/iJTZnalogu/dzrjtjeUZJrLJnUWEzyYo3NacJ/nnN3CDCt
         JptA9Fo1j1nkO/2q2zSQ70hgHv5gc7vBPQ5ctDYMyDaSd5be/ujpuBXE8dkCrNa7gVlh
         +O5G6dvWgpYHsKW7YeND5fMZwgImZOErM1BaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=sr7YHtklHG0g3u4h6xKFyftWa0y8W6h7irlW04n9PPGYOWFDGzIP9BX+wZYA3+S9ij
         RB3ecyHNoxJDV7eZPiYLl2Xkew5nYjNnDcUy15lgv0Tbwl1jxQe2OO3r9xGconwIF9h/
         xnAFJbAxHBAnbUlprtMbcDTIDr+exqliXYIKc=
Received: by 10.141.62.15 with SMTP id p15mr13827190rvk.144.1214274104944;
        Mon, 23 Jun 2008 19:21:44 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Mon, 23 Jun 2008 19:21:44 -0700 (PDT)
In-Reply-To: <1214273297-8257-2-git-send-email-adambrewster@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 628612da64933ba2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85983>

Git-basis is a perl script that remembers bases for use by git-bundle.
Code from rev-parse was borrowed to allow git-bundle to handle --stdin.

Signed-off-by: Adam Brewster <adambrewster@gmail.com>
---
Git-bundle is a great tool to move repositories between computers on
different networks, but in order to create thin packs, it needs to be
given a list of objects that are available on the remote end.  I don't
like any of the options listed in the git-bundle documentation, so I did
this.

Git-basis is a script that maintains lists of objects that exist in
various places.

With this patch, the command:

git-basis my-basis | git-bundle create my-bundle --all --stdin

will prepare a bundle containing everything except that which is a part
of my-basis.

Then you can add the objects in the bundle to the basis, so they won't
get included in the next pack like this:

git-basis --update my-basis < my-bundle

I'm sure that my implementation is crap, but I think this is a useful
idea.  Anybody agree?  Disagree?

 bundle.c  |   22 +++++++++++++++++-
 git-basis |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100755 git-basis

diff --git a/bundle.c b/bundle.c
index 0ba5df1..0af12d7 100644
--- a/bundle.c
+++ b/bundle.c
@@ -227,8 +227,26 @@ int create_bundle(struct bundle_header *header,
const char *path,

       /* write references */
       argc = setup_revisions(argc, argv, &revs, NULL);
-       if (argc > 1)
-               return error("unrecognized argument: %s'", argv[1]);
+
+       for (i = 1; i < argc; i++) {
+               if ( !strcmp(argv[i], "--stdin") ) {
+                       char line[1000];
+                               while (fgets(line, sizeof(line),
stdin) != NULL) {
+                               int len = strlen(line);
+                               if (len && line[len - 1] == '\n')
+                                       line[--len] = 0;
+                               if (!len)
+                                       break;
+                               if (line[0] == '-')
+                                       die("options not supported in
--stdin mode");
+                               if (handle_revision_arg(line, &revs, 0, 1))
+                                       die("bad revision '%s'", line);
+                       }
+                       continue;
+               }
+
+               return error("unrecognized argument: %s'", argv[i]);
+       }

       for (i = 0; i < revs.pending.nr; i++) {
               struct object_array_entry *e = revs.pending.objects + i;
diff --git a/git-basis b/git-basis
new file mode 100755
index 0000000..891635c
--- /dev/null
+++ b/git-basis
@@ -0,0 +1,71 @@
+#!/usr/bin/perl
+
+use strict;
+
+use Git;
+
+my $r = Git->repository();
+my $d = $r->repo_path();
+
+if ( ! -d "$d/bases" ) {
+    system( "mkdir '$d/bases'" );
+}
+
+if ( $#ARGV == -1 ) {
+    print "usage: git-basis [--update] basis1...\n";
+    exit;
+} elsif ( $ARGV[0] eq '--update' ) {
+    shift @ARGV;
+
+    my %new = ();
+    while (<STDIN>) {
+       if (!/^^?([a-z0-9]{40})/) {next;}
+       $new{$1} = 1;
+    }
+
+    foreach my $f (@ARGV) {
+       my %these = ();
+       open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";
+       while (<F>) {
+           if (!/^([a-z0-9]{40})/) {next;}
+           $these{$1} = 1;
+       }
+       close F;
+       open F, ">>$d/bases/$f" || die "Can't open bases/$f: $!";
+       print F "\#" . `date`;
+       foreach my $b (keys %new) {
+           if (exists($these{$b})) {next;}
+           print F "$b\n";
+       }
+       close F;
+    }
+} else {
+    my $n = 0;
+    my %basis = ();
+
+    my $f = shift @ARGV;
+    open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";
+    while (<F>) {
+       if (!/^([a-z0-9]{40})/) {next;}
+       $basis{$1} = $n;
+    }
+    close F;
+
+    foreach $f (@ARGV) {
+       open F, "<$d/bases/$f" || die "Can't open bases/$f: $!";
+       while (<F>) {
+           if (!/^([a-z0-9]{40})/) {next;}
+           if (!exists($basis{$1})) {next;}
+
+           if ($basis{$1} == $n) {$basis{$1}++;}
+           else {delete $basis{$1};}
+       }
+       close F;
+       $n++;
+    }
+
+    foreach my $b (keys %basis) {
+       if ( $basis{$b} != $n ) {next;}
+       print "^$b\n";
+    }
+}
--
1.5.5.1.211.g65ea3.dirty
