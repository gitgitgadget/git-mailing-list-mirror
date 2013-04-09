From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v4] transport-helper: report errors properly
Date: Tue, 9 Apr 2013 23:38:05 +0200
Message-ID: <87ip3v1j2a.fsf@hexa.v.cablecom.net>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgF4-0001iI-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935984Ab3DIViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:38:09 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:53101 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934470Ab3DIViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:38:08 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Apr
 2013 23:38:03 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Apr
 2013 23:38:05 +0200
In-Reply-To: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 8 Apr 2013 09:40:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220639>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If a push fails because the remote-helper died (with fast-export), the
> user won't see any error message. So let's add one.
>
> At the same time lets add tests to ensure this error is reported, and
> while we are at it, check the error from fast-import
[...]
> +# We sleep to give fast-export a chance to catch the SIGPIPE
> +test_expect_success 'proper failure checks for pushing' '
> +	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
> +	export GIT_REMOTE_TESTGIT_FAILURE &&
> +	cd local &&
> +	test_must_fail git push --all 2> error &&
> +	cat error &&
> +	grep -q "Reading from remote helper failed" error
> +	)
> +'

There appears to be a race in the version that is in today's pu
(5eb25f737b).  I reproduced with this:

  cd git/t
  i=1
  while ./t5801-remote-helpers.sh --root=/dev/shm --valgrind
  do
    i=$(($i+1))
  done

Two out of six of these loops quit within 1 and 2 iterations,
respectively, both with an error along the lines of:

  expecting success: 
          (GIT_REMOTE_TESTGIT_FAILURE=1 &&
          export GIT_REMOTE_TESTGIT_FAILURE &&
          cd local &&
          test_must_fail git push --all 2> error &&
          cat error &&
          grep -q "Reading from remote helper failed" error
          )

  error: fast-export died of signal 13
  fatal: Error while running fast-export
  not ok 21 - proper failure checks for pushing

I haven't been able to reproduce outside of valgrind tests.  Is this an
expected issue, caused by overrunning the sleep somehow?  If so, can you
increase the sleep delay under valgrind so as to not cause intermittent
failures in the test suite?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
