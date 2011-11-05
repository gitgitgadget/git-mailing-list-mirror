From: Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCHv2] Add options to specify snapshot file name, prefix
Date: Fri, 04 Nov 2011 20:52:25 -0400
Message-ID: <4EB488C9.2050301@aei.ca>
References: <1320302318-28315-1-git-send-email-dermoth@aei.ca>	<1320367999-24435-1-git-send-email-dermoth@aei.ca> <m3fwi350ou.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 01:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMUUr-0002O3-QC
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 01:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab1KEAw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 20:52:29 -0400
Received: from mail001.aei.ca ([206.123.6.130]:57015 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab1KEAw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 20:52:29 -0400
Received: (qmail 14982 invoked by uid 89); 5 Nov 2011 00:52:28 -0000
Received: by simscan 1.2.0 ppid: 14975, pid: 14978, t: 0.0027s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 5 Nov 2011 00:52:28 -0000
Received: (qmail 7721 invoked by uid 89); 5 Nov 2011 00:52:28 -0000
Received: by simscan 1.2.0 ppid: 7703, pid: 7709, t: 1.2057s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.1/m: spam: 3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from ppp-55-39.mtl.contact.net (HELO ?192.168.1.200?) (dermoth@216.221.55.39)
  by mail.aei.ca with ESMTPA; 5 Nov 2011 00:52:26 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <m3fwi350ou.fsf@localhost.localdomain>
X-Enigmail-Version: 1.1.2
OpenPGP: id=DE417216;
	url=http://pgpkeys.mit.edu:11371/pks/lookup?op=get&search=0xDE417216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184812>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11-11-04 12:10 PM, Jakub Narebski wrote:
> Thomas Guyot-Sionnest <dermoth@aei.ca> writes:
> 
>> commit b629275 implemented "smart" snapshot names and prefixes. I have
>> scripts that used to rely on the old behaviour which allowed in some
>> cases to have fixed prefix, and would require modifications to work with
>> newer Gitweb.
> 
> If scripts use 'wget' or 'curl' you can always change the name of
> saved file:
> 
>   wget -O <file> ...
>   curl -o <file> ...
> 
> If downloaded snapshot is compressed tarfile, you can use
> --strip-components=1 to strip prefix.

I actually didn't care about the filename (in my script I pipe straight
to tar, and in a python app I have that will use snapshots I have I
planned on "opening" the url as a stream directly with the tarfile lib);
it was just as easy to add both anyway.

I thought I had looked up the tar man page for an option that strips the
path, clearly I missed that one. :)

>> This patch adds two parameters for overriding the snapshot name and
>> prefix, sn and sp respectively. For example, to get a snapshot
>> named "myproject.[suffix]" with no prefix one can add this query string:
>>   ?sn=myproject;sp=
> 
> Would you need support for expandable parameters in both (a la
> 'action' feature)?

I'm not sure what you mean... I never tinkered with gitweb.pl directly
before.

> [...] 
>> @@ -6684,11 +6686,19 @@ sub git_snapshot {
>>  	}
>>  
>>  	my ($name, $prefix) = snapshot_name($project, $hash);
>> +	if (defined($input_params{'snapshot_name'})) {
>> +		$name = $input_params{'snapshot_name'};
>> +	}
>> +	if (defined($input_params{'snapshot_prefix'})) {
>> +		$prefix = $input_params{'snapshot_prefix'};
>> +	} else {
>> +		$prefix .= '/';
>> +	}
>>  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
>>  	my $cmd = quote_command(
>>  		git_cmd(), 'archive',
>>  		"--format=$known_snapshot_formats{$format}{'format'}",
>> -		"--prefix=$prefix/", $hash);
>> +		"--prefix=$prefix", $hash);
>>  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
>>  		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
>>  	}
> 
> I wonder if you really want to allow prefix which do not end in '/'

I kind of agree, yet considering its lack of "front-end" visibility it
made me think of plumbing commands like git-checkout-index (which I use
sometimes to replace the "missing" git export) where prefix is nothing
more than an appended string to file names.

And now I remember, this is also exactly how git-archive works.

> (which would be suprising, isn't it), or just allow empty prefix too.
>
>
> For example
> 
>   @@ -6684,11 +6686,19 @@ sub git_snapshot {
>    	}
>    
>    	my ($name, $prefix) = snapshot_name($project, $hash);
>   +	if (defined($input_params{'snapshot_name'})) {
>   +		$name = $input_params{'snapshot_name'};
>   +	}
>   +	if (defined($input_params{'snapshot_prefix'})) {
>   +		$prefix = $input_params{'snapshot_prefix'};
>   +	}
>    	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
>    	my $cmd = quote_command(
>    		git_cmd(), 'archive',
>    		"--format=$known_snapshot_formats{$format}{'format'}",
>   -		"--prefix=$prefix/", $hash);
>   +		($prefix eq "" ? () : "--prefix=$prefix"), $hash);
>    	if (exists $known_snapshot_formats{$format}{'compressor'}) {
>    		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
>    	}
> 

You still have to add the /, i.e.:

>   +		($prefix eq "" ? () : "--prefix=$prefix/"), $hash);

And personally, I think git-archive is the one that should add a / - it
has much more visibility to end-users than this obscure query-string.

- -- 
Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk60iMAACgkQ6dZ+Kt5BchbOFwCgmDuUVd9vI+ZC8JDQPS+SC7e2
FpIAnAkf6BrmAcvY/3GA1wjQvR9s50c6
=0pb2
-----END PGP SIGNATURE-----
