From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 9/9] git-svn: Make fetch ~1.7x faster
Date: Tue, 23 Oct 2007 23:48:37 -0700
Message-ID: <471EEAC5.8070804@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com> <1193118397-4696-8-git-send-email-aroben@apple.com> <1193118397-4696-9-git-send-email-aroben@apple.com> <1193118397-4696-10-git-send-email-aroben@apple.com> <20071024063401.GB10916@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 08:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ika3T-0000Uf-73
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 08:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbXJXGtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 02:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbXJXGtP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 02:49:15 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:61913 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559AbXJXGtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 02:49:13 -0400
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out4.apple.com (Postfix) with ESMTP id 06ED016AE67B;
	Tue, 23 Oct 2007 23:49:13 -0700 (PDT)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id DE90B400E0;
	Tue, 23 Oct 2007 23:49:12 -0700 (PDT)
X-AuditID: 11807126-a832ebb000000803-93-471eeae80391
Received: from [17.203.12.72] (aroben3.apple.com [17.203.12.72])
	by relay8.apple.com (Apple SCV relay) with ESMTP id C47384004E;
	Tue, 23 Oct 2007 23:49:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071024063401.GB10916@soma>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62197>

Eric Wong wrote:
> Adam Roben <aroben@apple.com> wrote:
>   
>> +package Git::Commands;
>>     
>
> Can this be a separate file, or a part of Git.pm?  I'm sure other
> scripts can eventually use this and I've been meaning to split
> git-svn.perl into separate files so it's easier to follow.
>   

I had considered doing one of the above, but decided that splitting it 
out could be done if/when it was deemed useful for another script. But 
I'll split it out since you think it's a good idea.

>> +use vars qw/$_cat_blob_pid $_cat_blob_in $_cat_blob_out $_cat_blob_ctx $_cat_blob_separator
>> +	    $_hash_object_pid $_hash_object_in $_hash_object_out $_hash_object_ctx/;
>>     
>
> I have trouble following long lines, and most of the git code also wraps
> at 80-columns.  Dead-tree publishers got this concept right a long
> time ago :)
>   

Will fix.

>> +use strict;
>> +use warnings;
>> +use File::Temp qw/tempfile/;
>> +use Git qw/command_bidi_pipe command_close_bidi_pipe/;
>> +
>> +sub _open_cat_blob_if_needed {
>> +	return if defined($_cat_blob_pid);
>> +	$_cat_blob_separator = "--------------GITCATFILESEPARATOR-----------";
>>     
>
> Brian brought this up already, but yes, having pre-defined separators
> instead of explicitly-specified sizes makes it all too easy for a
> malicious user to commit code that will break things for git-svn users.
>   

Yup, will fix this. :-)

>> +sub hash_object {
>> +	my (undef, $fh) = @_;
>> +
>> +	my ($tmp_fh, $tmp_filename) = tempfile(UNLINK => 1);
>> +	while (my $line = <$fh>) {
>> +		print $tmp_fh $line;
>> +	}
>> +	close($tmp_fh);
>>     
>
> Related to the above.  It's better to sysread()/syswrite() or
> read()/print() in a loop with a predefined buffer size rather than to
> use a readline() since you could be dealing with files with very long
> lines or binaries with no newline characters in them at all.
>   

Hm, OK. I'll look for similar code in git-svn and follow that.

>> +	_open_hash_object_if_needed();
>> +	print $_hash_object_out $tmp_filename . "\n";
>>     
>
> Minor, but
>
> 	print $_hash_object_out $tmp_filename, "\n";
>
> avoids creating a new string.
>   

Good idea.

Thanks for the feedback! I'll send out some new patches sometime soon.

-Adam
