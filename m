Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83F13A86A
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888737; cv=none; b=N2N0WqoARXewsXOs4xeT3pgaNQ6MlKFG7u4JB1xvjwUnIO1LkMfzkwvCGtb5Bs2I8hXoTeUnlY6Mk+m0J/rmZzeRHjyM6MOL424qPljVlHROMrT0ORE0phrxveh/KOF0SbhM0vAZX8lRYyjUDVkppXCrGj+9f0VJdm7czD6jJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888737; c=relaxed/simple;
	bh=6wswJ5AtwqmLfvuJqAdL/25O5Q/nxwGfWT4Ax2cOmIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nemaZ+vV8ikTZHEtvsWTeWAAu6mT0WSP+3YJHNnfMLtq/9OXA6HsZNBZIkWgx7oSP7bNP1MCo7V/yfbgD06Z7xYoB51JnO46V2U6V4UOfCIH6DGfz3QDQGQlNp4LBkADR8HANPsjKXUoXlUULbSqFAqdHW0ZIUh3ksudvVjzoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46DGckmU107587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:38:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Sat, 13 Jul 2024 12:38:41 -0400
Organization: Nexbridge Inc.
Message-ID: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdrVQrCyd5dQdMswTPiJl647hSafUg==
Content-Language: en-ca

Here is the breakage. I included the prior test log in case there was a
dependency.

checking prerequisite: TTY

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-TTY" &&
(
        cd "$TRASH_DIRECTORY/prereq-test-dir-TTY" &&
        test_have_prereq PERL &&

        # Reading from the pty master seems to get stuck _sometimes_
        # on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
        #
        # Reproduction recipe: run
        #
        #       i=0
        #       while ./test-terminal.perl echo hi $i
        #       do
        #               : $((i = $i + 1))
        #       done
        #
        # After 2000 iterations or so it hangs.
        # https://rt.cpan.org/Ticket/Display.html?id=65692
        #
        test "$(uname -s)" != Darwin &&

        perl "$TEST_DIRECTORY"/test-terminal.perl \
                sh -c "test -t 1 && test -t 2"

)
+ mkdir -p /home/randall/git/t/trash
directory.t0021-conversion/prereq-test-dir-TTY
+ cd /home/randall/git/t/trash
directory.t0021-conversion/prereq-test-dir-TTY
+ test_have_prereq PERL
+ uname -s
+ test NONSTOP_KERNEL != Darwin
+ perl /home/randall/git/t/test-terminal.perl sh -c test -t 1 && test -t 2
Can't locate IO/Pty.pm in @INC (you may need to install the IO::Pty module)
(@INC contains: /usr/lib/perl5/site_perl/5.30.3/nonstop_kernel
/usr/lib/perl5/site_perl/5.30.3 /usr/lib/perl5/5.30.3/nonstop_kernel
/usr/lib/perl5/5.30.3 /usr/lib/perl5/site_perl) at
/home/randall/git/t/test-terminal.perl line 5.
BEGIN failed--compilation aborted at /home/randall/git/t/test-terminal.perl
line 5.
error: last command exited with $?=162
prerequisite TTY not satisfied
ok 34 # skip delayed checkout shows progress by default on tty (pathspec
checkout) (missing TTY of PERL,TTY)

expecting success of 0021.35 'delayed checkout ommits progress on non-tty
(pathspec checkout)':
                test_delayed_checkout_progress ! git checkout $opt

+ test_delayed_checkout_progress ! git checkout .
test_delayed_checkout_progress: test: argument expected
error: last command exited with $?=127
not ok 35 - delayed checkout ommits progress on non-tty (pathspec checkout)
#
#                       test_delayed_checkout_progress ! git checkout $opt
#
1..35


--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



