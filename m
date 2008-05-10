From: "James Sadler" <freshtonic@gmail.com>
Subject: Re: git filter-branch --subdirectory-filter
Date: Sat, 10 May 2008 17:10:21 +1000
Message-ID: <e5e204700805100010k4f1bee78y7d387d660cca3f35@mail.gmail.com>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
	 <20080509013300.GA7836@sigill.intra.peff.net>
	 <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
	 <20080509080039.GA15393@sigill.intra.peff.net>
	 <e5e204700805092031m14c3d6c2kb85b51af5a1ee8f7@mail.gmail.com>
	 <20080510055332.GB11556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 10 09:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JujEj-0004QO-Vd
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 09:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbYEJHK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 03:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbYEJHK2
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 03:10:28 -0400
Received: from hs-out-0708.google.com ([64.233.178.247]:45200 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYEJHK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 03:10:27 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1159681hsl.5
        for <git@vger.kernel.org>; Sat, 10 May 2008 00:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cvutNoezxWhbNKwCDmrfjDLEhyOsUAHbMrF418O809A=;
        b=RsSrZ8C3jWB2s8thXqRFme4AYD+uWTcA5Et3TVR+BsD/lbpUbEXN0Am268+qHLl9H60JzvXYlnCzKFtVYob3+0LxNwXxZfi6lBn2dzf5QIPZjx4CphWU+zhnInNBL6HvZc2ReUDxm06U0LqPVESIxOnVvc06NUkUFlZICkh331M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bIyWP6M4D+DkYJk3GrNb/7sOSWZZq7zOTLlYn6fFt/8MOBRL1JAnC/UIQljMM6N+P26gvQ8efDlBx6h/8PFQhVWyZ3f4RB5uyciGMx4N1jfeihwhkPWCGVG8W+W1yV7ApE8eW4Dlrlr67Bk5pEnRlE58MqkeubudSOMl/FhCipU=
Received: by 10.90.92.10 with SMTP id p10mr7629094agb.23.1210403421404;
        Sat, 10 May 2008 00:10:21 -0700 (PDT)
Received: by 10.90.114.9 with HTTP; Sat, 10 May 2008 00:10:21 -0700 (PDT)
In-Reply-To: <20080510055332.GB11556@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81655>

Excellent!  I'll give that a whirl, thanks.

- James.

2008/5/10 Jeff King <peff@peff.net>:
> On Sat, May 10, 2008 at 01:31:37PM +1000, James Sadler wrote:
>
>> Does anybody have a script that can take an existing repo, and create
>> a new one with garbled-but-equivalent commits?  i.e.  file and
>> directory structure is same with names changed, and there is a one-one
>> relationship between lines of text in new repo and old one except the
>> lines have been scrambled?  It would be a useful tool for distributing
>> private repositories for debugging reasons.
>
> This is only lightly tested, but the script below should do the trick.
> It works as an index filter which munges all content in such a way that
> a particular line is always given the same replacement text. That means
> that diffs will look approximately the same, but will add and remove
> lines that say "Fake line XXX" instead of the actual content.
>
> You can munge the commit messages themselves by just replacing them with
> some unique text; in the example below, we just replace them with the
> md5sum of the content.
>
> This will leave the original author, committer, and date, which is
> presumably non-proprietary.
>
> -- >8 --
> #!/usr/bin/perl
> #
> # Obscure a repository while still maintaining the same history
> # structure and diffs.
> #
> # Invoke as:
> #   git filter-branch \
> #     --msg-filter md5sum \
> #     --index-filter /path/to/this/script
>
> use strict;
> use IPC::Open2;
> use DB_File;
> use Fcntl;
> tie my %blob_cache, 'DB_File', 'blob-cache', O_RDWR|O_CREAT, 0666;
> tie my %line_cache, 'DB_File', 'line-cache', O_RDWR|O_CREAT, 0666;
>
> open(my $lsfiles, '-|', qw(git ls-files --stage))
>  or die "unable to open ls-files: $!";
> open(my $update, '|-', qw(git update-index --index-info))
>  or die "unable to open upate-inex: $!";
>
> while(<$lsfiles>) {
>  my ($mode, $hash, $path) = /^(\d+) ([0-9a-f]{40}) \d\t(.*)/
>    or die "bad ls-files line: $_";
>  $blob_cache{$hash} = munge($hash)
>    unless exists $blob_cache{$hash};
>  print $update "$mode $blob_cache{$hash}\t$path\n";
> }
>
> close($lsfiles);
> close($update);
> exit $?;
>
> sub munge {
>  my $h = shift;
>
>  open(my $in, '-|', qw(git show), $h)
>    or die "unable to open git show: $!";
>  open2(my $hash, my $out, qw(git hash-object -w --stdin));
>
>  while(<$in>) {
>    $line_cache{$_} ||= 'Fake line ' . $line_cache{CURRENT}++ . "\n";
>    print $out $line_cache{$_};
>  }
>
>  close($in);
>  close($out);
>
>  my $r = <$hash>;
>  chomp $r;
>  return $r;
> }
>



-- 
James
