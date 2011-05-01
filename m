From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 01 May 2011 01:33:52 -0400
Message-ID: <4DBCF0C0.8080307@burntmail.com>
References: <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com> <7vtyfxgdz2.fsf@alter.siamese.dyndns.org> <7vipwbbrcc.fsf@alter.siamese.dyndns.org> <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com> <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fsf@alter.siamese.dyndns.org> <4D69DF29.8030701@burntmail.com> <7vvd056fyk.fsf@alter.siamese.dyndns.org> <4DBA3E14.7090602@burntmail.com> <20110429222729.GB5916@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Guy Rouillier <guyr@burntmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 07:34:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGPIy-0003iu-Dg
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 07:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab1EAFeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 01:34:46 -0400
Received: from mx02.burntmail.com ([70.87.63.122]:37081 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1EAFep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 01:34:45 -0400
Received: from [108.18.101.175] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1QGPI1-0002sG-Al; Sun, 01 May 2011 00:33:53 -0500
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110429222729.GB5916@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172529>

On 4/29/2011 6:27 PM, Jonathan Nieder wrote:
> Guy Rouillier wrote:
> 
>> Note that I've left this test in, although I still think it is a bad idea:
>>
>>     elsif (!$pass) {
>>        $pass = "A";
>>     }
> [...]
>> But that doesn't explain why it was put in there in the first
>> place.  I still say a better idea, if we don't want to allow an empty
>> password, is to error out rather than silently set a bogus password.
> 
> It might be a good idea after all to do something else in that case
> (as a separate patch :)), but it would require a little investigation.
> Isn't the convention in CVS for anonymous pserver access to accept an
> arbitrary password?
> 
>> The CVS password file separates tokens with a space character, while
>> the CVSNT password file separates tokens with an equal (=) character.
>> Add a sub find_password_entry that accepts the password file name
>> and a delimiter to eliminate code duplication.
>> ---
> 
> Sounds sensible to my untrained ears.  Sign-off?
> 
> [...]
>> +++ b/git-cvsimport.perl
>> @@ -227,6 +227,30 @@ sub new {
>>   	return $self;
>>   }
>>
>> +sub find_password_entry {
>> +	my ($cvspass, @cvsroot) = @_;
>> +	my ($file, $delim) = @$cvspass;
>> +	my $pass;
>> +	local ($_);
>> +
>> +	if (open(my $fh, $file)) {
>> +		# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
>> +		while (<$fh>) {
>> +			chomp;
>> +			s/^\/\d+\s+//;
>> +			my ($w, $p) = split($delim,$_,2);
>> +			for my $cvsroot (@cvsroot) {
>> +				if ($w eq $cvsroot) {
>> +					$pass = $p;
>> +					last;
> 
> In the old code, this "last" applied to the while loop, while in the
> new code it applies to the for loop.  Intentional?
> 
> [...]
>> +			if (1<  @loc) {
>> +				die("More than one cvs password files have ".
>> +				    "entries for CVSROOT $opt_d: @loc");
> 
> Grammar nit: "More than one" is singular (weird, eh?).  It might
> be clearer to say:
> 
> 	"Multiple cvs password files have " .
> 	"entries for CVSROOT $opt_d: @loc"
> 
> (or "Both cvs password files").
> 
> Thanks again, and hope that helps.

Jonathan, thanks for reading carefully.  I hadn't looked at this in a
couple months because I've been busy at work, and Perl is not my strong
point.  I had removed the last label because I didn't think it was
necessary, but you point out that it is.

I concur with addressing that default CVS password with a different
patch.  That logic has been in the code since the original Perl version,
so perhaps no one has really looked into CVS password requirements in
any detail.

Here is hopefully my final version:
---
From a96233ab1112748338e6445ed1e4a5f0e8c1213b Mon Sep 17 00:00:00 2001
From: Guy Rouillier <guyr@burntmail.com>
Date: Sun, 1 May 2011 01:23:44 -0400
Subject: [PATCH] Look for password in both CVS and CVSNT password files.

In conn, if password is not passed on command line, look for a password
entry in both the CVS password file and the CVSNT password file.  If only
one file is found and the requested repository is in that file, or if both
files are found but the requested repository is found in only one file, use
the password from the single file containing the repository entry.  If both
files are found and the requested repository is found in both files, then
produce an error message.

The CVS password file separates tokens with a space character, while
the CVSNT password file separates tokens with an equal (=) character.
Add a sub find_password_entry that accepts the password file name
and a delimiter to eliminate code duplication.

Signed-off-by: Guy Rouillier <guyr@burntmail.com>
---
 git-cvsimport.perl |   53 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bbf327f..a01b73d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -227,6 +227,31 @@ sub new {
 	return $self;
 }

+sub find_password_entry {
+	my ($cvspass, @cvsroot) = @_;
+	my ($file, $delim) = @$cvspass;
+	my $pass;
+	local ($_);
+
+	if (open(my $fh, $file)) {
+		# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+		CVSPASSFILE:
+		while (<$fh>) {
+			chomp;
+			s/^\/\d+\s+//;
+			my ($w, $p) = split($delim,$_,2);
+			for my $cvsroot (@cvsroot) {
+				if ($w eq $cvsroot) {
+					$pass = $p;
+					last CVSPASSFILE;
+				}
+			}
+		}
+		close($fh);
+	}
+	return $pass;
+}
+
 sub conn {
 	my $self = shift;
 	my $repo = $self->{'fullrep'};
@@ -259,19 +284,23 @@ sub conn {
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
-					}
+			my @cvspass = ([$ENV{'HOME'}."/.cvspass", qr/\s/],
+				       [$ENV{'HOME'}."/.cvs/cvspass", qr/=/]);
+			my @loc = ();
+			foreach my $cvspass (@cvspass) {
+				my $p = find_password_entry($cvspass, $rr, $rr2);
+				if ($p) {
+					push @loc, $cvspass->[0];
+					$pass = $p;
 				}
-			};
-			$pass = "A" unless $pass;
+			}
+
+			if (1 < @loc) {
+				die("Multiple cvs password files have ".
+				    "entries for CVSROOT $opt_d: @loc");
+			} elsif (!$pass) {
+				$pass = "A";
+			}		
 		}

 		my ($s, $rep);
--
1.7.5.134.gbea48





-- 
Guy Rouillier
