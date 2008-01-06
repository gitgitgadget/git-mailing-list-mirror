From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow git-mergetool to handle paths with a leading space
Date: Sun, 06 Jan 2008 03:48:03 -0800
Message-ID: <7v3atb5g5o.fsf@gitster.siamese.dyndns.org>
References: <47809E7E.2090708@dawes.za.net>
	<7vodbz5ka9.fsf@gitster.siamese.dyndns.org>
	<4780B2BD.6020109@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <rogan@dawes.za.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 12:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBTzj-00029E-5O
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 12:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbYAFLsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 06:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbYAFLsT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 06:48:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbYAFLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 06:48:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D92449906;
	Sun,  6 Jan 2008 06:48:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B156C9905;
	Sun,  6 Jan 2008 06:48:10 -0500 (EST)
In-Reply-To: <4780B2BD.6020109@dawes.za.net> (Rogan Dawes's message of "Sun,
	06 Jan 2008 12:51:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69730>

Rogan Dawes <rogan@dawes.za.net> writes:

>>> I am working on a project which has the root directory constructed
>>> with a leading space. i.e. ./ dir/. "read" skips the leading space
>>> char, and ends up with an incorrect filename, which can then not be
>>> found. Setting IFS=\n solves this problem.
>>
>> Does the project have a file that has letter 'n' (en) in its name?
>> Have you tested your patch while having a conflict in that file?
>
> Yes, it works correctly.

I am curious and puzzled...

        $ echo 'ann1' | (IFS=\n read i; echo "<$i>")
        <ann1>
        $ echo 'ann1' | (IFS=\n read i j; echo "<$i>")
	<a>
        $ echo 'n1' | (IFS=\n read i j; echo "<$i>")
	<>

Ok, "\n" is a funny way to say IFS does not matter as long as it
is set to a non whitespace letter.

It is VERY misleading as it looks as if the issue is fixed by
setting IFS to a single LF alone (excluding SP and HT from the
usual set), but that is not the patch is doing.  It is setting
it to a single 'n'.

I think you still will lose backslash by using read, but I guess
you would not care about that too much.

If you really cared, you would do something like this, but you
would also need similar surgery in merge_file function itself
that parses text form of ls-files output that tries to verify
and extract paths, which I did not bother to touch in this
demonstration patch.

 git-mergetool.sh |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f31fa2..b7c5098 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -388,17 +388,28 @@ fi
 
 
 if test $# -eq 0 ; then
-	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
-	if test -z "$files" ; then
-		echo "No files need merging"
-		exit 0
-	fi
-	echo Merging the files: $files
-	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u | while read i
-	do
-		printf "\n"
-		merge_file "$i" < /dev/tty > /dev/tty
-	done
+	doit=$(perl -e '
+		$/ = "\0";
+		my (%seen, @file);
+		my $ls_files;
+		open($ls_files, "-|", qw(git ls-files -u -z));
+		while (<$ls_files>) {
+			chomp;
+			s/^[^	]*	//;
+			$seen{$_}++;
+		}
+		@file = sort keys %seen;
+		if (!@file) {
+			print "echo No files need merging\n";
+			print "exit 0\n";
+		}
+		for (@file) {
+			s|'\''|'\''\\'\'''\''|g;
+			print "echo\n";
+			print "merge_file '\''$_'\'' </dev/tty >/dev/tty\n";
+		}
+	')
+	eval "$doit"
 else
 	while test $# -gt 0; do
 		printf "\n"
