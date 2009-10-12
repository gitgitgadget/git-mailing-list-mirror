From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH v5 2/2] gitweb: append short hash ids to snapshot files
Date: Mon, 12 Oct 2009 11:34:43 -0400
Message-ID: <4AD34C93.20605@mailservices.uwaterloo.ca>
References: <4ABE536D.3070705@mailservices.uwaterloo.ca> <200910051206.18943.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 17:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxN24-0003lc-99
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 17:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbZJLPfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756737AbZJLPfn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 11:35:43 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:38422 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756564AbZJLPfm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 11:35:42 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id n9CFYhAb021177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Oct 2009 11:34:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
In-Reply-To: <200910051206.18943.jnareb@gmail.com>
X-UUID: 59916285-713e-455e-b0bc-1d3ad092b636
X-Miltered: at mailchk-m05 with ID 4AD34C93.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Mon, 12 Oct 2009 11:34:49 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130027>

On 09-10-05 6:06 AM, Jakub Narebski wrote:

>>  	my $o_git_dir = $git_dir;
>>  	my $retval = undef;
>>  	$git_dir = "$projectroot/$project";
>> -	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
>> -		my $head = <$fd>;
>> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--verify', $hash) {
>> +		$hash = <$fd>;
>>  		close $fd;
>> -		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
>> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{40})$/) {
>> +			$retval = $1;
>> +		}
> 
> I guess that you use "$retval = $1;" instead of just "$retval = $hash;"
> because of similarities with git_get_short_hash, isn't it?  Or it is just
> following earlier code?

Yeah, it is following earlier code, I did not change it, though the diff
seems to think I added it, perhaps this is a bug with diff?

