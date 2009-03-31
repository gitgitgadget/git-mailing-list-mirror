From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:42:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903302239040.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain> <7vk5668g55.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain> <7vy6um6z9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWoE-00009C-2D
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbZCaFpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZCaFpU
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:45:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50820 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751826AbZCaFpT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:45:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5gpWx003970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 22:43:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5gpoG021681;
	Mon, 30 Mar 2009 22:42:51 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vy6um6z9m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.441 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115218>



On Mon, 30 Mar 2009, Junio C Hamano wrote:
> 
> I do have a lot of reflog entries kept around, as my main repository has
> these:
> 
>         [gc]
>                 reflogexpire = '2005-01-01 00:00:00 +0000'
>                 reflogexpireunreachable = '2005-01-01 00:00:00 +0000'

I think that actually _hides_ the problem. You'll never have anything at 
all that triggers that

	if (timestamp < cb->cmd->expire_unreachable) {

because your "expire_unreachable" timestamp is already very old (== small 
value), so 'timestamp' will _not_ be older (smaller value) than that.

I dunno. As mentioned, I don't really understand why we'd want to save 
some of those reflog entries at all in the first place, so I'm probably 
missing something.

If we've asked for reflog entries past a certain age to be expired, why do 
when then look at the details of those reflog entries and only expire them 
under certain circumstances? Just expire them, and get rid of the 
'unreachable' part.

			Linus
