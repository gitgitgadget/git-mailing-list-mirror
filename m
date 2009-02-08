From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [RFC PATCH] git-sh-setup: Use "cd" option, not /bin/pwd, for
 symlinked work tree
Date: Sun, 08 Feb 2009 10:11:21 -0800
Message-ID: <498F2049.9030608@oak.homeunix.org>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org> <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org> <alpine.DEB.1.00.0902071324230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	ae@op5.se, j.sixt@viscovery.net, git-dev@marzelpan.de,
	win@wincent.com, benji@silverinsanity.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 19:13:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWE9O-0001ZK-4z
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 19:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbZBHSLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 13:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbZBHSLf
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 13:11:35 -0500
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:30199 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752657AbZBHSLe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 13:11:34 -0500
Received: (qmail 18914 invoked from network); 8 Feb 2009 18:11:33 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp127.sbc.mail.sp1.yahoo.com with SMTP; 8 Feb 2009 18:11:33 -0000
X-YMail-OSG: w45PdpAVM1nlwto1HJbVeqVn2pQlwal69N1V3jtcpu56S4KFVlI0itXHK_WCncyMS_NkXsFhZ9Zeopvdwnrr.Oucdc6kgnmuvoanal7I459mLiWrr_yWUyQS0tTwDBeEbsms.fO3lbT89XJ7vEDqUC9I
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LWE7v-0007LL-Dq; Sun, 08 Feb 2009 10:11:31 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <alpine.DEB.1.00.0902071324230.10279@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108997>

Johannes Schindelin wrote:
> On Fri, 6 Feb 2009, Marcel M. Cary wrote:
>> While the "-P" option may be slightly less commonly supported than
>> /bin/pwd,
>
> Does this not suggest that your patch should at least fall back to
> using /bin/pwd when it was detected that "cd -P" does not work?

Having the "cd -P" strategy fall back to /bin/pwd negates most of the
value I saw in using the simpler strategy.

I haven't found cases where "cd -P" is more correct.  Are there other
reasons to bother with "cd -P" at all?  Maybe performance: "cd -P"
would save a fork, which seems to make it ~10x faster.  Dropping buffer
caches doesn't seem to widen or narrow the gap, so I don't think the
filesystem access is much different, performance-wise.  But I don't
expect this "cd" to be a performance bottleneck; most scripts that do
something repetitive can just start off in the work tree root to avoid
the issue.

Falling back to /bin/pwd would help compatibility if it were easy to
detect when "cd -P" failed.  But since its failure is hypothetical for
me at this point -- I don't know of an environment where it fails -- I'm
not sure whether to expect it to fail with non-zero exit status or by
silently ignoring the "-P".  And to handle the cases of silently
ignoring the "-P" I'd guess cd_to_toplevel would have to run /bin/pwd
just to check that it ended up in the right place, which seems
counterproductive to me.  Do you think it would be reasonable to just
assume "cd -P" will exit non-zero if "cd" doesn't understand "-P", send
its stderr to /dev/null, and try again using /bin/pwd?

Marcel
