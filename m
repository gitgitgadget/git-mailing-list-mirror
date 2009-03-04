From: Dave <kilroyd@googlemail.com>
Subject: Re: [Orinoco-users] linux-firmware binary corruption with gitweb
Date: Wed, 04 Mar 2009 23:52:09 +0000
Message-ID: <49AF1429.9080009@gmail.com>
References: <49A98F6A.50702@gmail.com> <1235886467.3195.15.camel@mj>	<49AD7E2B.3010101@gmail.com> <m3iqmqt9ox.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, orinoco-users@lists.sourceforge.net,
	dwmw2@infradead.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 00:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf0uR-0005yJ-TC
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 00:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZCDXw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 18:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZCDXw0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 18:52:26 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:3815 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZCDXwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 18:52:25 -0500
Received: by ey-out-2122.google.com with SMTP id 25so748655eya.37
        for <multiple recipients>; Wed, 04 Mar 2009 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=iPw07nS92p+jhbB782ulkvzAmHnynoc/3UFMhVB5ypE=;
        b=caYz4M/GeTWK32+UGaLYgZ3mr6K+wGEn3XEHKfAbUCrL41nRLIFhA1hIDsv2QaL12+
         s+xTNcb1Kj6mNzt/xq0zwDqY3FZh7m4Q2lhoWJbw8MdNFDpOy0o0md8sFZm9w451f41O
         3Wi3FBxeBmrSUp6JMWNxEesT4ZBTXcymOXMxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HTQbliLcT7mp5jMsnfm5laxEUNG26FpSFOYUU6Ufl3U4D4KU4w+YodaqRcVXX7DRI3
         Y2vmztfYpF4PwshhFclpc5yjsOufUpksjOAxqQAZaZcKwaxtrGmfYF1ycgV2kgUQcmtr
         3B9vPnHer4sL/4Bo0Wk4PTUC/mkNXvKWpPyhs=
Received: by 10.210.41.14 with SMTP id o14mr5410490ebo.8.1236210741756;
        Wed, 04 Mar 2009 15:52:21 -0800 (PST)
Received: from ?192.168.0.4? (5ac998a0.bb.sky.com [90.201.152.160])
        by mx.google.com with ESMTPS id 7sm674996eyb.48.2009.03.04.15.52.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 15:52:21 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090104)
In-Reply-To: <m3iqmqt9ox.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112246>

Jakub Narebski wrote:
> Dave <kilroyd@googlemail.com> writes:
>>> My strong impression is that the recoding takes place on the server.  I
>>> think the bug should be reported to the gitweb maintainers unless it a
>>> local breakage on the kernel.org site.
>> Thanks Pavel.
>>
>> I just did a quick scan of the gitweb README - is this an issue with the
>> $mimetypes_file or $fallback_encoding configurations variables?
> 
> First, what version of gitweb do you use? It should be in 'Generator'
> meta header, or (in older gitweb) in comments in HTML source at the
> top of the page.

Not sure where I'd find the meta header, but at the top of the HTML:

<!-- git web interface version 1.4.5-rc0.GIT-dirty, (C) 2005-2006, Kay
Sievers <kay.sievers@vrfy.org>, Christian Gierke -->
<!-- git core binaries version 1.6.1.1 -->

> Second, the file is actually sent to browser 'as is', using binmode :raw
> (or at least should be according to my understanding of Perl). And *.bin
> binary file gets application/octet-stream mimetype, and doesn't send any
> charset info. git.kernel.org should have modern enough gitweb to use this.
> Strange...

Dug around gitweb.perl in the main git repo. Then looked at the
git/warthog9/gitweb.git repo (after noting the Git Wiki says kernel.org
is running John Hawley's branch).

One notable change to git_blob_plain:

        undef $/;
        binmode STDOUT, ':raw';
-        print <$fd>;
+        #print <$fd>;
+        $output .= <$fd>;
        binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
        $/ = "\n";

        close $fd;
+
+        return $output;

If that's the code that's running, doesn't that mean the output mode
change doesn't impact the concatenation to $output? So the blob gets utf
encoding when actually printed.


Regards,

Dave.
