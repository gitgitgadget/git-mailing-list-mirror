Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4FD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 22:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeBFWy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 17:54:56 -0500
Received: from elephants.elehost.com ([216.66.27.132]:19173 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753506AbeBFWyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 17:54:55 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w16MsjJB021680
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Feb 2018 17:54:45 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Salvatore Bonaccorso'" <carnil@debian.org>
Cc:     <889680@bugs.debian.org>, <git@vger.kernel.org>
References: <151785928011.30076.5964248840190566119.reportbug@eldamar.local> <20180205204312.GB104086@aiede.svl.corp.google.com>
In-Reply-To: <20180205204312.GB104086@aiede.svl.corp.google.com>
Subject: RE: git: CVE-2018-1000021: client prints server sent ANSI escape codes to the terminal, allowing for unverified messages to potentially execute arbitrary commands
Date:   Tue, 6 Feb 2018 17:54:37 -0500
Message-ID: <00b601d39f9d$7a40b820$6ec22860$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKV3ZfFIFJAb10h2veIue2qrUCm7wI76Kt+ogGYXmA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 5, 2018 3:43 PM, Jonathan Nieder wrote:
> 
> Salvatore Bonaccorso wrote[1]:
> 
> > the following vulnerability was published for git.
> >
> > CVE-2018-1000021[0]:
> > |client prints server sent ANSI escape codes to the terminal, allowing
> > |for unverified messages to potentially execute arbitrary commands
> >
> > Creating this bug to track the issue in the BTS. Apparently the CVE
> > was sssigned without notifying/discussing it with upstream, at least
> > according to [1].
> >
> > If you fix the vulnerability please also make sure to include the CVE
> > (Common Vulnerabilities & Exposures) id in your changelog entry.
> >
> > For further information see:
> >
> > [0] https://security-tracker.debian.org/tracker/CVE-2018-1000021
> >     https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-1000021
> > [1] https://bugzilla.novell.com/show_bug.cgi?id=1079389#c1
> 
> Thanks.  Upstream was notified about this and we dropped the ball on
> passing it on to a more public forum.  Sorry about that.
> 
> I'd be interested in your advice on this.  There are cases where the user
may
> *want* ANSI escape codes to be passed through without change and other
> cases where the user doesn't want that.  Commands like "git diff" pass
their
> output through a pager by default, which itself may or may not sanitize
the
> output.
> 
> In other words, there are multiple components at play:
> 
>  1. A terminal.  IMHO, it is completely inexcusable these days for a
>     terminal to allow arbitrary code execution by writing output to
>     it.  If bugs of that kind still exist, I think we should fix them
>     (and perhaps even make it a requirement in Debian policy to make
>     the expectations clear for new terminals).
> 
>     That said, for defense in depth, it can be useful to also guard
>     against this kind of issue in other components.  In particular:
> 
>  2. A pager.  Are there clear guidelines for what it is safe and not
>     safe for a pager to write to a terminal?
> 
>     "less -R" tries to only allow ANSI "color" escape sequences
>     through but I wouldn't be surprised if there are some cases it
>     misses.
> 
>  3. Output formats.  Some git commands are designed for scripting
>     and do not have a sensible way to sanitize their output without
>     breaking scripts.  Fortunately, in the case of "git diff", git
>     has a notion of a "binary patch" where everything is sanitized,
>     at the cost of the output being unreadable to a human (email-safe
>     characters but not something that a human can read at a glance).
>     So if we know what sequences to avoid writing to stdout, then we
>     can treat files with those sequences as binary.
> 
> Pointers welcome.

One possible (albeit brute force) approach, in dealing with the specifics of
this CVE, may be to explicitly translate ESC-] into BLANK-], leaving a
potential attack visible but ineffective. This only addresses the attack
vector documented in the particular CVE but it can be done efficiently. The
sequence does not appear significant in ANSI - the CVE documents the xterm
situation.  Checking very old termcap, the impact would be on unfiltering
emulations derived (this is a sample) from nec 5520, freedom 100, Sun
workstations sun-s/-e-s, fortune, etc. Based on the seemingly limited use of
this sequence, having a config item may be overkill, but it could be set
enabled by default.

What I don't know - and it's not explicitly in the CVE - is just how many
other terminal types with similar vulnerabilities are out there, but I'm
suspecting it's larger than one would guess - mostly, it seems like this
particular sequence is intended to be used for writing status line output
(line 25?) instead of sticking it in a prompt. This can be used prettifies a
lengthy bash prompt to display the current branch and repository at the
bottom of the screen instead of in the inline prompt, but that's the user's
choice and not something git has to deal with. There were some green-screen
terminals with other weird ESC sequences back in the day that could really
get into trouble with this, including loading/executing programs in terminal
memory via output - really. I'm sure it seemed like a good idea at the time,
but I can see how it could have been used for evil.

A more general solution might be to permit the configuration of a list of
blocked character sequences and apply those as a filter. Something like
core.filter-mask="\E]", "\EA".

Just my $0.02 ramblings.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



