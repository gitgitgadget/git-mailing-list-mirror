From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] fix alias expansion with new Git::config_path()
Date: Fri, 14 Oct 2011 18:38:18 +0200
Message-ID: <201110141838.19118.jnareb@gmail.com>
References: <4E982B27.8050807@drmicha.warpmail.net> <20111014142557.GB13680@laptop> <4E984781.6050601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 18:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REkm2-0007iQ-0f
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 18:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600Ab1JNQiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 12:38:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58537 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab1JNQiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 12:38:12 -0400
Received: by eye27 with SMTP id 27so1311922eye.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EUbpqYut+QfCKMM+W57CwwtGAcnqwEof+YU+sj5GX28=;
        b=aUdgoGnEveM3+zL7U9VRwzc3c8xb611DEmgmy7kiV1uF37Csh0efKooZK2nV6r3u3S
         9wDWM1qJ5ci3Ndl680YZlww3r0+mp0C8RPCIVvt0ULgo+igxzPF/+akGa9qbnOtW7T9I
         JixJTw2ZRb/3vB2hY7IArl+tRXguk+Fboq/Ug=
Received: by 10.223.15.10 with SMTP id i10mr4924649faa.17.1318610290810;
        Fri, 14 Oct 2011 09:38:10 -0700 (PDT)
Received: from [192.168.1.13] (abvw122.neoplus.adsl.tpnet.pl. [83.8.220.122])
        by mx.google.com with ESMTPS id r16sm4591081fam.8.2011.10.14.09.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 09:38:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E984781.6050601@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183585>

Michael J Gruber wrote:
> Cord Seele venit, vidit, dixit 14.10.2011 16:25:
>> On Fri 14 Oct 2011 14:29:27 +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> 
>>> cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)
>>> broke the expansion of aliases for me:
[...]
>>> Reverting cec5dae brings my aliases back. [...]
[...]
>> 
>> The following patch fixes it for me, please give it a try.
>> 
>> Since this fix is simply copy&pasting some code from the config_settings path
>> someone with better perl understanding might wnat to refactor it
>> (Junio/Jacob)?

[missing commit message]

>> Signed-off-by: Cord Seele <cowose@gmail.com>
> 
> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> Thanks. (Though I'm still wondering what this is about overall.)

There were a few issues that were responsible for this error:

1. %config_bool_settings and %config_settings despite similar name have
   different semantic.  

   %config_bool_settings values are arrays where the first element is
   (reference to) the variable to set, and second element is default
   value... which admittedly is a bit cryptic.  More readable if more
   verbose option would be to use hash reference, e.g.:

	my %config_bool_settings = (
	    "thread" => { variable => \$thread, default => 1},
	    [...]

   Or something like that.

   %config_settings values are either either reference to scalar variable
   or reference to array.  In second case it means that option (or config
   option) is multi-valued.  BTW. this is similar to what Getopt::Long does.

2. In cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)
   the setting "aliasesfile" was moved from %config_settings to newly
   introduced %config_path_settings.  But the loop that parses settings
   from %config_path_settings was copy'n'pasted *wrongly* from
   %config_bool_settings instead of from %config_settings.

   It looks like cec5dae author cargo-culted this change...

3. 994d6c6 (send-email: address expansion for common mailers, 2006-05-14)
   didn't add test for alias expansion to t9001-send-email.sh

>> ---
>>  git-send-email.perl |   12 ++++++++++--
>>  1 files changed, 10 insertions(+), 2 deletions(-)
>> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 91607c5..6885dfa 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -337,8 +337,16 @@ sub read_config {
>>  	}
>>  
>>  	foreach my $setting (keys %config_path_settings) {
>> -		my $target = $config_path_settings{$setting}->[0];
>> -		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
>> +		my $target = $config_path_settings{$setting};
>> +		if (ref($target) eq "ARRAY") {
>> +			unless (@$target) {
>> +				my @values = Git::config_path(@repo, "$prefix.$setting");
>> +				@$target = @values if (@values && defined $values[0]);
>> +			}
>> +		}
>> +		else {
>> +			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
>> +		}
>>  	}
>>  
>>  	foreach my $setting (keys %config_settings) {

Or a bit simpler (though still duplicated somewhat code with
%config_settings) case:

diff --git i/git-send-email.perl w/git-send-email.perl
index 91607c5..eed241e 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -337,8 +337,13 @@ sub read_config {
 	}
 
 	foreach my $setting (keys %config_path_settings) {
-		my $target = $config_path_settings{$setting}->[0];
-		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		my $target = $config_path_settings{$setting};
+		if (ref($target) eq "ARRAY" && !@$target) {
+			my @values = Git::config_path(@repo, "$prefix.$setting");
+			@$target = @values if (@values && defined $values[0]);
+		} elsif (!defined $$target) {
+			$$target = Git::config_path(@repo, "$prefix.$setting");
+		}
 	}
 
 	foreach my $setting (keys %config_settings) {

P.S. Junio, does t9001 pass for you?  For me it fails very strangely on
some tests: 

  not ok - 21 reject long lines
  not ok - 22 no patch was sent
  not ok - 28 In-Reply-To without --chain-reply-to
  not ok - 29 In-Reply-To with --chain-reply-to
  not ok - 39 sendemail.cccmd
  not ok - 49 --suppress-cc=bodycc
  not ok - 51 --suppress-cc=cc
  not ok - 56 confirm by default (due to cc)
  not ok - 70 warning with an implicit --chain-reply-to
  # failed 9 among 93 test(s)
-- 
Jakub Narebski
Poland
