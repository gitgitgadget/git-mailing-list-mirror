From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch --contains is unbearably slow [Re: [PATCHv2] Warnings
 before rebasing -i published history]
Date: Mon, 11 Jun 2012 16:04:46 -0700
Message-ID: <7v8vft5u29.fsf@alter.siamese.dyndns.org>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <87r4tmhy12.fsf_-_@thomas.inf.ethz.ch>
 <7vvcix7rim.fsf@alter.siamese.dyndns.org> <87vcix8pz5.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, <git@vger.kernel.org>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:04:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeDfJ-000471-CW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 01:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab2FKXEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 19:04:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab2FKXEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 19:04:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BA0B87C8;
	Mon, 11 Jun 2012 19:04:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86xiVsfmK2C5FYeO0Qhb0elhv7E=; b=wGRah7
	MvGvK58qxIXI8NJyUhCEWLlSkKKflmGWt1X5/GJgzBciWv1hQhC1Eb2TMgPRMSbP
	OgCGn681ruLWMkTQ8SUdIdAtuYLRzik1nnDbRPTd5I5UhE1BdSJGn1Pq/3Yf8fTS
	DoO13/i+rxgjpyBuAIU52iSLR1/jKt2LqZg7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jwDhT4UoYo/WU6y9GAPAQYP5YbskJlGL
	13FszGmaPUslUlGCpRvX0cJp5UaMfOWC0EJi6iA8T1zHBzUudd9Cy99yEgHVImBE
	81topl+mCGed6wiDJj56KzmrqAGO7+7NUiJkCyP2Vz/Lq4At+caCCsUeye3Wvlyo
	maDxMMPXdkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00BBA87C7;
	Mon, 11 Jun 2012 19:04:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DFB987C6; Mon, 11 Jun 2012
 19:04:47 -0400 (EDT)
In-Reply-To: <87vcix8pz5.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 12 Jun 2012 00:04:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D716CF78-B419-11E1-8ED0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199753>

Thomas Rast <trast@student.ethz.ch> writes:

> I suspect most of your branches are in some way closely related to next,
> while I have a lot of cruft fetched from all sorts of people that fell
> behind over the years.  Can you try
>
>   git for-each-ref refs/remotes/ |
>   while read sha tp ref; do
>     printf "%8d %8d %s\n" $(
>       git rev-list --left-right --count $ref...next
>     ) $ref
>   done
>
> For me the output is as listed below (I ran it with origin/next instead
> of next).  Note that for almost all of them, a naive merge-base walk
> (going back from both until a common commit is found) has to walk
> thousands of commits.

I too seem to have a lot of cruft I'd better get rid of.  Thanks for
reminding ;-).

