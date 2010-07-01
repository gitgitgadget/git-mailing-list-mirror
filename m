From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a
 whole repo
Date: Thu, 1 Jul 2010 15:05:25 -0500
Message-ID: <20100701200525.GA3686@burratino>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:07:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQ2G-00059Y-50
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab0GAUGt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:06:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49081 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab0GAUGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:06:48 -0400
Received: by iwn7 with SMTP id 7so2386574iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vueBNZ0q1BzOlXNt087iGrK09jbrZ8wrtMyRwWAm9Yc=;
        b=SyOWp42ZFAmJ5y7iMA8opVmLruGRmkUtQ/dtmR919bhBo7dox+rXDfpETx9WhLPFKy
         E22gFOwccvPttv6Zxz3J8tYEvJTpHk5NJ3sLNwwdrfGAR48TnxnTJnMVE1skROBLEShd
         RcuNRrJ9lT77qMiHCVYHHNVVgdOwzP+QBidxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=m7CHRzxQHCV1z3guLJMJAuFGzZyvEbhD+8g5mSFLs2DR91CynuxyUww8OjN/CI7oVW
         495XcxE4iIEO1+ZItxFN7DdbtHojCRkanCcjIt83bUhuwria8M+1/hYfTiswicu4OuKq
         1J1xMqM4Y7iCH7xrsoFYCVT9ufpVg2LrIV+Q8=
Received: by 10.231.184.75 with SMTP id cj11mr1047ibb.51.1278014752409;
        Thu, 01 Jul 2010 13:05:52 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm5888409ibo.6.2010.07.01.13.05.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:05:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150065>

Hi Tim,

Tim Visher wrote:

> I need to get a listing of the entire contents of my current repo (as
> in, I don't need deleted files or anything like that, just the curren=
t
> snapshot) with the time the file was committed and who committed it.

You might be able to adapt Eric=E2=80=99s set-file-times script from [1=
].

The set-file-times script was designed to produce consistent
Last-Modified headers when serving static content from a cluster of
HTTP servers.  It does not do the right thing for merges (it is
missing at least =E2=80=98-c=E2=80=99), though it will at least produce=
 consistent
results in that case.  See the wiki page for details.

=46or reference:

 #!/usr/bin/perl -w
 # Use of this script in combination with =E2=80=98make=E2=80=99 is ask=
ing for trouble.

 use strict;

 my %ls =3D ();
 my $commit_time;

 $/ =3D "\0";
 open FH, 'git ls-files -z|' or die $!;
 while (<FH>) {
	chomp;
	$ls{$_} =3D $_;
 }
 close FH;

 $/ =3D "\n";
 open FH, "git log -r --name-only --no-color --pretty=3Draw -z @ARGV |"
 or die $!;
 while (<FH>) {
	chomp;
	if (/^committer .*? (\d+) (?:[\-\+]\d+)$/) {
		$commit_time =3D $1;
	} elsif (s/\0\0commit [a-f0-9]{40}$// or s/\0$//) {
		my @files =3D delete @ls{split(/\0/, $_)};
		@files =3D grep { defined $_ } @files;
		next unless @files;
		utime $commit_time, $commit_time, @files;
	}
	last unless %ls;
 }
 close FH;

Hope that helps,
Jonathan

[1] https://git.wiki.kernel.org/index.php/ExampleScripts#Setting_the_ti=
mestamps_of_the_files_to_the_commit_timestamp_of_the_commit_which_last_=
touched_them
