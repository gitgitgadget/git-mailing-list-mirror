From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v2 8/8] revision.c: discount UNINTERESTING parents
Date: Sat, 04 May 2013 23:18:39 +0300
Message-ID: <51856D1F.4030303@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi> <1367342788-7795-9-git-send-email-kevin@bracey.fi> <7vmwsfbtu7.fsf@alter.siamese.dyndns.org> <5182A7CC.4040009@bracey.fi> <7v61z11721.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 22:44:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYjJJ-0003fU-C6
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab3EDUn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 16:43:57 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:46133 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754282Ab3EDUn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 16:43:56 -0400
X-Greylist: delayed 1514 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 May 2013 16:43:56 EDT
Received: from mail240.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 50613DC1A18
	for <git@vger.kernel.org>; Sat,  4 May 2013 22:18:41 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 4 May 2013 22:18:41 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 4 May 2013 22:18:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <7v61z11721.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 7863284951213379800
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223377>

On 02/05/2013 23:05, Junio C Hamano wrote:
>
>>>       ....Z...A===X---o---o---B
>>>            \\    /
>>>             W---Y
>>>
> OK, I think I understand it, and we are in agreement.  For the
> purpose of the above paragraph, a side branch is what is not on the
> "--ancestry-path", so all of the below "examples" are about the
> behaviour when --ancestry-path is used.

Ah, in fact, no. In some previous mails I was concentrating on
ancestry-path, but those 3 examples were really of ordinary "A..B", with
W+Y in the INTERESTING set. I think the side-branch logic remains sound
and desirable even in the absence of --ancestry-path, so I don't think
this is an ancestry-path change. (And from a basic naive usability point
of view I'm much more interested in improving the more obvious modes
than the rather more obscure --ancestry-path.)

Ancestry path forces side branches to be ignored - it's the "simple"
case for ignoring (and understanding) side branches. But if we let other
modes know where the bottom is, they too can benefit from reliable side
branch logic - we can find out if anything happened on side branches,
but we can also ignore them completely if they turn out to be totally
irrelevant.

When not using ancestry-path, the side branches this patch works on are
thosewhich go off and don't come back - they stub off at some
UNINTERESTING commit other than the bottom(s). If no other limiting is
set, they must have hit an ancestor of our BOTTOM commit(s);
simplify-merges could have potentially pruned away if unlimited. And
this patch restores that pruning ability - simplify-merges can rewrite
them back to just 1 UNINTERESTING merge parent at the boundary (looking
like an ancestry-path boundary), then this patch can chuck the boundary
merge. Hey presto, irrelevant branch now invisible. And the patch also
provides benefits to all other modes.

I'll post v3 of the sequence tomorrow - it includes a new test which
illustrates the changes - it's a 60-or-so-item test set, with about 15
"failures" in a variety of modes that get fixed by this sequence. I
think that should make an excellent discussion topic. We'll see whether
folks agree with my view about what should and shouldn't be shown...

Kevin
