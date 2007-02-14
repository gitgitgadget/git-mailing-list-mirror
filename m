From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: Re: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Wed, 14 Feb 2007 17:03:12 +0100
Message-ID: <1171468992.629.68.camel@ibook.zvpunry.de>
References: <1171289831.629.6.camel@ibook.zvpunry.de>
	 <20070212172848.GC29621@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 17:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMbW-0000hD-Kl
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbXBNQD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbXBNQD1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:03:27 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:57090 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbXBNQD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:03:27 -0500
In-Reply-To: <20070212172848.GC29621@spearce.org>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39662>

Am Montag, den 12.02.2007, 12:28 -0500 schrieb Shawn O. Pearce:
... 
> bzip2 and compress are popular formats applied to tars.
yes, and this should be supported. There is an simple example in the
Archive::Tar manpage.

So something like "$tar = new Archive::Tar(*I)" is possible to use the
original filehandle but I removed this code before reading the whole
manpage.

>  
> > @@ -10,6 +10,10 @@
> >  ##
> >  
> >  use strict;
> > +use Archive::Tar;
> > +use Archive::Tar::File;
> > +use Archive::Tar::Constant;
> > +
> 
> I did not apply this hunk.  Not everyone has Archive::Tar installed.
And Archive::Tar is a little bit slower then your unpack() and it reads
the whole file into memory which is not so good.

> But then again, not everyone will use this example program either.
I have used it to play a bit with this nice fast-import stuff.

> I'm debating it.  Archive::Tar's parser will certainly be much
> more robust than the one I hand-crafted.  It might also let us deal
> with symlinks.  ;)
Maybe, but I haven't tested it with some bigger tar files.

> I would considering applying something like this if it would also
> support at least bz2.  This is an example program meant to teach
> people how to use fast-import, and maybe also to help someone who
> wants to quickly import one or more .tar.gz for use with git-grep.
> Requiring Archive::Tar here is not the end of Git as we know it. :)
I think we should stay with your unpack() version, it works, is faster
and doesn't read the whole file into memory.

In the Archive::Tar manpage they use gunzip and uncompress instead of
zcat or gzcat, so what do you think about the following patch?

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 990c9e7..5585a8b 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -25,11 +25,14 @@ foreach my $tar_file (@ARGV)
 	my $tar_name = $1;
 
 	if ($tar_name =~ s/\.(tar\.gz|tgz)$//) {
-		open(I, '-|', 'gzcat', $tar_file) or die "Unable to gzcat $tar_file: $!\n";
+		open(I, '-|', 'gunzip', '-c', $tar_file)
+			or die "Unable to gunzip -c $tar_file: $!\n";
 	} elsif ($tar_name =~ s/\.(tar\.bz2|tbz2)$//) {
-		open(I, '-|', 'bzcat', $tar_file) or die "Unable to bzcat $tar_file: $!\n";
+		open(I, '-|', 'bunzip2', '-c', $tar_file)
+			or die "Unable to bunzip2 -c $tar_file: $!\n";
 	} elsif ($tar_name =~ s/\.tar\.Z$//) {
-		open(I, '-|', 'zcat', $tar_file) or die "Unable to zcat $tar_file: $!\n";
+		open(I, '-|', 'uncompress', '-c', $tar_file)
+			or die "Unable to uncompress -c $tar_file: $!\n";
 	} elsif ($tar_name =~ s/\.tar$//) {
 		open(I, $tar_file) or die "Unable to open $tar_file: $!\n";
 	} else {


... the $git_mode patch ...
> 
> This hunk is completely unrelated to the Archive::Tar rewrite.
Yes, I had this change first in another patch but i forgot to mail it to
the list.

...
> I've applied this hunk (and only this hunk) to my fastimport tree
> and pushed it out.
Good, I no longer think this Archive::Tar stuff is such a good idea.
