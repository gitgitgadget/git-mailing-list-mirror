From: Chris Wilson <cwilson@vigilantsw.com>
Subject: Re: [PATCH] Fix config_file file leak.
Date: Thu, 14 Jul 2011 14:29:19 -0400
Message-ID: <20110714182919.GB23288@localhost>
References: <20110714181948.GA23288@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 20:29:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQfB-0005hn-T6
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab1GNS3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:29:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51171 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab1GNS3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:29:23 -0400
Received: by iyb12 with SMTP id 12so467239iyb.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:29:23 -0700 (PDT)
Received: by 10.42.3.144 with SMTP id 16mr2605602ico.284.1310668163103;
        Thu, 14 Jul 2011 11:29:23 -0700 (PDT)
Received: from localhost (c-67-180-177-185.hsd1.ca.comcast.net [67.180.177.185])
        by mx.google.com with ESMTPS id v16sm293657ibf.59.2011.07.14.11.29.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 11:29:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110714181948.GA23288@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177147>

On Thu, Jul 14, 2011 at 02:19:48PM -0400, Chris Wilson wrote:
> Hi,
> 
> We are using Sentry (a C/C++ static analysis tool) to analyze
> git on a nightly basis. Sentry found that a file leak
> was recently introduced in the commit 924aaf3.
> 
> I'm hoping the attached patch correctly fixes up this leak.

Oops, sorry if I was unclear. This happens in config.c here,
http://git.kernel.org/?p=git/git.git;a=blob;f=config.c;h=1fc063b2562101687b9215e5b697a91fcffdd5bb;hb=924aaf3ef764a5e8e976f68e024ecacf54ff6306
  
This happens once the file is opened successfully here,
  1449         if (!(config_file = fopen(config_filename, "rb"))) {
and then you enter the while loop here,
  1454         while (fgets(buf, sizeof(buf), config_file)) {
and then you take any 'goto out;' in the while loop, which doesn't
close the file handle.

1505  out:
1506         free(config_filename);
1507         return ret;
1508 }


Chris
