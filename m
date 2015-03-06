From: Jeff King <peff@peff.net>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote
 prune"?
Date: Fri, 6 Mar 2015 17:59:17 -0500
Message-ID: <20150306225917.GA1589@peff.net>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU1DK-00020D-3A
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 23:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbbCFW7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 17:59:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:57520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753526AbbCFW7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 17:59:21 -0500
Received: (qmail 7455 invoked by uid 102); 6 Mar 2015 22:59:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 16:59:20 -0600
Received: (qmail 22993 invoked by uid 107); 6 Mar 2015 22:59:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Mar 2015 17:59:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2015 17:59:17 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264971>

On Fri, Mar 06, 2015 at 05:48:39PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> The --prune option to fetch added in v1.6.5-8-gf360d84 seems to be
> around 20-30x slower than the equivalent operation with git remote
> prune. I'm wondering if I'm missing something and fetch does somethin=
g
> more, but it doesn't seem so.

"git fetch --prune" is "do a normal fetch, and also prune anything
necessary". "git remote prune" is "ls-remote the other side and see if
there is anything we can prune; do not touch anything else".

If your fetch is a noop (i.e., the other side has not advanced any
branches), the outcome is the same. But perhaps fetch is doing more
work to find out that it is a noop.

One way to measure that would be to see how expensive a noop "git fetch=
"
is (if it's expensive, then there is room to improve there. If not, the=
n
it is the pruning itself that is expensive).

But just guessing (I do not have time to dig in deeper right now), and
seeing this:

> $ gprof ~/g/git/git-fetch|head -n 20
> Flat profile:
>=20
> Each sample counts as 0.01 seconds.
>   %   cumulative   self              self     total
>  time   seconds   seconds    calls   s/call   s/call  name
>  26.42      0.33     0.33  1584583     0.00     0.00  strbuf_getwhole=
line
>  14.63      0.51     0.18 90601347     0.00     0.00  strbuf_grow
>  13.82      0.68     0.17  1045676     0.00     0.00  find_pack_entry=
_one
>   8.13      0.78     0.10  1050062     0.00     0.00  check_refname_f=
ormat
>   6.50      0.86     0.08  1584675     0.00     0.00  get_sha1_hex
>   5.69      0.93     0.07  2100529     0.00     0.00  starts_with
>   3.25      0.97     0.04  1044043     0.00     0.00  refname_is_safe
>   3.25      1.01     0.04     8007     0.00     0.00  get_packed_ref_=
cache
>   2.44      1.04     0.03  2605595     0.00     0.00  search_ref_dir
>   2.44      1.07     0.03  1040500     0.00     0.00  peel_entry
>   1.63      1.09     0.02  2632661     0.00     0.00  get_ref_dir
>   1.63      1.11     0.02  1044043     0.00     0.00  create_ref_entr=
y
>   1.63      1.13     0.02     8024     0.00     0.00  do_for_each_ent=
ry_in_dir
>   0.81      1.14     0.01  2155105     0.00     0.00  memory_limit_ch=
eck
>   0.81      1.15     0.01  1580503     0.00     0.00  sha1_to_hex

We spend a lot of time checking refs here. Probably this comes from
writing the `packed-refs` file out 1000 times in your example, because
fetch handles each ref individually. Whereas since c9e768b (remote:
repack packed-refs once when deleting multiple refs, 2014-05-23),
git-remote does it in one pass.

Now that we have ref_transaction_*, I think if git-fetch fed all of the
deletes (along with the updates) into a single transaction, we would ge=
t
the same optimization for free. Maybe that is even part of some of the
pending ref_transaction work from Stefan or Michael (both cc'd). I
haven't kept up very well with what is cooking in pu.

-Peff
