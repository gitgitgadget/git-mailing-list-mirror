From: nguyenki <nguyenki@ensibm.imag.fr>
Subject: Re: [PATCH/RFC] Export file attachements in git-remote-mediawiki
Date: Tue, 05 Jun 2012 19:00:01 +0200
Message-ID: <59db730bded272b60cbd16806c757660@ensibm.imag.fr>
References: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
 <vpqvcj6lq1m.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <roucherj@ensimag.imag.fr>,
	<Pavel.Volek@ensimag.imag.fr>
To: <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbx75-00012j-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 19:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab2FERAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 13:00:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56152 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab2FERAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 13:00:04 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q55GpHl4011156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 18:51:17 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q55H02aT028593;
	Tue, 5 Jun 2012 19:00:02 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q55H020q015825;
	Tue, 5 Jun 2012 19:00:02 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q55H01Jl015824;
	Tue, 5 Jun 2012 19:00:01 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to nguyenki@ensibm.imag.fr using -f
In-Reply-To: <vpqvcj6lq1m.fsf@bauges.imag.fr>
X-Sender: nguyenki@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Jun 2012 18:51:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55GpHl4011156
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: nguyenki@ensibm.imag.fr
MailScanner-NULL-Check: 1339519877.94971@UoMQdHjIMa+gKRsVK8X5Fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199266>

On Mon, 04 Jun 2012 23:34:29 +0200, Matthieu Moy wrote:
> NGUYEN Kim Thuat <kim-thuat.nguyen@ensimag.imag.fr> writes:
>
>> +# Get the list of file extensions supported by the current version=20
>> of mediawiki
>> +my @list_file_extensions =3D get_file_extensions();
>
> You should do it only on demand (like $mediawiki is created lazily).
yeah, i changed the code in this part, it look like:

@@ -113,9 +113,6 @@ $wiki_name =3D~ s/[^\/]*:\/\///;
  # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
  $wiki_name =3D~ s/^.*@//;

-# Get the list of file extensions supported by the current version of=20
mediawiki
-my @list_file_extensions =3D get_file_extensions();
-
  # Commands parser
  my $entry;
  my @cmd;
@@ -654,7 +651,7 @@ sub mw_push_file {
  	my $file_deleted =3D ($new_sha1 eq NULL_SHA1);
  	$complete_file_name =3D mediawiki_clean_filename($complete_file_name=
);

-	my %hashFiles =3D map {$_ =3D> 1}@list_file_extensions;
+	my %hashFiles =3D get_file_extensions_maybe($complete_file_name);
  	my $path =3D "File:".$complete_file_name;
  	my @extensions =3D split(/\./,$complete_file_name);
  	my $extension =3D pop(@extensions);

-sub get_file_extensions {
-	mw_connect_maybe();
-
-	my $query =3D {
-	action =3D> 'query',
-	meta =3D> 'siteinfo',
-	siprop =3D> 'fileextensions'
-	};
+sub get_file_extensions_maybe {
+	my $file_name =3D shift;
+	my $est_mw_page =3D substr($file_name,-3) eq ".mw";
+	if(!$est_mw_page) {
+		mw_connect_maybe();

-	my $result =3D $mediawiki->api($query);
+		my $query =3D {
+			action =3D> 'query',
+			meta =3D> 'siteinfo',
+			siprop =3D> 'fileextensions'
+			};

-	my @file_extensions =3D map=20
$_->{ext},@{$result->{query}->{fileextensions}};
+		my $result =3D $mediawiki->api($query);
+		my @file_extensions =3D map=20
$_->{ext},@{$result->{query}->{fileextensions}};
+		my %hashFile =3D map {$_ =3D> 1}@file_extensions;

-	return @file_extensions;
+		return %hashFile;
+	} else {
+		return ;
+	}
  }

  Now, the function will list the file extensions on demand.


>> @@ -642,8 +651,14 @@ sub mw_push_file {
>>  	my $old_sha1 =3D $diff_info_split[2];
>>  	my $page_created =3D ($old_sha1 eq NULL_SHA1);
>>  	my $page_deleted =3D ($new_sha1 eq NULL_SHA1);
>> +	my $file_deleted =3D ($new_sha1 eq NULL_SHA1);
>
> This line looks suspiciously similar to the previous one. Do you need
> another variable for the same value?
Yes, it's true. I just want the code to be more visible. Because, when=20
we delete a file attachment, it's not a page wiki.

> Does this work on wiki configured in foreign languages, like french=20
> that
> has Sp=C3=A9cial:T=C3=A9l=C3=A9verser instead?
>

>> +	else {
>> +		print STDERR "$complete_file_name is not supported on this=20
>> version of Mediawiki.\n"
>
> It's not a matter of version, it's a matter of configuration.
What do you think if i change it like:
         else {
	print STDERR "$complete_file_name is not a permitted file type. Check=20
your configuration for more information\n"
