From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v14 00/13] Port tag.c to use ref-filter.c
Date: Mon, 31 Aug 2015 09:31:00 +0200
Message-ID: <vpqa8t7j4nf.fsf@anie.imag.fr>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:31:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWJYk-0005Cv-My
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 09:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbHaHbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 03:31:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43976 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbHaHbI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 03:31:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V7Uxna004784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 09:30:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V7V0uC008236;
	Mon, 31 Aug 2015 09:31:00 +0200
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 29 Aug 2015 19:42:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2015 09:31:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7V7Uxna004784
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441611062.39778@mgaAFRu/3YdA2+q+8Q8zYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276850>

Karthik Nayak <karthik.188@gmail.com> writes:

> * We perform quoting on each layer of nested alignment. 

I do not understand why.

For example, using the tip of karthik/exp on GitHub (on top of this
series, d91419b (ref-filter: adopt get_head_description() from branch.c,
2015-08-23)):

git for-each-ref --shell \
  --format 'x=%(if)foo%(then)%(align:10)XXX%(end)%(else) not foo %(end)'

I'd expect an output like:

x='XXX      '

and instead I get:

x=''\''XXX       '\'''

which assigns the value 'XXX       ' (including the quotes) to $x. I do
not see a use-case for this (well, I could imagine one where we would
later call eval "$x", that seems rather far-fetched).

I think the quoting should be:

1) When the stack contains only the initial element, quote individual
   atoms.

2) When the stack contains exactly two elements and encountering a %(end)
   or %(else), quote the entire strbuf of the 2nd level when appending to
   the 1st level.

3) When the stack contains more than two elements, perform no quoting at
   all. The quoting will be done later by #2.

I found a segfault while testing:

$ git for-each-ref --format 'x=%(if)%(align:10)%(end)%(then)%(align:10)XXX%(end)%(else)%(end)' --shell
zsh: segmentation fault

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
