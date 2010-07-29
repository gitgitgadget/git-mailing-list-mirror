From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Fri, 30 Jul 2010 00:15:56 +0200
Message-ID: <201007300015.57045.trast@student.ethz.ch>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 30 00:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebOZ-000890-3R
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab0G2WQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 18:16:00 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:27477 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641Ab0G2WP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 18:15:59 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 00:15:58 +0200
Received: from thomas.site (84.74.100.241) by CAS20.d.ethz.ch (172.31.51.110)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul 2010 00:15:57
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152204>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> Currently we only notice bugs in the test suite when it's run
> manually. Bugs in Git that only occur on obscure platforms or setups
> that the core developers aren't using may thus go unnoticed until the
> bug makes it into a release.

BTW, below is the script I have devised to automatically run the tests
under valgrind and then bisect any offenders.  (It keeps exposing odd
test failures and stealing my time tracking them down...)

It gives fairly good results, but since it's also rather kludgy I want
to test and improve it a bit more before shooting for contrib (if
anything).

Note that running this will take on the order of hours at least.

---- 8< ----
#!/bin/sh

MAILTO=3Dtr@thomasrast.ch

branch=3D"${1:-next}"
logfile=3D"$(pwd)/bisection-log-$$"

export DIFF=3Ddiff # stupid bug

die () {
	(echo "Error message: $*"; echo '-----'; cat "$logfile") |
	mail -s "Testing $branch: die() called!" "$MAILTO"
	echo "fatal: $*" >&2
	exit 1
}

git fetch origin 2>&1 | tee "$logfile" || die "fetch failed"

# test if we've already done this
test "$(git rev-parse last_known_good_$branch)" =3D "$(git rev-parse or=
igin/$branch)" && exit

git checkout -f origin/"$branch" 2>&1 | tee "$logfile" || die "checkout=
 failed (can't happen)"

results=3D"test-results.$(git describe)"
mkdir "$results"

make -j12 2>&1 | tee -a "$logfile" || die "initial compilation failed?"
make -k -j8 test 2>&1 | tee -a "$logfile"

if [ ! -d t/"test-results" ]; then
    mail -s "Valgrind-tested $branch: all good!" "$MAILTO" < "$logfile"
    git tag -f last_known_good_$branch origin/$branch
    rm "$logfile"
    exit
fi

cd t/
cp -a test-results "$results"
( cd $results && perl -i -ne 'print unless /^=3D=3D.*execve/i' *.out )
failing_normally=3D$(cd "$results" && grep -L '^0$' *.exit)
failing_valgrind=3D$(cd "$results" && grep -lE '^=3D=3D[0-9]+=3D=3D' *.=
out)
cd ..

echo "failed (normal):" $failing_normally | tee -a "$logfile"
echo "failed (valgrind):" $failing_valgrind | tee -a "$logfile"

if [ -z "$failing_normally" -a -z "$failing_valgrind" ]; then
    mail -s "Valgrind-tested $branch: all good!" "$MAILTO" < "$logfile"
    git tag -f last_known_good_$branch origin/$branch
    rm "$logfile"
    exit
fi

mail -s "Valgrind-testing $branch: starting test bisection" "$MAILTO" <=
 "$logfile"

for test_out in $failing_valgrind; do
    test=3D"${test_out%.out}"
    echo "bisecting valgrind-failing test $test"
    git bisect start > t/"$results"/$test.bisect 2>&1
    git bisect good last_known_good_pu last_known_good_next 2>&1 | tee =
t/"$results"/$test.bisect
    git bisect bad origin/$branch 2>&1 | tee -a t/"$results"/$test.bise=
ct
    git bisect run sh -c "test ! -f t/$test.sh || { make -j12 && cd t &=
& ./$test.sh --valgrind --tee -i && ! grep -E '^=3D=3D[0-9]+=3D=3D' tes=
t-results/$test.out | grep -vi execve; }" 2>&1 | tee -a t/"$results"/$t=
est.bisect
    git bisect log 2>&1 | tee -a t/"$results"/$test.bisect
    git bisect reset
    mail -s "Bisection results for $test (valgrind)" "$MAILTO" < t/"$re=
sults"/$test.bisect
done

for test_out in $failing_normally; do
    test=3D"${test_out%.exit}"
    case "$failing_valgrind" in
	*$test.out*)
	    continue
	    ;;
    esac
    echo "bisecting failing test $test"
    git bisect start 2>&1 | tee t/"$results"/$test.bisect 2>&1
    git bisect good last_known_good_pu last_known_good_pu 2>&1 | tee -a=
 t/"$results"/$test.bisect 2>&1
    git bisect bad origin/$branch 2>&1 | tee -a t/"$results"/$test.bise=
ct 2>&1
    git bisect run sh -c "test ! -f t/$test.sh || { make -j12 && cd t &=
& ./$test.sh --tee -i; }" 2>&1 | tee -a t/"$results"/$test.bisect 2>&1
    git bisect log | tee -a t/"$results"/$test.bisect
    git bisect reset
    mail -s "Bisection results for $test" "$MAILTO" < t/"$results"/$tes=
t.bisect
done

rm "$logfile"
---- >8 ----

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
