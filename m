From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: CVS import [SOLVED]
Date: Tue, 17 Feb 2009 12:19:42 +0100 (CET)
Message-ID: <50713.77.61.241.211.1234869582.squirrel@hupie.xs4all.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
    <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
    <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
    <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ferry Huberts" <ferry.huberts@pelagic.nl>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 12:21:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZO0p-0007Ew-4x
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 12:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbZBQLTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 06:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbZBQLTq
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 06:19:46 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:48309 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751008AbZBQLTq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 06:19:46 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 9ED0C58BDCE; Tue, 17 Feb 2009 12:19:42 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Tue, 17 Feb 2009 12:19:42 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110358>

Ok.

I tested all combinations of autocrlf and safecrlf on an artificial cvs
repository with only a dos text file and a Unix text file. Here are my results.


 autocrlf safecrlf
1 false    false
2 false     warn
3 false     true
4 input    false
5 input     warn
6 input     true
7 true     false
8 true      warn
9 true      true


1- correct import, no warnings
2- correct import, no warnings
3- correct import, no warnings
4- correct import, no warnings
5- correct import, warning on the dos text file
6- correct import, no warnings
7- correct import, no warnings
8- correct import, no warnings
9- fail:

Initialized empty Git repository in /data/home.f9/ferry/testarea/cvsimport/wc.git.true.true/.git/
Running cvsps...
cvs_direct initialized to CVSROOT /data/home.f9/ferry/testarea/cvsimport/cvs
cvs rlog: Logging master
* UNKNOWN LINE * Branches:
Fetching dos.txt   v 1.1
New dos.txt: 25 bytes
Fetching unix.txt   v 1.1
New unix.txt: 22 bytes
fatal: LF would be replaced by CRLF in /tmp/gitcvs.RT1XN8
Use of uninitialized value $sha in scalar chomp at /usr/bin/git-cvsimport line 928.
Use of uninitialized value in concatenation (.) or string at /usr/bin/git-cvsimport line 674, <CVS> line 14.
fatal: malformed index info 100666 	unix.txt
unable to write to git-update-index:  at /usr/bin/git-cvsimport line 679, <CVS> line 14.


So 9 crashes while 6 does not. Apparently the artificial repo with the 2 text files
doesn't give enough coverage: my problem was with 6.

It seems that the import script does not detect a fatal from git. It seems to
me that it does not check the return code because it tries to continue.
Must be here (from line 923):

print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $opt_v;
my $pid = open(my $F, '-|');
die $! unless defined $pid;
if (!$pid) {
	exec("git-hash-object", "-w", $tmpname)
	or die "Cannot create object: $!\n";
}
my $sha = <$F>;
chomp $sha;
close $F;


I think the culprit here is git-hash-object. Either it does return a non-zero
exit code or cvsimport does not see the exit code correctly.
I've traced it in the code to the file convert.c, function
static void check_safe_crlf(const char *path, int action,
                            struct text_stat *stats, enum safe_crlf checksafe)

It does do a 'die' which will exit with code 128, but apparently isn't picked
up by perl. I'm stuck now as I don't know Perl well enough.


Back to the issue:
I think requiring autocrlf = false is too strict. Requiring autocrlf = false
should be enough. That combined with a bit of text in the manual page about
these settings: autocrlf = false is strongly recommended. Also, safecrlf is
required to be set to false.
