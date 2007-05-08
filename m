From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change default depth to 50
Date: Tue, 8 May 2007 12:30:44 -0400
Message-ID: <20070508163044.GA15796@thunk.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <alpine.LFD.0.99.0705081136050.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 08 18:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlSaY-0001yQ-AG
	for gcvg-git@gmane.org; Tue, 08 May 2007 18:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968149AbXEHQax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 12:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968237AbXEHQax
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 12:30:53 -0400
Received: from THUNK.ORG ([69.25.196.29]:44033 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968149AbXEHQaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 12:30:52 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlShD-0003Bk-7X; Tue, 08 May 2007 12:37:51 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlSaK-0001YP-6G; Tue, 08 May 2007 12:30:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705081136050.24220@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46599>

On Tue, May 08, 2007 at 11:38:46AM -0400, Nicolas Pitre wrote:
> On Tue, 8 May 2007, Theodore Ts'o wrote:
> 
> > Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> I'd prefer if tests were performed on the performance impact before 
> changing the default depth.  If done separately from this patch then the 
> commit log could contain those results as well.

The following results are on a recent git repository, using time to
record the real, user, and sys times on the two commands: "git-gc
--no-reuse-delta --window=X --depth=Y" and "git log --pretty=oneline
-S'object' > /dev/null".  All of these tests were done with a hot
cache, so disk speed didn't enter into the calculations.

                git-gc                     git log -S'object'   pack size
w=10,d=10       27.1s/25.2s/0.3s           20.8s/20.4s/0.1s     15292k
w=10,d=30	23.8s/22.3s/0.2s           21.2s/20.9s/0.1s     12996k
w=10,d=50       24.8s/22.4s/0.4s           21.8s/21.2s/0.1s     12340k
w=100,d=100     24.1s/22.8s/0.3s           22.4s/21.8s/0.2s     11772k

w=30,d=10       45.0s/43.1s/0.4s           20.8s/20.5s/0.1s     14388k
w=30,d=30       35.8s/34.1s/0.3s           21.6s/21.1s/0.1s     11800k
w=30,d=50       34.6s/33.0s/0.3s           22.1s/21.4s/0.1s     11376k
w=30,d=100      34.0s/32.2s/0.3s           22.2s/21.6s/0.1s     11012k

w=50,d=10       56.1s/54.3s/0.4s           21.3s/20.5s/0.1s     14224k
w=50,d=30       47.2s/45.4s/0.4s           21.6s/21.0s/0.1s     11496k      
w=50,d=50       44.5s/43.0s/0.3s           21.7s/21.2s/0.1s     11108k
w=50,d=100      44.3s/42.7s/0.4s           22.4s/21.7s/0.1s     10824k

So a couple of things immediately become evident.  First of all, as
Junio predicted, changing --depth makes no difference to the git-gc or
git log times.  The latter is thanks to the delta chaching.  Secondly,
changing --depth does make a signficiant difference to the pack size.

Finally, --window does help somewhat in reducing the pack size, but it
_significantly_ increases the time to calculate the pack.

My conclusion given this quick benchmark is that it seems to me that
changing the defaults of --depth to 50, and keeping --window at 10, is
a reasonable thing to do.

Regards,

						- Ted
