From: =?ISO-8859-1?Q?Nagy_Bal=E1zs?= <js@iksz.hu>
Subject: Re: git svn forking an awful lot of "git config"s
Date: Thu, 21 Feb 2008 00:57:36 +0100
Message-ID: <47BCBE70.8020706@iksz.hu>
References: <alpine.LSU.1.00.0802201520580.17164@racer.site>	<20080220223953.GA32663@hand.yhbt.net> <m3ejb7tdbo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRypX-0000kR-BU
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbYBTX5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYBTX5x
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:57:53 -0500
Received: from smtp.aranyoroszlan.hu ([195.56.77.57]:54540 "EHLO
	smtp.aranyoroszlan.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYBTX5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:57:52 -0500
Received: (qmail 28614 invoked by uid 263); 21 Feb 2008 00:07:13 -0000
Received: from 213.178.107.56 (js@iksz.hu@213.178.107.56) by tcb.aranyoroszlan.hu (envelope-from <js@iksz.hu>, uid 256) with qmail-scanner-2.02st 
 (clamdscan: 0.92/5779. spamassassin: 3.2.4. perlscan: 2.02st.  
 Clear:RC:0(213.178.107.56):SA:0(-2.0/5.0):. 
 Processed in 2.17495 secs); 21 Feb 2008 00:07:13 -0000
X-Spam-Status: No, hits=-2.0 required=5.0
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tcb.aranyoroszlan.hu
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RDNS_NONE autolearn=no version=3.2.4
X-Envelope-From: js@iksz.hu
Received: from unknown (HELO ?192.168.1.100?) (js@iksz.hu@213.178.107.56)
  by tcb.aranyoroszlan.hu with SMTP; 21 Feb 2008 00:07:10 -0000
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <m3ejb7tdbo.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74573>

Jakub Narebski wrote:
> Take a look how gitweb uses "git config -z -l" to read all config
> in one go, and save it to hash for later use, lazily.
...
> This is an alternate solution, better for simple scripts and one-off
> scripts (you don't need to write "git config -z -l" parser), but
> I think that additional eval might be not good for performance.
>   


Maybe I'll finish my git-depot proof of concept script someday.  Here's 
the configuration reader method I use (please note git-depot doesn't use 
repositories -- yet):

sub readConfig
{
	my $self = shift;
	my ($cfg, @cfg, $cat, $key, $val);

	$cfg = Git::command(qw/config -z -l/);
	@cfg = split(/\000/m, $cfg);
	%{$self->{cfg}} = ();
	foreach (@cfg) {
		if (($cat, $key, $val) = (/\A(\S+)\.(\S+)[\n\r]+^(.+)\Z/ms)) {
			next unless $cat eq 'depot';
			$self->{cfg}->{$key} = $val;
		}
	}
	return 1;
}

Works like a charm.
-- 
-jul-
