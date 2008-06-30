From: "Adam Brewster" <adambrewster@gmail.com>
Subject: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Mon, 30 Jun 2008 18:49:25 -0400
Message-ID: <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Adam Brewster" <adambrewster@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSCf-0006vx-C2
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbYF3Wtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbYF3Wtd
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:49:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:48116 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbYF3Wtb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:49:31 -0400
Received: by yw-out-2324.google.com with SMTP id 9so867498ywe.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Q/VssMzqhef66CL/VvRE92fOyWRF8LmO7cGeBZeJjnE=;
        b=a3ivGYZZBGd9de/ux2cAz4ada0fZF2gS2Zm+kyAodBWPJ9z9DNfjC1EsBsn+Uz62oz
         Rdl/S1SlklPU4EMAuQHsE1iQBOx4XopMaikuOD/DlQIwxUBlXElSvYZCORis3FObvZQc
         HwDkoEh4BAM+LOczdJzR8/qfsSW9BX5bD6BRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dtQZgWjErKj7vvpuH8LGTNjEiCzjXHt0t89+OzIde2QF86G5ZDAMiECK9JvNjLh007
         Fjfe712Ccu/4WGxV3NPLPw16CJHXeNvtOP0C2VmWjYkdfqdGGp9HANxzxryhGBzO4Z9I
         B7U32shAuzz7q7wd5VxXTIz/3m+WqXgfLYwAE=
Received: by 10.150.139.15 with SMTP id m15mr9259322ybd.132.1214866165327;
        Mon, 30 Jun 2008 15:49:25 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Mon, 30 Jun 2008 15:49:25 -0700 (PDT)
In-Reply-To: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86956>

Git-basis is a perl script that remembers bases for use by git-bundle.
Code from rev-parse was borrowed to allow git-bundle to handle --stdin.

Signed-off-by: Adam Brewster <adambrewster@gmail.com>
---
As promised, here's another patch with documentation.  The code is
identical to the previous version.

I know this is a minor patch, but I think the result is a more usable
git-bundle feature, and I'd like to see it included in future releases
if there are no objections.

 Documentation/git-basis.txt |   82 +++++++++++++++++++++++++++++++++++++++++++
 bundle.c                    |   22 ++++++++++-
 git-basis                   |   71 +++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/git-basis.txt
 create mode 100755 git-basis

diff --git a/Documentation/git-basis.txt b/Documentation/git-basis.txt
new file mode 100644
index 0000000..3624890
--- /dev/null
+++ b/Documentation/git-basis.txt
@@ -0,0 +1,82 @@
+git-basis(1)
+============
+
+NAME
+----
+git-basis - Track sets of references available on remote systems (bases)
+
+SYNOPSIS
+--------
+[verse]
+'git-basis' <basis> [<basis>...]
+'git-basis' --update <basis> [<basis>...] < <object list or bundle>
+
+DESCRIPTION
+-----------
+Maintains lists of objects that are known to be accessible on remote
+computer systems that are not accessible by network.
+
+OPTIONS
+-------
+
+basis::
+       List of bases to operate on.  Any valid filename can be
+       the name of a basis.  Bases that do not exist are taken
+       to be empty.
+
+--update::
+       Tells git-basis to read a list of objects from stdin and
+       add them to each of the given bases.  git-basis produces
+       no output when this option is given.  Bases will be created
+       if necessary.
+
+object list or bundle::
+       Git-basis --update reads object names, one per line from stdin.
+       Leading caret ("^") characters are ignored, as is anything
+       after the object name.  Lines that don't begin with an object
+       name are ignored.  The output of linkgit:git-ls-remote[1] or a
+       bundle created by linkgit:git-bundle[1] are both suitable input.
+
+DISCUSSION
+----------
+git-basis is probably only useful with linkgit:git-bundle[1].
+
+To create a bundle that excludes all objects that are part of my-basis,
+use
+
+git-basis my-basis | git-bundle create my-bundle --all --stdin
+
+To add the objects in my-bundle to my-basis, use
+
+git-basis --update my-basis < my-bundle
+
+DETAILS
+-------
+Bases are stored as plain text files under .git/bases/.  One object
+entry per line.
+
+git-basis without --update reads all of the basis names given on the
+command line, and outputs the intersection of them to stdout, with each
+object prefixed by "^".
+
+git-basis --update reads object names from stdin, and adds all of the
+references to each of the bases listed.  Duplicate references will not
+be listed twice, but otherwise redundant information will be included.
+
+BUGS
+----
+Likely.
+
+Bug reports are welcome, and patches are encouraged.
+
+SEE ALSO
+--------
+linkgit:git-bundle[1]
+
+AUTHOR
+------
+Written by Adam Brewster <asb@bu.edu>
+
+GIT
+---
+Part of the linkgit:git[1] suite
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
