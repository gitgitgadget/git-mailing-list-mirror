Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E9C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588797AbiAXWd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:33:58 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16093 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586019AbiAXWZd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:25:33 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20OMItIf071077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Jan 2022 17:18:55 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Michael Herrmann'" <michael@herrmann.io>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>        <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>        <xmqqilufl5cv.fsf@gitster.g>        <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>        <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>        <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>        <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>        <xmqqk0ep57ou.fsf@gitster.g>        <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com> <xmqqfspc3k8k.fsf@gitster.g>
In-Reply-To: <xmqqfspc3k8k.fsf@gitster.g>
Subject: RE: A puzzle: reset --hard and hard links
Date:   Mon, 24 Jan 2022 17:18:48 -0500
Organization: Nexbridge Inc.
Message-ID: <000e01d81170$5f62f600$1e28e200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIdSZEWasf1qw9XDX0IOkXUDFK/0AFI6l++AW4YK6QChYVSowKGdvMkASjeS7cCVC6c4gKVeznYAcmdvf0CQ0BaO6tZNzpA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 24, 2022 4:19 PM, Junio wrote:
> Michael Herrmann <michael@herrmann.io> writes:
> 
> >> It is merely because you helped Git to realize
> >
> > I don't want to "help Git realize". I'm sorry but in my opinion `git
> > status` should not have any effects on other commands. I don't
> > understand how you can argue that calling `git status` is a valid fix
> > to "help Git".
> >
> >> With another step 1.5 "append a line to the file in question", git
> >> should severe the link,
> >
> > I don't want to sever the hard link. I want to avoid that it gets
severed.
> 
> Sorry, if that is the case, what you want is not a version control, and it
is certainly
> not Git.  You want something else.
> 
> Think about this scenario.
> 
>     $ rm -fr one && git init one && cd one
>     $ echo 0 >a; echo 0 >b; git add a b; git commit -m zero
> 
> We have two files, a and b, each of which has "0" in it.
> 
>     $ echo 1 >b; git add b; git commit -m one
> 
> Now they have "0" and "1" respectively.
> 
>     $ echo 2 >a; echo 2 >b; git commit -a -m two
>     $ ln -f a b
>     $ git diff
>     $ git diff HEAD
> 
> Now they have "2".  Since they have identical contents, "diff" would
report no
> difference relative to the index or HEAD, even after we manually break the
> working tree by making one of them a hardlink to the other.
> 
> Now, what should this command do?
> 
>     $ git reset --hard HEAD^
> 
> What the user is asking is (1) to move the branch to point at the previous
commit,
> which had 0 and 1 in a and b respectively, and (2) to make sure that the
index and
> the working tree contents match what is recorded in the commit.
> 
> So for Git to be a usefully correct version control system, it is
essential to make
> sure what it writes out would not affect any path other than the one it is
writing
> out.  When it writes "0" to "a", it MUST break the hardlink from elsewhere
that
> points at "a" before it does so.  Otherwise, the "0" it writes into "a"
will also be
> seen elsewhere, which is not what the updated HEAD (i.e. commit "one")
wants to
> see.  The same for "b" when it is updated from "2" to "1"
> when this happens.

I think there are more use cases here than are apparent but also some
serious question about why one would do this.

In a Linux/POSIX environment, one can do a hard link to a file inside a git
repo, change the file using something like vim, and have git recognize that
there is a change in git status. However, this only works on some platforms.
Hard links do not have a 100% consistent semantic from one OS to another,
one file system to another, or even between editors and scripts. As Junio
pointed out, using a > operator on a hard link is likely going to replace
the file instead of modifying the existing one. >> might correctly append
and have git recognize it in a git status... on some platforms.

Making git consistent in this situation across every possible situation is
not only impractical, it is likely impossible and cutting down what git is
allowed to do so that only those common things are implemented might gut git
badly.

If you are looking for doing external edits while keeping git notified, I
would suggest wrapping the file modification in a script that is aware of
hard links so that you get the results you want.

Alternatively, a soft link made externally to a physical git file location
might do what you want - assuming your platform supports soft links. Your
modification script/program/etc. would use the file directly in git instead
of the hard link inode, so git is happy. A git status would see the change
because the file really only exists in git. Other git operations, like
restore, switch, etc., would cause the physical file to be modified
correctly, and anything using the referencing soft link would see the
change. Note: I am not suggest soft-linking from inside git to outside.

--Randall

