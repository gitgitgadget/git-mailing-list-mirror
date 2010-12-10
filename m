From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 17/18] gitweb: Prepare for cached error pages & better
 error page handling
Date: Fri, 10 Dec 2010 00:33:16 -0800
Message-ID: <4D01E5CC.6010301@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-18-git-send-email-warthog9@eaglescrag.net> <m3r5dqz9c5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 09:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQyO9-0007BU-51
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 09:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab0LJIbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 03:31:31 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:59902 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab0LJIbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 03:31:31 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA8VSfY018819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 10 Dec 2010 00:31:28 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3r5dqz9c5.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 10 Dec 2010 00:31:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163393>

> There is no problem with capturing output of die_error, nor there is a
> problem with caching error pages (perhaps transiently in memory).
> 
> The problem is that subroutines calling die_error assum that it would
> exit ending subroutine that is responsible for generating current
> action; see "goto DONE_GITWEB" which should be "goto DONE_REQUEST",
> and which was "exit 0" some time ago at the end of die_error().
> 
> With caching error pages you want die_error to exit $actions{$action}->(),
> but not exit cache_fetch().  How do you intend to do it?

Well there's one bug in how that function ends in looking at it again,
basically the return case shouldn't happen, and that function should
end, like your suggesting in the first part of your question (with
respect to DONE_GITWEB)

In the second part, your not thinking with the fork() going (though in
thinking sans the fork this might not work right).

It's the background process that will call die_error in such a way that
die_error_cache will get invoked.  die_error_cache will write the .err
file out, and the whole thing should just exit.

Though now that I say that there's an obvious bug in the case where
forking didn't work at all, in that case you would get a blank page as
the connection would just be closed.  If you refreshed (say hitting F5)
you'd get the error at that point.

Need to fix that non-forked problem though.

>> This adds two functions:
>>
>> die_error_cache() - this gets back called from die_error() so
>> that the error message generated can be cached.
> 
> *How* die_error_cache() gets called back from die_error()?  I don't
> see any changes to die_error(), or actually any calling sites for
> die_error_cache() in the patch below.
>  
>> cacheDisplayErr() - this is a simplified version of cacheDisplay()
>> that does an initial check, if the error page exists - display it
>> and exit.  If not, return.
> 
> Errr... isn't it removed in _preceding_ patch?  WTF???

in breaking up the series it got included in the wrong spot, and
apparently removed and re-added correctly, should be fixed in v9

>> +sub die_error_cache {
>> +	my ($output) = @_;
>> +
>> +	open(my $cacheFileErr, '>:utf8', "$fullhashpath.err");
>> +	my $lockStatus = flock($cacheFileErr,LOCK_EX|LOCK_NB);
> 
> Why do you need to lock here?  A comment would be nice.

At any point when a write happens there's the potential for multiple
simultaneous writes.  Locking becomes obvious, when your trying to
prevent multiple processes from writing to the same thing at the same
time...

>> +
>> +	if (! $lockStatus ){
>> +		if ( $areForked ){
> 
> Grrrr...
> 
> But if it is here to stay, a comment if you please.
> 
>> +			exit(0);
>> +		}else{
>> +			return;
>> +		}
>> +	}

The exit(0) or return have been removed in favor of DONE_GITWEB, as
we've already errored if we are broken here we should just die.

>> +
>> +	# Actually dump the output to the proper file handler
>> +	local $/ = undef;
>> +	$|++;
> 
> Why not
> 
>   +	local $| = 1;
> 

Done.

> 
>> +	print $cacheFileErr "$output";
>> +	$|--;
>> +
>> +	flock($cacheFileErr,LOCK_UN);
>> +	close($cacheFileErr);
> 
> Closing file will unlock it.

Doesn't really hurt to be explicit though.

>> +
>> +	if ( $areForked ){
>> +		exit(0);
>> +	}else{
>> +		return;
> 
> So die_error_cache would not actually work like "die" here and like
> die_error(), isn't it?

that was ejected, it was a bug.  DONE_GITWEB is more correct, though I
might need to add a hook to display the error message in the case that
the process didn't fork.

>> +	}
>> +}
>> +
>>  
>>  sub cacheWaitForUpdate {
>>  	my ($action) = @_;
>> @@ -380,6 +410,28 @@ EOF
>>  	return;
>>  }
>>  
>> +sub cacheDisplayErr {
>> +
>> +	return if ( ! -e "$fullhashpath.err" );
>> +
>> +	open($cacheFileErr, '<:utf8', "$fullhashpath.err");
>> +	$lockStatus = flock($cacheFileErr,LOCK_SH|LOCK_NB);
>> +
>> +	if (! $lockStatus ){
>> +		show_warning(
>> +				"<p>".
>> +				"<strong>*** Warning ***:</strong> Locking error when trying to lock error cache page, file $fullhashpath.err<br/>/\n".
> 
> esc_path
> 
>> +				"This is about as screwed up as it gets folks - see your systems administrator for more help with this.".
>> +				"<p>"
>> +				);
>> +	}
>> +
>> +	while( <$cacheFileErr> ){
>> +		print $_;
>> +	}
> 
> Why not 'print <$cacheFileErr>' (list context), like in insert_file()
> subroutine?

I've had buffer problems with 'print <$cacheFileErr>' in some cases.
This is small enough it shouldn't happen, but I've gotten into the habit
of doing it this way.  I can change it if you like.

> 
>> +	exit(0);
>> +}
> 
> Callsites?
> 
> Note: I have't read next commit yet.

Next patch.

If you'd rather I can squash 17 & 18 into a single commit.

- John 'Warthog9' Hawley
