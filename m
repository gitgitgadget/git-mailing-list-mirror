From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: entry terminator/separator behavior in show_log()
Date: Tue, 29 Apr 2008 01:58:42 -0700
Message-ID: <20080429085839.GA19705@adamsimpkins.net>
References: <20080428045504.GA24981@adamsimpkins.net> <7vtzhmc63w.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 10:59:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqlgT-0004ZC-8R
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 10:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYD2I6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYD2I6o
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 04:58:44 -0400
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:45612 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbYD2I6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 04:58:44 -0400
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 462171B4274;
	Tue, 29 Apr 2008 04:58:43 -0400 (EDT)
Received: by relay10.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 1F88C1B425F;
	Tue, 29 Apr 2008 04:58:43 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 1F39514100C1; Tue, 29 Apr 2008 01:58:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtzhmc63w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80671>

On Mon, Apr 28, 2008 at 09:10:59AM -0700, Junio C Hamano wrote:
> Adam Simpkins <adam@adamsimpkins.net> writes:
> 
> > - I don't really like the behavior for any of the cases under 2.2.2.
> >
> >   I especially don't like the fact that the output does not end in a
> >   terminating newline for case 2.2.2.1.
> 
> This is exactly why I did tformat so that we do not have to have a complex
> special case (Jeff and I exchanged a few weatherbaloon patches on the list
> trying out heuristics) to avoid breaking existing scripts that use format.

Hmm.  Here's another possible option to kick around:

Modify the argument parsing code to set use_terminator for
--pretty=format when -z is not supplied.  In other words:

  - If the -z argument is used (diffopt->line_termination is '\0'),
    the code has separator semantics, just like it always has.
    '\0' appears between the entries, and not at the end of the last
    one.

  - If the -z argument is not used (diffopt->line_termination is '\n'),
    the code has terminator semantics.  '\n' appears at the end of each
    entry.

The only change to the current behavior is that if the -z option is
not used, an extra newline will appear at the end of the output.  This
might confuse some scripts that don't use -z.

The nice thing about this change is that now all of the cases under
2.2.2 from my initial email behave identically.  These cases are the
most annoying to distinguish and handle correctly for the new --graph
code, so it would make the graph logic simpler.

Do you think this change would be acceptable, or would it still break
too many scripts?

-- 
Adam Simpkins
adam@adamsimpkins.net
