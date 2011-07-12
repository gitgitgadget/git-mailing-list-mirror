From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/17] sequencer: Announce sequencer state location
Date: Tue, 12 Jul 2011 13:56:38 -0500
Message-ID: <20110712185638.GA14909@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:56:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgi8d-0007F8-It
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1GLS4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 14:56:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64774 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab1GLS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 14:56:50 -0400
Received: by iyb12 with SMTP id 12so4916545iyb.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pGQpNecD8Bt/0haYMovGdYHMFKV3RhJ0O5h4WESFCmY=;
        b=x2jr/Ms+BHZAwLVqJWqZbc0IAwPhskzFghaTCOzHK4J0MqrxU/ehfayi4CYjZ21KGq
         Eq4cZReipjt3+zqpn0oy8mJVeuspSIxOB0gb+kG+SgogjAuWFZ6niTGXpzyONUsEGyd4
         ajlhcPf5qHgscqxjfXUoAxthxtz5XDbnSnK2w=
Received: by 10.42.161.135 with SMTP id t7mr183979icx.455.1310497009694;
        Tue, 12 Jul 2011 11:56:49 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id e1sm4922962icv.8.2011.07.12.11.56.47
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 11:56:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-11-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176967>

Ramkumar Ramachandra wrote:

> The plan to build a generic sequencer involves fist writing the
> functionality into builtin/revert.c (for cherry-pick and revert), and
> then factoring it out into sequencer.c and exposing it through
> sequencer.h as a nice API.  As a prelude to this, announce the
> location of the sequencer state in sequencer.h and write a function to
> remove it.

Wait, so what is the actual impact of this patch?

As far as I can tell, it is to introduce a remove_sequencer_state()
function whose eventual purpose would be to remove the .git/sequencer
directory used by "git cherry-pick" to record its progress.  Paraphrased,
the function does this:

	rm -fr "$GIT_DIR/sequencer-old"
	mv "$GIT_DIR/sequencer" "$GIT_DIR/sequencer-old"

This way, a person has one level of "undo" possible, assuming git
commands and scripts use the function carefully enough not to call it
twice.

Is the "undo" feature advertised anywhere?  Should this function write
a message to stderr to inform the operator about how to get back the
precious cherry-pick state?

If I were doing it, I'd squash this with the patch that introduces
"git cherry-pick --quit", to give an example of how the new function is
meant to be used (and tests!).

> --- /dev/null
> +++ b/sequencer.h
> @@ -0,0 +1,14 @@
[...]
> +/* Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
> + * any errors.  Intended to be used by 'git reset --hard'.
> + */
> +void remove_sequencer_state(void);

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=scripts/checkpatch.pl
