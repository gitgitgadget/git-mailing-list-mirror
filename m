From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 1/2] filter-branch: stop special-casing $filter_subdir argument
Date: Thu, 22 Oct 2009 10:05:10 +0200
Message-ID: <200910221005.11813.trast@student.ethz.ch>
References: <95535b01e2181d321190c6d93b2834188612a389.1256148512.git.trast@student.ethz.ch> <95535b01e2181d321190c6d93b2834188612a389.1256149428.git.trast@student.ethz.ch> <4ADFF66F.1080005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0sgm-0005Ws-4c
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbZJVIGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbZJVIGF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:06:05 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:56520 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbZJVIGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:06:04 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:06:08 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:05:45 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4ADFF66F.1080005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131004>

Johannes Sixt wrote:
> Thomas Rast schrieb:
> > Handling $filter_subdir in the usual way requires a separate case at
> > every use, because the variable is empty when unused.  Furthermore,
> > the case for --subdirectory-filter supplies its own --, so the user
> > cannot provide one himself (though there is also very little point in
> > doing so).
> 
> I understand that this is a preparatory patch, but you seem to argue that
> even without the follow-up patch there is a problem. But from your
> explanation I do not understand what it is. An example invocation that
> shows the problem would be very helpful.

Well, I just observed while writing the patch that you cannot say

  git filter-branch --subdirectory-filter subdir -- --all -- subdir/file

because the --subdirectory-filter supplies its own -- to the rev-list
invocation, i.e., it calls

  git rev-list --all -- subdir/file -- subdir

which filters for a file called --.

I doubt anyone ever needed this operation though, and it can easily be
done in two separate filtering steps.

> > @@ -257,15 +257,29 @@ git read-tree || die "Could not seed the index"
> >  # map old->new commit ids for rewriting parents
> >  mkdir ../map || die "Could not create map/ directory"
> >  
> > +non_ref_args=$(git rev-parse --no-revs --sq "$@")
> > +dashdash=--
> > +for arg in "$non_ref_args"; do
> 
> At this point $non_ref_args might contain one or more IFS-separatable
> words, but if you say "$non_ref_args" here, this loop will be entered
> exactly once. But even if you drop the dquotes, the --sq quoting that you
> requested from rev-parse bought you nothing.

Hrm.  Ok, so the ".." were clearly in mistake, but why could I remove
the --sq?  Doesn't the shell expand the arguments provided by
$non_ref_args if I use it without quotes nor --sq, so that it might
accidentally expand paths or such?

> > +	if test arg = --; then
> 
> Did you mean $arg here? Even then this test will succeed only if
> $non_ref_args contains exactly one word and that word is '--'. Is that
> what you mean?

No, it should find a -- argument to see if we need to supply our own
before the $filter_subdir.

> This looks so convoluted; there must be a simpler way to achieve your goal.

I'll try with more 'case's later...  maybe I can at least avoid the
eval.

Thanks for your comments!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
