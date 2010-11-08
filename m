From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Understanding and improving --word-diff
Date: Mon, 8 Nov 2010 20:22:13 +0100
Message-ID: <201011082022.13678.trast@student.ethz.ch>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Wincent Colaiuta <win@wincent.com>
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:22:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXIL-0000hR-Uh
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab0KHTWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:22:16 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:12881 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab0KHTWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:22:15 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 8 Nov
 2010 20:22:13 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 8 Nov
 2010 20:22:13 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101108151601.GF22067@login.drsnuggles.stderr.nl>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160971>

Matthijs Kooijman wrote:
> This is somewhat expected, of course, since the --word-diff formats are
> documented to show only changes to words, not to non-words/whitespace.
> So I guess it is expected that the output is ambigious wrt whitespace,
> but if so, what is the use of this porcelain format? Wouldn't it be make
> a lot more sense to make the format unambiguous and make it do
> word-based diff at the same time? I think this should be possible
> because of the explicit notation used for the newline.

It's not just the newlines.  You will note that when diffing e.g.

  a x  c
vs.
  a  b c

then because the word-diff engine doesn't bother with the non-word
parts, you will end up with (using ordinary --word-diff)

  a  [-x-]{+b+} c

or using the porcelain format

  $ git diff --no-index --word-diff=porcelain a b | cat -E
  diff --git 1/a 2/b$
  index 4f47486..b040ae0 100644$
  --- 1/a$
  +++ 2/b$
  @@ -1 +1 @@$
   a  $
  -x$
  +b$
    c$
  ~$

Note how the second space after 'x' disappeared.  The case that
Wincent explains in the email he linked (thanks; I didn't even see it
the first time around) shows a more drastic example.  So the logic
that inserts the space again is too simplistic.

What it does not is something like (haven't checked again) always
insert the postimage space that went with the preceding word.  What it
*would* have to do is actually compute differences in the space, while
at the same time ignoring them for the purposes of the LCS algorithm.
If it weren't for the customizable word-regex, it might be enough to
put the spaces in the words again but enable the internal equivalent
of -b.

> Looking at the format itself, it's a bit unclear to me what the ~ lines
> mean exactly. Commit 882749, which introduced the format says the mean
> "newlines in the input", but I'm not sure if this means the old file,
> new file or both.

As Matthieu already said, the history of --word-diff=porcelain is
just: I needed a way to pipe word-diff output to gitk for coloring,
without any messing around with the color strings.  The ~ is the
minimal required feature to at least let git communicate *some*
linebreaks.

You are probably right in that while the format leaves open the
possibility of showing addition and removal of space (although the
current engine does not really attempt to compute it), I did not think
far enough to let it show addition and removal of whitespace.

> For example, Specifying the ~ lines to mean a newline in the old, new or
> both files depending on the previous +, - or space prefixed line is
> probably enough for this. By generating empty +, - or space prefixed
> lines when needed, every occurence of ~ could be disambiguated.

AFAICS that breaks down if you couple a newline-change-aware consumer
with a non-aware producer (i.e., a new frontend with an old git),
since there is currently no guarantee that the line before a ~ is
context.

So you would have to introduce a new format (porcelain2?) anyway, and
if you're already going that route, then for simplicity I'd rather
have something like ~+ (or so) instead of requiring the parser to
track state.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
