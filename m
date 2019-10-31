Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D70B1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 19:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfJaT0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 15:26:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:35290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729347AbfJaT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 15:26:51 -0400
Received: (qmail 19314 invoked by uid 109); 31 Oct 2019 19:26:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 19:26:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4566 invoked by uid 111); 31 Oct 2019 19:30:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 15:30:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 15:26:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] sequencer: reencode to utf-8 before arrange rebase's
 todo list
Message-ID: <20191031192650.GA12834@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-4-congdanhqx@gmail.com>
 <nycvar.QRO.7.76.6.1910311134011.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1910311134011.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 11:38:14AM +0100, Johannes Schindelin wrote:

> On Thu, 31 Oct 2019, Doan Tran Cong Danh wrote:
> 
> > On musl libc, ISO-2022-JP encoder is too eager to switch back to
> > 1 byte encoding, musl's iconv always switch back after every combining
> > character. Comparing glibc and musl's output for this command
> > $ sed q t/t3900/ISO-2022-JP.txt| iconv -f ISO-2022-JP -t utf-8 |
> > 	iconv -f utf-8 -t ISO-2022-JP | xxd
> >
> > glibc:
> > 00000000: 1b24 4224 4f24 6c24 5224 5b24 551b 2842  .$B$O$l$R$[$U.(B
> > 00000010: 0a                                       .
> >
> > musl:
> > 00000000: 1b24 4224 4f1b 2842 1b24 4224 6c1b 2842  .$B$O.(B.$B$l.(B
> > 00000010: 1b24 4224 521b 2842 1b24 4224 5b1b 2842  .$B$R.(B.$B$[.(B
> > 00000020: 1b24 4224 551b 2842 0a                   .$B$U.(B.
> >
> > Although musl iconv's output isn't optimal, it's still correct.
> >
> > From commit 7d509878b8, ("pretty.c: format string with truncate respects
> > logOutputEncoding", 2014-05-21), we're encoding the message to utf-8
> > first, then format it and convert the message to the actual output
> > encoding on git commit --squash.
> >
> > Thus, t3900 is failing on Linux with musl libc.
> >
> > Reencode to utf-8 before arranging rebase's todo list.
> 
> Since the re-encoded commit messages are only used for figuring out the
> relationships between the `fixup!`/`squash!` commits and their targets,
> but are not used in any of the lines that are written out, this change
> looks good to me.

I'm confused about a few things here, though. I agree with you that the
subjects here are only used for finding the fixup/squash relationships.
But I don't understand the musl connection.

Wouldn't failure to reencode here always be a problem? E.g., if I do:

  for encoding in utf-8 iso-8859-1; do
    # commit using the encoding
    echo $encoding >file && git add file
    echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
      git -c i18n.commitEncoding=$encoding commit -F -
    # and then fixup without it
    echo "$encoding fixed" >file && git add file
    git commit --fixup HEAD
  done
  
  GIT_EDITOR='echo; grep -v ^#' git rebase -i --root --autosquash

then the resulting todo-list output (on my glibc system) is:

  pick 3a5bace éñcödèd with utf-8
  fixup aa9f09c fixup! éñcödèd with utf-8
  pick 6e85d32 éñcödèd with iso-8859-1
  pick 3ceac05 fixup! éñcödèd with iso-8859-1

I.e., we don't actually match up the second pair, and I think we
probably ought to.

I guess the test in t3900 is less exotic; it uses the same encoding for
both commits. And it's just that "foo" and "!fixup foo" can (and do in
musl) end up with different encodings (because of the specific language,
and the vagaries of each iconv implementation).

Would we have similar problems in all of the other functions which use
get_commit_buffer() without reencoding? For instance if I do this:

  echo base >file && git add file && git commit -m base
  for encoding in utf-8 iso-8859-1; do
    echo $encoding >file && git add file
    echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
      git -c i18n.commitEncoding=$encoding commit -F -
  done
  git checkout -b side HEAD~2
  git cherry-pick master master^
  cat .git/sequencer/todo

then the resulting todo file has a mix of iso-8859-1 and utf-8.

It seems to me that we should always be working with the subjects in a
single encoding internally, and likewise outputting in that format
(which should probably be git_log_output_encoding(), for the instances
where we show it to the user).

I.e., we should always call logmsg_reencode() instead of
get_commit_buffer().

-Peff
