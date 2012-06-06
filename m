From: nguyenki <nguyenki@ensibm.imag.fr>
Subject: Re: [PATCH/RFC] Export file attachements in git-remote-mediawiki
Date: Thu, 07 Jun 2012 00:25:47 +0200
Message-ID: <24f8b089a3ca00153ca927d6a5e4090b@ensibm.imag.fr>
References: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
 <vpqvcj6lq1m.fsf@bauges.imag.fr>
 <59db730bded272b60cbd16806c757660@ensibm.imag.fr>
 <vpq62b5g047.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:25:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScOfr-0007ou-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 00:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab2FFWZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 18:25:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58650 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab2FFWZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 18:25:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q56MH8ME027800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 00:17:08 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q56MPlMn020686;
	Thu, 7 Jun 2012 00:25:47 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q56MPldp022536;
	Thu, 7 Jun 2012 00:25:47 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q56MPlmp022532;
	Thu, 7 Jun 2012 00:25:47 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to nguyenki@ensibm.imag.fr using -f
In-Reply-To: <vpq62b5g047.fsf@bauges.imag.fr>
X-Sender: nguyenki@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jun 2012 00:17:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q56MH8ME027800
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: nguyenki@ensibm.imag.fr
MailScanner-NULL-Check: 1339625828.79826@7W0ZY+vg57bORqcXoa1+iQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199359>

On Tue, 05 Jun 2012 19:05:44 +0200, Matthieu Moy wrote:
> nguyenki <nguyenki@ensibm.imag.fr> writes:
>
>>>> @@ -642,8 +651,14 @@ sub mw_push_file {
>>>>  	my $old_sha1 = $diff_info_split[2];
>>>>  	my $page_created = ($old_sha1 eq NULL_SHA1);
>>>>  	my $page_deleted = ($new_sha1 eq NULL_SHA1);
>>>> +	my $file_deleted = ($new_sha1 eq NULL_SHA1);
>>>
>>> This line looks suspiciously similar to the previous one. Do you 
>>> need
>>> another variable for the same value?
>> Yes, it's true. I just want the code to be more visible. Because, 
>> when
>> we delete a file attachment, it's not a page wiki.
>
> I still don't see a reason to have two variables for the same thing. 
> If
> $page_deleted is not a good name, then rename the variable to
> something more general (e.g. $path_deleted ?)
>

>>>> +	else {
>>>> +		print STDERR "$complete_file_name is not supported on
>>>> this version of Mediawiki.\n"
>>>
>>> It's not a matter of version, it's a matter of configuration.
>> What do you think if i change it like:
>>         else {
>> 	print STDERR "$complete_file_name is not a permitted file
>> type. Check your configuration for more information\n"
>
> That's better, but it doesn't tell the user which configuration to
> check (Git's one, or the wiki's one).
Thank for your advices, i changed the code from your suggestions, now 
it look like:
@@ -36,6 +36,7 @@
  use strict;
  use MediaWiki::API;
  use DateTime::Format::ISO8601;
+use encoding 'utf8';

  # use encoding 'utf8' doesn't change STDERROR
  # but we're going to output UTF-8 filenames to STDERR
@@ -275,7 +276,8 @@ sub run_git {
  }

  sub run_git_raw {
-        open(my $g,"-|","git " . $_[0]);
+	no encoding 'utf8';
+        open(my $g, "-|:utf8", "git " . $_[0]);
          my $r = do { local $/; <$g> };
          close($g);

@@ -648,7 +650,6 @@ sub mw_push_file {
  	my $old_sha1 = $diff_info_split[2];
  	my $page_created = ($old_sha1 eq NULL_SHA1);
  	my $page_deleted = ($new_sha1 eq NULL_SHA1);
-	my $file_deleted = ($new_sha1 eq NULL_SHA1);
  	$complete_file_name = mediawiki_clean_filename($complete_file_name);

  	my %hashFiles = get_file_extensions_maybe($complete_file_name);
@@ -700,28 +701,29 @@ sub mw_push_file {
  		print STDERR "Pushed file: $new_sha1 - $title\n";
  	} elsif (exists($hashFiles{$extension})) {
  		# Deleting and uploading a file require the priviledge of the user
-		if ($file_deleted) {
+		if ($page_deleted) {
  			mw_connect_maybe();
  			my $res = $mediawiki->edit( {
-			action => 'delete',
-			title => $path,
-			reason => $summary } )
+				action => 'delete',
+				title => $path,
+				reason => $summary } )
  			|| die $mediawiki-> {error}->{code} . ':' . 
$mediawiki->{error}->{details};

  		} else {
  			my $content = run_git_raw("cat-file blob $new_sha1");
  			mw_connect_maybe();
-				$mediawiki->{config}->{upload_url} = 
"$url/index.php/Special:Upload";
+			$mediawiki->{config}->{upload_url} = 
"$url/index.php/Special:Upload";

-				$mediawiki->upload( {
+			$mediawiki->upload( {
  				title => $complete_file_name,
  				summary => $summary,
  				data => $content,
  				ignorewarnings=>1
-                                  }, {
-					skip_encoding => 1 # Helps with names with accentuated characters
-			} ) || die $mediawiki-> {error}->{code} . ':' . 
$mediawiki->{error}->{details};
-			$newrevid = get_reviId_filepage();
+					}, {
+						skip_encoding => 1 # Helps with names with accentuated 
characters
+					} ) || die $mediawiki-> {error}->{code} . ':' . 
$mediawiki->{error}->{details};
+			my $last_file_page = $mediawiki->get_page({title =>$path});
+			$newrevid = $last_file_page->{revid};
  			print STDERR "Pushed file: $new_sha1 - $complete_file_name\n";
  			 }
  	else {
@@ -864,29 +866,6 @@ sub mw_push_revision {
  	return 1;
  }

-sub get_reviId_filepage() {
-	mw_connect_maybe();
-
-	my $max_rev_num_file = 0;
-
-	my @list_file_pages = get_mw_media_pages();
-
-	foreach my $file_page (@list_file_pages) {
-	my $id = $file_page->{pageid};
-
-	my $query = {
-		action => 'query',
-		prop => 'revisions',
-		rvprop => 'ids',
-		pageids => $id,
-		};
-
-	my $result = $mediawiki->api($query);
-
-	my $lastrev = pop(@{$result->{query}->{pages}->{$id}->{revisions}});
-	}
-}
-
