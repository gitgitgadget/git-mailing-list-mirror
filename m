Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86D51FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeANVcs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 14 Jan 2018 16:32:48 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16236 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeANVcr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 16:32:47 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0ELWaCO003545
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Jan 2018 16:32:36 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>
References: <004a01d38cab$705262a0$50f727e0$@nexbridge.com> <001a01d38d57$d36c7d10$7a457730$@nexbridge.com> <59d3adab-4a95-4ef5-2d8f-ef4c7b797156@kdbg.org>
In-Reply-To: <59d3adab-4a95-4ef5-2d8f-ef4c7b797156@kdbg.org>
Subject: RE: [BUG] test_must_fail: does not correctly detect failures - Was Git 2.16.0-rc2 Test Summary on NonStop
Date:   Sun, 14 Jan 2018 16:32:32 -0500
Message-ID: <004a01d38d7f$3306e810$9914b830$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJL2DF5YDw1sAX4TtGn7MOoKgkH9AFqQNrWAa1IcAKiaoeeAA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Johannes Sixt [mailto:j6t@kdbg.org]
> Sent: On January 14, 2018 1:41 PM wrote:
> Am 14.01.2018 um 17:50 schrieb Randall S. Becker:
> > Follow-up: This looks like the completion code from perl on NonStop is
> > not the same as expected by git in the case of failures. I need to
> > debug this to get more details to the team. We have had completion
> > issues before relating to interpretation problems between perl, bash,
> > and git in this platform, so I'm assuming this to be likely again but need to
> track down the specifics.
> > Can anyone point me to where the detection is within git or the execv?
> 
> Perhaps you are looking for wait_or_whine() in run-command.c? But this
> function cannot do anything if perl alread exits with an exotic code (>
> 128 even though no signal was received).

The exotic error code coming back from perl is 162. I can muck with it, if there was a value more useful to git.
*  553          } else if (WIFEXITED(status)) {
*  554                  code = WEXITSTATUS(status);
(eInspect 3,887):p code
$4 = 162

The perl code uses die to terminate with a non-specific non-zero error code. What it seems is that there is an assumed value that the git tests depend on, but perl.org describes the following:

"die raises an exception. Inside an eval the error message is stuffed into $@ and the eval is terminated with the undefined value. If the exception is outside of all enclosing evals, then the uncaught exception prints LIST to STDERR and exits with a non-zero value. If you need to exit the process with a specific exit code, see exit."

So it seems that we might need to either not use die or change the tests not to care about the exit code for specific tests involving perl. Suggestions?

Sincerely,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



