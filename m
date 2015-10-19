From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Mon, 19 Oct 2015 15:46:34 +0200
Message-ID: <20151019134633.GL2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <1445008605-16534-4-git-send-email-tklauser@distanz.ch>
 <CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
 <xmqqwpukayde.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 15:46:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoAlu-0007lx-R2
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 15:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbbJSNqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 09:46:37 -0400
Received: from sym2.noone.org ([178.63.92.236]:33174 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbbJSNqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 09:46:36 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3nffWb1QzpzQWbW; Mon, 19 Oct 2015 15:46:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqwpukayde.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279872>

On 2015-10-18 at 19:18:53 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > Is there any application beyond git-rebase--interactive where a
> > --count-lines options is expected to be useful? It's not obvious from
> > the commit message that this change is necessarily a win for later
> > porting of git-rebase--interactive to C since the amount of extra code
> > and support material added by this patch probably outweighs the amount
> > of code a C version of git-rebase--interactive would need to count the
> > lines itself.
> >
> > Stated differently, are the two or three instances of piping through
> > 'wc' in git-rebase--interactive sufficient justification for
> > introducing extra complexity into git-stripspace and its documentation
> > and tests?
> 
> Interesting thought.  When somebody rewrites "rebase -i" in C,
> nobody needs to count lines in "stripspace" output.  The rewritten
> "rebase -i" would internally run strbuf_stripspace() and the question
> becomes what is the best way to let that code find out how many lines
> the result contains.
> 
> When viewed from that angle, I agree that "stripspace --count" does
> not add anything to further the goal of helping "rebase -i" to move
> to C.  Adding strbuf_count_lines() that counts the number of lines
> in the given strbuf (if there is no such helper yet; I didn't check),
> though.

I check before implementing this series and didn't find any helper. I
also didn't find any other uses of line counting in the code.

After considering your and Eric's reply, I'll drop these patches for
now and only resubmit patches 1/4 and 2/4 for v3 (also see my reply to
Eric).

> >> +test_expect_success '--count-lines with newline only' '
> >> +       printf "0\n" >expect &&
> >> +       printf "\n" | git stripspace --count-lines >actual &&
> >> +       test_cmp expect actual
> >> +'
> >
> > What is the expected behavior when the input is an empty file, a file
> > with content but no newline, a file with one or more lines but lacking
> > a newline on the final line? Should these cases be tested, as well?
> 
> Good point here, too.  If we were to add strbuf_count_lines()
> helper, whoever adds that function needs to take a possible
> incomplete line at the end into account.

Yes, makes more sense like this (even though it doesn't correspond to
what 'wc -l' does).
