From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: exit status = 1 from git fetch -t
Date: Thu, 28 May 2009 09:56:33 +0200
Message-ID: <4A1E43B1.20400@drmicha.warpmail.net>
References: <200905280357.n4S3v73G016535@hilo.ca.kronos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dvilleneuve@kronos.com
X-From: git-owner@vger.kernel.org Thu May 28 09:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9aTx-0004ia-Op
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbZE1H4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757268AbZE1H4p
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:56:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39629 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757895AbZE1H4o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 03:56:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D76A4346E8A;
	Thu, 28 May 2009 03:56:45 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 28 May 2009 03:56:45 -0400
X-Sasl-enc: anjjY96eIdeUmhhrN+JSEv7HgMJZQfe7xjMCARTWHD2s 1243497405
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 45BA9B439;
	Thu, 28 May 2009 03:56:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200905280357.n4S3v73G016535@hilo.ca.kronos.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120167>

Villeneuve venit, vidit, dixit 28.05.2009 05:57:
> Hi,
> 
> I'm getting an unexpected exit status of 1 from "git fetch
> -t" on one of our largest repositories (by large, I mean 47
> branches and 5442 tags, some of which might not be reachable
> from branch heads).
> 
> The docs are not clear about the interpretation of git
> fetch's exit status, so maybe I should not bother.
> 
> But assuming the exit status of 1 really indicates some
> trouble, here are more details.
> 
> Next tests done with git over ssh (server 1.6.1.3, client
> 1.6.3.1) on RHEL4.
> 
> In the "REPO1" repository (exit status printed just before $
> in prompt following command):
> 
> [REPO1] 0 $ git fetch -t -v -v
> Server supports multi_ack
> Server supports side-band-64k
> Server supports ofs-delta
> Marking 60e4d540748c5c3d368c888c4c248de0bdd684cc as complete
> Marking 60e4d540748c5c3d368c888c4c248de0bdd684cc as complete
> [REPO1] 1 $
> 
> while with another repository, "REPO2":
> 
> [REPO2] 0 $ git fetch -t -v -v
> From ssh://user@machine/path/to/GIT/dir1/dir2/REPO2
>  = [up to date]      v1.1 -> v1.1
>  = [up to date]      v1.2 -> v1.2
>  = [up to date]      v2.0 -> v2.0
> ... # lots of other similar lines
> [REPO2] 0 $
> 
> I've compiled git in debug to step in the code, and the
> source of the "error" exit status seems to come from
> builtin-fetch-pack.c:everything_local, where *refs being
> NULL leaves retval to 1 in the final loop.
> 
> I'm also puzzled that I don't get the "From ssh://..." in
> the trace from "REPO1" as for the "REPO2" repository above.
> I do get the "From ssh://..."  line if doing only "git fetch
> -v -v" without the "-t" option in "REPO1".

Looking at that loop, I reckon everything_local() returns 0 if there is
at least one object we "want" from the remote and 1 if there is none
(i.e. if "everything is local"). So that seems intentional. (The
structure of REPO1 and your fetch refspecs lines should explain why we
don't want anything.)

About the "From": If fetch displays no note (i.e. "foo   ref -> ref") it
displays no "From" either, which makes sense. We're not getting anything
from anywhere, we're not even listing up to date info, so we're not
displaying the reference point.

Michael
