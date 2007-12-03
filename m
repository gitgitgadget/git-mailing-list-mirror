From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Mon, 3 Dec 2007 09:09:43 +0100
Message-ID: <5BE6088E-22F0-4154-BAE5-22F3229D0782@wincent.com>
References: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org> <1196337638-45972-1-git-send-email-win@wincent.com> <7vy7cf87jz.fsf@gitster.siamese.dyndns.org> <5B4BC281-10BD-437F-A956-EEB73F40A76C@wincent.com> <7veje4ykzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 09:10:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz6Ne-0004bs-S6
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 09:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbXLCIJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 03:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbXLCIJ4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 03:09:56 -0500
Received: from wincent.com ([72.3.236.74]:59950 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbXLCIJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 03:09:55 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB389jBh022775;
	Mon, 3 Dec 2007 02:09:45 -0600
In-Reply-To: <7veje4ykzg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66886>

El 2/12/2007, a las 20:06, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> Unless by "documentation" you meant to somehow expose these in the
>> interface at runtime... something like this? (applied on top of the
>> patch I just sent to the list):
>
> I did not recall (and was too lazy to check) if they were documented
> already, but as you suggest, I think letting people type ? at the =20
> prompt
> to get a help is always a good idea.  So, instead of doing this part:
>
>> @@ -308,7 +309,7 @@ sub list_and_choose {
>>  			print "> ";
>>  		}
>>  		else {
>> -			print ">> ";
>> +			print " (?)>> ";
>
> I'd prefer accepting '?'  as a valid "help me" input and showing
> appropriate help for _both_ singleton select and multiple select,
> without mentioning " (?)".  For this, your prompt_help_cmd needs to b=
e
> enhanced to limit the help to singleton case, though.


That's actually the way I did it the first time, but then decided that =
=20
the singleton prompt help had so little to say that I doubted about =20
including it. Something like this, once again on top of the patch I =20
posted yesterday ("Fixes for automatic prefix highlighting"):

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 32fb9ea..335c2c6 100755
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
@@ -318,6 +319,12 @@ sub list_and_choose {
  		}
  		chomp $line;
  		last if $line eq '';
+		if ($line eq '?') {
+			$opts->{SINGLETON} ?
+			    singleton_prompt_help_cmd() :
+			    prompt_help_cmd();
+			next TOPLOOP;
+		}
  		for my $choice (split(/[\s,]+/, $line)) {
  			my $choose =3D 1;
  			my ($bottom, $top);
@@ -363,6 +370,28 @@ sub list_and_choose {
  	return @return;
  }

+sub singleton_prompt_help_cmd {
+	print <<\EOF ;
+Prompt help:
+1          - select a numbered item
+foo        - select item based on unique prefix
+           - (empty) select nothing
+EOF
+}
+
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