$ git for-each-ref refs/remotes/ |
  while read sha tp ref; do
    printf "%8d %8d %s\n" $(
      git rev-list --left-right --count $ref...next
    ) $ref
  done
     159     6180 refs/remotes/ab-i18n/i18n
      65     6284 refs/remotes/ab-i18n/i18n-add-translations
      63     6279 refs/remotes/ab-i18n/i18n-all
      93     6244 refs/remotes/ab-i18n/i18n-all-continue
      78     6279 refs/remotes/ab-i18n/i18n-all-continue-squash
      93     6244 refs/remotes/ab-i18n/i18n-continue
      94     6244 refs/remotes/ab-i18n/i18n-continue-with-hindi
      92     6236 refs/remotes/ab-i18n/i18n-for-junio
      98     6236 refs/remotes/ab-i18n/i18n-for-junio-with-docs
      63     6284 refs/remotes/ab-i18n/i18n-gettextize
     140     6195 refs/remotes/ab-i18n/i18n-in-pu
     160     6195 refs/remotes/ab-i18n/i18n-rewrite
     161     6195 refs/remotes/ab-i18n/i18n-rewrite-with-po-line-numbers
     140     6232 refs/remotes/ab-i18n/i18n-v2
       0    16335 refs/remotes/gfi/HEAD
       0    17824 refs/remotes/gfi/maint
       0    16335 refs/remotes/gfi/master
      31    20748 refs/remotes/gfi/sp/pack4
       7    16320 refs/remotes/gfi/sp/sendpack-sideband
       3    20518 refs/remotes/gfi/sp/splitpack
       2    16325 refs/remotes/gfi/sp/unixsock
       0    28459 refs/remotes/git-gui/maint
       0    28446 refs/remotes/git-gui/master
       3    28459 refs/remotes/git-gui/pu
       9    29498 refs/remotes/git-gui/todo
       0    15622 refs/remotes/git-p4/git-p4
       0      752 refs/remotes/git-svn/HEAD
       0     3782 refs/remotes/git-svn/instaweb
       0      752 refs/remotes/git-svn/master
       0      753 refs/remotes/git-svn/origin
       0    13207 refs/remotes/git-svn/spearce/origin
       0     6744 refs/remotes/git-svn/webrick
       0      865 refs/remotes/github2/maint
       0      222 refs/remotes/github2/master
       0        4 refs/remotes/github2/next
     100      204 refs/remotes/github2/pu
     981    29498 refs/remotes/github2/todo
       0      865 refs/remotes/gph/maint
       0      222 refs/remotes/gph/master
       0        4 refs/remotes/gph/next
     100      204 refs/remotes/gph/pu
     871    29498 refs/remotes/gph/todo
       8    16603 refs/remotes/jbf-um/HEAD
       3    17804 refs/remotes/jbf-um/better-whitespace-checks
      12    18132 refs/remotes/jbf-um/docwork-concepts
       1    18010 refs/remotes/jbf-um/docwork-design
       1    17849 refs/remotes/jbf-um/docwork-detached
       1    18010 refs/remotes/jbf-um/docwork-foreign-scms
       1    17883 refs/remotes/jbf-um/docwork-recovery
       0    17825 refs/remotes/jbf-um/maint
      10    17867 refs/remotes/jbf-um/maint-history
       8    16603 refs/remotes/jbf-um/master
       1    17804 refs/remotes/jbf-um/messages
       1    19546 refs/remotes/jbf-um/parallel-diff
       7    20685 refs/remotes/jbf-um/recovery
       1    21989 refs/remotes/jbf-um/tutorial-2
      48     3056 refs/remotes/ko-private/jch
       0     3656 refs/remotes/ko-private/maint
       5    22527 refs/remotes/ko-private/maint-1.4.4
       0    16075 refs/remotes/ko-private/maint-1.5.4
       0    15296 refs/remotes/ko-private/maint-1.5.5
       0    14555 refs/remotes/ko-private/maint-1.5.6
       0    11606 refs/remotes/ko-private/maint-1.6.2
       0     9484 refs/remotes/ko-private/maint-1.6.5
       0     8014 refs/remotes/ko-private/maint-1.7.0
       0     7333 refs/remotes/ko-private/maint-1.7.1
       0     6657 refs/remotes/ko-private/maint-1.7.2
       0     6616 refs/remotes/ko-private/master
     175     3056 refs/remotes/ko-private/next
       0     3171 refs/remotes/ko-private/origin
      66     8872 refs/remotes/ko-private/private-jch
      99     3027 refs/remotes/ko-private/pu
       0     8016 refs/remotes/ko-private/snap
       0    11942 refs/remotes/ko-private/test
       0      865 refs/remotes/ko/maint
       0      222 refs/remotes/ko/master
       0        4 refs/remotes/ko/next
     100      204 refs/remotes/ko/pu
       0     1188 refs/remotes/l10n/master
       9    14815 refs/remotes/lea/master
       0    14877 refs/remotes/lea/origin
       0    18037 refs/remotes/mergetool/master
       0    18037 refs/remotes/mergetool/mergetool
     918    13101 refs/remotes/mingw/master
     862    15327 refs/remotes/mingw/master-borked
       0    18173 refs/remotes/pasky.web/master
     825    18172 refs/remotes/pasky.web/mob
       4    18173 refs/remotes/pasky.web/next
       8    18173 refs/remotes/pasky.web/pu
       0    28975 refs/remotes/paulus/HEAD
       6    29067 refs/remotes/paulus/asdf
       0    28989 refs/remotes/paulus/dev
      17    29331 refs/remotes/paulus/lines
       0    28975 refs/remotes/paulus/master
      32    29321 refs/remotes/paulus/new
    1100    29498 refs/remotes/repo/html
       0      865 refs/remotes/repo/maint
     980    29498 refs/remotes/repo/man
       0      222 refs/remotes/repo/master
       0        4 refs/remotes/repo/next
     100      204 refs/remotes/repo/pu
     894    29498 refs/remotes/repo/todo
       0    13638 refs/remotes/spearce.git/maint
       0    13207 refs/remotes/spearce.git/master
     149    13176 refs/remotes/spearce.git/next
     381    29498 refs/remotes/spearce.git/todo
       0    28540 refs/remotes/thoyts/maint
       0    28511 refs/remotes/thoyts/master
       0    28527 refs/remotes/thoyts/pu
       9    29498 refs/remotes/thoyts/todo
       0     8920 refs/remotes/trast-doc/HEAD
       0     8920 refs/remotes/trast-doc/for-next
       0     8920 refs/remotes/trast-doc/master
       0     8917 refs/remotes/trast-doc/pu
:
