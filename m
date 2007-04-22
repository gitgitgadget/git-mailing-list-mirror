From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver 
 definition.
Date: Sat, 21 Apr 2007 18:33:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704211821560.5655@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net>
 <11771520591703-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 04:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfRTd-0000PR-RI
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 04:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbXDVCGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 22:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbXDVCGc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 22:06:32 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:37532 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753994AbXDVCGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 22:06:31 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 21 Apr 2007 19:06:30 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 21 Apr 2007 19:06:28 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <11771520591703-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45208>

On Sat, 21 Apr 2007, Junio C Hamano wrote:

> The interface is similar to the custom low-level merge drivers.
>
> First you configure your filter driver by defining 'filter.<name>.*'
> variables in the configuration.
>
> 	filter.<name>.clean	filter command to run upon checkin
> 	filter.<name>.smudge	filter command to run upon checkout
>
> Then you assign filter attribute to each path, whose name
> matches the custom filter driver's name.
>
> Example:
>
> 	(in .gitattributes)
> 	*.c	filter=indent
>
> 	(in config)
> 	[filter "indent"]
> 		clean = indent
> 		smudge = cat


hmm, three things come to mind here

1. it would be useful in many cases for the filter program to know what file 
it's working on (and probably some other things), so there are probably some 
command-line arguments that should be able to be passed to the filter.

2. should this be done as a modification of the in-memory buffer (s this patch 
does it?) or should it be done at the time of the read/write, makeing the filter 
be responsible for actually doing the disk I/O, which would give it the benifit 
of being able to do things like set permissions and other things that can't be 
done until the file is actually on the filesystem (for something managing config 
files, this could include restarting the daemon related to the config file for 
example)

3. why specify seperate clean/smudge programs instead of just one script with a 
read/write parameter? I suspect that in most cases the external filter program 
that cleans files will be the same one that smudges them. the clean/smudge 
version does let you specify vastly different things without requireing a 
wrapper script around them, but it would mean duplicating the line when they are 
the same.

the first two items seem fairly important to me, but the third is a niceity that 
I could live with as-is.

David Lang
