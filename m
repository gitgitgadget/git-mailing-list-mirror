Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D79C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 22:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhLGXD3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Dec 2021 18:03:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:12042 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhLGXD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 18:03:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B7MxqFA090991
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Dec 2021 17:59:52 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Neeraj Singh'" <nksingh85@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        "'Git List'" <git@vger.kernel.org>
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com> <20211206222539.GA27821@neerajsi-x1.localdomain> <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet> <CANQDOdfkRMMWpF2gaRpZW0NRzMuN-ADO++D1J4rS8WLxOPudRw@mail.gmail.com>
In-Reply-To: <CANQDOdfkRMMWpF2gaRpZW0NRzMuN-ADO++D1J4rS8WLxOPudRw@mail.gmail.com>
Subject: RE: [PATCH] git-compat-util(msvc): C11 does not imply support for zero-sized arrays
Date:   Tue, 7 Dec 2021 17:59:47 -0500
Organization: Nexbridge Inc.
Message-ID: <010c01d7ebbe$255a0890$700e19b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIRaxP6W4mSJpE6b1kzxVaeZysxqAHqQqnYAox0/ngBzvXM2KuCeDtg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 7, 2021 5:22 PM, Neeraj Singh wrote:
> On Tue, Dec 7, 2021 at 1:33 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Neeraj,
> >
> > On Mon, 6 Dec 2021, Neeraj Singh wrote:
> >
> > > I'm a little confused by this issue. Looks like an empty flex array
> > > is supported here: https://godbolt.org/z/j3ndYTEfx.
> >
> > It is somewhat strange, but understandable, that the empty flex array
> > at the end of a struct isn't triggering a compile error. But having a
> > field _after_ that empty flex array _does_ trigger a compile error:
> >
> > struct MyStruct {
> >     int x;
> >     int flexA[];
> >     char string[256];
> > };
> >
> > Note the added `string` field.
> >
> 
> Please see https://godbolt.org/z/4Tb9PobYM.  GCC throws a morally
> equivalent error.  I don't think that's a valid usage of flex-array.
> 
> > See https://godbolt.org/z/TbcYhEW5d, it says:
> >
> >         <source>(5): error C2229: struct 'MyStruct' has an illegal zero-sized
> array
> >         Compiler returned: 2
> >
> > > (Note that I'm passing /TC to force C compilation).
> >
> > Yes, `/TC` is one of the flags we pass to MSVC. For more details, see
> > https://github.com/git-for-windows/git/runs/4389081542?check_suite_foc
> > us=true#step:9:125
> >
> > > Also, heap_fsentry doesn't appear to use a flex array in current sources.
> >
> > It does, but it is admittedly a bit convoluted and not very easy to see.
> > The definition of `heap_fsentry` is
> > [this](https://github.com/git-for-
> windows/git/blob/v2.34.1.windows.1/compat/win32/fscache.c#L77-L80):
> >
> >         struct heap_fsentry {
> >                 struct fsentry ent;
> >                 char dummy[MAX_LONG_PATH];
> >         };
> >
> > No flex array here, right? But wait, there is a `struct fsentry`.
> > Let's look at
> > [that](https://github.com/git-for-
> windows/git/blob/v2.34.1.windows.1/compat/win32/fscache.c#L43-L74):
> >
> >         struct fsentry {
> >                 struct hashmap_entry ent;
> >                 [...]
> >                 /*
> >                  * Name of the entry. For directory listings: relative path of the
> >                  * directory, without trailing '/' (empty for cwd()). For file
> >                  * entries:
> >                  * name of the file. Typically points to the end of the structure
> >                  * if
> >                  * the fsentry is allocated on the heap (see fsentry_alloc), or to
> >                  * a
> >                  * local variable if on the stack (see fsentry_init).
> >                  */
> >                 struct dirent dirent;
> >         };
> >
> > Still no flex array, right? But wait, there is a `struct dirent`.
> > Let's
> > [see](https://github.com/git-for-
> windows/git/blob/v2.34.1.windows.1/compat/win32/dirent.h#L9-L12):
> >
> >         struct dirent {
> >                 unsigned char d_type; /* file type to prevent lstat after readdir */
> >                 char d_name[FLEX_ARRAY]; /* file name */
> >         };
> >
> > Finally! We see the flex array.
> >
> > Now, you may ask why is this even correct? How can you have an
> > empty-sized field in a struct that is inside another struct that is
> > inside yet another struct _and then followed by another field_?
> >
> > The reason why this is correct and intended is that `struct dirent`
> > intentionally leaves the length of the `d_name` undefined, to leave it
> > to the implementation whether a fixed-size buffer is used or a
> > specifically-allocated one of the exact correct size for a _specific_
> > directory entry.
> >
> > In FSCache, we want to allocate a large-enough buffer to fit _any_
> > file name, and it should not only contain the metadata in `struct
> > dirent`, but additionally some FSCache-specific metadata.
> >
> > Therefore, `struct fsentry` is kind of a subclass of `struct dirent`,
> > and `struct heap_fsentry` is kind of a subclass of something that does
> > not exist, a `struct dirent` that offers enough space to fit _any_
> > legal `d_name` (that is what that `dummy` field is for, it is not
> > actually intended to be accessed except via `d_name`).
> >
> > > If it does start using it, there issue may actually be elsewhere
> > > besides the struct definition (it could be just a badly targeted compiler
> error).
> > > We have code like `struct heap_fsentry key[2];`.  That declaration
> > > can't work with a flex array.
> >
> > I hope my explanation above made sense to you.
> >
> > Admittedly, it is slightly icky code, but honestly, I do not have any
> > splendid idea how to make it less complicated to understand. Do you?
> 
> Thanks for explaining all of this.  It was hard for me to see what was going on
> before.
> 
> So when trying the same thing with Clang, this construct is claimed to be a
> GNU extension: https://godbolt.org/z/q3ndr57Pf
> 
> The fix I'd propose (uncomment the line defining FIXED_DEF in godbolt) is to
> use a union where the char buf has the size of the fsentry _plus_ the desired
> buffer.

I don't know which compiler versions support this check, but it is customary to have a union with the largest allocation first, then smaller allocations following in separate sub-union fields. This may not match your intent.

-Randall

