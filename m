From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sat, 19 Feb 2011 02:17:43 -0500
Message-ID: <4D5F6E97.4000402@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com> <7voc69p4xu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 08:18:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqh5Y-0001FT-L1
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 08:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1BSHSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 02:18:31 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:59586 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1BSHS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 02:18:29 -0500
Received: from [173.79.61.50] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1Pqh4g-0002B1-KO; Sat, 19 Feb 2011 01:17:50 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7voc69p4xu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167253>

On 2/18/2011 1:34 PM, Junio C Hamano wrote:
> Guy Rouillier <guyr@burntmail.com> writes:
> 
>> ...  I'm new to all this and I thought 
>> perhaps one of the listed committers had to submit the official patch.  
> 
> There is no _listed committers_ ;-)  I was hoping either you as the original
> author of the patch or Martin as the area expert would respond, but as
> long as the result looks correct and explained well, it doesn't matter
> either way.
> 
> Just one hopefully final question.
> 
> After stripping "/<version number><space>" from the beginning of the line
> in order to treat newer .cvspass file format and the original file format
> the same way, the code splits the remainder into two fields (cvsroot and
> lightly-scrambled password).  It used to split only at a whitespace, which
> seems to be in line with the source of CVS 1.12.13 I looked at (it is in
> password_entry_parseline() function, src/login.c).  You new code however
> also allows '=' to be a delimiter to be used for this split.
> 
> Is this change intentional?  If so please explain why it is necessary in
> the commit log message.

Thanks to everyone here for the gracious patience with newcomers.

Yes, the change is intentional.  I've added an additional commit comment to
explain why.

>From 0fdfbdc0dbd0a0280d987640890f7b5ff566d6ef Mon Sep 17 00:00:00 2001
From: Guy Rouillier <guyr@burntmail.com>
Date: Sat, 19 Feb 2011 01:56:15 -0500
Subject: [PATCH] Look for password in both CVS and CVSNT password files.

The existing code looks for the CVS reposity password only in
the CVS password file in HOME/.cvspass. Accommodate the CVS
alternative CVSNT by also looking in HOME/.cvs/cvspass.  Die
if both files are found, and ask the user to remove one.

The two clients use a different delimiter to separate the CVS
repository name from the user password.  The original CVS
client separates the two entries with a space character, while
CVSNT separates them with an equal (=) character.  Hence,
the regular expression used to split these two tokens is
altered to accept either delimiter.

Signed-off-by: Guy Rouillier <guyr@burntmail.com>
---
 git-cvsimport.perl |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8e683e5..76b4765 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -259,19 +259,27 @@ sub conn {
 		if ($pass) {
 			$pass = $self->_scramble($pass);
 		} else {
-			open(H,$ENV{'HOME'}."/.cvspass") and do {
-				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
-				while (<H>) {
-					chomp;
-					s/^\/\d+\s+//;
-					my ($w,$p) = split(/\s/,$_,2);
-					if ($w eq $rr or $w eq $rr2) {
-						$pass = $p;
-						last;
+			my @cvspasslocations = ($ENV{'HOME'}."/.cvspass", $ENV{'HOME'}."/.cvs/cvspass");
+			my $filecount = 0;
+			foreach my $cvspass (@cvspasslocations) {
+
+				open(H, $cvspass) and do {
+					# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+					$filecount++;
+					while (<H>) {
+						chomp;
+						s/^\/\d+\s+//;
+						my ($w,$p) = split(/[\s=]/,$_,2);
+						if ($w eq $rr or $w eq $rr2) {
+							$pass = $p;
+							last;
+						}
 					}
-				}
-			};
-			$pass = "A" unless $pass;
+				};
+			}
+
+			die("Two CVS password files found: @cvspasslocations, please remove one") if $filecount > 1;
+			die("Password not found for CVSROOT: $opt_d\n") unless $pass;
 		}

 		my ($s, $rep);
--
1.7.4.rc1.5.ge17aa

-- 
Guy Rouillier