>> +	}
>> +	if (defined $o_git_dir) {
>> +		$git_dir = $o_git_dir;
>> +	}
>> +	return $retval;
>> +}
>> +
>> +# try and get a shorter hash id
>> +sub git_get_short_hash {
>> +	my $project = shift;
>> +	my $hash = shift;
>> +	my $o_git_dir = $git_dir;
>> +	my $retval = undef;
>> +	$git_dir = "$projectroot/$project";
>> +	if (open my $fd, '-|', git_cmd(), 'rev-parse', '--short=7', $hash) {
>> +		$hash = <$fd>;
>> +		close $fd;
>> +		if (defined $hash && $hash =~ /^([0-9a-fA-F]{7,})$/) {
>>  			$retval = $1;
>>  		}
>>  	}
> 
> Note that git_get_full_hash (which additionally does verification) and
> git_get_short_hash share much of code.  Perhaps it might be worth to
> avoid code duplication somehow?  On the other hand it might be not worth
> to complicate code by trying to extract common parts here...

Hmm, I think it might be a good idea to just write a generic routine
that takes a hash length as an extra parameter. Then the short and full
hash fetching routines can just acts as wrappers.

>> @@ -5203,6 +5228,13 @@ sub git_snapshot {
>>  		die_error(400, 'Object is not a tree-ish');
>>  	}
>>  
>> +
>> +	my $full_hash = git_get_full_hash($project, $hash);
>> +	if ($full_hash =~ /^$hash/) {
>> +		$hash = git_get_short_hash($project, $hash);
>> +	} else {
>> +		$hash .= '-' . git_get_short_hash($project, $hash);
>> +	}
> 
> I think we might want to avoid calling git_get_full_hash (and extra call
> to "git rev-parse" command, which is extra fork) if we know in advance
> that  $full_hash =~ /^$hash/  can't be true, i.e. if $hash doesn't match
> /^[0-9a-fA-F]+$/.  That would require that we continue to use $hash
> and not $full_hash, see comment for the chunk below.
> 
> BTW do you think that having better name (nicer name in the case
> when $hash is full SHA-1, or name which describes exact version as 
> in the case when $hash is branch name or just 'HEAD') is worth
> slight extra cost of "git rev-parse --abbrev=7"?

Hmm, yeah, some optimization will have to occur in that block of
code. Though, my reason for that extra call to rev-parse to get the
short hash is so I can get git to find the shortest unique SHA-1,
instead of just assuming that it will always be of length 7. I think
the cost is not too bad considering a snapshot will have to be generated
and probably take way more time. Though, warthog9 has some caching
patches that work, so maybe it isn't worth it. Hmm...

>>  	my $name = $project;
>>  	$name =~ s,([^/])/*\.git$,$1,;
>>  	$name = basename($name);
>> @@ -5213,7 +5245,7 @@ sub git_snapshot {
>>  	$cmd = quote_command(
>>  		git_cmd(), 'archive',
>>  		"--format=$known_snapshot_formats{$format}{'format'}",
>> -		"--prefix=$name/", $hash);
>> +		"--prefix=$name/", $full_hash);
> 
> Why this change?

Since $hash can change by becoming something like 'HEAD-43ab5f2c' due to
the process of creating the better name we need to pass something to
`archive' that will be valid, and $full_hash will be valid.

>> +test_description='gitweb as standalone script (parsing script output).
>> +
>> +This test runs gitweb (git web interface) as a CGI script from the
>> +commandline, and checks that it produces the correct output, either
>> +in the HTTP header or the actual script output.'
> 
> Currently all tests here are about 'snapshot' action.  They are quite
> specific, and they do require some knowledge about chosen archive format.
> I think it would be better to put snapshot test into separate test,
> i.e. in 't/t9502-gitweb-standalone-snapshot.sh'.
> 

Ok.

>> +test_commit \
>> +	'SnapshotFileTests' \
>> +	'i can has snapshot?'
> 
> Errr... with filename [cutely] called 'i can has snapshot?' you would
> have, I guess, problems with tests on MS Windows, where IIRC '?' is
> forbidden in filenames.

I was able to confirm `?' as a forbidden file name character in Windows 7,
so I will have to change that...

> In the test below you use "git rev-parse --verify HEAD" and
> "git rev-parse --short HEAD" over and over.  I think it would be better
> to calculate them upfront:
> 
>   +test_expect_success 'calculate full and short ids' '
>   +	FULLID= $(git rev-parse --verify  HEAD) &&
>   +	SHORTID=$(git rev-parse --short=7 HEAD)
>   +'
> 

Ok.

>> +	ID=`git rev-parse --short HEAD` &&
>> +	grep ".git-$ID.tar.gz" gitweb.output
> 
> Here had to think a bit that gitweb.output consists both of HTTP headers,
> and of response body, and you are grepping here in the HTTP headers part.
> It would be better solution for gitweb_run to split gitweb.output into
> gitweb.headers and gitweb.body (perhaps if requested by setting some
> variable, e.g. GITWEB_SPLIT_OUTPUT).
> 
> It can be done using the following lines:
> 
> 	sed    -e '/^\r$/'      <gitweb.output >gitweb.headers
> 	sed -n -e '0,/^\r$/!p'  <gitweb.output >gitweb.body
> 
> 	# gitweb.headers is used to parse http headers
> 	# gitweb.body is response without http headers
> 
> But the second one uses GNU sed extension; I don't know how to write
> it in more portable way.

I like this and will try to find a way of setting this up without using
GNU extensions.

> Note that this would mean that t/t9501-gitweb-standalone-http-status.sh
> should also be updated to use gitweb.headers and gitweb.body

Yeah, now I have a few things mentioned by either you or Junio that I
should probably fix in the test cases I have submitted. I will clean
them up in a separate patch once I finish with this patch.

>> +	gitweb_run "p=.git;a=snapshot;h=SnapshotFileTests;sf=tgz" &&
>> +	ID=`git rev-parse --short SnapshotFileTests` &&
>> +	grep ".git-SnapshotFileTests-$ID.tar.gz" gitweb.output
>> +'
>> +test_debug 'cat gitweb.output'
> 
> Note that to avoid ambiguities currently gitweb uses refs/heads/master
> and refs/tags/SnapshotFileTests... but dealing with this issue should be
> left, I think, for separate commit.
> 

I do not understand what ambiguity exists, can you please explain this?


-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca
