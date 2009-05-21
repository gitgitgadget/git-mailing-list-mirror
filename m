From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [MAKESHIFT PATCH] Cope better with a _lot_ of packs
Date: Wed, 20 May 2009 18:22:33 -0700
Message-ID: <7vzld7tfl2.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302>
	<7vmy9etey8.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0905152040590.26154@pacific.mpi-cbg.de>
	<20090515191735.GG30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 21 03:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6x0A-0003qf-FE
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 03:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbZEUBWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 21:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbZEUBWe
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 21:22:34 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63912 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbZEUBWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 21:22:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521012232.EMOP20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 May 2009 21:22:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id u1Na1b0024aMwMQ041NaEt; Wed, 20 May 2009 21:22:34 -0400
X-Authority-Analysis: v=1.0 c=1 a=wDfkcx9OqdoA:10 a=hd0G9KVtRm0A:10
 a=oAYF_C9AAAAA:8 a=91SssEX-zdtN7Cw8PJQA:9 a=RsD7bxjKBILP5gM0Gieksbj3WSsA:4
 a=R0wQ3QzoQ0IA:10 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <20090515191735.GG30527@spearce.org> (Shawn O. Pearce's message of "Fri\, 15 May 2009 12\:17\:35 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119644>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> You might end up with a situation where you have tons of pack files, e.g.
>> when using hg2git.  In this situation, all kinds of operations may 
>> end up with a "too many files open" error.  Let's recover gracefully from 
>> that.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Yea, this looks right to me.  JGit had a similar problem and now
> maintains a core.packedGitOpenFiles parameter, set to 128 by default,
> as one of the rules it uses to limit the size of its pack cache area.
>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 28bd908..bd5edd8 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -720,6 +720,8 @@ static int open_packed_git_1(struct packed_git *p)
>>  		return error("packfile %s index unavailable", p->pack_name);
>>  
>>  	p->pack_fd = open(p->pack_name, O_RDONLY);
>> +	while (p->pack_fd < 0 && errno == EMFILE && unuse_one_window(p, -1))
>> +		p->pack_fd = open(p->pack_name, O_RDONLY);
>>  	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
>>  		return -1;

I wonder if this use of unuse_one_window() can be made more clever to drop
windows from the same packfile first.  If you have 200 packfiles with 2
windows open for each one when you ran out the file descriptors, you do
not want to drop one window from each packfile (which would not give you
any free file descriptor) and then finally release another window (at
which point we have one packfile with no window and we can close the
descriptor).

But at the same time I do not know if it matters in practice.  Presumably
you have too many packfiles because many of them are very small.
