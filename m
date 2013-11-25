From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Test suite fails if temporary space is mounted noexec
Date: Mon, 25 Nov 2013 16:10:59 +0100
Message-ID: <52936883.7060400@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 16:18:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkxvP-0001qg-Ik
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 16:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab3KYPSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 10:18:07 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45272 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754417Ab3KYPSF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 10:18:05 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2013 10:18:05 EST
X-AuditID: 12074413-b7fc76d000002aba-43-529368853b64
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 84.AF.10938.58863925; Mon, 25 Nov 2013 10:11:01 -0500 (EST)
Received: from [192.168.69.146] (p57A25205.dip0.t-ipconnect.de [87.162.82.5])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rAPFAx8W022725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 25 Nov 2013 10:11:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqNuaMTnI4FC3rEXXlW4mB0aPz5vk
	AhijuG2SEkvKgjPT8/TtErgzzm9exlzwWKxixokm5gbGv4JdjJwcEgImEpdW7WSHsMUkLtxb
	z9bFyMUhJHCZUeLv7UnsEM5zJokXnxaDVfEKaEusvPkHqIqDg0VAVWL1a1GQMJuArsSinmYm
	EFtUIEji0aGHUOWCEidnPmEBsUUExCXeHp/JDtIqLGAn8W+bLIgpARTuaQwCqWAW0JF41/eA
	GcKWl9j+dg7zBEa+WUgGzUJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkl
	eqkppZsYIQEmvINx10m5Q4wCHIxKPLwWlZOChFgTy4orcw8xSnIwKYny7k2bHCTEl5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhHeaAVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgm
	K8PBoSTB6wMyVLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UdfHFwLgDSfEA7Z0O
	0s5bXJCYCxSFaD3FqMsx78uHb4xCLHn5ealS4rxC6UBFAiBFGaV5cCtg6eQVozjQx8K86iBV
	PMBUBDfpFdASJqAlXUZgS0oSEVJSDYxdK+r2hSjt42q5GV2cyZVzIEUurJ9RdJPJOa0L2u9F
	70xMsIpfkmPjf5ozMj3riE+6hmmliFvayauzJn2NtTz6ypLPJlXC/eS303Usn58at546Wcm8
	gj10K4cU63/OdP8v7nw1S6Vf6/99eOTD/uWz71u90ZVI3v9jSVmaz5+45++3fJ24 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238316>

Hi,

tl;dr: The filesystem used as temporary space for the Git test suite
must not be mounted "noexec".

It took me a while to figure out why many tests in the Git test suite
were failing on my new notebook computer.  The failures started right in
test t0000:

    [15:06:31] t0000-basic.sh .....................................
    Dubious, test returned 1 (wstat 256, 0x100)
    Failed 10/59 subtests
            (less 5 skipped subtests: 44 okay)

and maybe 5% of the other test scripts were failing, too.

The reason is that I was using the tmpfs (RAM filesystem) at /run/shm as
temporary space for running the tests.  That speeds the tests up quite a
bit relative to using a hard disk as temp space.  I had options like the
following in config.mak:

    DEFAULT_TEST_TARGET = prove
    GIT_TEST_OPTS = -q --root=/run/shm --tee
    GIT_PROVE_OPTS = --timer --jobs 5 --state=fresh,hot,slow,save

This used to work, but my new notebook is running Debian testing, which
mounts /run/shm with the "noexec" option.  Since some of the tests in
the test suite write temporary scripts to the temporary space then try
to execute them, they were failing on this filesystem.


In fact, my old setup was deficient in several ways:

* /run/shm isn't really meant to be used as temporary disk space in the
first place

* Lots of temporary directories were being created directly in the
top-level /run/shm directory rather than being tucked in a subdirectory

* It was unreliable to run the test suite in different working copies
simultaneously (because they might clobber each others temporary files)


To fix these problems, I am now doing the following:

1. Have Debian mount a tmpfs at /tmp rather than using an on-disk /tmp
directory.  To do this, I added a file /etc/fstab.d/tmp.fstab containing
the following line (see tmpfs(5) for more information):

    tmpfs     /tmp tmpfs     nodev,nosuid,size=25%,mode=1777    0    0

2. Change the above lines in config.mak to the following:

    TMP := /tmp/git-tests-$(shell git rev-parse --show-toplevel |
sha1sum | head -c10)
    DEFAULT_TEST_TARGET = prove
    GIT_TEST_OPTS = -q --root=$(TMP) --tee
    GIT_PROVE_OPTS = --timer --jobs 16 --state=fresh,hot,slow,save

The idea is that the path of the working copy is encoded in the name of
the directory used for temporary space, so test suites for multiple
working copies can be run simultaneously.  The test suite creates this
directory automatically if it doesn't already exist (however, it doesn't
remove it when the tests are over).

I also boosted the parallelism of prove from 5 to 16.  With these
settings, the test suite completes in about 33 seconds for me, including
the cvsimport tests but not the svn or p4 tests.

I hope that is useful to somebody,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
