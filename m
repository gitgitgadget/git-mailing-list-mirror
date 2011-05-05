From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: How to efficiently find where a patch applies?
Date: Thu, 5 May 2011 13:17:41 -0500
Message-ID: <20110505181741.GA27251@nwp-laptop>
Reply-To: nathan.panike@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 20:17:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI37M-00030X-PW
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab1EESRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:17:35 -0400
Received: from mail-iw0-f194.google.com ([209.85.214.194]:37190 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab1EESRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:17:35 -0400
Received: by iwc10 with SMTP id 10so493092iwc.1
        for <git@vger.kernel.org>; Thu, 05 May 2011 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:reply-to
         :mime-version:content-type:content-disposition:user-agent;
        bh=Ie8iyMoZECeMDgwDpyw9CvhSMwfGO9NqwEYwC07vo/c=;
        b=sB7VZtpS3FIWCMe58O/HKUVaVD2DxnHgudtFSH0JI4zoTagS8K3KEto8M1TgJfqD54
         4OkdDDHB2twHpuIUIU6/vOq0YOw+iGYvGPmRcaDWlVAjmTyaRwcaK0mAZVZcgvvZDTlv
         W0H5onjowIBipKR5PQGd1DgCAc/mWA69GfeJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:reply-to:mime-version:content-type
         :content-disposition:user-agent;
        b=ndNfmoUWA2jozn+oXHhtxvUnVnWgsFYv4niFwuK4KRNmgluFxo7dsCaU5ePY9eA7+8
         LqpItkcw2A2MLXV8lNBF0LubJKUbEvfhJ08wHsK3w0hUYOvWDXTwQKZx/K9sWW2/CkPv
         k/J/4YrmoANT6sQKsepUrxdghL4DJfCGmKg6s=
Received: by 10.42.224.195 with SMTP id ip3mr1410806icb.183.1304619454573;
        Thu, 05 May 2011 11:17:34 -0700 (PDT)
Received: from localhost ([128.104.153.131])
        by mx.google.com with ESMTPS id c1sm990351ibe.17.2011.05.05.11.17.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 11:17:34 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172865>

In the past couple weeks, I have had several occasions where a collaborator has
sent a patch, which does not have information about where the patch forked from
master.  I wrote the following scripts to try to discover where the patch
should be applied.  Is there a better way?

create_awk.pl:
----------------------->8------------------------------------------
#! /usr/bin/env perl
print <<HEADER;
BEGIN {
	i = 0
}
HEADER

print "/";

my $numseen=0;
my $nummatches = 0;
while(<STDIN>){
	if(/^index ([0-9a-f]+)\.\..+$/){
		$hash = $1;
	} else {
		next;
	}
	if($hash =~ /^0*$/) {
		next;
	}
	print "|" if($numseen > 0);
	$numseen = 1;
	++$nummatches;
	print "$hash";	
}
print "/{ i += 1; print \$0}\n";

print <<FOOTER;
END {
	if( i == $nummatches) {
		print "FOUND IT";
		exit 1;
	}
	print "i =",i;
	exit 0;
}
FOOTER
----------------------->8------------------------------------------

To find the place where the patch applies, I then would run something like

git rev-list --all | \
while read commit; do \
	git ls-tree -r $commit | \
	awk "$(perl ~/programs/git-hacks/create_awk.pl < <patch file>)" > /dev/null || \
	echo $commit; \
done

Nathan Panike
