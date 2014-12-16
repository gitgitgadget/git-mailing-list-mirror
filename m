From: Kenneth Lorber <keni@his.com>
Subject: bug & patch: exit codes from internal commands are handled incorrectly
Date: Tue, 16 Dec 2014 14:28:15 -0500
Message-ID: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 20:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xsn-0007JV-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaLPTeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Dec 2014 14:34:04 -0500
Received: from smtp-nf-106.his.com ([216.194.251.35]:42688 "EHLO
	smtp-nf-106.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaLPTeB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2014 14:34:01 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Dec 2014 14:34:00 EST
Received: from cuda201.his.com (cuda201.his.com [216.194.248.226])
	by smtp-nf-106.his.com (Postfix) with ESMTPS id 8A3E1609CD
	for <git@vger.kernel.org>; Tue, 16 Dec 2014 14:28:21 -0500 (EST)
X-ASG-Debug-ID: 1418758100-061c414fc11fc20c0001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.248.252]) by cuda201.his.com with ESMTP id itfLmCfSegMGZuY8 for <git@vger.kernel.org>; Tue, 16 Dec 2014 14:28:20 -0500 (EST)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.252
Received: from mail-sterling.his.com (mail-sterling.his.com [216.194.248.141])
	by smtp-nf-202.his.com (Postfix) with ESMTP id B593A600FB
	for <git@vger.kernel.org>; Tue, 16 Dec 2014 14:28:20 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail-sterling.his.com (Postfix) with ESMTP id A33334170001
	for <git@vger.kernel.org>; Tue, 16 Dec 2014 14:28:19 -0500 (EST)
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.141
X-Virus-Scanned: amavisd-new at mail-sterling.his.com
Received: from mail-sterling.his.com ([127.0.0.1])
	by localhost (mail-sterling.his.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfhiF8Go4HE2; Tue, 16 Dec 2014 14:28:16 -0500 (EST)
Received: from polyhymnia.home (pool-71-246-192-220.washdc.fios.verizon.net [71.246.192.220])
	by mail-sterling.his.com (Postfix) with ESMTPSA id 9949E3FF0001;
	Tue, 16 Dec 2014 14:28:16 -0500 (EST)
X-Barracuda-Apparent-Source-IP: 71.246.192.220
X-ASG-Orig-Subj: bug & patch: exit codes from internal commands are handled incorrectly
X-Mailer: Apple Mail (2.1878.6)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.248.252]
X-Barracuda-Start-Time: 1418758100
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
Received-SPF: pass (his.com: domain of keni@his.com designates 216.194.248.141 as permitted sender)
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.12982
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261458>

(Apologies if I=92ve missed anything here - I=92m still climbing the gi=
t learning curve.)

Bug: exit codes from (at least) internal commands are handled incorrect=
ly.
E.g. git-merge-file, docs say:
        The exit value of this program is negative on error, and the nu=
mber of
        conflicts otherwise. If the merge was clean, the exit value is =
0.
But only 8 bits get carried through exit, so 256 conflicts gives exit(0=
), which means the merge was clean.

Issue shows up on:
 git version 1.8.5.2 (Apple Git-48)
 build from source (git version 2.2.0.68.g64396d6.dirty after patch bel=
ow applied)

Reproduce by:

Put the following test program in an empty directory as buggen.pl

TEST PROGRAM START
open OUTB, ">basefile" or die;
print OUTB "this is the base file\n";
close OUTB;

open OUT1, ">bfile1" or die;
open OUT2, ">bfile2" or die;

$c =3D shift;

while($c > 0){
        print OUT1 "a\nb\nc\nd\nchange $c file 1\n";
        print OUT2 "a\nb\nc\nd\nchange $c file 2\n";
        $c--;
}
TEST PROGRAM END

Do these tests:

perl buggen.pl 0
git merge-file -p bfile1 basefile bfile2
echo $status
0

perl buggen.pl 1
git merge-file -p bfile1 basefile bfile2
echo $status
1

perl buggen.pl 256
git merge-file -p bfile1 basefile bfile2
echo $status
0       <=3D=3D=3DOOPS

Proposed patches:
diff --git a/git.c b/git.c
index 82d7a1c..8228a3c 100644
--- a/git.c
+++ b/git.c
@@ -349,6 +349,8 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const
        trace_argv_printf(argv, "trace: built-in: git");

        status =3D p->fn(argc, argv, prefix);
+       if (status > 255)
+               status =3D 255;   /* prevent exit() from truncating to =
0 */
        if (status)
                return status;
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge=
-file.txt
index d2fc12e..76e6a11 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -41,7 +41,8 @@ lines from `<other-file>`, or lines from both respect=
ively.  T
 conflict markers can be given with the `--marker-size` option.

 The exit value of this program is negative on error, and the number of
-conflicts otherwise. If the merge was clean, the exit value is 0.
+conflicts otherwise (but 255 will be reported even if more than 255 co=
nflicts
+exist). If the merge was clean, the exit value is 0.

 'git merge-file' is designed to be a minimal clone of RCS 'merge'; tha=
t is, it
 implements all of RCS 'merge''s functionality which is needed by

Open questions:
1) Is 255 safe for all operating systems?
2) Does this issue affect any other places?

Thanks,
Keni
keni@his.com
