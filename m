From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 12:29:44 +0100
Message-ID: <20160111112944.GB10612@hank>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
 <CAPig+cRXy=CBZBTC7fU5wHA3d9Acqh_WYD54DmY1sHj7rob9Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 12:29:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIaf6-0008Hi-W5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 12:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759686AbcAKL3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 06:29:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36817 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758960AbcAKL3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 06:29:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so25808028wmf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C84X3bvy1Jqbq/YakfIEWWZX9QeNJo2c3SrZcxfZOlU=;
        b=G37MAi9aAzYZfV6PvBoOP5L3NPuBKruYkNInoBp5VQi6kLtwbZLcJIfJmKByuwZ7tB
         aMRUNgK/1JMI+6/tJRTK3VeZS2wdMqcvnX9QyABoWNwCswY1i7mONuSu2b40j4tMWj8X
         bmps3Qd0Uw0YG7/A2wKQ8up0BHn8U2m2eB1laR71vB7+PtlhOwBWkq9QrMs0fVUPr70x
         awl8E7Df1XbrvPJ3JA6ZDQHVnbzC9eOOq7naz7H6JvkwC6vl59wadPhEbdig3j1vNWl+
         La0xhQZ9EUXJcc8f2wf8V6DB9zKrUBruszrOX1awS6iHGETe8naOf7RtEWPa3kCT8dqd
         P2wQ==
X-Received: by 10.28.148.82 with SMTP id w79mr13513096wmd.71.1452511759271;
        Mon, 11 Jan 2016 03:29:19 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id w23sm12375016wmd.1.2016.01.11.03.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 03:29:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPig+cRXy=CBZBTC7fU5wHA3d9Acqh_WYD54DmY1sHj7rob9Pw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283645>

On 01/10, Eric Sunshine wrote:
> On Sun, Jan 10, 2016 at 9:19 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Currently when git grep is used outside of a git repository without the
> > --no-index option git simply dies.  For convenience, implicitly make git
> > grep behave like git grep --no-index when it is called outside of a git
> > repository.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > @@ -19,6 +19,9 @@
> > +#define GREP_NO_INDEX_EXPLICIT 1
> > +#define GREP_NO_INDEX_IMPLICIT 2
> > @@ -873,13 +881,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
> >         if (!show_in_pager && !opt.status_only)
> >                 setup_pager();
> >
> > -       if (no_index && (untracked || cached))
> > -               die(_("--cached or --untracked cannot be used with --no-index."));
> > +       if (untracked || cached) {
> > +               if (no_index == GREP_NO_INDEX_EXPLICIT)
> > +                       die(_("--cached or --untracked cannot be used with --no-index."));
> > +               else if (no_index == GREP_NO_INDEX_IMPLICIT)
>
> Just below here when checking --untracked, you use a simple 'else'
> rather than 'else if' to handle the other case of explicit vs
> implicit. Why the inconsistency? Also, the ordering of 'if/else' arms
> is opposite.

The reason is that I removed the no_index check from the surrounding
if block, and grep should only die if no_index is set, while in the
block below it should also die if only untracked is set, but no_index
isn't.  I agree however that it's a bit confusing, so I'll just leave
the no_index check in the surrounding block and use the simple else
here, so the block ends up like this:

	if (no_index && (untracked || cached)) {
		if (no_index == GREP_NO_INDEX_IMPLICIT)
			die(_("--cached or --untracked cannot be used outside a git repository."));
		else
			die(_("--cached or --untracked cannot be used with --no-index."));
	}

> > +                       die(_("--cached or --untracked cannot be used outside a git repository."));
> > +       }
> >
> >         if (no_index || untracked) {
> >                 int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
> > -               if (list.nr)
> > -                       die(_("--no-index or --untracked cannot be used with revs."));
> > +               if (list.nr) {
> > +                       if (no_index == GREP_NO_INDEX_IMPLICIT)
> > +                               die(_("cannot use revs outside of a git repository."));
> > +                       else
> > +                               die(_("--no-index or --untracked cannot be used with revs."));
> > +               }
> > diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> > @@ -821,6 +818,44 @@ test_expect_success 'outside of git repository' '
> > +test_expect_success 'outside of git repository without --no-index' '
> > +       rm -fr non &&
> > +       mkdir -p non/git/sub &&
> > +       echo hello >non/git/file1 &&
> > +       echo world >non/git/sub/file2 &&
> > +       {
> > +               echo file1:hello &&
> > +               echo sub/file2:world
> > +       } >non/expect.full &&
>
> Isn't the above just a complicated way of saying:
>
>     cat <<-\EOF >non/expect.full &&
>     file:hello
>     sub/file2:world
>     EOF
>
> ?

Yes, the test case is mostly copy paste from the test case above it
where it is written like this.  Looking around in t7810, both the more
complicated way as I used it, as well as the way you've written it are
used, so I'll use the simpler way in the re-roll.  Thanks.

> > +       echo file2:world >non/expect.sub &&
> > +       (
> > +               GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> > +               export GIT_CEILING_DIRECTORIES &&
> > +               cd non/git &&
> > +               git grep o >../actual.full &&
> > +               test_cmp ../expect.full ../actual.full
>
> Broken &&-chain.
>
> > +               cd sub &&
> > +               git grep o >../../actual.sub &&
> > +               test_cmp ../../expect.sub ../../actual.sub
> > +       ) &&
> > +
> > +       echo ".*o*" >non/git/.gitignore &&
> > +       (
> > +               GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> > +               export GIT_CEILING_DIRECTORIES &&
> > +               cd non/git &&
> > +               git grep --exclude-standard o >../actual.full &&
> > +               test_cmp ../expect.full ../actual.full &&
> > +
> > +               {
> > +                       echo ".gitignore:.*o*"
>
> Broken &&-chain.

Thanks for catching these two, again the test is mostly a copy paste,
so the chain is broken in the test before this one as well, will add
the fix to my first cleanup patch for the other tests and fix these in
the re-roll.

Thanks for your review!

> > +                       cat ../expect.full
> > +               } >../expect.with.ignored &&
> > +               git grep --no-exclude o >../actual.full &&
> > +               test_cmp ../expect.with.ignored ../actual.full
> > +       )
> > +'
