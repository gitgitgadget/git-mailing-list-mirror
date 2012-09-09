From: David Gould <david@optimisefitness.com>
Subject: Probable bug in file run-command.c function clear_child_for_cleanup
Date: Sun, 09 Sep 2012 15:44:54 +0100
Message-ID: <504CAB66.1050003@optimisefitness.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 17:02:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAj1j-0001qN-09
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 17:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab2IIPCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 11:02:15 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:57996
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753255Ab2IIPCO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 11:02:14 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Sep 2012 11:02:14 EDT
X-Trace: 612719653/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$ON_NET_AUTH_ACCEPTED/pipex-temporary-group/88.108.247.46/None/david@optimisefitness.com
X-SBRS: None
X-RemoteIP: 88.108.247.46
X-IP-MAIL-FROM: david@optimisefitness.com
X-SMTP-AUTH: 
X-Originating-Country: GB/UNITED KINGDOM
X-MUA: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIqrTFBYbPcu/2dsb2JhbABFu1GBCIJOERENIhkkFhgDAgECAScxCAEBFYd7B5k2oBqOKoMfA5spE4NUhmqCZw
X-IronPort-AV: E=Sophos;i="4.80,394,1344207600"; 
   d="scan'208";a="612719653"
X-IP-Direction: IN
Received: from 88-108-247-46.dynamic.dsl.as9105.com (HELO ephebe) ([88.108.247.46])
  by smtp.pipex.tiscali.co.uk with ESMTP; 09 Sep 2012 15:52:38 +0100
Received: from [192.168.100.9] (pseudopolis [192.168.100.9])
	by ephebe (Postfix) with ESMTPS id 6467F8017C
	for <git@vger.kernel.org>; Sun,  9 Sep 2012 15:44:55 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205082>

Hi,

This is probably the wrong way to do this, and I'm sorry if I end up 
wasting someone's time. That said, here goes....

While idly browsing through the git source (as you do on a sunny Sunday 
afternoon), I spotted the following code (that appears to be wrong) in 
the file  https://github.com/git/git/blob/master/run-command.c It's the 
same in branches maint, next and pu. The branch todo gives me a 404.

(line 53 is here)
static void clear_child_for_cleanup(pid_t pid)
{
	struct child_to_clean **last, *p;

	last = &children_to_clean;
	for (p = children_to_clean; p; p = p->next) {
		if (p->pid == pid) {
			*last = p->next;
			free(p);
			return;
		}
	}
}
(line 67 is here)

It appears that last is intended to point to the next field that's being 
updated, but fails to "follow" the p pointer along the chain. The result 
is that children_to_clean will end up pointing to the entry after the 
deleted one, and all the entries before it will be lost. It'll only be 
fine in the case that the pid is that of the first entry in the chain.

You want something like:

for (... {
	if (... {
		...
	}
	last = &p->next;
}

or (probably clearer, but I haven't read your coding style guide, if 
there is one, and some people don't like this approach)

for (p = children_to_clean; p; last = &p->next, p = p->next) {
	...

Cheers,
David

-- 
David Gould, Personal Trainer
	Register of Kettlebell Professionals
	INWA Nordic Walking Instructor
Optimise Fitness Ltd -- fit for life
01264 720709
www.optimisefitness.com
