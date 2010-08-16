From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 07/12] bundle: run setup_git_directory_gently() sooner
Date: Mon, 16 Aug 2010 09:21:32 +0200
Message-ID: <201008160921.33198.trast@student.ethz.ch>
References: <20100626192203.GA19973@burratino> <20100806023529.GB22369@burratino> <20100806031204.GK22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 09:22:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oku1G-0004xo-55
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 09:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab0HPHV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 03:21:56 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:37115 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab0HPHV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 03:21:56 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 16 Aug
 2010 09:21:54 +0200
Received: from thomas.site (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 16 Aug
 2010 09:21:33 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100806031204.GK22369@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153652>

Jonathan Nieder wrote:
>  builtin/bundle.c |    6 ++----
>  git.c            |    2 +-
>  t/t7006-pager.sh |   33 +++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 5 deletions(-)
[...]
> +test_expect_success 'configuration can enable pager (from subdir)' '
> +	rm -f paginated.out &&
> +	mkdir -p subdir &&
> +	git config pager.bundle true &&
> +	test_when_finished "git config --unset pager.bundle" &&
> +
> +	git bundle create test.bundle --all &&
> +	rm -f paginated.out subdir/paginated.out &&
> +	(
> +		cd subdir &&
> +		test_terminal git bundle unbundle ../test.bundle
> +	) &&
> +	{
> +		test -e paginated.out ||
> +		test -e subdir/paginated.out
> +	}
> +'
> +
>  # A colored commit log will begin with an appropriate ANSI escape
>  # for the first color; the text "commit" comes later.
>  colorful() {

On my valgrind test setup, this never worked (i.e., fails and bisects
to this commit).

Oddly, I am seeing this error message from the second test (second in
t7006, not in this patch):

  expecting success: 
          rm -f stdout_is_tty ||
          cleanup_fail &&

          if test -t 1
          then
                  >stdout_is_tty
          elif
                  test_have_prereq PERL &&
                  "$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl \
                          sh -c "test -t 1"
          then
                  >test_terminal_works
          fi

  Can't locate IO/Pty.pm in @INC (@INC contains: <snip>) at /local/home/trast/git/t/t7006/test-terminal.perl line 4.
  BEGIN failed--compilation aborted at /local/home/trast/git/t/t7006/test-terminal.perl line 4.
  ok 2 - set up terminal for tests

Which raises a few questions: Why was this never an issue before?  Am
I supposed to have IO::Pty with a perl install (it's a perl 5.8.8) or
does the test need a prerequisite other than HAVE_PERL?4

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
