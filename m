From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Sun, 2 Dec 2007 15:11:24 +0100
Message-ID: <5B4BC281-10BD-437F-A956-EEB73F40A76C@wincent.com>
References: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org> <1196337638-45972-1-git-send-email-win@wincent.com> <7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 15:12:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IypYF-0007H7-UZ
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 15:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXLBOLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 09:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbXLBOLm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 09:11:42 -0500
Received: from wincent.com ([72.3.236.74]:57777 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbXLBOLl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 09:11:41 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB2EBQe5001218;
	Sun, 2 Dec 2007 08:11:27 -0600
In-Reply-To: <7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66780>

El 1/12/2007, a las 3:36, Junio C Hamano escribi=F3:

> When list_and_choose() function is letting you choose more than one
> items, its prompt becomes ">> ", instead of "> " that is used for a
> singleton choice.  To that prompt, you can say "3-7" (Add these 5 =20
> items
> to the choice), "*" (I want all of them), "-2-4" (exclude 2 and 3 =20
> and 4
> from the set I have chosen so far).  These are also "hidden", and nee=
d
> to be documented, but that would be a separate patch.

I was just about to prepare some documentation for this when I saw =20
that it is already documented, and by none other than you, Junio! (see =
=20
6a5ad23d).

Unless by "documentation" you meant to somehow expose these in the =20
interface at runtime... something like this? (applied on top of the =20
patch I just sent to the list):

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 32fb9ea..e7b07ee 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -237,7 +237,8 @@ sub is_valid_prefix {
  	    !($prefix =3D~ /[\s,]/) && # separators
  	    !($prefix =3D~ /^-/) &&    # deselection
  	    !($prefix =3D~ /^\d+/) &&  # selection
-	    ($prefix ne '*');        # "all" wildcard
+	    ($prefix ne '*') &&      # "all" wildcard
+	    ($prefix ne '?');        # prompt help
  }

  # given a prefix/remainder tuple return a string with the prefix =20
highlighted
@@ -308,7 +309,7 @@ sub list_and_choose {
  			print "> ";
  		}
  		else {
-			print ">> ";
+			print " (?)>> ";
  		}
  		my $line =3D <STDIN>;
  		if (!$line) {
@@ -318,6 +319,10 @@ sub list_and_choose {
  		}
  		chomp $line;
  		last if $line eq '';
+		if ($line eq '?' && !$opts->{SINGLETON}) {
+			prompt_help_cmd();
+			next TOPLOOP;
+		}
  		for my $choice (split(/[\s,]+/, $line)) {
  			my $choose =3D 1;
  			my ($bottom, $top);
@@ -363,6 +368,19 @@ sub list_and_choose {
  	return @return;
  }

+sub prompt_help_cmd {
+	print <<\EOF ;
+Prompt help:
+1          - select a single item
+3-5        - select a range of items
+2-3,6-9    - select multiple ranges
+foo        - select item based on unique prefix
+-...       - unselect specified items
+*          - choose all items
+           - (empty) finish selecting
+EOF
+}
+
  sub status_cmd {
  	list_and_choose({ LIST_ONLY =3D> 1, HEADER =3D> $status_head },
  			list_modified());


Cheers,
Wincent
