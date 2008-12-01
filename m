From: Liu Yubao <yubao.liu@gmail.com>
Subject: two questions about the format of loose object
Date: Mon, 01 Dec 2008 16:00:55 +0800
Message-ID: <493399B7.5000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 09:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L73kA-0007hz-T6
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 09:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYLAIBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 03:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbYLAIBJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 03:01:09 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:13657 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYLAIBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 03:01:07 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1549664tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 00:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Lel4USyYSMI6/99sRtx3g7sUKlJT83G+4Tb5cl7jvDs=;
        b=c5++ce38kKUNxSXzO8LT2K0YmdG+cxckQdsJ+MHpI8u7SOAXSxQ4wGKzhRDlGBiVa8
         lt62S//3yRE3Vfs+/C1Z10aeeQC3ZTXsuWalzA9hYV/FsGFOfRRsh8DAj+pwUH0bNHCL
         A5U7SVoXAqaRnVe9FSWcwGRw1W2L+mZWJL7z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=KIzKOSp62E7jfss9pZE11qCaNNj9U3dEHAma2SnYBOA5mxNvLSljVRIymnJsy45xWa
         uo7PElkv74BjbERV4+nTrPgNsG9KYL6p+i5BvmhkhuvovGrsG4m7tkeNGC8PGEbBoVtW
         l+q16HWH9Eb9bpCtLfQ+JF/uiL1NNKmRjnS+A=
Received: by 10.110.63.17 with SMTP id l17mr1423477tia.23.1228118464998;
        Mon, 01 Dec 2008 00:01:04 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id u12sm9127898tia.3.2008.12.01.00.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 00:01:03 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102001>

Hi,

In current implementation the loose objects are compressed:

     loose object = deflate(typename + <space> + size + '\0' + data)

In sha1_file.c:unpack_sha1_file():
	1) unpack_sha1_header() inflates first 8KB
        2) parse_sha1_header() gets object's size
        3) unpack_sha1_reset() allocates a (1+size) bytes buffer and
           copy the first 8KB without header to it.

* Question 1:

Why not use the format below for loose object?
    loose object = typename + <space> + size + '\0' + deflate(data)

So the size of loose object can be known before inflating it, in
step 3 above the 8KB memcpy isn't required.

In general, deflate() can decrease file size by 70% for text file, 
I checked the git source and linux-2.6 source and got the statistical
data below:

.------------------+--------------+--------.
|                  | <= (8/0.3)KB | <= 8KB |
|------------------+--------------+--------|
| git-1.6.03       |          97% |    84% |
| linux-2.6.27-rc6 |          90% |    66% |
`------------------+--------------+--------'


* Question 2:

Why not use uncompressed loose object? That's to say:
   loose object = typename + <space> + size + '\0' + data

I did a simple benchmark on my notebook and a server in my company,
writing a big file to disk is faster than compressing it first and
writing the result out. The former's performance for reading should
also be better because of file cache.

The current implementation caches objects in one process, the objects
can't be shared by many processes because they are uncompressed
to heap memory area of each process.

Uncompressed loose objects are better for sharing objects among
multiple git processes because they can be used directly after being
mmap-ed.

And I guess the most frequently used objects are loose objects
when you do some coding(git add, git diff, git diff --cached, git merge),
using uncompressed loose objects avoids uncompressing loose objects again
and again.


Below is the result of my simple benchmark:

########################################
# on my notebook
$ perl b.pl git-1.5.6/Makefile 1000
               Rate   compressed uncompressed
compressed    198/s           --         -92%
uncompressed 2463/s        1147%           --


$ perl b.pl git-1.5.6/parse-options.c 2000
               Rate   compressed uncompressed
compressed    341/s           --         -88%
uncompressed 2845/s         734%           --


$ find git-1.5.6/ -name "*.[ch]" -exec cat {} + > all.c
$ perl b.pl all.c 1000
               Rate   compressed uncompressed
compressed   3.39/s           --         -97%
uncompressed  111/s        3182%           --

#######################################
# on a server
$ perl b.pl Makefile 6000
            (warning: too few iterations for a reliable count)
                Rate   compressed uncompressed
compressed     447/s           --         -98%
uncompressed 18750/s        4094%           --

$ perl b.pl parse-options.c 8000
            (warning: too few iterations for a reliable count)
                Rate   compressed uncompressed
compressed    1130/s           --         -97%
uncompressed 33333/s        2850%           --

$ perl b.pl all.c 1000
               Rate   compressed uncompressed
compressed   5.48/s           --         -95%
uncompressed  115/s        1997%           

#####################################################
# b.pl
#!/usr/bin/perl
use strict;
use warnings;
use Benchmark qw(:hireswallclock cmpthese);
use File::Slurp;
use IO::Compress::Deflate qw(deflate $DeflateError);

my $text = read_file($ARGV[0], binmode => ':raw');

cmpthese($ARGV[1], {'compressed' => \&zip, 'uncompressed' => \&output});

sub zip {
    deflate \$text => 'all.c.z' || die "$!\n";
}

sub output {
    write_file("all2.c", {binmode => ':raw'}, $text);
}
