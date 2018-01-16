Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7527D1F406
	for <e@80x24.org>; Tue, 16 Jan 2018 03:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbeAPDb3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 15 Jan 2018 22:31:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:46083 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeAPDb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 22:31:28 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0G3VIVx018971
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Jan 2018 22:31:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>
References: <004a01d38cab$705262a0$50f727e0$@nexbridge.com> <001a01d38d57$d36c7d10$7a457730$@nexbridge.com> <59d3adab-4a95-4ef5-2d8f-ef4c7b797156@kdbg.org> <004a01d38d7f$3306e810$9914b830$@nexbridge.com> <007901d38da9$d517e9e0$7f47bda0$@nexbridge.com> <499fb29f-ca34-8d28-256d-896107c29a3e@kdbg.org> <001b01d38e0c$ba16e250$2e44a6f0$@nexbridge.com> <20180116030051.GA244260@genre.crustytoothpaste.net>
In-Reply-To: <20180116030051.GA244260@genre.crustytoothpaste.net>
Subject: RE: [BUG] test_must_fail: does not correctly detect failures - Was Git 2.16.0-rc2 Test Summary on NonStop
Date:   Mon, 15 Jan 2018 22:31:14 -0500
Message-ID: <00eb01d38e7a$79cb0960$6d611c20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJL2DF5YDw1sAX4TtGn7MOoKgkH9AFqQNrWAa1IcAICMDCvxwE+b2lEArTVekACkMZMAwHgYxGOohfhfCA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 15, 2018 10:01 PM, brian m. Carlson wrote:
> On Mon, Jan 15, 2018 at 09:25:37AM -0500, Randall S. Becker wrote:
> > On January 15, 2018 2:06 AM, Johannes Sixt wrote:
> > > I take "die exits with non-zero" as a piece of information for the
> > > *users* so that they can write "if perl foo.pl; then something; fi"
> > > in shell scripts. I do *not* interpret it as leeway for implementers
> > > of perl to choose any random value as exit code. Choosing 162 just
> > > to be funky would be short-sighted. [I'm saying all this without knowing
> how perl specifies 'die'
> > > beyond the paragraph you cited. Perhaps there's more about 'die'
> > > that justifies exit code 162.] I'd say that the perl port is broken.
> >
> > I agree that 162 is wrong. Its interpretation is 128+signal, which
> > clearly does not happen in this case. On the platform, if the perl
> > script is via stdin, 162 or 169 are returned. If via file (perl
> > file.pl), 255 comes back. The port has issues. I have an opened a bug
> > report with the platform developers. Usual non-Open Source timeframes
> > to fix apply. ☹
> 
> I believe the standard behavior for Perl with die is the following:
> 
> exit $! if $!;
> exit $? >> 8 if $? >> 8;
> exit 255; # otherwise
> 
> Is there an errno value on your port that matches 162?  Maybe EBADF?
> 
> On Linux, I get the following:
> 
> genre ok % printf die | perl -; echo $?
> Died at - line 1.
> 9

Nah. Worse. Assume a perl script that is simply 'die "hello world"'. If it's in a file, perl reports 255. If from stdin, perl reports 162/169. Doh. That's supposed to be 128+signum, and max sig is 31 (SIGABEND) on the platform. The difficulty at this point is that if I fix wait_or_whine to map either code to 255 or 1, then many more other tests fail, so I'm stuck with either 6 reasonably acceptable breaks or about 60 unacceptable ones, based on assumptions in test_must_fail or other fail detections in the git suite. I'd rather not mess with git code if the test breaks themselves are explainable.

Sign.

Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



