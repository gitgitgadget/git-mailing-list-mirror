From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Tue, 31 May 2016 07:45:06 +0000
Message-ID: <20160531074506.GA8911@dcvr.yhbt.net>
References: <20160530232142.21098-1-e@80x24.org>
 <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 31 09:45:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7eMS-00050J-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 09:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbcEaHpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 03:45:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38760 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416AbcEaHpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 03:45:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BAF1F71A;
	Tue, 31 May 2016 07:45:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295962>

Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 30, 2016 at 7:21 PM, Eric Wong <e@80x24.org> wrote:
> > diff --git a/pretty.c b/pretty.c
> > @@ -1697,12 +1699,34 @@ static void pp_handle_indent(struct pretty_print_context *pp,
> > +static regex_t *mboxrd_prepare(void)
> > +{
> > +       static regex_t preg;
> > +       const char re[] = "^>*From ";
> > +       int err = regcomp(&preg, re, REG_NOSUB | REG_EXTENDED);
> > +[...]
> > +       return &preg;
> > +}
> > +
> >  void pp_remainder(struct pretty_print_context *pp,
> >                   const char **msg_p,
> >                   struct strbuf *sb,
> >                   int indent)
> >  {
> > +       static regex_t *mboxrd_from;
> > +
> > +       if (pp->fmt == CMIT_FMT_MBOXRD && !mboxrd_from)
> > +               mboxrd_from = mboxrd_prepare();
> > +
> > @@ -1725,8 +1749,13 @@ void pp_remainder(struct pretty_print_context *pp,
> >                 else if (pp->expand_tabs_in_log)
> >                         strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
> >                                              line, linelen);
> > -               else
> > +               else {
> > +                       if (pp->fmt == CMIT_FMT_MBOXRD &&
> > +                                       !regexec(mboxrd_from, line, 0, 0, 0))
> > +                               strbuf_addch(sb, '>');
> 
> At first glance, this seems dangerous since it's handing 'line' to
> regexec() without paying attention to 'linelen'. For an arbitrary
> regex, this could result in erroneous matches on subsequent "lines",
> however, since this expression is anchored with '^', it's not a
> problem. But, it is a bit subtle.

Maybe having more context of the pp_remainder function and
seeing the get_one_line call would've helped in the diff;
I didn't think of this issue once I figured out where to
place the change.

On the other hand, not being too familiar with git C APIs, I was
more worried strbuf was not NUL-terminated for regexec, but it
seems to be.

> I wonder if hand-coding, rather than using a regex, could be an improvement:
> 
>     static int is_mboxrd_from(const char *s, size_t n)
>     {
>         size_t f = strlen("From ");
>         const char *t = s + n;
> 
>         while (s < t && *s == '>')
>             s++;
>         return t - s >= f && !memcmp(s, "From ", f);
>     }
> 
> or something.

Yikes.  I mostly work in high-level languages and do my best to
avoid string parsing in C; so that scares me.  A lot.

I admit a regex isn't necessary, but I'm wondering if the above
could be made less frightening to someone like me.

Or maybe I'm just easily frightened :x

Maybe extra test cases + valgrind can quell my fears :)

> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > @@ -1565,4 +1565,31 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
> > +test_expect_success 'format-patch --pretty=mboxrd' '
> > +       cat >msg <<-INPUT_END &&
> 
> Maybe use <<-\INPUT_END to indicate that no variable interpolation is
> expected. Ditto below.

Noted, though I may add variable interpolation to test a line
with trailing whitespace (just "From ") to ensure we don't
overrun a buffer.

> Hmm, -A is not POSIX and is otherwise not used in Git tests. Perhaps
> you could use 'git grep --no-index -A' instead or something?

Noted and will fix for v2.  Will wait a day or two for
further comments on this series.
