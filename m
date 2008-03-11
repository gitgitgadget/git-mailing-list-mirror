From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Tue, 11 Mar 2008 18:30:57 +0100
Message-ID: <200803111830.58392.jnareb@gmail.com>
References: <20080308165245.15343.62914.stgit@localhost.localdomain> <20080311090100.GN10103@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:32:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8KN-00027g-4A
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYCKRbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYCKRbK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:31:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:38206 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYCKRbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:31:08 -0400
Received: by ug-out-1314.google.com with SMTP id z38so56184ugc.16
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ZQ8NYpBW9+AGwuJOXUkAT22ExXtCfvdNmA7ngQl6p6k=;
        b=TTtpQlo5doHY6zz52IVcRvajJV5kq1+YHNY3fsSZzqVpvfMMhwUV8iBEA5qU9QQ/F7So83CkwWoh1xmNsJVQSUtShVcGOT/0vzIjc3asWfvUM4I+FblN+x+10G90VemoXB9DJdwwEot8g/UtuWbijlgxxFIvGTV4nYNKgtV5sFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZCvannFVfIQJ/IW4fIa61ww/mXddqCjKvTdHegopOiZf+w2L2NNvxCAiQra6BMoJ8Vw5s6Pk1ePi6rQ+ZJZ4hcaMdHk8Bt5wZOShWvflnqTMmiPbRA1fxcRZ7HSNOlcwdYt7cucVEXM5cRDuxxzhZZq12u5Ia4JOxFu+u0Csbd8=
Received: by 10.67.115.17 with SMTP id s17mr94415ugm.56.1205256663046;
        Tue, 11 Mar 2008 10:31:03 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.244.132])
        by mx.google.com with ESMTPS id m1sm577437uge.69.2008.03.11.10.31.00
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 10:31:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080311090100.GN10103@mail-vs.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76883>

Thanks a lot for reviewing this patch!

On Tue, 11 March 2008, Frank Lichtenheld wrote:
> On Sat, Mar 08, 2008 at 05:57:20PM +0100, Jakub Narebski wrote:
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a5df2fe..ba97a7b 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1455,6 +1455,35 @@ sub git_cmd_str {
>>  	return join(' ', git_cmd());
>>  }
>>  
>> +# my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
>> +# is equivalent to (is the "list form" of) the following
>> +# open my $fh, "-|", "cmd_1 option | cmd_2 argument"
>> +#
>> +# Based on http://www.perlmonks.org/?node_id=246397

Note that this patch is a bit "cargo cult" (copy'n'paste) programming...
 
> It might be worthwile to look into how e.g. IPC::Run does this.

Thanks for the pointer. I look at it.

IPC::Run isn't installed by default with Perl, like Encode, Fcntl,
File::Find and File::Basename, or reasonable to be required to be
installed to run server side app like CGI, so we cannot use it
directly, as we cannot require for gitweb user to have it installed.

Additionally while in some parts IPC::Run API is nice and well
thought (composing pipeline), some of it would make it hard to use
in gitweb. For example I could not find how to direct pipeline
output to filehandle instead of to scalar or opened file. While
for currently the only pipeline in gitweb, namely generating
(externally) compressed snapshot IPC::Run API would be enough,
for syntax highlighting with its line-by-line pipeline output
parsing it would be, I think, a bit cumbersome.

It would be nice if parts of IPC::Run made it into Git.pm...
then we could just use it in gitweb.

>> +sub output_pipeline {
>> +	my @commands_list = @_;
>> +	exit unless @commands_list;
>> +
>> +	my $pid = open(my $fh, "-|");
>> +	#die "Couldn't fork: $!" unless defined $pid;
> 
> Why are all the die's commented out?

The goal is to have gitweb deal with errors gracefully. It should
generate some kind of '503 Server Error' page, instead of dieing
without output, or what would be even worse, in the middle of output.

I haven't examined how it should be writen for this RFC patch, so
I have commented out 'die' just in case. In the final version (if it
will be decided to go this route) it should be cleaned out.

>> +	if ($pid) { # parent
>> +		return $fh;
>> +	}
>> +
>> +	# child
>> + COMMAND:
>> +	while (my $command = pop @commands_list) {
>> +		my $pid = @commands_list ? open(STDIN, "-|") : -1;
>> +		#die "Couldn't fork: $!" unless defined $pid;
>> +
>> +		next COMMAND unless ($pid); # parent
>> +		exec @$command;             # child
> 
> The "parent" and "child" comments here are wrong, which was really
> really confusing...

I'm sorry. My mistake.

> This should probably be "new child" instead of "parent" and
> "old child" instead of "child".

I think those comments could be simply removed, as they are, I guess,
equivalent to

   count++;  /* increment counter */

in C/C++.

> Thw whole concept of processing the array backwards might be shorter,
> I personally find it somewhat confusing though.

I'm not sure if it is not the only possible way, as the (first) parent,
I think, has to return filehandle. But I might be mistaken.

> What happens to all these child processes anyway if one of them fails to
> exec?

Original snippet returned in addition to filehandle also list of pids.
Perhaps I have oversimplified this snipped... or it was to simple to
begin with.

>> +		#die "Couldn't exec \"@$command\": $!";
>> +	}
>> +}
>> +
>>  # get HEAD ref of given project as hash
>>  sub git_get_head_hash {
>>  	my $project = shift;
>> @@ -4545,27 +4574,26 @@ sub git_snapshot {
>>  		$hash = git_get_head_hash($project);
>>  	}
>>  
>> -	my $git_command = git_cmd_str();
>>  	my $name = $project;
>> -	$name =~ s,([^/])/*\.git$,$1,;
>> +	$name =~ s,([^/])/*\.git$,$1,; # strip '.git' or '/.git'
>>  	$name = basename($name);
>> -	my $filename = to_utf8($name);
>> -	$name =~ s/\047/\047\\\047\047/g;
>> -	my $cmd;
>> -	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
>> -	$cmd = "$git_command archive " .
>> -		"--format=$known_snapshot_formats{$format}{'format'} " .
>> -		"--prefix=\'$name\'/ $hash";
>> +	$name = to_utf8($name);  # or only for filename, not prefix?
>> +	$name .= "-$hash";
>> +
>> +	my @cmds = ([git_cmd(), "archive",
>> +		"--format=$known_snapshot_formats{$format}{'format'}",
>> +		"--prefix=$name/", $hash]);
>>  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
>> -		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
>> +		push @cmds, $known_snapshot_formats{$format}{'compressor'};
>>  	}
>>  
>>  	print $cgi->header(
>>  		-type => $known_snapshot_formats{$format}{'type'},
>> -		-content_disposition => 'inline; filename="' . "$filename" . '"',
>> +		-content_disposition => 'inline; filename="' .
>> +			"$filename$known_snapshot_formats{$format}{'suffix'}" . '"',
> 
> Huh, that compiles? Where is $filename defined now at all?

I'm very sorry. This was my quick improving code just before sending
this patch... forgetting to test after "obvously correct" (not!) changes.

By the way, this change to have <filename>.<suffix> snapshot extract to
<filename>/ directory is independent on the "list form of pipeline"
changes and should probably be sent as separate patch.


Once again, thanks for reviewing and commenting on this RFC patch.
I'm just not a Perl hacker...
-- 
Jakub Narebski
Poland
