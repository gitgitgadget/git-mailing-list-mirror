From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 09:40:48 +0100
Message-ID: <20111031084048.GA11807__21610.4542407722$1320051469$gmane$org@elte.hu>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 09:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKngd-00089A-Gv
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 09:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab1JaI5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 04:57:39 -0400
Received: from fallback.mail.elte.hu ([157.181.151.13]:32806 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab1JaI5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 04:57:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1RKngX-0006Rr-5d
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Mon, 31 Oct 2011 09:57:37 +0100
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1RKnXM-0003Cu-6H
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Mon, 31 Oct 2011 09:48:08 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id D37E53E2512; Mon, 31 Oct 2011 09:48:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184496>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> That said, even the "BEGIN PGP SIGNED MESSAGE" things are a massive 
> pain in the butt. We need to automate this some sane way, both for 
> the sender and for the recipient.

The most practical form would be if Git supported such oneliner pull 
requests:

 git pull git://foo.com bar.branch                           \
  --pull-sha1 0acf00014bcfd71090c3b0d43c98e970108064e4       \
  --gpg-by: "Ingo Molnar <mingo@kernel.org>"                 \
  --gpg-sig: 8a6f134afd1d212fe21345

maintainers could just paste them into a shell and it would abort if 
it's not trusted. The maintainer verifies the visible, 'Ingo Molnar' 
bit. The 8a6f134afd1d212fe21345 is a signed-by-Ingo-Molnar version of 
this content:

    git://foo.com bar.branch 0acf00014bcfd71090c3b0d43c98e970108064e4

And Git would verify that what ends up being pulled is indeed 
0acf00014bcfd and also verifies that it was signed by me.

[ If we are extra diligent/paranoid then beyond the sha1 we might 
  even GPG sign the shortlog, or even the full raw log of all commits 
  leading to the sha1: this introduces some Git shortlog and patch 
  formatting version dependency though.

  Git could also double check foo.com's DNS coherency, or check it 
  against a known-trusted whitelist of domain names specified in the 
  maintainer's .gitconfig, as an extra layer. ]

Doing it in this form would remove all the mail formatting madness - 
one could paste such a pull request into a shell straight away, from 
HTML email, from text email, from MIME email, etc.

In fact i would trust such a Git based solution far more than any 
opaque, invisible tool that claims to have checked a signature with 
cooperation of my mail client (ha!).

The only somewhat non-obvious bit is that Git should be *very* 
careful about its key ID and signature parsing strategy, to protect 
against social engineering attacks.

For example neither this:

  --gpg-by: "Ingo Molnar <mingo@kernal.org>"

nor this:

  --pgp-by: "Ingo Molnar <mingo@kernel.org>"

malicious pull request should slip through in any fashion:

 - Git should only use keys that are in your ring of trust - not pull 
   keys from the public keyring automatically and just check 
   coherency of the pull request or such. [I'm sure people will be 
   tempted to have such a feature - but that temptation should be 
   resisted.]

 - Git should abort the moment it sees an unknown option

Thanks,

	Ingo
