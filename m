From: Kyle McKay <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 19:13:42 -0700
Message-ID: <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com> <20130707002430.GE30132@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 04:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UveUG-00050X-Ku
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 04:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab3GGCNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 22:13:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61409 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab3GGCNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 22:13:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3207488pbb.33
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 19:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=XvoiOzP4BD8o0vY5rixQ91nHAKC0C7NCgEHmnrXp7Nw=;
        b=txA28nzRQQanrudz55cjTeoH2v44DTcyi+MaeDfY+02EGDG/cVK2MzI/OJNS6Umgeo
         whU2+5NnPYfNWbMohBBzbEZDm8jCXE++w6GB+mGl3eJlmsO5xB33ag+YKx/GzARR0vj4
         2crjMkXF9gWUyg6xYO3gajFCBIXvjxBMcxLVgDVhGDTtqJyfCV4deA9M7VVRaYjIeBuq
         rlv5dP4N72/VZ8dn2K4//CczQVaNTbp4WM9iQkbPuByP5RXaGiIIgqFpnQPISirFBI4y
         uqhIYwooJ/0aymfD86pLbX+ybCN233W3fDFv07zlaipr+00XAtQtmsvR3Yy9CakH6pjs
         HJAQ==
X-Received: by 10.68.105.163 with SMTP id gn3mr15748433pbb.181.1373163225198;
        Sat, 06 Jul 2013 19:13:45 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id aj3sm15982985pad.8.2013.07.06.19.13.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 19:13:44 -0700 (PDT)
In-Reply-To: <20130707002430.GE30132@google.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229715>

On Jul 6, 2013, at 17:24, Jonathan Nieder wrote:
> (cc-ing Eric Wong, who wrote this code)
> Hi,
>
> Kyle McKay wrote:
>
>> Temp file with moniker 'svn_delta' already in use at Git.pm line 1250
>> Temp file with moniker 'git_blob' already in use at Git.pm line 1250
>>
>> David Rothenberger <daveroth@acm.org> has determined the cause to
>> be that ra_serf does not drive the delta editor in a depth-first
>> manner [...]. Instead, the calls come in this order:
> [...]
>> --- a/perl/Git/SVN/Fetcher.pm
>> +++ b/perl/Git/SVN/Fetcher.pm
>> @@ -315,11 +315,13 @@ sub change_file_prop {
>> sub apply_textdelta {
>> 	my ($self, $fb, $exp) = @_;
>> 	return undef if $self->is_path_ignored($fb->{path});
>> -	my $fh = $::_repository->temp_acquire('svn_delta');
>> +	my $suffix = 0;
>> +	++$suffix while $::_repository->temp_is_locked("svn_delta_${$}_ 
>> $suffix");
>> +	my $fh = $::_repository->temp_acquire("svn_delta_${$}_$suffix");
>> 	# $fh gets auto-closed() by SVN::TxDelta::apply(),
>> 	# (but $base does not,) so dup() it for reading in close_file
>> 	open my $dup, '<&', $fh or croak $!;
>> -	my $base = $::_repository->temp_acquire('git_blob');
>> +	my $base = $::_repository->temp_acquire("git_blob_${$}_$suffix");
>
> Thanks for your work tracking this down.
>
> I'm a bit confused.  Are you saying that apply_textdelta gets called
> multiple times in a row without an intervening close_file?

Unless bulk updates are disabled when using the serf access method  
(the only one available with svn 1.8) for https?: urls,  
apply_textdelta does indeed get called multiple times in a row without  
an intervening temp_release.

Two temp files are created for each apply_textdelta ('svn_delta...'  
and 'git_blob...').  In my tests it seems that most of the time the  
two temp files are enough, but occasionally as many as six will be  
open at the same time.

I suspect this maximum number is related to the maximum number of  
simultaneous connections the serf access method will use which  
defaults to 4.  Therefore I would expect to see as many as 8 temp  
files (4 each for 'svn_delta...' and 'git_blob...'), but I have only  
been able to trigger creation of 6 temp files so far.

Kyle
