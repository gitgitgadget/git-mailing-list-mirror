From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Sun, 31 Dec 2006 12:45:37 +0100
Message-ID: <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 12:45:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0z8T-0002Tc-FE
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 12:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134AbWLaLpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 06:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933135AbWLaLpj
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 06:45:39 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:22587 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbWLaLpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 06:45:38 -0500
Received: by py-out-1112.google.com with SMTP id a29so2915684pyi
        for <git@vger.kernel.org>; Sun, 31 Dec 2006 03:45:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qvKTgllzrewJiO08tqm+8vvDq+/LllV4UmjD3OSIBQMHnHyoD3dU83DF/A2HjWFKrKyc3JPzdhQMJJ4mcNJPJvp2f/Uql7Cs/pznO+rItZepzlD2h5jB5ktHg+l8lEGCBg6fB+6VQFH+WFj+Vcchfk/jcg9H/m3HS7NK5nMBukA=
Received: by 10.35.66.1 with SMTP id t1mr33879939pyk.1167565537790;
        Sun, 31 Dec 2006 03:45:37 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 31 Dec 2006 03:45:37 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35693>

I'm sorry to reply only now but I have problems with my internet
connection, I am also not able to test Junio patches now.

Regarding qgit parsing 'bug' I would like to point out something that
probably is not clear.

1) Parsing routine _must_ be able to sustain the loading of more then
40000 revisions in a couple of seconds, so must be very quick. A lot
of effort has been put to index the header info at maximum speed. Now
it takes about 300ms to parse the whole linux tree. You can have this
only if the header format is 'fixed enough', it means that you would
not expect whole new lines (new '\n' chars) to appear from nowhere in
header, with the exception of log message and parents info lines of
course.

2) I _have_ to rely on headers info because that's where I get data to
show the user, that's the whole point of calling git-rev-list with
--headers option.

3) The rule of double '\n\n' as an indicator of the start of log
message it's not only very slow, it's also broken in cases of no log,
see 7b7abfe3dd81d in Linux tree.

4) We are talking of keeping back compatibility, _fixing_ qgit does
not solves the issues with current qgit users.

So please I really would ask again to *do not print that encoding
extra line if not requested to do so*

Thanks again
Marco

P.S: One way to really speed up the indexing would be if git-rev-list
prints at the beginning the length of the record, i.e. the distance
from the next '\0' terminating point. I don't know if this info is
already available to git-rev-list before to print the record or has to
find it anyway, in the latter case there is no point in doing this.
But in the former case it would be possible to avoid a costly
find('\0'), starting from the beginning of log message. Log message is
more then the half of all the record length so it would be possible to
avoid a good amount of unuseful work because only the position of the
next '\0' is needed during parsing, not the log message, that is
retrieved and shown to the user only on demand, i.e. only for the
selected revision.
