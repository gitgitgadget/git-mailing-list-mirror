From: Alfred Perlstein <bright@mu.org>
Subject: Re: [PATCH] git-svn: Support for git-svn propset
Date: Mon, 8 Dec 2014 15:43:00 -0800
Message-ID: <04BE232D-0198-4DEA-90ED-8C8E36456CC5@mu.org>
References: <20141207104723.GB54199@elvis.mu.org> <20141208213636.GA3743@dcvr.yhbt.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Alfred Perlstein <alfred@freebsd.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>,
	David Fraser <davidf@sjsoft.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 00:49:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy83t-0004Ny-CP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 00:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbaLHXtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 18:49:49 -0500
Received: from elvis.mu.org ([192.203.228.196]:13690 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaLHXts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 18:49:48 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Dec 2014 18:49:48 EST
Received: from [100.89.165.221] (220.sub-70-197-14.myvzw.com [70.197.14.220])
	by elvis.mu.org (Postfix) with ESMTPSA id B126C341F873;
	Mon,  8 Dec 2014 15:43:02 -0800 (PST)
X-Mailer: iPhone Mail (12B436)
In-Reply-To: <20141208213636.GA3743@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261099>



> On Dec 8, 2014, at 1:36 PM, Eric Wong <normalperson@yhbt.net> wrote:
> 
> Alfred Perlstein <alfred@freebsd.org> wrote:
>> Appearing here:
>>  http://marc.info/?l=git&m=125259772625008&w=2
> 
> Probably better to use a mid URL here, too
> 
> http://mid.gmane.org/1927112650.1281253084529659.JavaMail.root@klofta.sjsoft.com
> 
> such a long URL, though...
> 
>> --- a/perl/Git/SVN/Editor.pm
>> +++ b/perl/Git/SVN/Editor.pm
>> @@ -288,6 +288,44 @@ sub apply_autoprops {
>>    }
>> }
>> 
>> +sub check_attr {
>> +    my ($attr,$path) = @_;
>> +    my $fh = command_output_pipe("check-attr", $attr, "--", $path);
>> +    return undef if (!$fh);
>> +
>> +    my $val = <$fh>;
>> +    close $fh;
>> +    if ($val) { $val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/; }
>> +    return $val;
>> +}
> 
> I just noticed command_output_pipe didn't use a corresponding
> command_close_pipe to check for errors, but command_oneline is even
> better.  I'll squash the following:
> 
> --- a/perl/Git/SVN/Editor.pm
> +++ b/perl/Git/SVN/Editor.pm
> @@ -290,11 +290,7 @@ sub apply_autoprops {
> 
> sub check_attr {
>    my ($attr,$path) = @_;
> -    my $fh = command_output_pipe("check-attr", $attr, "--", $path);
> -    return undef if (!$fh);
> -
> -    my $val = <$fh>;
> -    close $fh;
> +    my $val = command_oneline("check-attr", $attr, "--", $path);
>    if ($val) { $val =~ s/^[^:]*:\s*[^:]*:\s*(.*)\s*$/$1/; }
>    return $val;
> }
> 
> In your test, "local" isn't portable, unfortunately, but tests seem to
> work fine without local so I've removed them:
> 
> --- a/t/t9148-git-svn-propset.sh
> +++ b/t/t9148-git-svn-propset.sh
> @@ -29,10 +29,9 @@ test_expect_success 'fetch revisions from svn' '
>    git svn fetch
>    '
> 
> -set_props()
> -{
> -    local subdir="$1"
> -    local file="$2"
> +set_props () {
> +    subdir="$1"
> +    file="$2"
>    shift;shift;
>    (cd "$subdir" &&
>        while [ $# -gt 0 ] ; do
> @@ -43,10 +42,9 @@ set_props()
>        git commit -m "testing propset" "$file")
> }
> 
> -confirm_props()
> -{
> -    local subdir="$1"
> -    local file="$2"
> +confirm_props () {
> +    subdir="$1"
> +    file="$2"
>    shift;shift;
>    (set -e ; cd "svn_project/$subdir" &&
>        while [ $# -gt 0 ] ; do
> 
> Unless there's other improvements we missed, I'll push out your v3 with
> my changes squashed in for Junio to pull in a day or two.  Thank you
> again for working on this!
> 

Eric,

All looks good to me. 

Thank you all very much for the feedback and help.  It's made this a very rewarding endeavor. 

-Alfred. 