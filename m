From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 3/6] tests: new test for orderfile options
Date: Wed, 23 Apr 2014 21:00:03 +0300
Message-ID: <20140423180003.GA28334@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
 <1398255277-26303-3-git-send-email-mst@redhat.com>
 <xmqq8uqw0ww0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:59:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1SA-0001JQ-FP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbaDWR7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328AbaDWR7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:59:20 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3NHxJMw014221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2014 13:59:19 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3NHxHGP028131;
	Wed, 23 Apr 2014 13:59:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uqw0ww0.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246861>

On Wed, Apr 23, 2014 at 10:38:07AM -0700, Junio C Hamano wrote:
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
> > index 0000000..a247b7a
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
> > +        as="a a a a a a a a" && # eight a
> > +        test_write_lines $as >foo &&
> > +        test_write_lines $as >bar &&
> > +	git add foo bar &&
> > +	git commit -a -m initial &&
> > +        test_write_lines $as b >foo &&
> > +        test_write_lines $as b >bar &&
> 
> These lines are curiously jaggy; are you indenting with spaces?
> Please don't.
> 
> My running "git am -s3c" may auto-fix these indentation issues, so
> please wait before seeing what may be pushed out on 'pu'.  It may
> turn out that there is no other need for rerolling this patch in the
> series.
> 
> Thanks.

Not normally - but this did creep in here, somehow :(

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
