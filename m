From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Thu, 31 Jul 2008 14:45:29 +0400
Message-ID: <20080731104529.GE7008@dpotapov.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807311243.35219.litvinov2004@gmail.com> <200807311257.49108.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 12:46:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOVg4-0001qn-Qa
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 12:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYGaKpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 06:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYGaKpf
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 06:45:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:31612 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbYGaKpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 06:45:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so238740fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MlY6QF31KQ0ovr3igB6hppf+GNG3DpldZ5CRueJgCPg=;
        b=uP/6wVPpgAd/BWLd49eSCTnoGJvYFJcjVq9urGG8TahJTEVaqNHMiNkA5FhJX8sjAG
         K7kLj5Q5m5pa4ko/Lh8hgaJJ5wfTPpZGYxYwPEyQsk9H5rXXS4Mu8RtR1AL5Mnuc/h9d
         o0kKUpuueZXI/PqFMNmd6onlUPGd5n363D3Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gtZhQanMRw4noMqjdGpMlsE2rW13mzpgA+wp183J0iTRAAbLV0hrnJin5HVlbSJZQG
         BDftk+j+rRtppWtkEC+lUA877Jasy974XFCR8KdupGfDzASv+b3TfHSc1vuT/s6L0lQ/
         pz5NRyyEg65tmoJMSNUtS1dHBGmizzf1jmpeU=
Received: by 10.86.51.10 with SMTP id y10mr5940426fgy.6.1217501133130;
        Thu, 31 Jul 2008 03:45:33 -0700 (PDT)
Received: from localhost ( [85.141.148.53])
        by mx.google.com with ESMTPS id d4sm2443499fga.8.2008.07.31.03.45.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 03:45:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807311257.49108.litvinov2004@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90922>

On Thu, Jul 31, 2008 at 12:57:48PM +0700, Alexander Litvinov wrote:
> 
> git-svn fetch files with this patch but I have found that git-svn use 
> git-hash-object and provide file name to store into stdin. As far as file is 
> a temp file git-hash-object can't correctly apply crlf convertion for the 
> file.

It does not look to be true. I did the following test:

mkdir hash_test
cd hash_test
git init

cat <<\=== > hash_test.pl
#!/usr/bin/env perl

use File::Temp qw/tempfile/;

my ($tmp_fh, $tmp_filename) = File::Temp::tempfile(UNLINK => 1);
print $tmp_fh "Hi\r\n";
$tmp_fh->flush;
system ("echo $tmp_filename | git hash-object --stdin-paths");
===

git config core.autocrlf true
perl hash_test.pl
git config core.autocrlf false
perl hash_test.pl


and the output was
b14df6442ea5a1b382985a6549b85d435376c351
ea6b6afbc2cbed0eb8c0f7561286ab72f349416c

which means that the autocrlf conversion is done for temporary
files created by perl. (I tested it on Linux and Windows/Cygwin).

In any case, I believe the right solution should be adding a
new option to git-hash-object to disable any conversion.

Dmitry
