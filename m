From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] grep: do not segfault when -f is used
Date: Fri, 16 Oct 2009 06:39:08 -0700
Message-ID: <20091016133908.GA3172@ftbfs.org>
References: <1255683204-28988-1-git-send-email-kraai@ftbfs.org>
 <4AD84C2F.5000809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 15:45:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myn7O-0001jU-82
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 15:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbZJPNmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZJPNmX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 09:42:23 -0400
Received: from zoom.lafn.org ([206.117.18.8]:31402 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZJPNmW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 09:42:22 -0400
Received: from macbookpro (pool-173-51-225-123.lsanca.fios.verizon.net [173.51.225.123])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id n9GDfiCn069132
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Oct 2009 06:41:45 -0700 (PDT)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1Myn1Q-0001j8-Qz; Fri, 16 Oct 2009 06:39:08 -0700
Content-Disposition: inline
In-Reply-To: <4AD84C2F.5000809@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.1 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130485>

On Fri, Oct 16, 2009 at 12:34:23PM +0200, Johannes Sixt wrote:
> Matt Kraai schrieb:
> > +test_expect_success 'grep should not segfault with -f' '
> > +        test_must_fail git grep -f /dev/null
> > +'
> 
> there must be a better way to test whether grep -f behaves correctly.

How about the following test cases instead?

test_expect_success 'grep -f, non-existent file' '
	test_must_fail git grep -f patterns
'

cat >expected <<EOF
file:foo mmap bar
file:foo_mmap bar
file:foo_mmap bar mmap
file:foo mmap bar_mmap
file:foo_mmap bar mmap baz
EOF

cat >pattern <<EOF
mmap
EOF

test_expect_success 'grep -f, one pattern' '
	git grep -f pattern >actual &&
	test_cmp expected actual
'

cat >expected <<EOF
file:foo mmap bar
file:foo_mmap bar
file:foo_mmap bar mmap
file:foo mmap bar_mmap
file:foo_mmap bar mmap baz
t/a/v:vvv
t/v:vvv
v:vvv
EOF

cat >patterns <<EOF
mmap
vvv
EOF

test_expect_success 'grep -f, multiple patterns' '
	git grep -f patterns >actual &&
	test_cmp expected actual
'

cat >expected <<EOF
file:foo mmap bar
file:foo_mmap bar
file:foo_mmap bar mmap
file:foo mmap bar_mmap
file:foo_mmap bar mmap baz
t/a/v:vvv
t/v:vvv
v:vvv
EOF

cat >patterns <<EOF

mmap

vvv

EOF

test_expect_success 'grep -f, ignore empty lines' '
	git grep -f patterns >actual &&
	test_cmp expected actual
'

-- 
Matt Kraai                                           http://ftbfs.org/
