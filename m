From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline revs
Date: Wed, 30 Nov 2011 17:56:32 +0100
Message-ID: <201111301756.32305.trast@student.ethz.ch>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com> <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 17:56:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVnSa-0002Zr-Ln
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 17:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab1K3Q4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 11:56:36 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:1334 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1K3Q4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 11:56:35 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 30 Nov
 2011 17:56:31 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 30 Nov
 2011 17:56:32 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186129>

Sverre Rabbelier wrote:
> When a revision is specified on the commandline we explicitly output
> a 'reset' command for it if it was not handled already. This allows
> for example the remote-helper protocol to use fast-export to create
> branches that point to a commit that has already been exported.
> 
> Initial-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>

My apologies if this is redundant, I'm not up to speed on progress
here.  But a crash in t9350.19 caught my eye:

  checking known breakage: 
          (
                  cd limit-by-paths &&
                  git fast-export master~2..master~1 > output &&
                  test_cmp output expected
          )

  ==23766== Invalid read of size 1
  ==23766==    at 0x4FD21E: prefixcmp (strbuf.c:9)
  ==23766==    by 0x42B936: handle_tags_and_duplicates (fast-export.c:563)
  ==23766==    by 0x42C274: cmd_fast_export (fast-export.c:732)
  ==23766==    by 0x4051F1: run_builtin (git.c:308)
  ==23766==    by 0x40538B: handle_internal_command (git.c:466)
  ==23766==    by 0x4054A5: run_argv (git.c:512)
  ==23766==    by 0x40562C: main (git.c:585)
  ==23766==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
  ==23766== 
  {
     <insert_a_suppression_name_here>
     Memcheck:Addr1
     fun:prefixcmp
     fun:handle_tags_and_duplicates
     fun:cmd_fast_export
     fun:run_builtin
     fun:handle_internal_command
     fun:run_argv
     fun:main
  }
  ==23766== 
  ==23766== Process terminating with default action of signal 11 (SIGSEGV)
  ==23766==  Access not within mapped region at address 0x0
  ==23766==    at 0x4FD21E: prefixcmp (strbuf.c:9)
  ==23766==    by 0x42B936: handle_tags_and_duplicates (fast-export.c:563)
  ==23766==    by 0x42C274: cmd_fast_export (fast-export.c:732)
  ==23766==    by 0x4051F1: run_builtin (git.c:308)
  ==23766==    by 0x40538B: handle_internal_command (git.c:466)
  ==23766==    by 0x4054A5: run_argv (git.c:512)
  ==23766==    by 0x40562C: main (git.c:585)

The crash is hidden by the fact that the test is test_expect_failure.
It bisects to this commit.  Perhaps we should distinguish between
test_expect_failure and test_expect_crash?...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
