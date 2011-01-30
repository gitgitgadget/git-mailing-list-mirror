From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 30 Jan 2011 01:33:57 -0500
Message-ID: <4D450655.5090501@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Martin Langhoff <martin@laptop.org>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 07:34:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjQs0-00086V-9G
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 07:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab1A3Gej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 01:34:39 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:47325 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab1A3Gej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 01:34:39 -0500
Received: from [108.18.101.164] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.63)
	(envelope-from <guyr@burntmail.com>)
	id 1PjQrG-00042f-RL; Sun, 30 Jan 2011 00:33:58 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7v8vynnokt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165679>

Sorry for the delay in following up, work has been busy.

On 1/14/2011 4:49 PM, Junio C Hamano wrote:
> As the general principle, in a "we see two, and we cannot tell which one
> the user wants to use" situation like this, I tend to prefer erroring out
> to _force_ the user to fix the configuration once and for all.

That was my original inclination.  As no other opinions have been posted 
since your message, here is my amended patch, incorporating Martin's 
ideas and dieing if the script finds both CVS and CVSNT password files.
I don't know why diff got tripped up on brace indentation; I used only
tabs and everything looks fine in vi.

--- git-cvsimport.org   2011-01-09 03:52:39.000000000 -0500
+++ git-cvsimport.perl  2011-01-30 00:59:29.000000000 -0500
@@ -260,19 +260,27 @@
                if ($pass) {
                        $pass = $self->_scramble($pass);
                } else {
-                       open(H,$ENV{'HOME'}."/.cvspass") and do {
+                       my @cvspasslocations = ($ENV{'HOME'}."/.cvspass", $ENV{'HOME'}."/.cvs/cvspass");
+                       my $filecount = 0;
+                       foreach my $cvspass (@cvspasslocations) {
+
+                               open(H, $cvspass) and do {
                                # :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+                                       $filecount++;
                                while (<H>) {
                                        chomp;
                                        s/^\/\d+\s+//;
-                                       my ($w,$p) = split(/\s/,$_,2);
+                                               my ($w,$p) = split(/[\s=]/,$_,2);
                                        if ($w eq $rr or $w eq $rr2) {
                                                $pass = $p;
                                                last;
                                        }
                                }
                        };
-                       $pass = "A" unless $pass;
+                       }
+                       
+                       die("Two CVS password files found: @cvspasslocations, please remove one") if $filecount > 1;
+                       die("Password not found for CVSROOT: $opt_d\n") unless $pass;
                }

                my ($s, $rep);


-- 
Guy Rouillier
