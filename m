From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 18 Feb 2011 01:26:30 -0500
Message-ID: <4D5E1116.7040501@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 07:27:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqJoJ-0003xy-4r
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 07:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab1BRG1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 01:27:18 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:56277 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab1BRG1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 01:27:17 -0500
Received: from [173.79.61.50] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1PqJnR-0000zi-N6; Fri, 18 Feb 2011 00:26:29 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vhbcb35xk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167178>

On 2/10/2011 5:01 PM, Junio C Hamano wrote:
> Martin Langhoff <martin@laptop.org> writes:
> 
>> On Sat, Jan 29, 2011 at 11:33 PM, Guy Rouillier<guyr@burntmail.com>  wrote:
>>> That was my original inclination.  As no other opinions have been posted
>>> since your message, here is my amended patch, incorporating Martin's
>>> ideas and dieing if the script finds both CVS and CVSNT password files.
>>
>> ACK! Thanks!
> 
> Can somebody resubmit an appliable patch with a proper commit message that
> describes the problem and the solution please.
> 
> Thanks.

Junio, sorry for the delay in response.  I'm new to all this and I thought 
perhaps one of the listed committers had to submit the official patch.  
Perhaps they do.  I followed the directions in SubmittingPatches.  The result 
is below.  Please let me know if I need to do something differently.  I 
didn't simply send the result of format-match because that would have started 
a different message thread.  Thanks.

>From d3ae7d304ee2b89740225b0433bf7d7e07248f59 Mon Sep 17 00:00:00 2001
From: Guy Rouillier <guyr@burntmail.com>
Date: Fri, 18 Feb 2011 00:53:10 -0500
Subject: [PATCH] Look for password in both CVS and CVSNT password files.

The existing code looks for the CVS reposity password only in
the CVS password file in HOME/.cvspass. Accommodate the CVS
alternative CVSNT by also looking in HOME/.cvs/cvspass.  Die
if both files are found, and ask the user to remove one.

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
1.7.3.4



-- 
Guy Rouillier
