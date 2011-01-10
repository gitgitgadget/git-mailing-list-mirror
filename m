From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Mon, 10 Jan 2011 02:33:17 -0500
Message-ID: <4D2AB63D.7040803@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Martin Langhoff <martin@laptop.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 08:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcCGR-00089Y-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 08:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab1AJHd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 02:33:58 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:52842 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1AJHd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 02:33:57 -0500
Received: from [173.79.59.45] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.63)
	(envelope-from <guyr@burntmail.com>)
	id 1PcCFl-0008TO-3q; Mon, 10 Jan 2011 01:33:21 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D119015.6020207@burntmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164867>

On 12/22/2010 12:43 AM, Guy Rouillier wrote:
>
> Emil and Jonathan, thanks for the feedback. Perl is not my strong point,
> but I'll take a crack at it over the upcoming holidays. I'm inclined not
> to get too fancy and try to second-guess the user's environment. Perhaps
> he has both cvs and cvsnt installed for some reason (testing one, using
> the other for regular work); perhaps a tool installed one or the other
> and he doesn't even know he has them both. Etc.
>
> So, at most I can see, as Emil suggested, seeing if the entry exists in
> both files and is the same in both. If so, or if the entry is only in
> one of them, then just use the entry. However, if the entry is in both
> files and is different, I'd prefer to just exit with an error and have
> the user clarify his environment.

Here is my patch for accomplishing the above.  As this is my first time
submitting a patch, please let me know the correct procedure if
submitting a diff here is not appropriate.  Thanks.

--- git-cvsimport.org	2011-01-09 03:52:39.000000000 -0500
+++ git-cvsimport.cvsnt	2011-01-10 01:42:29.000000000 -0500
@@ -260,6 +260,8 @@
  		if ($pass) {
  			$pass = $self->_scramble($pass);
  		} else {
+			# First try the original CVS location.
+
  			open(H,$ENV{'HOME'}."/.cvspass") and do {
  				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
  				while (<H>) {
@@ -272,7 +274,30 @@
  					}
  				}
  			};
-			$pass = "A" unless $pass;
+
+			# Now try the CVSNT location.
+
+			open(H,$ENV{'HOME'}."/.cvs/cvspass") and do {
+				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+				while (<H>) {
+					chomp;
+					s/^\/\d+\s+//;
+					my ($w,$p) = split(/=/,$_,2);
+					if ($w eq $rr or $w eq $rr2) {
+						my $cvsntpass = $p;
+
+						if (!$pass) {
+							$pass = $cvsntpass;
+						} elsif ($pass ne $cvsntpass) {
+							die("CVSROOT found in both CVS and CVSNT cvspass files, passwords do not match\n");
+						}
+						last;
+					}
+				}
+			};
+
+
+			die("Password not found for CVSROOT: $opt_d\n") unless $pass;
  		}

  		my ($s, $rep);



-- 
Guy Rouillier
