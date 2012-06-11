From: Thomas Rast <trast@student.ethz.ch>
Subject: branch --contains is unbearably slow [Re: [PATCHv2] Warnings before rebasing -i published history]
Date: Mon, 11 Jun 2012 13:46:01 +0200
Message-ID: <87r4tmhy12.fsf_-_@thomas.inf.ethz.ch>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 13:46:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se34V-0002br-Au
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 13:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622Ab2FKLqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 07:46:06 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46379 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab2FKLqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 07:46:05 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Jun
 2012 13:46:02 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Jun
 2012 13:46:02 +0200
In-Reply-To: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Lucien Kong's message of "Mon, 11 Jun 2012 12:04:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199646>

[+Cc Junio who wrote branch --contains, and Peff who sped up tag
--contains in ffc4b801.]

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> "git rebase -i" can be very dangerous if used on an already published
> history. This code detects that one is rewriting a commit that is an
> ancestor of a remote-tracking branch, and warns the user through the
> editor. This feature is controlled by a new config key
> rebase.checkremoterefs.
[...]
> +# Add the name the branches after each pick, fixup or squash commit that
> +# is an ancestor of a remote-tracking branch.
> +add_remoterefs () {
> +	while read -r command sha1 message
> +	do
> +		printf '%s\n' "$command $sha1 $message"
> +		git branch -r --contains "$sha1" >"$1.branch"
[...]
> +	done >"$1.published" <"$1"
> +	cat "$1.published" >"$1"
> +	rm -f "$1.published" "$1.branch"
> +}

While I like the idea, I think it unfortunately needs some changes in
'git branch --contains'.  That command is unbelievably slow on a
repository with many remote branches, like my git.git:

  $ g remote -v | wc -l  # note that each appears twice, for fetch/push
  28
  $ git branch -r | wc -l
  364

  $ time git branch -r --contains origin/next
    origin/next

  real    0m32.060s
  user    0m31.895s
  sys     0m0.036s

I think an upper bound for the runtime of any 'git branch --contains'
should be generating the *complete* topology like this:

  $ time git log --graph --oneline --all >/dev/null

  real    0m2.637s
  user    0m2.246s
  sys     0m0.364s

It should also be possible to generate the --contains output for several
commits at the same time.  Otherwise the feature will be too painfully
slow for all but the simplest rebases.  Currently the startup time for
'rebase -i' to show an editor is near-instantaneous for me; adding N*2s
would be too much on most of my topics, where I tend to gather a handful
of fixups and improvements before the next 'rebase -i' round.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
