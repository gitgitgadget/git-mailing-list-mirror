From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 15:28:47 +0400
Message-ID: <447ADAEF.3030806@Intel.com>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca> <e5d6i0$rnf$1@sea.gmane.org> <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 29 13:29:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkfvi-0001kb-Ry
	for gcvg-git@gmane.org; Mon, 29 May 2006 13:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWE2L2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 07:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWE2L2x
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 07:28:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:31100 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750836AbWE2L2x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 07:28:53 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101-1.fm.intel.com with ESMTP; 29 May 2006 04:28:52 -0700
Received: from fmsmsx332.fm.intel.com (HELO fmsmsx332.amr.corp.intel.com) ([132.233.42.148])
  by fmsmga001.fm.intel.com with ESMTP; 29 May 2006 04:28:52 -0700
X-IronPort-AV: i="4.05,183,1146466800"; 
   d="scan'208"; a="43862305:sNHT22116178"
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 29 May 2006 04:28:52 -0700
Received: from mssmsx402.ccr.corp.intel.com ([10.125.2.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 29 May 2006 04:28:52 -0700
Received: from [10.125.151.180] ([10.125.151.180]) by mssmsx402.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 29 May 2006 15:28:48 +0400
User-Agent: Thunderbird 1.5 (Windows/20051201)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 29 May 2006 11:28:48.0871 (UTC) FILETIME=[0DF97F70:01C68313]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20942>

Johannes Schindelin wrote:
> See also
> 
> http://thread.gmane.org/gmane.comp.version-control.git/13856/focus=13876

I've read the thread, but couldn't find a practical solution there.
 
> The essence of the thread: If you want to do anything useful in a non-bare 
> repository, you are likely using other tools than git, which do not 
> interpret core.umask or $GIT_DIR/umask.
> 
> If you use a bare repository, just make it shared. No need for an umask.

Could you please elaborate on what does it mean "make it shared"?

My setup: I have a bare GIT repository on a machine, where everybody can
SSH into (with full shell access). I've assigned the repo to a special group
where everybody belongs, and done a 'find repo.git -type d | xargs chmod 2775'

The problem: After someone pushed to the repository, the object directories 
(i.e repo.git/objects/??)
get created with 755 access rights, and effectively prevent everyone else from pushing
objects starting with the same prefix.

The obvious solution to use umask 002 is not applicable, because
1) It does not seem practical to enforce umask 002 in everyone's rc files, 
because just one forgetful or careless person can break access for all others
2) I have 'umask 002' in my ~/.profile. Somehow, it does not help,
because ~/.profile is not read on non-interactive SSH sessions
(to verify that, just try to do 'ssh somehost umask')

The current workaround for the problem is a cron script, which
makes 'find | xargs chmod 2775' every 5 minutes. It works, but is ugly.

Is there any better way to keep correct access rights in a shared repository?

Thanks a lot!
