From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: run-command: output owner picking strategy
Date: Fri, 20 May 2016 15:11:50 +0200 (CEST)
Message-ID: <401208017.5792558.1463749910970.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <906110267.5791524.1463748828183.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: sbeller@google.com,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3k7T-0006Rp-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 15:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbcETNFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 09:05:25 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:56022 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932681AbcETNFV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 09:05:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DB0C2210E;
	Fri, 20 May 2016 15:05:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjS5SeOLz2Wc; Fri, 20 May 2016 15:05:16 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C43122109;
	Fri, 20 May 2016 15:05:16 +0200 (CEST)
In-Reply-To: <906110267.5791524.1463748828183.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: run-command: output owner picking strategy
Thread-Index: T/WNbvdI9tE985WrStiBhyrVtA0LNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295161>

Hi,
I stumbled upon this piece of code (run-command.c:pp_collect_finish()), picking the owner of the output amongst parallel processes (introduced by Stephan Beller in commit c553c72eed64b5f7316ce227f6d5d783eae6f2ed)

/*
 * Pick next process to output live.
 * NEEDSWORK:
 * For now we pick it randomly by doing a round
 * robin. Later we may want to pick the one with
 * the most output or the longest or shortest
 * running process time.
 */
for (i = 0; i < n; i++)
   if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
      break;
pp->output_owner = (pp->output_owner + i) % n;


Would it be useful to improve this round-robin into something smarter (as stated by the NEEDSWORK)? It seems to be only used for submodules fetch/clone.

The options would be (as said in the comment):
1 - pick the process with the longest running process time
2 - pick the process with the shortest running process time
3 - pick the process for which the output buffer is the longest

But with one of those strategies, wouldn't we lose the advantage of having the same output order as a non-parallelized version? Cf the commit message.

What do you think ? 
