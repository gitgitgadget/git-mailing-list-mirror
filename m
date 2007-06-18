From: Scott Lamb <slamb@slamb.org>
Subject: Re: [PATCH] mergetool: make Apple's FileMerge available as a merge_tool
Date: Mon, 18 Jun 2007 02:39:08 -0700
Message-ID: <467652BC.4050900@slamb.org>
References: <11820959413590-git-send-email-prohaska@zib.de> <B12626B9-766E-4EA4-888F-B3E2DA889D15@zib.de> <20070617181200.GA15218@thunk.org> <42FEB11E-426D-4B44-9E7E-0E35032CB1B0@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jun 18 11:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Dhb-00007l-IJ
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 11:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760028AbXFRJjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 05:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759905AbXFRJjN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 05:39:13 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:40897 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759342AbXFRJjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 05:39:12 -0400
Received: from spiff.local (ppp-71-139-189-107.dsl.snfc21.pacbell.net [71.139.189.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id C008E98036;
	Mon, 18 Jun 2007 02:39:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <42FEB11E-426D-4B44-9E7E-0E35032CB1B0@zib.de>
X-Enigmail-Version: 0.95.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50388>

Steffen Prohaska wrote:
> 
> On Jun 17, 2007, at 8:12 PM, Theodore Tso wrote:
>> Do you know of a way of determining whether or not under MacOS X, a
>> program can easily determine whether or not the user is sitting in
>> front of the graphical display, as opposed to coming in via an SSH
>> connection?
> 
> this might do the job:
> 
> --- SNIP ---
> #! /bin/sh
> 
> pid=$$
> 
> while [ $pid -ne 1 ] ; do
>     command=$(ps -p $pid | tail -n 1 | cut -b 27-)
>     echo $command | grep -q sshd && { echo "ssh" ; exit ; }
>     echo $command | grep -q Terminal && { echo "local" ; exit ; }
>     pid=$(ps -O ppid -p $pid | tail -n 1 | cut -b 6-11)
> done
> 
> echo "unknown"
> --- SNIP ---

I propose a simpler test:

    if [ -n "$TERM_PROGRAM" ]; then
        echo local
    else
        echo remote
    fi

This environment variable seems to be set by Terminal.app and even two
alternatives I just tried (iTerm.app and GLterm.app). It's not
transmitted across ssh unless you stick an AcceptEnv in sshd_config.

About the only time it would fail is logging in via local xterm. I'd
guess few people do that, and determining if xterm is local or not seems
infeasible - the best I've got is examining DISPLAY, but where do you
draw the line between :0.0 or localhost:0 (probably local), foobar:0
(probably remote), and :10 (probably remote via ssh forwarding)? I'd
rather not try.

-- 
Scott Lamb <http://www.slamb.org/>
