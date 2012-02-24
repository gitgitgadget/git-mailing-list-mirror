From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: [PATCH v7 0/11] diff --stat: use the full terminal width
Date: Fri, 24 Feb 2012 21:31:16 +0100
Message-ID: <4F47F394.5070007@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> <7v4nuljcnk.fsf@alter.siamese.dyndns.org> <4F42E4C2.7070801@in.waw.pl> <7vr4xois3l.fsf@alter.siamese.dyndns.org> <4F436C5D.7070606@in.waw.pl> <7v1upogd6w.fsf@alter.siamese.dyndns.org> <4F44D084.7030308@in.waw.pl> <7vr4xmac6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:31:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11nh-0007kw-NU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930Ab2BXUb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:31:28 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55081 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757840Ab2BXUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:31:27 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S11nZ-00042P-J9; Fri, 24 Feb 2012 21:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vr4xmac6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191460>

Hi,

I accept your reasoning that a graph narrower than 80 columns would not 
look good.

On 02/22/2012 08:41 PM, Junio C Hamano wrote:
> It might be just the matter of raising the artificial cap to much higher
> than 40-column (say, 80-column).  A possible alternative may be to declare
> that the perceived ugliness is the user's problem of having overly wide
> terminal in the first place and do without any such cap.
>
> Either is fine, but regressing output on 80-column terminal when showing a
> patch with short filenames and large changes is unacceptable, not because
> I personally use 80-col terminal myself (I don't---mine is a bit wider but
> not 200), but because it changes behaviour from the old code without any
> good justification to do so.

I've taken both options :) The graph-width-limit is turned into an 
option (commandline --stat-graph-width and config diff.statGraphWidth), 
off by default. Now no tests need to be changed. But if somebody doesn't 
like very wide graph output, they can set the config option to something 
like 80 and forget about this.

This is on top of today's next. I'm sending 1/11 'make lineno_width() 
from blame reusable for others' again, because the version in next is 
the previous version before s/int/uintmax_t/.

Changes since v6:

- 40 column limit for the graph part is changed in an optional, 
configurable limit, off by default
- parts 7.1/8, 7.2/8, 7.3/8 get their own numbers, and 7.3 is split into 
two parts (9/10 is --stat-graph-width and 10/10 is diff.statGraphWidth).

v6:
[1/8]  make lineno_width() from blame reusable for others
   This is very close to what was in pu, but I'm sending a new version:
   - the function argument is changed from int to uintmax_t
     (max_change is uintmax_t and 9/9 does decimal_width(max_change).)
[2/8] diff --stat: tests for long filenames and big change counts
   - Tests are run for format-patch, diff, log, show, and merge.
   - Since tests are not only for format-patch, they are added in a new
     file t/t4052-stat-output.sh.
[3/8] diff --stat: use the full terminal width
   Add logic to use term_columns() when diffopts.stat_width==-1 and
   turn it on in git-diff --stat.
   - show_stats() output is adapted to full terminal width only when
     diffopts.stat_width==-1.
[4/8] show --stat: use the full terminal width
   Enable for git-show.
[5/8] log --stat: use the full terminal width
   Enable for log-show.
[6/8] merge --stat: use the full terminal width
   Enable for git-merge.
[7/8] diff --stat: limit graph part to 40 columns
   Change the logic to divide columns. This part is the unchanged from
   v5, just separated from 3/9.
[8/8] diff --stat: use less columns for change counts
   This one is optional, to be applied or not, "when the dust settles".

v5:
- tests are moved to an earlier patch
   - seq is replaced with a while loop for windows compatibility
   - grep -m 1 is replaced with grep " | "
   - redirects are made portable
   - piped output is split into two commands to verify that the first 
command
     sucessfully runs to completion
- using decimal_width(change count) is moved to a later patch
- "histogram" is really not used


v4:
- comments are updated and the word "histogram" is banished
- "mopping up" is removed (but the minimum width are guaranteed)

v3:
- use decimal_width(max_change) to calculate number of columns
   required for change counts
- rework the logic to divide columns
- document the logic in comments, update docs
- add more tests

v2:
- style fixes
- some tests for git-format-patch added
- patches 3 and 4 squashed together, since they touch the same lines
- graph width is limited to 40 columns, even if there's more space
- patch descriptions extended and cleared up
