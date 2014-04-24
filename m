From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 3/9] tests: new test for orderfile options
Date: Fri, 25 Apr 2014 00:39:12 +0300
Message-ID: <20140424213912.GD9129@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-3-git-send-email-mst@redhat.com>
 <xmqqoazqva5s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 23:38:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdRLu-0004yZ-EW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 23:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaDXVii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 17:38:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9476 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbaDXVih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 17:38:37 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OLcTsQ019469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2014 17:38:30 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3OLcRx8012658;
	Thu, 24 Apr 2014 17:38:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoazqva5s.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247011>

On Thu, Apr 24, 2014 at 11:45:35AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > The test is very basic and can be extended.
> > Couldn't find a good existing place to put it,
> > so created a new file.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  t/t4056-diff-order.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100755 t/t4056-diff-order.sh
> >
> > diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> > new file mode 100755
> > index 0000000..0404f50
> 
> Huh?  What codebase is this based on?
> 
> I think we had t4056 since b5277730 (t4056: add new tests for "git
> diff -O", 2013-12-18).
> 
> Puzzled...


Yes I didn't rebase in a while: 7794a680e63a2a11b73cb1194653662f2769a792
was the tip.
I'll rebase, sorry.

> > --- /dev/null
> > +++ b/t/t4056-diff-order.sh
> > @@ -0,0 +1,63 @@
> > +#!/bin/sh
> > +
> > +test_description='diff orderfile'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +	as="a a a a a a a a" && # eight a
> > +	test_write_lines $as >foo &&
> > +	test_write_lines $as >bar &&
> > +	git add foo bar &&
> > +	git commit -a -m initial &&
> > +	test_write_lines $as b >foo &&
> > +	test_write_lines $as b >bar &&
> > +	git commit -a -m first &&
> > +	test_write_lines bar foo >bar-then-foo &&
> > +	test_write_lines foo bar >foo-then-bar &&
> > +	git diff -Ofoo-then-bar HEAD~1..HEAD >diff-foo-then-bar &&
> > +	git diff -Obar-then-foo HEAD~1..HEAD >diff-bar-then-foo
> > +'
> > +
> > +test_diff_well_formed () {
> > +	grep ^+b "$1" >added
> > +	grep ^-b "$1" >removed
> > +	grep ^+++ "$1" >oldfiles
> > +	grep ^--- "$1" >newfiles
> > +	test_line_count = 2 added &&
> > +	test_line_count = 0 removed &&
> > +	test_line_count = 2 oldfiles &&
> > +	test_line_count = 2 newfiles
> > +}
> > +
> > +test_expect_success 'diff output with -O is well-formed' '
> > +	test_diff_well_formed diff-foo-then-bar &&
> > +	test_diff_well_formed diff-bar-then-foo
> > +'
> > +
> > +test_expect_success 'flag -O affects diff output' '
> > +	! test_cmp diff-foo-then-bar diff-bar-then-foo
> > +'
> > +
> > +test_expect_success 'orderfile is same as -O' '
> > +	test_config diff.orderfile foo-then-bar &&
> > +	git diff HEAD~1..HEAD >diff-foo-then-bar-config &&
> > +	test_config diff.orderfile bar-then-foo &&
> > +	git diff HEAD~1..HEAD >diff-bar-then-foo-config &&
> > +	test_cmp diff-foo-then-bar diff-foo-then-bar-config &&
> > +	test_cmp diff-bar-then-foo diff-bar-then-foo-config
> > +'
> > +
> > +test_expect_success '-O overrides orderfile' '
> > +	test_config diff.orderfile foo-then-bar &&
> > +	git diff -Obar-then-foo HEAD~1..HEAD >diff-bar-then-foo-flag &&
> > +	test_cmp diff-bar-then-foo diff-bar-then-foo-flag
> > +'
> > +
> > +test_expect_success '/dev/null is same as no orderfile' '
> > +	git diff -O/dev/null HEAD~1..HEAD>diff-null-orderfile &&
> > +	git diff HEAD~1..HEAD >diff-default &&
> > +	test_cmp diff-null-orderfile diff-default
> > +'
> > +
> > +test_done
