Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770EC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJTMEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTMEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 08:04:38 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Oct 2022 05:04:27 PDT
Received: from smtp1.fnusa.cz (smtp1.fnusa.cz [195.113.158.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F2B492
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 05:04:25 -0700 (PDT)
Received: from smtp1.fnusa.cz (mailfilter.fnusa.cz [172.30.0.204])
        by smtp1.fnusa.cz (Postfix) with ESMTP id 1AA02120C07;
        Thu, 20 Oct 2022 13:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fnusa.cz; s=mail;
        t=1666267139; bh=GqKJES5tpUl+osT+ElX30JtbOd13F19NJ4f3lpo9SAs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d7EV/P1O7DpWMtAHjGSvYjf1F2gzcU7Bgo3wX674rahR2i7ne+lrgi6OpL5KTk4xO
         LwDV/vxi+9/f7Yldwp9jo4LcPDeAicInGIRrSivhUD51jw82tSP+6zeKlvEUWwDTb3
         eyQPMkoyhkyY7Dmbiv2jb4PLJcxlg4RiUCzsqo3o=
Received: from [172.30.22.150] (unknown [172.30.22.150])
        by smtp1.fnusa.cz (Postfix) with ESMTPS id D8F15120BB2;
        Thu, 20 Oct 2022 13:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fnusa.cz; s=mail;
        t=1666267139; bh=GqKJES5tpUl+osT+ElX30JtbOd13F19NJ4f3lpo9SAs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d7EV/P1O7DpWMtAHjGSvYjf1F2gzcU7Bgo3wX674rahR2i7ne+lrgi6OpL5KTk4xO
         LwDV/vxi+9/f7Yldwp9jo4LcPDeAicInGIRrSivhUD51jw82tSP+6zeKlvEUWwDTb3
         eyQPMkoyhkyY7Dmbiv2jb4PLJcxlg4RiUCzsqo3o=
Message-ID: <00af268377fb7c3b8efd059482ee7449b71f48b1.camel@fnusa.cz>
Subject: Another possible instance of async-signal-safe opendir path
 callstack? (Was: [PATCH] tmp-objdir: do not opendir() when handling a
 signal)
From:   Jan =?ISO-8859-1?Q?Pokorn=FD?= <poki@fnusa.cz>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:   Thu, 20 Oct 2022 13:58:58 +0200
In-Reply-To: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
Organization: =?UTF-8?Q?Fakultn=C3=AD?= nemocnice u sv. Anny v
 =?UTF-8?Q?Brn=C4=9B?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc37) 
MIME-Version: 1.0
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai via GitGitGadget p=C3=AD=C5=A1e v Po 26. 09. 2022 v 23:53 +0000:
> From: John Cai <johncai86@gmail.com>
>=20
> In the tmp-objdir api, tmp_objdir_create will create a temporary
> directory but also register signal handlers responsible for removing
> the directory's contents and the directory itself. However, the
> function responsible for recursively removing the contents and
> directory, remove_dir_recurse() calls opendir(3) and closedir(3).
> This can be problematic because these functions allocate and free
> memory, which are not async-signal-safe functions. This can lead to
> deadlocks.
>=20
> One place we call tmp_objdir_create() is in git-receive-pack, where
> we create a temporary quarantine directory "incoming". Incoming
> objects will be written to this directory before they get moved to
> the object directory.

Just noticed this unattended git crash in the logs and I think it might
actually be another occurrence of the same problem in principle, so
shamelessly piggy-backing the stack trace here (no coredump preserved
at this point, sorry):

    #0  0x00007f08df0ea06c __pthread_kill_implementation (libc.so.6 + 0x8b0=
6c)
    #1  0x00007f08df098046 raise (libc.so.6 + 0x39046)
    #2  0x00007f08df0817fc abort (libc.so.6 + 0x227fc)
    #3  0x00007f08df082533 __libc_message.cold (libc.so.6 + 0x23533)
    #4  0x00007f08df090a67 __libc_assert_fail (libc.so.6 + 0x31a67)
    #5  0x00007f08df0f68f2 sysmalloc (libc.so.6 + 0x978f2)
    #6  0x00007f08df0f7789 _int_malloc (libc.so.6 + 0x98789)
    #7  0x00007f08df0f80d2 __libc_malloc (libc.so.6 + 0x990d2)
    #8  0x00007f08df12fa55 __alloc_dir (libc.so.6 + 0xd0a55)
  ->#9  0x00007f08df12fac2 opendir_tail (libc.so.6 + 0xd0ac2)
    #10 0x00005632ea10c823 remove_temporary_files.lto_priv.0 (git + 0xdc823=
)
  ->#11 0x00005632ea10c97c remove_pack_on_signal.lto_priv.0 (git + 0xdc97c)
    #12 0x00007f08df0980f0 __restore_rt (libc.so.6 + 0x390f0)
    #13 0x00007f08df0f7775 _int_malloc (libc.so.6 + 0x98775)
    #14 0x00007f08df0f80d2 __libc_malloc (libc.so.6 + 0x990d2)
    #15 0x00007f08df0d2b44 _IO_file_doallocate (libc.so.6 + 0x73b44)
    #16 0x00007f08df0e1d20 _IO_doallocbuf (libc.so.6 + 0x82d20)
    #17 0x00007f08df0e0a8c _IO_file_underflow@@GLIBC_2.2.5 (libc.so.6 + 0x8=
1a8c)
    #18 0x00007f08df0d4598 __getdelim (libc.so.6 + 0x75598)
    #19 0x00005632ea29f372 strbuf_getwholeline (git + 0x26f372)
    #20 0x00005632ea117915 cmd_repack (git + 0xe7915)
    #21 0x00005632ea0556fa handle_builtin.lto_priv.0 (git + 0x256fa)
    #22 0x00005632ea050551 main (git + 0x20551)
    #23 0x00007f08df082a50 __libc_start_call_main (libc.so.6 + 0x23a50)
    #24 0x00007f08df082b09 __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x23b=
09)
    #25 0x00005632ea051555 _start (git + 0x21555)

As per the captured info, following Fedora x86_64 packages were involved:

  git-2.37.3-1.fc38
  zlib-1.2.12-5.fc38
  pcre2-10.40-1.fc37.1

Full command at hand:

  /usr/libexec/git-core/git repack -d -l --no-write-bitmap-index

It happened twice, actually, about a week's time apart, but that was
a month ago while this unattended task runs hourly till today and
git hasn't been updated since.

Not subscribed to the list and I don't think I can provide more info
on this, but feel free to contact me directly.

-- poki
