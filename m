From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 3/4] stripspace: Implement --count-lines option
Date: Mon, 19 Oct 2015 15:31:51 +0200
Message-ID: <20151019133150.GK2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <1445008605-16534-4-git-send-email-tklauser@distanz.ch>
 <CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 15:32:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoAXk-00069L-KD
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 15:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbbJSNb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 09:31:57 -0400
Received: from sym2.noone.org ([178.63.92.236]:60126 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbbJSNby (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 09:31:54 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3nffBc1zxKzQWbW; Mon, 19 Oct 2015 15:31:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAPig+cQ=8FO8yFY4sHUwr0mYuyvMu4d-eizHZeadE9f0BgpXpQ@mail.gmail.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279871>

On 2015-10-18 at 01:57:57 +0200, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Oct 16, 2015 at 11:16 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> > Implement the --count-lines options for git stripspace [...]
> >
> > This will make it easier to port git-rebase--interactive.sh to C later
> > on.
> 
> Is there any application beyond git-rebase--interactive where a
> --count-lines options is expected to be useful? It's not obvious from
> the commit message that this change is necessarily a win for later
> porting of git-rebase--interactive to C since the amount of extra code
> and support material added by this patch probably outweighs the amount
> of code a C version of git-rebase--interactive would need to count the
> lines itself.

Agreed, it doesn't make much sense anymore in the current form. An
strbuf helper function implementing the line counting would probably be
the better way. But I guess this should only be introduced once someone
decides to write a C version of git-rebase--interactive (or any other
use for line counting appears).

> Stated differently, are the two or three instances of piping through
> 'wc' in git-rebase--interactive sufficient justification for
> introducing extra complexity into git-stripspace and its documentation
> and tests?

IMO it doesn't add a lot of complexity, but on the other hand it also
doesn't provide a large benefit apart from getting rid of a few
calls to an external program in a code path which is not performance
critical.

So I suggest I'll drop patches 3/4 and 4/4 for v3. Once someone really
needs the line counting functionality in C, an strbuf helper can still
be added.

> More below.
> 
> > Furthermore, add the corresponding documentation and tests.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> > diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> > index 29e91d8..9c00cb9 100755
> > --- a/t/t0030-stripspace.sh
> > +++ b/t/t0030-stripspace.sh
> > @@ -438,4 +438,40 @@ test_expect_success 'avoid SP-HT sequence in commented line' '
> >         test_cmp expect actual
> >  '
> >
> > +test_expect_success '--count-lines with newline only' '
> > +       printf "0\n" >expect &&
> > +       printf "\n" | git stripspace --count-lines >actual &&
> > +       test_cmp expect actual
> > +'
> 
> What is the expected behavior when the input is an empty file, a file
> with content but no newline, a file with one or more lines but lacking
> a newline on the final line? Should these cases be tested, as well?

Not really sure. For the implementation I followed the behavior of 'wc
-l' which doesn't consider the final line if it lacks a newline. Should
this be different for git's purposes? In any case, I agree that these
cases should excplicitely be tested/documented.
