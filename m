Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E11C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 15:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D9A208A9
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 15:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416970AbgJYPRx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 25 Oct 2020 11:17:53 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30405 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416967AbgJYPRx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 11:17:53 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 09PFHaBK075807
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Oct 2020 11:17:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <hv@crypt.org>, <git@vger.kernel.org>
References: <202010242019.09OKJTP13180@crypt.org> <016001d6aa52$b1cbc510$15634f30$@nexbridge.com> <20201025030606.GF860779@camp.crustytoothpaste.net>
In-Reply-To: <20201025030606.GF860779@camp.crustytoothpaste.net>
Subject: RE: safer git?
Date:   Sun, 25 Oct 2020 11:17:30 -0400
Message-ID: <017f01d6aae1$f870e4c0$e952ae40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0te9slIV6tbfjyjRjcOVBcUwWFAJTrrciAi2KMCypyE2xQA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 24, 2020 11:06 PM, brian m. carlson wrote:
> [I somehow didn't get the original message, so replying inline below.]
> 
> On 2020-10-24 at 22:11:54, Randall S. Becker wrote:
> > On October 24, 2020 4:19 PM, hv@crypt.org wrote:
> > > Q: Is there a mode in which I can run git that would make it a bit
> > > more robust against crashes, at the cost of being a bit slower?
> > >
> > >
> > > The primary symptom is that files modified shortly before a crash
> > > show up existing but zero-length after the crash. For source files I
> > > mostly know what to do in that situation, but `git fsck` shows a lot
> > > of files under '.git/objects' that are empty, which seems to make
> > > things hard to recover:
> > >
> > > % git fsck
> > > error: object file
> > > .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533 is empty
> > > error: unable to mmap
> > > .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533: No such
> file
> > > or directory
> > > error: 0ef31631726cea2e9bf89d7bbe7b924b5282d533: object corrupt or
> > > missing: .git/objects/0e/f31631726cea2e9bf89d7bbe7b924b5282d533
> > > [... a dozen similar entries ...]
> > > error: object file
> > > .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5 is empty
> > > error: unable to mmap
> > > .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: No such
> file
> > > or directory
> > > error: f5a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5: object corrupt or
> > > missing: .git/objects/f5/a9d125645e69a0e40f9bf7a8c90b1c1c4a4ea5
> > > Checking object directories: 100% (256/256), done.
> > > Checking objects: 100% (1577/1577), done.
> > > error: refs/stash: invalid sha1 pointer
> > > 0000000000000000000000000000000000000000
> > > error: bad ref for .git/logs/refs/stash dangling commit
> > > 1c0ea4e6159952501957012d2b9db7d68b52d107
> > > %
> 
> You can try setting core.fsyncObjectFiles to true.  That's the only knob that
> Git has for that at the moment, although there was some discussion about
> adding a new feature for other files[0].
> 
> I suspect a lot of the zero-byte files and any files that end up as all-zeros are
> due to your file system.  The default file system on Ubuntu is ext4, IIRC, and
> if that's what you're using, you can set data=journal instead of data=ordered
> as a mount option.  For the root file system, you'll need to pass
> rootflags=data=journal as a kernel boot option.
> 
> That may be significantly slower, but until you get your hardware problem
> sorted out, it may very well be worth it for you.  I'd try this option before the
> one below because it'll have less of an impact on performance and may solve
> most or all of your problems.
> 
> > > Last time I checked out the previous state from github in a new
> > > directory
> > and
> > > was able to find and copy over most of my work before continuing. On
> > > this occasion I did a `git stash save` shortly before the crash, and
> > > I'm not
> > sure
> > > how to get that back. I see RenÃ© Scharfe's suggestion of:
> > >   git fsck --unreachable |
> > >   grep commit | cut -d\  -f3 |
> > >   xargs git log --merges --no-walk --grep=WIP from a recent message,
> > > but that is only showing me an older stash item.
> >
> > I would suggest turning off write-through buffering on your disk. Let
> > writes complete immediately instead of being deferred to sync. Also,
> > this does feel like a disk issue, so fsck or chkdsk /f (or whatever) on your
> disk urgently.
> 
> Turning off buffering and caching for your disk drive may make things
> _really_ slow, but it will definitely improve data integrity.
> 
> I know hardware problems are always a hassle, so I hope you get things
> figured out and fixed soon.
> 
> [0] I admit I am not running the very latest version and the new feature may
> have already landed; if so, I apologize for the out-of-date information and
> for not keeping up with the list.

Thanks for pointing out the git knob. I didn't know about that one and it seems helpful in general.

Regards,
Randall

